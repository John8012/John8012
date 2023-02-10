tableextension 50106 BankAccount extends "Bank Account"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Default Bank"; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }
}