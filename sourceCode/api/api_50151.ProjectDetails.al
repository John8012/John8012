page 50151 CustomerAPI
{
    APIGroup = 'cic';
    APIPublisher = 'cic';
    APIVersion = 'v1.0';
    Caption = 'customerContractAPI';
    DelayedInsert = true;
    EntityName = 'customerContract';
    EntitySetName = 'customersContract';
    PageType = API;
    SourceTable = "Project Details";
    ODataKeyFields = SystemId;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    ApplicationArea = All;
                }
                field(customerNo; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }

                field(pocContactName; Rec."POC Contact Name")
                {
                    Caption = 'POC Contact Name';
                }
                field(pocContactSurname; Rec."POC Contact Surname")
                {
                    Caption = 'POC Contact Surname';
                }
                field(pocEmail; Rec."POC Email")
                {
                    Caption = 'POC Email';
                }
                field(pocMobilePhoneNo; Rec."POC Mobile Phone No.")
                {
                    Caption = 'POC Mobile Phone No.';
                }
                field(pocPhoneNo; Rec."POC Phone No.")
                {
                    Caption = 'POC Phone No.';
                }
                field(pocPhysicalAddress; Rec."POC Physical Address")
                {
                    Caption = 'POC Physical Address';
                }
                field(pocPostalAddress; Rec."POC Postal Address")
                {
                    Caption = 'POC Postal Address';
                }
                field(prcContactName; Rec."PRC Contact Name")
                {
                    Caption = 'PRC Contact Name';
                }
                field(prcContactSurname; Rec."PRC Contact Surname")
                {
                    Caption = 'PRC Contact Surname';
                }
                field(prcDesignation; Rec."PRC Designation")
                {
                    Caption = 'PRC Designation';
                }
                field(prcEmail; Rec."PRC Email")
                {
                    Caption = 'PRC Email';
                }
                field(prcMobilePhoneNo; Rec."PRC Mobile Phone No.")
                {
                    Caption = 'PRC Mobile Phone No.';
                }
                field(prcPhoneNo; Rec."PRC Phone No.")
                {
                    Caption = 'PRC Phone No.';
                }
                field(projectDetails; Rec."Project Details")
                {
                    Caption = 'Project Details';
                }
                field(projectNumber; Rec."Project Number")
                {
                    Caption = 'Project Number';
                }
                field(levy; Rec."Levy %")
                {
                    Caption = 'Levy %';
                }
                field(levyAmount; Rec."Levy Amount")
                {
                    Caption = 'Levy Amount';
                }
                field(levyBalance; Rec."Levy Balance")
                {
                    Caption = 'Levy Balance';
                }
                field(levyPaid; Rec."Levy Paid")
                {
                    Caption = 'Levy Paid';
                }
                field(levyPaymentOption; Rec."Levy payment option")
                {
                    Caption = 'Levy payment option';
                }
                field(microDate; Rec."Micro Date")
                {
                    Caption = 'Micro Date';
                }
                field(awardDate; Rec."Award Date")
                {
                    Caption = 'Award Date';
                }
                field(completionDate; Rec."Completion date")
                {
                    Caption = 'Completion date';
                }
                field(contractSum; Rec."Contract Sum")
                {
                    Caption = 'Contract Sum';
                }
                field(customerCategory; Rec."Customer Category")
                {
                    Caption = 'Customer Category';
                }
                field(timeFrameForPaymentOfLevy; Rec."Time frame for payment of levy")
                {
                    Caption = 'Time frame for payment of levy';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
                }
                field(category; Rec.Category)
                {
                    Caption = 'Category';
                }
                field(balance; Rec."Levy Balance")
                {
                    Caption = 'Balance';
                }
                field(grade; Rec.Grade)
                {
                    Caption = 'Grade';
                }
                field(certificateNo; Rec."Certificate No.")
                {
                    Caption = 'Certificate No.';
                }
                field(classification; Rec.Classification)
                {
                    caption = 'Classification';
                }
                field(invoiceNo; Rec."Invoice No.")
                { }

            }
        }
    }
}
