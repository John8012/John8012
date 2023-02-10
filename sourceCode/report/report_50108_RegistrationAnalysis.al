report 50108 RegistrationAnalysis
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Registration Analysis Excel';
    dataset
    {
        dataitem("Registration Details"; "Registration Details")
        {
            trigger OnPreDataItem()
            begin
                //Header Info
                TempExcelBuffer.Reset();
                TempExcelBuffer.DeleteAll();
                TempExcelBuffer.ClearNewRow;
                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn('Date of Payment', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Type of Payment', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Bank', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CERTIFICATE NUMBER', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('COMPANY NAME ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CAT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('REG', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('RENEWAL ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('ADMIN FEE', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('PENALTY ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Levy', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CREDIT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('OWING', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('TOTAL ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Month Of Registration', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('NOTES', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                TempExcelBuffer.NewRow;
                //  TempExcelBuffer.AddColumn('', FALSE, '', FALSE,
                //   FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Type of Payment", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Bank, FALSE, '', TRUE, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Certificate Number", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Business Name", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Category, FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Registration Fee", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Renewal Fee", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Admin Fee", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Penalty, FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Levy, FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(' ', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Month Of Registration", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
            end;



        }

    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }


    }

    trigger OnPostReport()

    begin
        TempExcelBuffer.CreateNewBook('Registration Analysis');
        TempExcelBuffer.WriteSheet('Registration Analysis Excel', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Registration Analysis Excel', CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
        // Error('');
    end;


    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
}