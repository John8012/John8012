page 50155 SalesInvoiceLine
{
    PageType = API;
    APIGroup = 'cic';
    APIPublisher = 'cic';
    APIVersion = 'v1.0';
    Caption = 'salesInvoice';
    DelayedInsert = true;
    EntityName = 'cicSalesInvoiceLine';
    EntitySetName = 'cicSalesInvoiceLines';
    SourceTable = "Sales Line";
    SourceTableView = where("Document Type" = filter(Invoice));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(lineType; Rec.Type)
                { }
                field(lineObjectNumber; Rec."No.")
                { }
                field(description; Rec.Description)
                { }
                field(unitPrice; Rec."Unit Price")
                { }
                field(quantity; Rec.Quantity)
                { }
                field(discountAmount; Rec."Line Discount Amount")
                { }
                field(discountPercent; Rec."Line Discount %")
                { }
            }
        }
    }
}