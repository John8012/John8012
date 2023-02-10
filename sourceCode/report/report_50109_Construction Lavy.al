report 50109 ConstructionLavy
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Construction Lavy';
    dataset
    {
        dataitem("Project Details"; "Project Details")
        {
            trigger OnPreDataItem()
            begin
                //Header Info
                TempExcelBuffer.Reset();
                TempExcelBuffer.DeleteAll();
                TempExcelBuffer.ClearNewRow;
                TempExcelBuffer.NewRow;
                TempExcelBuffer.AddColumn('PROJECT NUMBER', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('INVOICE DATE', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Year', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Age Analysis', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Month of Invoice ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('REGISTRATION FORM STATUS', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('DATE AWARDED', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('DATE STARTED ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('DATE COMPLETED', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Above 2022 ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Project Update', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('PROJECT OWNER', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CLASSIFICATION', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CONTRACTOR ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Customer Category', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Grade', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Collector ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CONTACT # 1', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CONTACT # 2 ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CONTACT # 3', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CONTACT PERSON', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Email Address', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Project Manager Name', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Project Manager Contact', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Project Manager Email Address', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Project Details', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('FINAL ACCOUNT', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('CONTRACT SUM', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('LEVY %', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('LEVY PAID ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('BALANCE', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Collections Percentage', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Micro projects date', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('Certificates paid ', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('This Certificate Levy Due', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Comment', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('Summary', FALSE, '', TRUE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text);

            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                TempExcelBuffer.NewRow;
                //  TempExcelBuffer.AddColumn('', FALSE, '', FALSE,
                //   FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Project Number", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Project Year", FALSE, '', TRUE, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Award Date", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Start Date", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Completion date", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Project Update", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("POC Contact Name", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Classification, FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Customer Category", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn(Grade, FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);


                TempExcelBuffer.AddColumn("PRC Contact Name", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("PRC Email", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Project Details", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Contract Sum", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Levy %", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Levy Amount", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Levy Paid", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn("Levy Balance", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                if "Levy Amount" <> 0 then
                    TempExcelBuffer.AddColumn("Levy Paid" / "Levy Amount", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text)
                else
                    TempExcelBuffer.AddColumn("Levy Paid" / 1, FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn("Micro Date", FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);

                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
                TempExcelBuffer.AddColumn('', FALSE, '', false, FALSE, false, '', TempExcelBuffer."Cell Type"::Text);
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
        TempExcelBuffer.CreateNewBook('Construction Lavy');
        TempExcelBuffer.WriteSheet('Construction Lavy Excel', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Construction Lavy Excel', CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
        // Error('');
    end;


    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
}