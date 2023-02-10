pageextension 50108 SalesInvoicesList extends "Sales Invoice List"
{

    // actions
    // {
    //     addafter(Statistics)
    //     {
    //         action(getData)
    //         {
    //             ApplicationArea = Suite;
    //             Caption = 'GetData';
    //             Image = Statistics;
    //             ShortCutKey = 'F7';
    //             ToolTip = 'View statistical information, such as the value of posted entries, for the record.';

    //             trigger OnAction()
    //             var
    //                 UpdateAzureFormStatus: Codeunit UpdateAzureFormStatus;
    //             begin
    //                 UpdateAzureFormStatus.UpdateAzureStorage();
    //             end;
    //         }
    //     }
    // }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetFilter("Levy Invoice", '%1', false);
        Rec.FilterGroup(0);
    end;


}