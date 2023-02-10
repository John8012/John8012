codeunit 50103 "Purch.-Req to Quote (Yes/No)"
{
    TableNo = "Purchase Header";

    trigger OnRun()
    var
        ConfirmManagement: Codeunit "Confirm Management";
        IsHandled: Boolean;
    begin
        Rec.TestField("Document Type", Rec."Document Type"::Requisition);
        if not ConfirmManagement.GetResponseOrDefault(ConvertQuoteToOrderQst, true) then
            exit;

        IsHandled := false;
        OnBeforePurchQuoteToOrder(Rec, IsHandled);
        if IsHandled then
            exit;

        PurchReqToQuote.Run(Rec);
        PurchReqToQuote.GetPurchOrderHeader(PurchOrderHeader);

        IsHandled := false;
        OnAfterCreatePurchOrder(PurchOrderHeader, IsHandled);
        if not IsHandled then
            if ConfirmManagement.GetResponseOrDefault(StrSubstNo(OpenNewOrderQst, PurchOrderHeader."No."), true) then
                PAGE.Run(PAGE::"Purchase Quote", PurchOrderHeader);
    end;

    var
        ConvertQuoteToOrderQst: Label 'Do you want to convert the requisition to an quote?';
        PurchOrderHeader: Record "Purchase Header";
        PurchReqToQuote: Codeunit "Purch.-Requisition to Quote";
        OpenNewOrderQst: Label 'The requisition has been converted to quote number %1. Do you want to open the new quote?', Comment = '%1 - No. of new purchase quote.';

    [IntegrationEvent(false, false)]
    local procedure OnAfterCreatePurchOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePurchQuoteToOrder(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean)
    begin
    end;
}

