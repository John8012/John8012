tableextension 50108 SalesReceivablesSetup extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "CEO Email"; Text[80])
        {
            DataClassification = CustomerContent;
        }
    }
}