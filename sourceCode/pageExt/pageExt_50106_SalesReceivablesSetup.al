pageextension 50106 SalesReceivablesSetup extends "Sales & Receivables Setup"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("CEO Email"; Rec."CEO Email")
            {
                ApplicationArea = All;
            }
        }
    }
}