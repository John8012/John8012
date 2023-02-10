tableextension 50100 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50100; "Requisition Purpose"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Requisition Purpose";
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50101; "Requisition Reason"; Text[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50102; "Requisition Details"; Blob)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50103; "Request Date"; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50104; "Expected Delivery Date "; Date)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50105; "Requisition Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Open,Approved,Rejected,Invoiced;
        }
        field(50106; "Over Budget"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50107; "Approved Over Budget"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50108; Preparer; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50109; Requestor; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50110; "Requisition No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50111; "Purchase Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                TestStatusOpen();
            end;
        }
        field(50112; "Modified By"; Code[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(User."User Name" where(SystemModifiedBy = field(SystemModifiedBy)));
        }

    }

    procedure ApprovedOverBudget()
    var
        lvUserSetup: Record "User Setup";
        lvNotAuthorised: Boolean;
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GET;
        IF NOT GLSetup."Check Budget" THEN
            EXIT;

        IF (NOT "Over Budget") OR "Approved Over Budget" THEN
            EXIT;

        lvNotAuthorised := TRUE;
        lvUserSetup.RESET;
        lvUserSetup.SETRANGE("User ID", USERID);
        IF lvUserSetup.FINDFIRST THEN BEGIN
            IF lvUserSetup."Approved Over Budget" THEN BEGIN
                "Approved Over Budget" := TRUE;
                MODIFY;
                lvNotAuthorised := FALSE;
                MESSAGE('Over Budget has been approved');
            END;
        END;
        IF lvNotAuthorised THEN
            ERROR('You dont have permission to approved Over Budget');
    end;

    procedure setRequitionDetails(requitionDetails: Text)
    var
        OutStream: OutStream;
    begin
        Clear("Requisition Details");
        "Requisition Details".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(requitionDetails);
        Modify;
    end;

    procedure getRequitionDetails() requitionDetails: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("Requisition Details");
        "Requisition Details".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), requitionDetails) then
            Message(ReadingDataSkippedMsg, FieldCaption("Requisition Details"));
    end;

    var
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';

}