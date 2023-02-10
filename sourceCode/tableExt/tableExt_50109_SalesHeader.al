tableextension 50109 SalesHeader extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Levy Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Remaining Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Remaining Amount';
            Editable = false;
        }
        field(50003; "Amount Paid"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Paid';
        }
        field(50004; "Partition Key"; Text[1024])
        {
        }
        field(50005; "Form Name"; Text[20])
        { }
    }
}