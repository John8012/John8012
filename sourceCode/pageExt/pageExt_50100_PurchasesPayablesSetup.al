pageextension 50100 PurchaseSetup extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Order Nos.")
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                ApplicationArea = All;
                Caption = 'Requisition No.';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}