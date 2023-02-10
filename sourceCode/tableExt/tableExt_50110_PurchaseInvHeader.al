tableextension 50110 PurchaseInvHeader extends "Purch. Inv. Header"
{
    fields
    {
        // Add changes to table fields here
        field(50102; "Requisition Details"; Blob)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin

            end;
        }
    }
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