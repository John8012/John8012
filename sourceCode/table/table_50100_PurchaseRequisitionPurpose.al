table 50100 "Purchase Requisition Purpose"
{
    LookupPageId = "Purchase Requisition Purpose";
    DrillDownPageId = "Purchase Requisition Purpose";

    fields
    {
        field(1; code; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; code)
        {
            Clustered = true;
        }
    }
}