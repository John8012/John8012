pageextension 50105 PostedSalesInvoiceUpdate extends "Posted Sales Inv. - Update"
{
    layout
    {
        // Add changes to page layout here
        addlast(Payment)
        {
            field("Payment Status"; Rec."Payment Status")
            {
                ApplicationArea = All;
            }
        }
    }
    procedure SetLevyRec(SalesInvoiceHeader: Record "Sales Invoice Header")
    begin
        Rec := SalesInvoiceHeader;
        Rec.Insert();
    end;
}