tableextension 50107 SalesInvoiceHeader extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Payment Status"; Option)
        {
            OptionMembers = Pending,Completed;
        }
        field(50001; "Levy Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Partition Key"; Text[1024])
        {
        }
        field(50005; "Form Name"; Text[20])
        { }
    }
}