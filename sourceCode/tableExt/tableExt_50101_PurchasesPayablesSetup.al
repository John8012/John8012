tableextension 50101 PurchasesPayablesSetup extends "Purchases & Payables Setup"
{
    fields
    {
        field(50100; "Requisition No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}