pageextension 50104 BankAccountCard extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Default Bank"; Rec."Default Bank")
            {
                ApplicationArea = All;
            }
        }
    }
}