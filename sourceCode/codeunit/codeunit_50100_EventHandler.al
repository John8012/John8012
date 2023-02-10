codeunit 50100 EventHandler
{

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterTestNoSeries', '', true, true)]
    local procedure "Purchase Header_OnAfterTestNoSeries"
    (
        var PurchHeader: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup"
    )
    begin
        case PurchHeader."Document Type" of
            "Purchase Document Type"::Requisition:
                PurchSetup.TestField("Requisition No.");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterGetNoSeriesCode', '', true, true)]
    local procedure "Purchase Header_OnAfterGetNoSeriesCode"
    (
        var PurchHeader: Record "Purchase Header";
        PurchSetup: Record "Purchases & Payables Setup";
        var NoSeriesCode: Code[20]
    )
    begin
        case PurchHeader."Document Type" of
            "Purchase Document Type"::Requisition:
                NoSeriesCode := PurchSetup."Requisition No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCheckBuyFromVendorNo', '', true, true)]
    local procedure "Purchase Line_OnBeforeCheckBuyFromVendorNo"
    (
        PurchaseHeader: Record "Purchase Header";
        var IsHandled: Boolean
    )
    begin
        case PurchaseHeader."Document Type" of
            "Purchase Document Type"::Requisition:
                IsHandled := true
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateVATProdPostingGroup', '', true, true)]
    local procedure "Purchase Line_OnBeforeValidateVATProdPostingGroup"
    (
        var PurchaseLine: Record "Purchase Line";
        xPurchaseLine: Record "Purchase Line";
        var IsHandled: Boolean
    )
    begin
        case PurchaseLine."Document Type" of
            "Purchase Document Type"::Requisition:
                IsHandled := true
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnUpdateDirectUnitCostOnBeforeFindPrice', '', true, true)]
    local procedure "Purchase Line_OnUpdateDirectUnitCostOnBeforeFindPrice"
    (
        PurchaseHeader: Record "Purchase Header";
        var PurchaseLine: Record "Purchase Line";
        CalledByFieldNo: Integer;
        CallingFieldNo: Integer;
        var IsHandled: Boolean
    )
    begin
        case PurchaseLine."Document Type" of
            "Purchase Document Type"::Requisition:
                IsHandled := true
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Enum Assignment Management", 'OnGetPurchApprovalDocumentType', '', true, true)]
    local procedure "Enum Assignment Management_OnGetPurchApprovalDocumentType"
    (
        PurchDocumentType: Enum "Purchase Document Type";
        var ApprovalDocumentType: Enum "Approval Document Type";
        var IsHandled: Boolean
    )
    begin
        case PurchDocumentType of
            PurchDocumentType::Requisition:
                begin
                    IsHandled := true;
                    ApprovalDocumentType := ApprovalDocumentType::Requisition;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforePerformManualRelease', '', true, true)]
    local procedure "Release Purchase Document_OnBeforePerformManualRelease"
    (
        var PurchaseHeader: Record "Purchase Header";
        PreviewMode: Boolean;
        var IsHandled: Boolean
    )
    begin
        case PurchaseHeader."Document Type" of
            "Purchase Document Type"::Requisition:
                begin
                    IsHandled := true;
                    PurchaseHeader.Status := PurchaseHeader.Status::Released;
                    PurchaseHeader.Modify(true)
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure "Approvals Mgmt._OnPopulateApprovalEntryArgument"
       (
           var RecRef: RecordRef;
           var ApprovalEntryArgument: Record "Approval Entry";
           WorkflowStepInstance: Record "Workflow Step Instance"
       )
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        case RecRef.Number of
            database::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseHeader);
                    ApprovalEntryArgument."Document No." := PurchaseHeader."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := PurchaseHeader."Purchaser Code";
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Notification Management", 'OnGetDocumentTypeAndNumber', '', true, true)]
    local procedure "Notification Management_OnGetDocumentTypeAndNumber"
    (
        var RecRef: RecordRef;
        var DocumentType: Text;
        var DocumentNo: Text;
        var IsHandled: Boolean
    )
    var
        FieldRef: FieldRef;
    begin
        DocumentType := RecRef.Caption;
        FieldRef := RecRef.Field(1);
        DocumentNo := Format(FieldRef.Value);
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure "Workflow Response Handling_OnReleaseDocument"
   (
       RecRef: RecordRef;
       var Handled: Boolean
   )
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        case RecRef.Number of
            database::"Purchase Header":
                begin
                    RecRef.SetTable(PurchaseHeader);
                    PurchaseHeader.Status := PurchaseHeader.Status::Released;
                    PurchaseHeader.Modify();
                    Handled := true
                end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnBeforeModifyHeader', '', true, true)]
    local procedure "Release Purchase Document_OnCodeOnBeforeModifyHeader"
    (
        var PurchaseHeader: Record "Purchase Header";
        var PurchaseLine: Record "Purchase Line";
        PreviewMode: Boolean;
        var LinesWereModified: Boolean
    )
    begin
        PurchaseHeader."Requisition Status" := PurchaseHeader."Requisition Status"::Approved;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReopenPurchaseDoc', '', true, true)]
    local procedure "Release Purchase Document_OnAfterReopenPurchaseDoc"
    (
        var PurchaseHeader: Record "Purchase Header";
        PreviewMode: Boolean
    )
    begin
        PurchaseHeader."Requisition Status" := PurchaseHeader."Requisition Status"::Open;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequestsForRecordOnAfterCreateApprovalEntryNotification', '', true, true)]
    local procedure "Approvals Mgmt._OnRejectApprovalRequestsForRecordOnAfterCreateApprovalEntryNotification"
    (
        var ApprovalEntry: Record "Approval Entry";
        WorkflowStepInstance: Record "Workflow Step Instance";
        OldStatus: Enum "Approval Status"
    )
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("Document Type", ApprovalEntry."Document Type");
        PurchaseHeader.SetRange("No.", ApprovalEntry."Document No.");
        if PurchaseHeader.FindFirst() then begin
            PurchaseHeader."Requisition Status" := PurchaseHeader."Requisition Status"::Rejected;
            PurchaseHeader.Modify(true);
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnCreatePurchHeaderOnBeforePurchOrderHeaderInsert', '', true, true)]
    local procedure "Purch.-Quote to Order_OnCreatePurchHeaderOnBeforePurchOrderHeaderInsert"
    (
        var PurchOrderHeader: Record "Purchase Header";
        var PurchHeader: Record "Purchase Header"
    )
    begin
        PurchOrderHeader."Requisition No." := PurchHeader."Requisition No.";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnRecreatePurchLinesOnBeforeTempPurchLineInsert', '', true, true)]
    local procedure "Purchase Header_OnRecreatePurchLinesOnBeforeTempPurchLineInsert"
    (
        var TempPurchaseLine: Record "Purchase Line";
        PurchaseLine: Record "Purchase Line"
    )
    begin
        TempPurchaseLine."Requisition Line No." := PurchaseLine."Requisition Line No.";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnRecreatePurchLinesOnBeforeInsertPurchLine', '', true, true)]
    local procedure "Purchase Header_OnRecreatePurchLinesOnBeforeInsertPurchLine"
    (
        var PurchaseLine: Record "Purchase Line";
        var TempPurchaseLine: Record "Purchase Line";
        ChangedFieldName: Text[100]
    )
    begin
        PurchaseLine."Requisition Line No." := TempPurchaseLine."Requisition Line No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeInsertPurchOrderLine', '', true, true)]
    local procedure "Purch.-Quote to Order_OnBeforeInsertPurchOrderLine"
    (
        var PurchOrderLine: Record "Purchase Line";
        PurchOrderHeader: Record "Purchase Header";
        PurchQuoteLine: Record "Purchase Line";
        PurchQuoteHeader: Record "Purchase Header"
    )
    begin
        PurchOrderLine."Requisition Line No." := PurchQuoteLine."Requisition Line No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", 'OnBeforeDeletePurchQuote', '', true, true)]
    local procedure "Purch.-Quote to Order_OnBeforeDeletePurchQuote"
    (
        var QuotePurchHeader: Record "Purchase Header";
        var OrderPurchHeader: Record "Purchase Header";
        var IsHandled: Boolean
    )
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order (Yes/No)", 'OnAfterCreatePurchOrder', '', true, true)]
    local procedure "Purch.-Quote to Order (Yes/No)_OnAfterCreatePurchOrder"
    (
        var PurchaseHeader: Record "Purchase Header";
        var IsHandled: Boolean
    )
    var
        PurchaseQuoteHeader: Record "Purchase Header";
        purchaseRequisitionHeader: Record "Purchase Header";
        purchaseRequisitionLine: Record "Purchase Line";
        purchaseQuoteLine: Record "Purchase Line";
    begin
        PurchaseQuoteHeader.Reset();
        PurchaseQuoteHeader.SetFilter("Document Type", '%1', PurchaseQuoteHeader."Document Type"::Quote);
        PurchaseQuoteHeader.SetRange("Requisition No.", PurchaseHeader."Requisition No.");
        PurchaseQuoteHeader.SetFilter("No.", '<>%1', PurchaseHeader."Quote No.");
        if PurchaseQuoteHeader.FindSet() then begin
            PurchaseQuoteHeader.ModifyAll(PurchaseQuoteHeader.Status, PurchaseQuoteHeader.Status::Rejected);
        end;

        PurchaseQuoteHeader.Reset();
        PurchaseQuoteHeader.SetFilter("Document Type", '%1', PurchaseQuoteHeader."Document Type"::Quote);
        PurchaseQuoteHeader.SetRange("Requisition No.", PurchaseHeader."Requisition No.");
        PurchaseQuoteHeader.SetRange("No.", PurchaseHeader."Quote No.");
        if PurchaseQuoteHeader.FindSet() then begin
            PurchaseQuoteHeader.Status := PurchaseQuoteHeader.Status::Awarded;
            PurchaseQuoteHeader.Modify();

            purchaseRequisitionHeader.Reset();
            purchaseRequisitionHeader.SetFilter("Document Type", '%1', purchaseRequisitionHeader."Document Type"::Requisition);
            purchaseRequisitionHeader.SetRange("No.", PurchaseQuoteHeader."Requisition No.");
            if purchaseRequisitionHeader.FindFirst() then begin
                purchaseRequisitionHeader.Status := purchaseRequisitionHeader.Status::Open;
                purchaseRequisitionHeader.Modify();
                purchaseQuoteLine.Reset();
                purchaseQuoteLine.SetRange("Document Type", PurchaseQuoteHeader."Document Type");
                purchaseQuoteLine.SetRange("Document No.", PurchaseQuoteHeader."No.");
                if purchaseQuoteLine.FindSet() then begin
                    repeat
                        purchaseRequisitionLine.Reset();
                        purchaseRequisitionLine.SetFilter("Document Type", '%1', purchaseRequisitionLine."Document Type"::Requisition);
                        purchaseRequisitionLine.SetRange("Document No.", PurchaseQuoteHeader."Requisition No.");
                        purchaseRequisitionLine.SetRange("Line No.", purchaseQuoteLine."Requisition Line No.");
                        if purchaseRequisitionLine.FindFirst() then begin
                            purchaseRequisitionLine.Validate("Direct Unit Cost", purchaseQuoteLine."Direct Unit Cost");
                            purchaseRequisitionLine.Modify();
                        end;
                    until purchaseQuoteLine.Next() = 0;
                end;
                purchaseRequisitionHeader.Status := purchaseRequisitionHeader.Status::Released;
                purchaseRequisitionHeader.Modify();
            end;
        end;

        purchaseRequisitionHeader.Reset();
        purchaseRequisitionHeader.SetFilter("Document Type", '%1', purchaseRequisitionHeader."Document Type"::Requisition);
        purchaseRequisitionHeader.SetRange("No.", PurchaseHeader."Requisition No.");
        if purchaseRequisitionHeader.FindFirst() then begin
            purchaseRequisitionHeader."Purchase Order No." := PurchaseHeader."No.";
            purchaseRequisitionHeader.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostUpdateOrderLineOnBeforeUpdateBlanketOrderLine', '', true, true)]
    local procedure "Purch.-Post_OnPostUpdateOrderLineOnBeforeUpdateBlanketOrderLine"
    (
        var PurchaseHeader: Record "Purchase Header";
        var TempPurchaseLine: Record "Purchase Line"
    )
    var
        purchaseRequisitionLine: Record "Purchase Line";
        PurchaseRequisitionHeader: Record "Purchase Header";
    begin
        purchaseRequisitionLine.Reset();
        purchaseRequisitionLine.SetFilter("Document Type", '%1', purchaseRequisitionLine."Document Type"::Requisition);
        purchaseRequisitionLine.SetRange("Document No.", PurchaseHeader."Requisition No.");
        purchaseRequisitionLine.SetRange("Line No.", TempPurchaseLine."Requisition Line No.");
        if purchaseRequisitionLine.FindFirst() then begin
            if PurchaseHeader.Receive then begin
                purchaseRequisitionLine."Quantity Received" := TempPurchaseLine."Quantity Received";
                purchaseRequisitionLine."Qty. Received (Base)" := TempPurchaseLine."Qty. Received (Base)";
            end;
            if PurchaseHeader.Invoice then begin
                purchaseRequisitionLine."Quantity Invoiced" := TempPurchaseLine."Quantity Invoiced";
                purchaseRequisitionLine."Qty. Invoiced (Base)" := TempPurchaseLine."Qty. Invoiced (Base)";
                PurchaseRequisitionHeader.Reset();
                PurchaseRequisitionHeader.SetRange("Document Type", purchaseRequisitionLine."Document Type");
                PurchaseRequisitionHeader.SetRange("No.", purchaseRequisitionLine."Document No.");
                if PurchaseRequisitionHeader.FindFirst() then begin
                    PurchaseRequisitionHeader."Requisition Status" := PurchaseRequisitionHeader."Requisition Status"::Invoiced;
                    PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Invoiced;
                    PurchaseRequisitionHeader.Modify();
                end;
            end;
            purchaseRequisitionLine.Modify();
            purchaseRequisitionLine."Qty. to Receive" := purchaseRequisitionLine.Quantity - purchaseRequisitionLine."Quantity Received";
            purchaseRequisitionLine."Qty. to Invoice" := purchaseRequisitionLine."Quantity Received" - purchaseRequisitionLine."Quantity Invoiced";
            purchaseRequisitionLine."Qty. to Receive (Base)" := purchaseRequisitionLine."Quantity (Base)" - purchaseRequisitionLine."Qty. Received (Base)";
            purchaseRequisitionLine."Qty. to Invoice (Base)" := purchaseRequisitionLine."Qty. Received (Base)" - purchaseRequisitionLine."Qty. Invoiced (Base)";
            purchaseRequisitionLine.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnFinalizePostingOnBeforeUpdateAfterPosting', '', true, true)]
    local procedure "Purch.-Post_OnFinalizePostingOnBeforeUpdateAfterPosting"
    (
        var PurchHeader: Record "Purchase Header";
        var TempDropShptPostBuffer: Record "Drop Shpt. Post. Buffer";
        var EverythingInvoiced: Boolean;
        var IsHandled: Boolean;
        var TempPurchLine: Record "Purchase Line"
    )
    var
        purchaseRequisitionLine: Record "Purchase Line";
        PurchaseRequisitionHeader: Record "Purchase Header";
    begin
        purchaseRequisitionLine.Reset();
        purchaseRequisitionLine.SetFilter("Document Type", '%1', purchaseRequisitionLine."Document Type"::Requisition);
        purchaseRequisitionLine.SetRange("Document No.", PurchHeader."Requisition No.");
        purchaseRequisitionLine.SetRange("Line No.", TempPurchLine."Requisition Line No.");
        if purchaseRequisitionLine.FindFirst() then begin
            clear(purchaseRequisitionLine."Qty. to Invoice");
            clear(purchaseRequisitionLine."Qty. to Receive");
            purchaseRequisitionLine."Quantity Invoiced" := TempPurchLine."Quantity Invoiced";
            purchaseRequisitionLine."Quantity Received" := TempPurchLine."Quantity Received";
            purchaseRequisitionLine."Qty. Received (Base)" := TempPurchLine."Qty. Received (Base)";
            purchaseRequisitionLine."Qty. Invoiced (Base)" := TempPurchLine."Qty. Invoiced (Base)";
            purchaseRequisitionLine.Modify();
            purchaseRequisitionLine."Qty. to Invoice" := purchaseRequisitionLine."Quantity Received" - purchaseRequisitionLine."Quantity Invoiced";
            purchaseRequisitionLine."Qty. to Receive" := purchaseRequisitionLine.Quantity - purchaseRequisitionLine."Quantity Received";
            purchaseRequisitionLine.Modify();
            PurchaseRequisitionHeader.Reset();
            PurchaseRequisitionHeader.SetRange("Document Type", purchaseRequisitionLine."Document Type");
            PurchaseRequisitionHeader.SetRange("No.", purchaseRequisitionLine."Document No.");
            if PurchaseRequisitionHeader.FindFirst() then begin
                PurchaseRequisitionHeader."Requisition Status" := PurchaseRequisitionHeader."Requisition Status"::Invoiced;
                PurchaseRequisitionHeader.Status := PurchaseRequisitionHeader.Status::Invoiced;
                PurchaseRequisitionHeader.Modify();
            end;
        end;
    end;



    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Inv. - Update", 'OnAfterRecordChanged', '', true, true)]
    local procedure "Posted Sales Inv. - Update_OnAfterRecordChanged"
    (
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        xSalesInvoiceHeader: Record "Sales Invoice Header";
        var IsChanged: Boolean
    )
    begin
        IsChanged := IsChanged or (SalesInvoiceHeader."Payment Status" <> xSalesInvoiceHeader."Payment Status");
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Inv. Header - Edit", 'OnOnRunOnBeforeTestFieldNo', '', true, true)]
    local procedure "Sales Inv. Header - Edit_OnOnRunOnBeforeTestFieldNo"
    (
        var SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceHeaderRec: Record "Sales Invoice Header"
    )
    var
        EmailNotification: Codeunit EmailNotification;
        UpdateAzureFormStatus: Codeunit UpdateAzureFormStatus;
    begin
        SalesInvoiceHeader."Payment Status" := SalesInvoiceHeaderRec."Payment Status";
        if SalesInvoiceHeaderRec."Payment Status" = SalesInvoiceHeaderRec."Payment Status"::Completed then begin
            EmailNotification.SendNotificationToCEO(SalesInvoiceHeaderRec);
            UpdateAzureFormStatus.PaymentCompletedNotification(SalesInvoiceHeaderRec);
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    local procedure "Sales-Post_OnAfterPostSalesDoc"
    (
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        RetRcpHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        WhseReceiv: Boolean
    )
    var
        SalesInvLine: Record "Sales Invoice Line";
        Customer: Record Customer;
        SalesInvHeader: Record "Sales Invoice Header";
        RegistrationDetails: Record "Registration Details";
        ProjectDetails: Record "Project Details";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then begin
            ProjectDetails.Reset();
            ProjectDetails.SetRange("Invoice No.", SalesHeader."No.");
            if ProjectDetails.FindFirst() then begin
                ProjectDetails."Posted Invoice No." := SalesInvHdrNo;
                ProjectDetails.Modify();
            end;

            SalesInvLine.SetRange("Document No.", SalesInvHdrNo);
            SalesInvLine.SetFilter(Type, '%1', SalesInvLine.Type::"G/L Account");
            SalesInvLine.SetFilter("No.", '%1|%2', '1000/005', '1000/004');
            if SalesInvLine.FindSet() then begin
                repeat
                    RegistrationDetails.Reset();
                    RegistrationDetails.SetRange("Invoice No.", SalesHeader."No.");
                    if RegistrationDetails.FindFirst() then begin
                        RegistrationDetails."Posted Invoice No." := SalesInvHdrNo;
                        if SalesInvLine."No." = '1000/005' then //Admin Fee
                            RegistrationDetails."Admin Fee" := SalesInvLine."Line Amount";
                        if SalesInvLine."No." = '1000/004' then //Reg Fee
                            RegistrationDetails."Registration Fee" := SalesInvLine."Line Amount";
                        RegistrationDetails.Modify();
                    end;
                until SalesInvLine.Next() = 0;
            end;
            AttachDocumentBlobStorage(SalesInvHdrNo);
        end;
    end;

    local procedure AttachDocumentBlobStorage(SalesInvHdrNo: Code[20])
    var
        Authorization: Interface "Storage Service Authorization";
        ABSContainersetup: Record "AZBSA Blob Storage Connection";
        APIStorageConnection: Codeunit "AZBSA Blob Storage API";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        InS: InStream;
        OutS: OutStream;
        tempBlob: Codeunit "Temp Blob";
        Filename: Text;
        returnValue: Boolean;
        RecRef: RecordRef;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Base64Convert: Codeunit "Base64 Convert";
        base64Text: Text;
        DummyReportSelections: Record "Report Selections";
        response: text;
    begin
        //Copy from outstream to instream
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", SalesInvHdrNo);
        if SalesInvoiceHeader.FindFirst() then begin
            Clear(RecRef);
            Clear(OutS);
            Clear(InS);
            Clear(tempBlob);
            RecRef.GetTable(SalesInvoiceHeader);
            tempBlob.CreateOutStream(OutS);
            // returnValue := Report.SaveAs(Report::"Contract Invoice", '', ReportFormat::Pdf, OutS, RecRef);

            DummyReportSelections.SetFilter(Usage, '%1', DummyReportSelections.Usage::"S.Invoice");
            DummyReportSelections.SetFilter(Sequence, '%1', '1');
            if DummyReportSelections.FindFirst() then;
            returnValue := Report.SaveAs(DummyReportSelections."Report ID", '', ReportFormat::Pdf, OutS, RecRef);

            tempBlob.CreateInStream(InS);

            Filename := SalesInvoiceHeader."Bill-to Customer No." + '/' + SalesInvoiceHeader."Bill-to Customer No." + '-' + SalesInvoiceHeader."No." + '-SalesInvoice.pdf';
            if ABSContainersetup.FindFirst() then;
            ABSContainersetup.UploadFile(Filename, InS);
            EmailInvoiceToCustomer(SalesInvHdrNo);
        end;
    end;


    procedure EmailInvoiceToCustomer(docNo: Code[20])
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        tempBlob: Codeunit "Temp Blob";
        Filename: Text;
        returnValue: Boolean;
        RecRef: RecordRef;
        CustRecRef: RecordRef;
        sendMail: Boolean;
        eMail: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailID: List of [Text];
        varseparator: Text;
        varEmail: list of [Text];
        varEmailCount: Integer;
        Subject: Text;
        Body: Text;
        AttachmentName: Text;
        BlobInStream: InStream;
        BlobOutStream: OutStream;
        BlobCustInStream: InStream;
        BlobCustOutStream: OutStream;
        DummyReportSelections: Record "Report Selections";
        ContractorStatement: Report "Contractor Statement";
    begin
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", docNo);
        if SalesInvoiceHeader.FindFirst() then begin
            RecRef.GetTable(SalesInvoiceHeader);
            Customer.Reset;
            if customer.get(SalesInvoiceHeader."Sell-to Customer No.") then;
            if Customer."E-Mail" = '' then
                exit;

            Clear(EmailID);
            Clear(varEmail);
            SalesInvoiceHeader.CalcFields(Amount, "Amount Including VAT");
            varseparator := ';';
            if Customer."E-Mail" <> '' then begin
                if StrPos(Customer."E-Mail", varseparator) <> 0 then begin
                    varEmail := Customer."E-Mail".Split(varseparator);
                    for varEmailCount := 1 to varEmail.Count do begin
                        EmailID.Add(varEmail.Get(varEmailCount));
                    end;
                end else
                    EmailID.Add(Customer."E-Mail");
            end;

            CLEAR(Body);

            Subject := StrSubstNo('Invoice : %1 dated %2', SalesInvoiceHeader."No.", Format(SalesInvoiceHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'));

            Body := 'Dear ' + Customer.Name + ' - ' + Customer."No." + ', <br> <br> I hope you’re well. Please see attached invoice number ' + SalesInvoiceHeader."No." + ', ';

            Body += 'payment E ' + format(SalesInvoiceHeader."Amount Including VAT") + ' due on ' + Format(SalesInvoiceHeader."Due Date", 0, '<Day,2>/<Month,2>/<Year4>');

            Body += '.<br> Please let us know when we can expect to receive payment for this invoice. If you have any queries, don’t hesitate to let us know.';

            Body += '<br> <br> Kind regards,';

            Body += '<br> <br> Accounts Admin';

            EmailMessage.Create(EmailID, Subject, Body, true);

            clear(BlobInStream);
            Clear(BlobOutStream);
            Clear(tempBlob);
            Clear(AttachmentName);
            TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
            DummyReportSelections.SetFilter(Usage, '%1', DummyReportSelections.Usage::"S.Invoice");
            DummyReportSelections.SetFilter(Sequence, '%1', '1');
            if DummyReportSelections.FindFirst() then;
            returnValue := Report.SaveAs(DummyReportSelections."Report ID", '', ReportFormat::Pdf, BlobOutStream, RecRef);
            TempBlob.CreateInStream(BlobInStream, TextEncoding::UTF8);
            AttachmentName := 'Sales Invoice.pdf';
            EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobInStream);
            Customer.Reset();
            if Customer.get(SalesInvoiceHeader."Sell-to Customer No.") then;

            CustRecRef.GetTable(Customer);
            Clear(tempBlob);
            Clear(BlobCustInStream);
            Clear(BlobCustOutStream);
            Clear(AttachmentName);
            TempBlob.CreateOutStream(BlobCustOutStream, TextEncoding::UTF8);
            ContractorStatement.InitializeRequestfromMail(CalcDate('-1Y', Today), SalesInvoiceHeader."Posting Date", true, Customer."No.");
            returnValue := ContractorStatement.SaveAs('', ReportFormat::Pdf, BlobCustOutStream, CustRecRef);
            TempBlob.CreateInStream(BlobCustInStream, TextEncoding::UTF8);
            AttachmentName := 'Contractor Statement.pdf';
            EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobCustInStream);

            CLEAR(eMail);
            if eMail.Send(EmailMessage) then;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateNo', '', true, true)]
    local procedure "Purchase Line_OnBeforeValidateNo"
    (
        var PurchaseLine: Record "Purchase Line";
        xPurchaseLine: Record "Purchase Line";
        CurrentFieldNo: Integer;
        var IsHandled: Boolean
    )
    begin
        IF PurchaseLine."Document Type" = PurchaseLine."Document Type"::Requisition then begin
            PurchaseLine."No." := PurchaseLine.FindOrCreateRecordByNo(PurchaseLine."No.");

            PurchaseLine.TestStatusOpen();
            PurchaseLine.TestField("Qty. Rcd. Not Invoiced", 0);
            PurchaseLine.TestField("Quantity Received", 0);
            PurchaseLine.TestField("Receipt No.", '');

            case PurchaseLine.Type of
                PurchaseLine.Type::"G/L Account":
                    CopyFromGLAccount(PurchaseLine);
            end;
            IsHandled := true;
        end;
    end;

    local procedure CopyFromGLAccount(var PurchaseLine: Record "Purchase Line")
    var
        GLAcc: Record "G/L Account";
    begin
        GLAcc.Get(PurchaseLine."No.");
        GLAcc.CheckGLAcc;
        GLAcc.TestField("Direct Posting", true);
        PurchaseLine.Description := GLAcc.Name;
        PurchaseLine."Gen. Prod. Posting Group" := GLAcc."Gen. Prod. Posting Group";
        PurchaseLine."VAT Prod. Posting Group" := GLAcc."VAT Prod. Posting Group";
        PurchaseLine."Tax Group Code" := GLAcc."Tax Group Code";
        PurchaseLine."Allow Invoice Disc." := false;
        PurchaseLine."Allow Item Charge Assignment" := false;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforeDeleteAfterPosting', '', true, true)]
    local procedure "Purch.-Post_OnBeforeDeleteAfterPosting"
    (
        var PurchaseHeader: Record "Purchase Header";
        var PurchInvHeader: Record "Purch. Inv. Header";
        var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        var SkipDelete: Boolean;
        CommitIsSupressed: Boolean;
        var TempPurchLine: Record "Purchase Line";
        var TempPurchLineGlobal: Record "Purchase Line"
    )
    var
        purchaseLine: Record "Purchase Line";
    begin
        SkipDelete := true;
    end;
}