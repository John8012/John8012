table 50103 "Registration Details"
{
    LookupPageId = "Registration Detail";
    DrillDownPageId = "Registration Detail";

    fields
    {
        // Add changes to table fields here

        field(50002; "Project Number"; Code[100])
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
        field(50014; "Levy payment option"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50015; "Time frame for payment of levy"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(50030; "Certificate No."; code[100])
        {
            DataClassification = CustomerContent;
        }
        field(50031; "Date of Payment"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50032; "Type of Payment"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50033; Bank; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50034; "Certificate Number"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50035; "Business Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50036; "Registration Fee"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50037; "Renewal Fee"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50038; "Admin Fee"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50039; Penalty; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50040; Credit; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50041; Owing; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50042; Total; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50043; "Month Of Registration"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50044; Levy; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50048; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(50050; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
        }

        field(50051; "Invoice No."; Code[20])
        {
        }
        field(50052; "Posted Invoice No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Invoice No.", "External Document No.")
        {
            Clustered = true;
        }
        key(Key3; "Posted Invoice No.", "Customer No.")
        {
        }
    }
}