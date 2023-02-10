tableextension 50102 PurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; "Over Budget"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Posting Date"; Date)
        {
            CalcFormula = Lookup("Purchase Header"."Posting Date" WHERE("Document Type" = FIELD("Document Type"),
                                                                         "No." = FIELD("Document No.")));
            FieldClass = FlowField;
        }
        field(50002; "Requisition Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    var
        NotShowMessage: Boolean;

    procedure CheckBudget()
    var
        GLBudgetEntries: Record "G/L Budget Entry";
        PH: Record "Purchase Header";
        BudgetAmount: Decimal;
        PL: Record "Purchase Line";
        PIL: Record "Purch. Inv. Line";
        PCL: Record "Purch. Cr. Memo Line";
        TotalUsedAmount: Decimal;
        lvOverBudget: Boolean;
        lvBudgetFound: Boolean;
        StartDate: Date;
        EndDate: Date;
        AccountingPeriod: Record "Accounting Period";
        lvSkipChecking: Boolean;
        GLAccount: Record "G/L Account";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET;
        IF NOT GLSetup."Check Budget" THEN
            EXIT;

        IF (Type = Type::"G/L Account") AND ("No." <> '') AND (Quantity <> 0) AND ("Line Amount" <> 0) AND
           (("Document Type" = "Document Type"::Order) OR ("Document Type" = "Document Type"::Invoice)) THEN BEGIN

            lvOverBudget := "Over Budget";
            PH.RESET;
            PH.SETRANGE("Document Type", "Document Type");
            PH.SETRANGE("No.", "Document No.");
            IF PH.FINDFIRST THEN;

            lvSkipChecking := FALSE;

            CLEAR(StartDate);
            CLEAR(EndDate);
            AccountingPeriod.RESET;
            AccountingPeriod.SETFILTER("Starting Date", '<=%1', PH."Posting Date");
            AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
            AccountingPeriod.SETRANGE(Closed, FALSE);
            IF AccountingPeriod.FINDLAST THEN BEGIN
                StartDate := AccountingPeriod."Starting Date";
            END;

            AccountingPeriod.RESET;
            AccountingPeriod.SETFILTER("Starting Date", '>=%1', PH."Posting Date");
            AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
            AccountingPeriod.SETRANGE(Closed, FALSE);
            IF AccountingPeriod.FINDFIRST THEN BEGIN
                EndDate := AccountingPeriod."Starting Date" - 1;
            END;

            IF StartDate = 0D THEN
                ERROR('Start Date of fiscal year not found for Posting Date %1', PH."Posting Date");
            IF EndDate = 0D THEN
                ERROR('End Date of fiscal year not found for Posting Date %1', PH."Posting Date");

            lvBudgetFound := FALSE;
            BudgetAmount := 0;
            TotalUsedAmount := 0;
            GLBudgetEntries.RESET;
            GLBudgetEntries.SETRANGE("G/L Account No.", "No.");
            GLBudgetEntries.SETRANGE(Date, StartDate, EndDate);
            GLBudgetEntries.SETRANGE("Dimension Set ID", "Dimension Set ID");
            IF GLBudgetEntries.FINDSET THEN BEGIN
                REPEAT
                    BudgetAmount := BudgetAmount + GLBudgetEntries.Amount;
                    lvBudgetFound := TRUE;
                UNTIL GLBudgetEntries.NEXT = 0;
            END;
            IF BudgetAmount < 0 THEN
                lvSkipChecking := TRUE;

            lvBudgetFound := TRUE;

            //Purchase Order
            PL.RESET;
            PL.SETRANGE("Document Type", PL."Document Type"::Order);
            PL.SETRANGE(Type, PL.Type::"G/L Account");
            PL.SETRANGE("No.", "No.");
            PL.SETRANGE("Dimension Set ID", "Dimension Set ID");
            PL.SETRANGE("Posting Date", StartDate, EndDate);
            PL.SETFILTER(Quantity, '<>%1', 0);
            IF PL.FINDSET THEN BEGIN
                REPEAT
                    IF NOT ((PL."Document No." = "Document No.") AND (PL."Line No." = "Line No.")) THEN
                        TotalUsedAmount := TotalUsedAmount + PL."Amount Including VAT";
                UNTIL PL.NEXT = 0;
            END;

            //Purchase Invoice
            PL.RESET;
            PL.SETRANGE("Document Type", PL."Document Type"::Invoice);
            PL.SETRANGE(Type, PL.Type::"G/L Account");
            PL.SETRANGE("No.", "No.");
            PL.SETRANGE("Dimension Set ID", "Dimension Set ID");
            PL.SETRANGE("Posting Date", StartDate, EndDate);
            PL.SETFILTER(Quantity, '<>%1', 0);
            IF PL.FINDSET THEN BEGIN
                REPEAT
                    IF NOT ((PL."Document No." = "Document No.") AND (PL."Line No." = "Line No.")) THEN
                        TotalUsedAmount := TotalUsedAmount + PL."Amount Including VAT";
                UNTIL PL.NEXT = 0;
            END;

            //Purchase Credit Memo
            PL.RESET;
            PL.SETRANGE("Document Type", PL."Document Type"::"Credit Memo");
            PL.SETRANGE(Type, PL.Type::"G/L Account");
            PL.SETRANGE("No.", "No.");
            PL.SETRANGE("Dimension Set ID", "Dimension Set ID");
            PL.SETRANGE("Posting Date", StartDate, EndDate);
            PL.SETFILTER(Quantity, '<>%1', 0);
            IF PL.FINDSET THEN BEGIN
                REPEAT
                    TotalUsedAmount := TotalUsedAmount - PL."Amount Including VAT";
                UNTIL PL.NEXT = 0;
            END;

            //Purchase Inv Line
            PIL.RESET;
            PIL.SETRANGE(Type, PIL.Type::"G/L Account");
            PIL.SETRANGE("No.", "No.");
            PIL.SETRANGE("Dimension Set ID", "Dimension Set ID");
            PIL.SETRANGE("Posting Date", StartDate, EndDate);
            PIL.SETFILTER(Quantity, '<>%1', 0);
            IF PIL.FINDSET THEN BEGIN
                REPEAT
                    TotalUsedAmount := TotalUsedAmount + PIL."Amount Including VAT";
                UNTIL PIL.NEXT = 0;
            END;

            //Purchase CR Memo Line
            PCL.RESET;
            PCL.SETRANGE(Type, PCL.Type::"G/L Account");
            PCL.SETRANGE("No.", "No.");
            PCL.SETRANGE("Dimension Set ID", "Dimension Set ID");
            PCL.SETRANGE("Posting Date", StartDate, EndDate);
            PCL.SETFILTER(Quantity, '<>%1', 0);
            IF PCL.FINDSET THEN BEGIN
                REPEAT
                    TotalUsedAmount := TotalUsedAmount - PCL."Amount Including VAT";
                UNTIL PCL.NEXT = 0;
            END;

            IF (BudgetAmount < (TotalUsedAmount + "Line Amount")) AND lvBudgetFound AND NOT lvSkipChecking THEN BEGIN
                "Over Budget" := TRUE;
            END ELSE
                "Over Budget" := FALSE;

            IF (NOT NotShowMessage) AND ("Over Budget") AND (lvOverBudget = FALSE) THEN
                MESSAGE('Please be informed that G/L Account No. %1 is Over Budget.', "No.");
        END ELSE
            "Over Budget" := FALSE;
        IF MODIFY THEN;
    end;
}