page 50153 createCustomerAPI
{
    APIGroup = 'cic';
    APIPublisher = 'cic';
    APIVersion = 'v1.0';
    Caption = 'createCustomerAPI';
    DelayedInsert = true;
    EntityName = 'createCustomer';
    EntitySetName = 'createCustomers';
    PageType = API;
    SourceTable = Customer;
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                { ApplicationArea = All; }
                field(customerNumber; Rec."No.")
                { ApplicationArea = All; }
                field(displayName; Rec.Name)
                { ApplicationArea = All; }
                field(email; rec."E-Mail")
                { ApplicationArea = All; }
                field(phoneNumber; rec."Phone No.")
                { ApplicationArea = All; }
                field(genBusPostingGrp; Rec."Gen. Bus. Posting Group")
                { ApplicationArea = All; }
                field(customerPostingGrp; Rec."Customer Posting Group")
                { ApplicationArea = All; }
                field(vatBusPostingGrp; Rec."VAT Bus. Posting Group")
                { ApplicationArea = All; }
            }
        }
    }
}
