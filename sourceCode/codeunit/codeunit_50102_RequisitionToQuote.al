codeunit 50102 "Purch.-Requisition to Quote"
{
    TableNo = "Purchase Header";

    trigger OnRun()
    var
        Vend: Record Vendor;
        PurchCommentLine: Record "Purch. Comment Line";
        PurchCalcDiscByType: Codeunit "Purch - Calc Disc. By Type";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        RecordLinkManagement: Codeunit "Record Link Management";
        ShouldRedistributeInvoiceAmount: Boolean;
        IsHandled: Boolean;
    begin
        OnBeforeRun(Rec);

        Rec.TestField("Document Type", Rec."Document Type"::Requisition);
        ShouldRedistributeInvoiceAmount := PurchCalcDiscByType.ShouldRedistributeInvoiceDiscountAmount(Rec);

        CreatePurchHeader(Rec, Vend."Prepayment %");

        TransferQuoteToOrderLines(PurchReqLine, Rec, PurchQuoteLine, PurchQuoteHeader, Vend);
        OnAfterInsertAllPurchOrderLines(PurchQuoteLine, Rec);

        PurchSetup.Get();
        // ArchivePurchaseQuote(Rec);

        if PurchSetup."Default Posting Date" = PurchSetup."Default Posting Date"::"No Date" then begin
            PurchQuoteHeader."Posting Date" := 0D;
            PurchQuoteHeader.Modify();
        end;

        PurchCommentLine.CopyComments("Document Type".AsInteger(), PurchQuoteHeader."Document Type".AsInteger(), "No.", PurchQuoteHeader."No.");
        RecordLinkManagement.CopyLinks(Rec, PurchQuoteHeader);

        AssignItemCharges(Rec."Document Type", Rec."No.", PurchQuoteHeader."Document Type", PurchQuoteHeader."No.");

        ApprovalsMgmt.CopyApprovalEntryQuoteToOrder(Rec.RecordId, PurchQuoteHeader."No.", PurchQuoteHeader.RecordId);

        if not ShouldRedistributeInvoiceAmount then
            PurchCalcDiscByType.ResetRecalculateInvoiceDisc(PurchQuoteHeader);

        OnAfterRun(Rec, PurchQuoteHeader);
    end;

    var
        PurchReqLine: Record "Purchase Line";
        PurchQuoteHeader: Record "Purchase Header";
        PurchQuoteLine: Record "Purchase Line";
        PurchSetup: Record "Purchases & Payables Setup";
        PrepmtMgt: Codeunit "Prepayment Mgt.";

    local procedure CreatePurchHeader(PurchHeader: Record "Purchase Header"; PrepmtPercent: Decimal)
    begin
        OnBeforeCreatePurchHeader(PurchHeader);

        with PurchHeader do begin
            PurchQuoteHeader := PurchHeader;
            PurchQuoteHeader."Document Type" := PurchQuoteHeader."Document Type"::Quote;
            PurchQuoteHeader."No. Printed" := 0;
            PurchQuoteHeader.Status := PurchQuoteHeader.Status::Open;
            PurchQuoteHeader."No." := '';
            PurchQuoteHeader."Requisition No." := "No.";
            PurchQuoteHeader.Requestor := Requestor;
            CalcFields("Requisition Details");
            PurchQuoteHeader."Requisition Details" := "Requisition Details";
            PurchQuoteHeader."Requisition Purpose" := "Requisition Purpose";
            PurchQuoteHeader."Requisition Reason" := "Requisition Reason";
            PurchQuoteHeader."Requisition Status" := "Requisition Status";
            PurchQuoteHeader."Expected Delivery Date " := "Expected Delivery Date ";
            PurchQuoteHeader."Request Date" := "Request Date";

            OnCreatePurchHeaderOnBeforeInitRecord(PurchQuoteHeader, PurchHeader);
            //PurchQuoteHeader.InitRecord();

            PurchQuoteLine.LockTable();
            OnCreatePurchHeaderOnBeforePurchOrderHeaderInsert(PurchQuoteHeader, PurchHeader);
            PurchQuoteHeader.Insert(true);
            OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert(PurchQuoteHeader, PurchHeader);

            PurchQuoteHeader."Order Date" := "Order Date";
            if "Posting Date" <> 0D then
                PurchQuoteHeader."Posting Date" := "Posting Date";

            PurchQuoteHeader.InitFromPurchHeader(PurchHeader);
            OnCreatePurchHeaderOnAfterInitFromPurchHeader(PurchQuoteHeader, PurchHeader);
            PurchQuoteHeader."Inbound Whse. Handling Time" := "Inbound Whse. Handling Time";

            PurchQuoteHeader."Prepayment %" := PrepmtPercent;
            if PurchQuoteHeader."Posting Date" = 0D then
                PurchQuoteHeader."Posting Date" := WorkDate;
            OnCreatePurchHeaderOnBeforePurchOrderHeaderModify(PurchQuoteHeader, PurchHeader);
            PurchQuoteHeader.Modify();
        end;

        OnAfterCreatePurchHeader(PurchQuoteHeader, PurchHeader);
    end;

    local procedure AssignItemCharges(FromDocType: Enum "Purchase Document Type"; FromDocNo: Code[20]; ToDocType: Enum "Purchase Applies-to Document Type"; ToDocNo: Code[20])
    var
        ItemChargeAssgntPurch: Record "Item Charge Assignment (Purch)";
    begin
        ItemChargeAssgntPurch.Reset();
        ItemChargeAssgntPurch.SetRange("Document Type", FromDocType);
        ItemChargeAssgntPurch.SetRange("Document No.", FromDocNo);
        while ItemChargeAssgntPurch.FindFirst do begin
            ItemChargeAssgntPurch.Delete();
            ItemChargeAssgntPurch."Document Type" := PurchQuoteHeader."Document Type";
            ItemChargeAssgntPurch."Document No." := PurchQuoteHeader."No.";
            if not (ItemChargeAssgntPurch."Applies-to Doc. Type" in
                    [ItemChargeAssgntPurch."Applies-to Doc. Type"::Receipt,
                     ItemChargeAssgntPurch."Applies-to Doc. Type"::"Return Shipment"])
            then begin
                ItemChargeAssgntPurch."Applies-to Doc. Type" := ToDocType;
                ItemChargeAssgntPurch."Applies-to Doc. No." := ToDocNo;
            end;
            ItemChargeAssgntPurch.Insert();
        end;
    end;

    procedure GetPurchOrderHeader(var PurchHeader: Record "Purchase Header")
    begin
        PurchHeader := PurchQuoteHeader;
    end;

    local procedure TransferQuoteToOrderLines(var PurchQuoteLine: Record "Purchase Line"; var PurchQuoteHeader: Record "Purchase Header"; var PurchOrderLine: Record "Purchase Line"; var PurchOrderHeader: Record "Purchase Header"; Vend: Record Vendor)
    var
        PurchLineReserve: Codeunit "Purch. Line-Reserve";
        IsHandled: Boolean;
    begin
        PurchQuoteLine.SetRange("Document Type", PurchQuoteHeader."Document Type");
        PurchQuoteLine.SetRange("Document No.", PurchQuoteHeader."No.");
        OnTransferQuoteToOrderLinesOnAfterPurchQuoteLineSetFilters(PurchQuoteLine, PurchQuoteHeader, PurchOrderHeader);
        if PurchQuoteLine.FindSet() then
            repeat
                IsHandled := false;
                OnBeforeTransferQuoteLineToOrderLineLoop(PurchQuoteLine, PurchQuoteHeader, PurchOrderHeader, IsHandled);
                if not IsHandled then begin
                    PurchOrderLine := PurchQuoteLine;
                    PurchOrderLine."Document Type" := PurchOrderHeader."Document Type";
                    PurchOrderLine."Document No." := PurchOrderHeader."No.";
                    PurchLineReserve.TransferPurchLineToPurchLine(
                      PurchQuoteLine, PurchOrderLine, PurchQuoteLine."Outstanding Qty. (Base)");
                    PurchOrderLine."Shortcut Dimension 1 Code" := PurchQuoteLine."Shortcut Dimension 1 Code";
                    PurchOrderLine."Shortcut Dimension 2 Code" := PurchQuoteLine."Shortcut Dimension 2 Code";
                    PurchOrderLine."Dimension Set ID" := PurchQuoteLine."Dimension Set ID";
                    PurchOrderLine."Transaction Type" := PurchOrderHeader."Transaction Type";
                    PurchOrderLine."Requisition Line No." := PurchQuoteLine."Line No.";

                    PurchOrderLine.Description := PurchQuoteLine.Description;
                    PurchOrderLine."Description 2" := PurchQuoteLine."Description 2";

                    if Vend."Prepayment %" <> 0 then
                        PurchOrderLine."Prepayment %" := Vend."Prepayment %";
                    PrepmtMgt.SetPurchPrepaymentPct(PurchOrderLine, PurchOrderHeader."Posting Date");
                    ValidatePurchOrderLinePrepaymentPct(PurchOrderLine);
                    PurchOrderLine.DefaultDeferralCode;
                    OnBeforeInsertPurchOrderLine(PurchOrderLine, PurchOrderHeader, PurchQuoteLine, PurchQuoteHeader);
                    PurchOrderLine.Insert();
                    OnAfterInsertPurchOrderLine(PurchQuoteLine, PurchOrderLine);
                    PurchLineReserve.VerifyQuantity(PurchOrderLine, PurchQuoteLine);
                    OnTransferQuoteToOrderLinesOnAfterVerifyQuantity(PurchOrderLine, PurchOrderHeader, PurchQuoteLine, PurchQuoteHeader);
                end;
            until PurchQuoteLine.Next() = 0;
    end;

    local procedure ValidatePurchOrderLinePrepaymentPct(var PurchOrderLine: Record "Purchase Line")
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeValidatePurchOrderLinePrepaymentPct(PurchOrderLine, IsHandled);
        if IsHandled then
            exit;

        PurchOrderLine.Validate("Prepayment %");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterRun(var PurchaseHeader: Record "Purchase Header"; PurchOrderHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeArchivePurchaseQuote(var PurchaseHeader: Record "Purchase Header"; PurchaseOrderHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeRun(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCreatePurchHeader(var PurchaseHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDeletePurchQuote(var QuotePurchHeader: Record "Purchase Header"; var OrderPurchHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertPurchOrderLine(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertPurchOrderLine(var PurchaseQuoteLine: Record "Purchase Line"; var PurchaseOrderLine: Record "Purchase Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterInsertAllPurchOrderLines(var PurchOrderLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeTransferQuoteLineToOrderLineLoop(var PurchQuoteLine: Record "Purchase Line"; var PurchQuoteHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidatePurchOrderLinePrepaymentPct(var PurchOrderLine: Record "Purchase Line"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreatePurchHeaderOnBeforeInitRecord(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreatePurchHeaderOnAfterInitFromPurchHeader(var PurchOrderHeader: Record "Purchase Header"; PurchHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreatePurchHeaderOnBeforePurchOrderHeaderInsert(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreatePurchHeaderOnAfterPurchOrderHeaderInsert(var PurchOrderHeader: Record "Purchase Header"; BlanketOrderPurchHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnCreatePurchHeaderOnBeforePurchOrderHeaderModify(var PurchOrderHeader: Record "Purchase Header"; var PurchHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreatePurchHeader(var PurchOrderHeader: Record "Purchase Header"; PurchHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTransferQuoteToOrderLinesOnAfterPurchQuoteLineSetFilters(var PurchQuoteLine: Record "Purchase Line"; var PurchQuoteHeader: Record "Purchase Header"; PurchOrderHeader: Record "Purchase Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnTransferQuoteToOrderLinesOnAfterVerifyQuantity(var PurchOrderLine: Record "Purchase Line"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; PurchQuoteHeader: Record "Purchase Header")
    begin
    end;
}

