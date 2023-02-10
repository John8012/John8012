page 50108 "Project Details"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Project Details";
    CardPageId = "Project Detail";
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
                field("Project Number"; Rec."Project Number")
                {
                    ApplicationArea = All;
                }
                field("Project Details"; Rec."Project Details")
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