page 50152 ApiCustomer
{
    PageType = API;
    APIGroup = 'cic';
    APIPublisher = 'cic';
    APIVersion = 'v1.0';
    Caption = 'customerContractAPI';
    DelayedInsert = true;
    EntityName = 'customerContract1';
    EntitySetName = 'customersContract1';
    SourceTable = "Registration Details";
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater("Additional")
            {
                field(id; Rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(customerNo; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(businessName; Rec."Business Name")
                {
                    ApplicationArea = All;
                }
                field(certificateNo; Rec."Certificate No.")
                {
                    ApplicationArea = All;
                }
                field(monthofReg; Rec."Month Of Registration")
                {
                    ApplicationArea = All;
                }
                field(registration; Rec."Registration Fee")
                {
                    ApplicationArea = All;
                }
                field(renewal; Rec."Renewal Fee")
                {
                    ApplicationArea = All;
                }
                field(adminFee; Rec."Admin Fee")
                {
                    ApplicationArea = All;
                }
                field(penalty; Rec.Penalty)
                {
                    ApplicationArea = All;
                }
                field(levy; Rec.Levy)
                {
                    ApplicationArea = All;
                }
                field(credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field(owing; Rec.Owing)
                {
                    ApplicationArea = All;
                }
                field(total; Rec.Total)
                {
                    ApplicationArea = All;
                }
                field(dateofPay; Rec."Date of Payment")
                {
                    ApplicationArea = All;
                }
                field(typeofPay; Rec."Type of Payment")
                {
                    ApplicationArea = All;
                }
                field(bank; Rec.Bank)
                {
                    ApplicationArea = All;
                }
                field(externalDocumentNo; Rec."External Document No.")
                { }
                field(invoiceNo; Rec."Invoice No.")
                { }
                field(category; Rec.Category)
                { }
            }
        }
    }




}