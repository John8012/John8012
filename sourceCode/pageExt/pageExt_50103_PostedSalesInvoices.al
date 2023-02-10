pageextension 50103 PostedSalesInvoices extends "Posted Sales Invoices"
{

    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            // action(SalesLevyInvoice)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Levy Invoice';
            //     Ellipsis = true;
            //     Image = Print;
            //     Promoted = true;
            //     PromotedCategory = Category7;
            //     ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
            //     Visible = false;
            //     trigger OnAction()
            //     var
            //         SalesInvHeader: Record "Sales Invoice Header";
            //     begin
            //         SalesInvHeader := Rec;
            //         CurrPage.SetSelectionFilter(SalesInvHeader);
            //         Report.Run(Report::"Sales Invoice Levy", true, false, SalesInvHeader);
            //     end;
            // }
            // action(AssessmentLetter)
            // {
            //     ApplicationArea = Basic, Suite;
            //     Caption = 'Assessment Letter';
            //     Ellipsis = true;
            //     Image = Print;
            //     Promoted = true;
            //     PromotedCategory = Category7;
            //     ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

            //     trigger OnAction()
            //     var
            //         SalesInvHeader: Record "Sales Invoice Header";
            //     begin
            //         SalesInvHeader := Rec;
            //         CurrPage.SetSelectionFilter(SalesInvHeader);
            //         Report.Run(Report::"Assessment Letter", true, false, SalesInvHeader);
            //     end;
            // }
            action(LetterOfDemand)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Letter Of Demand';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    Report.Run(Report::"Letter Of Demand", true, false, SalesInvHeader);
                end;
            }
            action(sendEmail)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send Email';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                Visible = false;
                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                    EmailNotification: Codeunit EmailNotification;
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    EmailNotification.SendInvoiceDueNotificationToCustomer(SalesInvHeader."No.");
                    EmailNotification.sendOverdue97(SalesInvHeader."No.");
                end;
            }

            action(SalesInvoice)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoice';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SalesInvHeader: Record "Sales Invoice Header";
                begin
                    SalesInvHeader := Rec;
                    CurrPage.SetSelectionFilter(SalesInvHeader);
                    Report.Run(Report::"Sales Invoice", true, false, SalesInvHeader);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Levy Invoice", '%1', false);
        Rec.FilterGroup(0);
    end;
}