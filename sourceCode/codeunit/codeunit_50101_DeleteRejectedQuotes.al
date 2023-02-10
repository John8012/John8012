codeunit 50101 DeleteRejectedQuotes
{
    trigger OnRun()
    begin
        DeleteRejectedQuotes;
    end;

    local procedure DeleteRejectedQuotes()
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetFilter("Document Type", '%1', PurchaseHeader."Document Type"::Quote);
        PurchaseHeader.SetFilter("Requisition Status", '%1', PurchaseHeader."Requisition Status"::Rejected);
        if PurchaseHeader.FindSet() then
            PurchaseHeader.DeleteAll(true);
    end;
}