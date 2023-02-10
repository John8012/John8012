pageextension 50101 CustomerCard extends "Customer Card"
{
    // layout
    // {
    //     addlast(content)
    //     {
    //         group(RegistrationDetails)
    //         {
    //             Caption = 'Registration Details';

    //             field("Business Name"; Rec."Business Name")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field("Certificate No."; Rec."Certificate No.")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Category; Rec.Category)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field("Month Of Registration"; Rec."Month Of Registration")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Registration; Rec."Registration Fee")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Renewal; rec."Renewal Fee")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field("Admin Fee"; Rec."Admin Fee")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Penalty; Rec.Penalty)
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Levy; Rec.Levy)
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Credit; Rec.Credit)
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Owing; Rec.Owing)
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Total; rec.Total)
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field("Date of Payment"; rec."Date of Payment")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field("Type of Payment"; rec."Type of Payment")
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field(Bank; rec.Bank)
    //             {
    //                 ApplicationArea = All;
    //             }
    //             field("Levy payment option"; Rec."Levy payment option")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Visible = false;
    //             }
    //             field("Time frame for payment of levy"; Rec."Time frame for payment of levy")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Visible = false;
    //             }

    //         }
    //         group(ProjectDetails)
    //         {
    //             Caption = 'Project Details';
    //             field("Project Details"; Rec."Project Details")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field("Project Number"; Rec."Project Number")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field(Grade; Rec.Grade)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field("Customer Category"; Rec."Customer Category")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field(Classification; Rec.Classification)
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field("Project Year"; Rec."Project Year")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field("Project Update"; Rec."Project Update")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field("Award Date"; Rec."Award Date")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Editable = false;
    //             }
    //             field("Start Date"; Rec."Start Date")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Editable = false;
    //             }
    //             field("Completion date"; Rec."Completion date")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Editable = false;
    //             }
    //             field("Micro Date"; Rec."Micro Date")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field("Contract Sum"; Rec."Contract Sum")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Editable = false;
    //             }
    //             field("Levy %"; Rec."Levy %")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Editable = false;
    //             }
    //             field("Levy Amount"; Rec."Levy Amount")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Editable = false;
    //             }
    //             field("Levy Paid"; Rec."Levy Paid")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //             }
    //             field("Levy Balance"; Rec."Levy Balance")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Editable = false;
    //             }
    //         }

    //         group(projectRepresentativeContact)
    //         {
    //             Caption = 'Project Representative Contact';
    //             field("PRC Contact Surname"; Rec."PRC Contact Surname")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Contact Surname';
    //             }
    //             field("PRC Contact Name"; Rec."PRC Contact Name")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Contact Name';
    //             }
    //             field("PRC Designation"; Rec."PRC Designation")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Designation';
    //             }
    //             field("PRC Mobile Phone No."; Rec."PRC Mobile Phone No.")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Mobile Phone No.';
    //             }
    //             field("PRC Email"; Rec."PRC Email")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Email';
    //             }
    //             field("PRC Phone No."; Rec."PRC Phone No.")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Phone No.';
    //             }
    //         }
    //         group(projectOwnerContact)
    //         {
    //             Caption = 'Project Owner Contact';
    //             field("POC Contact Surname"; Rec."POC Contact Surname")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Contact Surname';
    //             }
    //             field("POC Contact Name"; Rec."POC Contact Name")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Contact Name';
    //             }
    //             group(POCPostalAddress)
    //             {
    //                 Caption = 'Postal Address';
    //                 field(postalAddress; postalAddress)
    //                 {
    //                     MultiLine = true;
    //                     ApplicationArea = All;
    //                     Importance = Additional;
    //                     ShowCaption = false;
    //                     trigger OnValidate()
    //                     begin
    //                         Rec.setPostalAddress(postalAddress);
    //                     end;
    //                 }
    //             }
    //             group(POCPhysicalAddress)
    //             {
    //                 Caption = 'Physical Address';
    //                 field(physicalAddress; physicalAddress)
    //                 {
    //                     MultiLine = true;
    //                     ApplicationArea = All;
    //                     Importance = Additional;
    //                     ShowCaption = false;
    //                     trigger OnValidate()
    //                     begin
    //                         Rec.setPhysicalAddress(physicalAddress);
    //                     end;
    //                 }
    //             }
    //             field("POC Mobile Phone No."; Rec."POC Mobile Phone No.")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Mobile Phone No.';
    //             }
    //             field("POC Email"; Rec."POC Email")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Email';
    //             }
    //             field("POC Phone No."; Rec."POC Phone No.")
    //             {
    //                 ApplicationArea = Basic, Suite;
    //                 Caption = 'Phone No.';
    //             }
    //         }
    //     }
    // }
    actions
    {
        addlast("&Customer")
        {
            action(ProjectRegistrationDetails)
            {
                ApplicationArea = all;
                Caption = 'Project Details';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "Project Details";
                RunPageLink = "Customer No." = FIELD("No.");
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit project details';
            }
            action(RegistrationDetail)
            {
                ApplicationArea = all;
                Caption = 'Registration Details';
                Image = Documents;
                Promoted = true;
                PromotedCategory = Category9;
                PromotedIsBig = true;
                RunObject = Page "Registration Details";
                RunPageLink = "Customer No." = FIELD("No.");
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit registration details';
            }
        }
    }

    var
        physicalAddress: Text;
        postalAddress: Text;

    trigger OnAfterGetRecord()
    begin
        physicalAddress := Rec.getPhysicalAddress();
        postalAddress := Rec.getPostalAddress();
    end;
}
