pageextension 50109 SalesInvoice extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Form Name"; Rec."Form Name")
            {
                ApplicationArea = all;
            }
            field("Partition Key"; Rec."Partition Key")
            {
                ApplicationArea = All;
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