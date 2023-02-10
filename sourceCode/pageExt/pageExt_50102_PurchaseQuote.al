pageextension 50102 PurchaseQuote extends "Purchase Quote"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Requisition No."; Rec."Requisition No.")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field(Preparer; Rec.Preparer)
            {
                Editable = false;
                Caption = 'Preparer';
                ApplicationArea = All;
            }
            field(Requestor; Rec.Requestor)
            {
                Editable = false;
                Caption = 'Requester';
                ApplicationArea = All;
            }
            field("Requisition Purpose"; Rec."Requisition Purpose")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Requisition Reason"; Rec."Requisition Reason")
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Request Date"; Rec."Request Date")
            {
                Editable = false;
                ApplicationArea = All;
            }
            group(requitionDetailsGroup)
            {
                Caption = 'Requisition Details';
                field(requitionDetails; requitionDetails)
                {
                    Editable = false;
                    MultiLine = true;
                    ApplicationArea = All;
                    Importance = Additional;
                    ShowCaption = false;
                    trigger OnValidate()
                    begin
                        Rec.setRequitionDetails(requitionDetails);
                    end;
                }
            }
        }
    }
    var
        requitionDetails: Text;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        requitionDetails := Rec.getRequitionDetails();
    end;
}