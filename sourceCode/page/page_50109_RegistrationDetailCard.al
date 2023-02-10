page 50109 "Registration Detail"
{
    PageType = Card;
    SourceTable = "Registration Details";

    layout
    {
        area(Content)
        {
            group(RegistrationDetails)
            {
                Caption = 'Registration Details';
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Business Name"; Rec."Business Name")
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
                field("Certificate No."; Rec."Certificate No.")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Month Of Registration"; Rec."Month Of Registration")
                {
                    ApplicationArea = All;
                }
                field(Registration; Rec."Registration Fee")
                {
                    ApplicationArea = All;
                }
                field(Renewal; rec."Renewal Fee")
                {
                    ApplicationArea = All;
                }
                field("Admin Fee"; Rec."Admin Fee")
                {
                    ApplicationArea = All;
                }
                field(Penalty; Rec.Penalty)
                {
                    ApplicationArea = All;
                }
                field(Levy; Rec.Levy)
                {
                    ApplicationArea = All;
                }
                field(Credit; Rec.Credit)
                {
                    ApplicationArea = All;
                }
                field(Owing; Rec.Owing)
                {
                    ApplicationArea = All;
                }
                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                }
                field("Date of Payment"; rec."Date of Payment")
                {
                    ApplicationArea = All;
                }
                field("Type of Payment"; rec."Type of Payment")
                {
                    ApplicationArea = All;
                }
                field(Bank; rec.Bank)
                {
                    ApplicationArea = All;
                }
                field("Levy payment option"; Rec."Levy payment option")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Time frame for payment of levy"; Rec."Time frame for payment of levy")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }

            }
        }
    }
}