table 50102 "Project Details"
{
    LookupPageId = "Project Detail";
    DrillDownPageId = "Project Detail";

    fields
    {
        // Add changes to table fields here
        field(50000; "Customer Category"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "Grade"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Project Number"; Code[100])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Contract Sum"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50004; "Levy %"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Levy Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50006; "Levy Paid"; Decimal)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if "Levy Paid" <> 0 then
                    "Levy Balance" := "Levy Amount" - "Levy Paid";
            end;
        }
        field(50007; "Levy Balance"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50008; Category; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50009; Classification; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Award Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50011; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50012; "Completion date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Micro Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50014; "Levy payment option"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50015; "Time frame for payment of levy"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50016; "Project Details"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50017; "PRC Contact Surname"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50018; "PRC Contact Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50019; "PRC Designation"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50020; "PRC Mobile Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50021; "PRC Email"; Text[80])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                MailManagement: codeunit "Mail Management";
            begin
                if "PRC Email" <> '' then
                    MailManagement.CheckValidEmailAddresses("PRC Email");
            end;
        }
        field(50022; "PRC Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50023; "POC Contact Surname"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50024; "POC Contact Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50025; "POC Postal Address"; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(50026; "POC Physical Address"; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(50027; "POC Mobile Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50028; "POC Email"; Text[80])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                MailManagement: codeunit "Mail Management";
            begin
                if "POC Email" <> '' then
                    MailManagement.CheckValidEmailAddresses("POC Email");
            end;
        }
        field(50029; "POC Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50030; "Certificate No."; code[100])
        {
            DataClassification = CustomerContent;
        }
        field(50034; "Certificate Number"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50045; "Project Year"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50046; "Project Update"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Completed,Finalized,"In progress";
        }
        field(50047; "Collection Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50048; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(50051; "Invoice No."; Code[20])
        {
        }
        field(50052; "Posted Invoice No."; Code[20])
        {
        }

        // field(8000; Id; Guid)
        // {
        //     Caption = 'Id';
        //     DataClassification = SystemMetadata;
        // }
    }

    keys
    {
        key(Key1; "Customer No.", "Project Number")
        {
            Clustered = true;
        }
        key(Key3; "Project Number", "Customer No.")
        {
        }
    }


    procedure setPhysicalAddress(physicalAddress: Text)
    var
        OutStream: OutStream;
    begin
        Clear("POC Physical Address");
        "POC Physical Address".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(physicalAddress);
        Modify;
    end;

    procedure getPhysicalAddress() physicalAddress: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("POC Physical Address");
        "POC Physical Address".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), physicalAddress) then
            Message(ReadingDataSkippedMsg, FieldCaption("POC Physical Address"));
    end;

    procedure setPostalAddress(postalAddress: Text)
    var
        OutStream: OutStream;
    begin
        Clear("POC Postal Address");
        "POC Postal Address".CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(postalAddress);
        Modify;
    end;

    procedure getPostalAddress() postalAddress: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        CalcFields("POC Postal Address");
        "POC Postal Address".CreateInStream(InStream, TEXTENCODING::UTF8);
        if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), postalAddress) then
            Message(ReadingDataSkippedMsg, FieldCaption("POC Postal Address"));
    end;

    var
        ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';


}