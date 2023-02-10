pageextension 50107 PurchaseQuotes extends "Purchase Quotes"
{
    layout
    {
        // Add changes to page layout here
        addafter("Buy-from Vendor Name")
        {
            field(Amount; Rec.Amount)
            {
                ApplicationArea = All;
            }
        }
        modify(Status)
        {
            Visible = true;
        }
        addlast(Control1)
        {
            field("Modified By"; Rec."Modified By")
            {
                ApplicationArea = All;
            }
        }
    }
}