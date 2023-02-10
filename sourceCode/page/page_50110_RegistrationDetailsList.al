page 50110 "Registration Details"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Registration Details";
    CardPageId = "Registration Detail";
    Editable = false;
    DataCaptionFields = "Customer No.";
    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Business Name"; Rec."Business Name")
                {
                    ApplicationArea = All;
                }
                field("Certificate Number"; Rec."Certificate Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}