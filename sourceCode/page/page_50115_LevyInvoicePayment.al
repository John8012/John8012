page 50115 "Levy Payment Invoice"
{
    PageType = Card;
    SourceTable = "Sales Header";
    PromotedActionCategories = 'New,Process,Report,Release,Posting,Invoice,Request Approval,Navigate';

    layout
    {
        area(Content)
        {
            group(Payment)
            {
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount Paid"; LevyPaid)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if LevyPaid > Rec.Amount then
                            Error('Please enter correct amount..');

                        ProjectDetails.Reset();
                        ProjectDetails.SetRange("Invoice No.", Rec."No.");
                        if ProjectDetails.FindFirst() then
                            Rec."Remaining Amount" := Rec.Amount - (LevyPaid + ProjectDetails."Levy Paid");
                    end;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("&Invoice")
            {
                Caption = '&Invoice';
                Image = Invoice;
                action(sendEmail)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Partially Completed';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Notify CEO on each Payment';

                    trigger OnAction()
                    var
                        SalesHeader: Record "Sales Header";
                        EmailNotification: Codeunit EmailNotification;
                        UpdateAzureFormStatus: Codeunit UpdateAzureFormStatus;
                    begin
                        ProjectDetails.Reset();
                        ProjectDetails.SetRange("Invoice No.", Rec."No.");
                        if ProjectDetails.FindFirst() then begin
                            ProjectDetails."Levy Paid" := ProjectDetails."Levy Paid" + LevyPaid;
                            ProjectDetails."Levy Balance" := ProjectDetails."Levy Amount" - ProjectDetails."Levy Paid";
                            ProjectDetails.Modify();
                        end;
                        Clear(LevyPaid);

                        SalesHeader := Rec;
                        CurrPage.SetSelectionFilter(SalesHeader);
                        EmailNotification.SendPaymentNotificationToCEO(SalesHeader);
                        //UpdateAzureFormStatus.UpdateStatus1(SalesHeader);
                    end;
                }
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        ProjectDetails.Reset();
        ProjectDetails.SetRange("Invoice No.", Rec."No.");
        if ProjectDetails.FindFirst() then
            Rec."Remaining Amount" := Rec.Amount - ProjectDetails."Levy Paid";
    end;

    var
        ProjectDetails: Record "Project Details";
        LevyPaid: Decimal;
}