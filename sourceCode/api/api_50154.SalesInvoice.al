page 50154 SalesInvoice
{
    PageType = API;
    APIGroup = 'cic';
    APIPublisher = 'cic';
    APIVersion = 'v1.0';
    Caption = 'salesInvoice';
    DelayedInsert = true;
    EntityName = 'cicSalesInvoice';
    EntitySetName = 'cicSalesInvoices';
    SourceTable = "Sales Header";
    ODataKeyFields = SystemId;
    SourceTableView = where("Document Type" = filter(Invoice));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(id; Rec.SystemId)
                { }
                field(number; Rec."No.")
                { }
                field(customerNumber; Rec."Sell-to Customer No.")
                { }
                field(externalDocumentNumber; Rec."External Document No.")
                { }
                field(levyInvoice; Rec."Levy Invoice")
                { }
                field(partitionKey; Rec."Partition Key")
                { }
                field(formName; Rec."Form Name")
                { }
            }
        }
    }
}