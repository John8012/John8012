report 50112 "Sales Invoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = './sourceCode/reportLayout/Layout_50112_salesInvoice.rdl';
    PreviewMode = PrintLayout;
    Caption = 'Levy Invoice';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "No.";
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                    column(ReqPBankSel; ReqPBankSel)
                    {
                    }
                    column(ReqPShowDisc; ReqPShowDisc)
                    {
                    }
                    column(ReqPSayingAmnt; ReqPSayingAmnt)
                    {
                    }
                    column(ReqPShowPicISO; ReqPShowPicISO)
                    {
                    }
                    column(ReqPShowNonCommercial; ReqPShowNonCommercial)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(SeqNo; SeqNo)
                    {
                    }
                    column(RecCompInfoPicture; RecCompInfo.Picture)
                    {
                    }
                    column(RecCompInfoPicture2; '')
                    {
                    }
                    column(RecSlsPurchSignPic; '')
                    {
                    }
                    column(VarDocTittle; VarDocTittle)
                    {
                    }
                    column(VarCompInfo1; VarCompInfo[1])
                    {
                    }
                    column(VarCompInfo2; VarCompInfo[2])
                    {
                    }
                    column(VarCompInfo3; VarCompInfo[3])
                    {
                    }
                    column(VarCompInfo4; VarCompInfo[4])
                    {
                    }
                    column(VarCompInfo5; VarCompInfo[5])
                    {
                    }
                    column(VarCompInfo6; VarCompInfo[6])
                    {
                    }
                    column(VarCompInfo7; VarCompInfo[7])
                    {
                    }
                    column(VarCompInfo8; VarCompInfo[8])
                    {
                    }
                    column(VarCompInfo9; VarCompInfo[9])
                    {
                    }
                    column(VarCompInfo10; VarCompInfo[10])
                    {
                    }
                    column(VarCompInfo11; VarCompInfo[11])
                    {
                    }
                    column(VarCompInfo12; VarCompInfo[12])
                    {
                    }
                    column(VarHeadInfo1; VarHeadInfo[1])
                    {
                    }
                    column(VarHeadInfo2; VarHeadInfo[2])
                    {
                    }
                    column(VarHeadInfo3; VarHeadInfo[3])
                    {
                    }
                    column(VarHeadInfo4; VarHeadInfo[4])
                    {
                    }
                    column(VarHeadInfo5; VarHeadInfo[5])
                    {
                    }
                    column(VarHeadInfo6; VarHeadInfo[6])
                    {
                    }
                    column(VarHeadInfo7; VarHeadInfo[7])
                    {
                    }
                    column(VarHeadInfo8; VarHeadInfo[8])
                    {
                    }
                    column(VarHeadInfo9; VarHeadInfo[9])
                    {
                    }
                    column(VarHeadInfo10; VarHeadInfo[10])
                    {
                    }
                    column(VarHeadInfo11; VarHeadInfo[11])
                    {
                    }
                    column(VarHeadInfo12; VarHeadInfo[12])
                    {
                    }
                    column(VarHeadInfo13; VarHeadInfo[13])
                    {
                    }
                    column(VarHeadInfo14; VarHeadInfo[14])
                    {
                    }
                    column(VarHeadInfo15; VarHeadInfo[15])
                    {
                    }
                    column(VarBillTo1; VarBillTo[1])
                    {
                    }
                    column(VarBillTo2; VarBillTo[2])
                    {
                    }
                    column(VarBillTo3; VarBillTo[3])
                    {
                    }
                    column(VarBillTo4; VarBillTo[4])
                    {
                    }
                    column(VarBillTo5; VarBillTo[5])
                    {
                    }
                    column(VarBillTo6; VarBillTo[6])
                    {
                    }
                    column(VarBillTo7; VarBillTo[7])
                    {
                    }
                    column(VarBillTo8; VarBillTo[8])
                    {
                    }
                    column(VarBillTo9; VarBillTo[9])
                    {
                    }
                    column(VarBillTo10; VarBillTo[10])
                    {
                    }
                    column(VarShipTo1; VarShipTo[1])
                    {
                    }
                    column(VarShipTo2; VarShipTo[2])
                    {
                    }
                    column(VarShipTo3; VarShipTo[3])
                    {
                    }
                    column(VarShipTo4; VarShipTo[4])
                    {
                    }
                    column(VarShipTo5; VarShipTo[5])
                    {
                    }
                    column(VarShipTo6; VarShipTo[6])
                    {
                    }
                    column(VarShipTo7; VarShipTo[7])
                    {
                    }
                    column(VarShipTo8; VarShipTo[8])
                    {
                    }
                    column(VarShipTo9; VarShipTo[9])
                    {
                    }
                    column(VarShipTo10; VarShipTo[10])
                    {
                    }
                    column(VarBankInfo1; VarBankInfo[1])
                    {
                    }
                    column(VarBankInfo2; VarBankInfo[2])
                    {
                    }
                    column(VarBankInfo3; VarBankInfo[3])
                    {
                    }
                    column(VarBankInfo4; VarBankInfo[4])
                    {
                    }
                    column(VarBankInfo5; VarBankInfo[5])
                    {
                    }
                    column(VarBankInfo6; VarBankInfo[6])
                    {
                    }
                    column(VarBankInfo7; VarBankInfo[7])
                    {
                    }
                    column(VarBankInfo8; VarBankInfo[8])
                    {
                    }
                    column(VarBankInfo9; VarBankInfo[9])
                    {
                    }
                    column(VarBankInfo10; VarBankInfo[10])
                    {
                    }
                    column(VarFootValDec1; VarFootValDec[1])
                    {
                    }
                    column(VarFootValDec2; VarFootValDec[2])
                    {
                    }
                    column(VarFootValDec3; VarFootValDec[3])
                    {
                    }
                    column(VarFootValDec4; VarFootValDec[4])
                    {
                    }
                    column(VarFootValDec5; VarFootValDec[5])
                    {
                    }
                    column(VarFootValDec6; VarFootValDec[6])
                    {
                    }
                    column(VarFootValDec7; VarFootValDec[7])
                    {
                    }
                    column(FootInfo1; VarFootInfo1)
                    {
                    }
                    column(FootInfo2; VarFootInfo2)
                    {
                    }
                    column(VarAddInfo1; VarAddInfo[1])
                    {
                    }
                    column(VarAddInfo2; VarAddInfo[2])
                    {
                    }
                    column(VarAddInfo3; VarAddInfo[3])
                    {
                    }
                    column(VarAddInfo4; VarAddInfo[4])
                    {
                    }
                    column(VarAddInfo5; VarAddInfo[5])
                    {
                    }
                    column(VarAddInfo6; VarAddInfo[6])
                    {
                    }
                    column(VarAddInfo7; VarAddInfo[7])
                    {
                    }
                    column(VarAddInfo8; VarAddInfo[8])
                    {
                    }
                    column(VarAddInfo9; VarAddInfo[9])
                    {
                    }
                    column(VarAddInfo10; VarAddInfo[10])
                    {
                    }
                    column(VarBankInfo21; VarBankInfo2[1])
                    {
                    }
                    column(VarBankInfo22; VarBankInfo2[2])
                    {
                    }
                    column(VarBankInfo23; VarBankInfo2[3])
                    {
                    }
                    column(VarBankInfo24; VarBankInfo2[4])
                    {
                    }
                    column(VarBankInfo31; VarBankInfo3[1])
                    {
                    }
                    column(VarBankInfo32; VarBankInfo3[2])
                    {
                    }
                    column(VarBankInfo33; VarBankInfo3[3])
                    {
                    }
                    column(VarBankInfo34; VarBankInfo3[4])
                    {
                    }
                    column(VarBankInfo41; VarBankInfo4[1])
                    {
                    }
                    column(VarBankInfo42; VarBankInfo4[2])
                    {
                    }
                    column(VarBankInfo43; VarBankInfo4[3])
                    {
                    }
                    column(VarBankInfo44; VarBankInfo4[4])
                    {
                    }
                    column(VarBankInfo51; VarBankInfo5[1])
                    {
                    }
                    column(VarBankInfo52; VarBankInfo5[2])
                    {
                    }
                    column(VarBankInfo53; VarBankInfo5[3])
                    {
                    }
                    column(VarBankInfo54; VarBankInfo5[4])
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        column(VarLinesValText1; VarLinesValText[1])
                        {
                        }
                        column(VarLinesValText2; VarLinesValText[2])
                        {
                        }
                        column(VarLinesValText3; VarLinesValText[3])
                        {
                        }
                        column(VarLinesValText4; VarLinesValText[4])
                        {
                        }
                        column(VarLinesValText5; VarLinesValText[5])
                        {
                        }
                        column(VarLinesValText6; VarLinesValText[6])
                        {
                        }
                        column(VarLinesValText7; VarLinesValText[7])
                        {
                        }
                        column(VarLinesValText8; VarLinesValText[8])
                        {
                        }
                        column(VarLinesValText9; VarLinesValText[9])
                        {
                        }
                        column(VarLinesValDec1; VarLinesValDec[1])
                        {
                        }
                        column(VarLinesValDec2; VarLinesValDec[2])
                        {
                        }
                        column(VarLinesValDec3; VarLinesValDec[3])
                        {
                        }
                        column(VarLinesValDec4; VarLinesValDec[4])
                        {
                        }
                        column(VarLinesValDec5; VarLinesValDec[5])
                        {
                        }
                        column(VarLinesValDec6; VarLinesValDec[6])
                        {
                        }
                        column(VarLinesValDec7; VarLinesValDec[7])
                        {
                        }
                        column(AmountInWords; Saying[1] + ' ' + Saying[2])
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            Clear(VarLinesValText);
                            Clear(VarLinesValDec);

                            //with "Sales Line" do begin
                            if (Type <> Type::" ") and (Quantity = 0) then CurrReport.Skip;
                            if (Type <> Type::" ") then
                                SeqNo += 1;

                            VarLinesValText[1] := "No.";
                            VarLinesValText[2] := Description;
                            VarLinesValText[3] := "Unit of Measure Code";
                            VarLinesValText[4] := ''; //Lead Time
                            VarLinesValText[5] := "Description 2";

                            VarLinesValDec[1] := "Line Amount";
                            RecProject.Reset();
                            RecProject.SetRange("Customer No.", "Bill-to Customer No.");
                            if RecProject.FindSet() then begin
                                VarLinesValDec[2] := RecProject."Levy %";
                                VarLinesValDec[3] := ("Line Amount" * RecProject."Levy %") / 100;
                            end;
                            //end;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if Number > 1 then begin
                        CopyText := 'COPY';
                        OutputNo += 1;
                    end;

                    SeqNo := 0;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                RecCompInfo.Get;
                RecCompInfo.CalcFields(Picture);

                case ReqPDocTittleOpt of
                    ReqPDocTittleOpt::"order":
                        VarDocTittle := 'INVOICE';
                end;

                RecCountry.Reset;
                if RecCountry.Get(RecCompInfo."Country/Region Code") then;

                VarCompInfo[1] := RecCompInfo.Name;
                VarCompInfo[2] := RecCompInfo.Address;
                VarCompInfo[3] := RecCompInfo."Address 2";

                RecCountry.Reset;
                if RecCountry.Get(RecCompInfo."Country/Region Code") then;
                if RecCompInfo.City <> '' then
                    VarCompInfo[4] := RecCompInfo.City + ' ' + RecCountry.Name + ' ' + RecCompInfo."Post Code"
                else
                    VarCompInfo[4] := RecCountry.Name + ' ' + RecCompInfo."Post Code";

                if RecCompInfo."Fax No." <> '' then
                    VarCompInfo[5] := 'Phone ' + RecCompInfo."Phone No." + '  Fax ' + RecCompInfo."Fax No."
                else
                    VarCompInfo[5] := 'Phone ' + RecCompInfo."Phone No.";
                CompressArray(VarCompInfo);

                Clear(VarHeadInfo);
                Clear(VarBillTo);
                Clear(VarShipTo);
                Clear(VarBankInfo);
                Clear(VarFootValDec);

                RecGLSet.Get;

                //with Header do begin
                CalcFields(Amount, "Amount Including VAT");

                VarHeadInfo[1] := Format("Document Date", 0, '<Day,2>/<Month,2>/<Year4>');
                VarHeadInfo[2] := "No.";
                VarHeadInfo[3] := 'Construction Levy';
                RecProject.Reset();
                RecProject.SetRange("Customer No.", "Bill-to Customer No.");
                if RecProject.FindFirst() then begin
                    VarHeadInfo[4] := RecProject."Project Details";
                    VarHeadInfo[5] := RecProject."Project Number";
                end;

                if "Currency Code" <> '' then
                    VarHeadInfo[8] := "Currency Code"
                else
                    VarHeadInfo[8] := RecGLSet."LCY Code";

                //Get GST percentage & Total Discount
                Clear(VarSumVATPercent);
                Clear(VarCountLineVAT);
                Clear(VarSumDisc);
                Clear(VarSumWHT);

                RecSlsLine.Reset;
                RecSlsLine.SetRange("Document No.", "No.");
                RecSlsLine.SetFilter(Quantity, '<>%1', 0);
                if RecSlsLine.FindSet then
                    repeat
                        VarSumDisc += RecSlsLine."Inv. Discount Amount" + RecSlsLine."Line Discount Amount";

                        if RecSlsLine."Amount Including VAT" - RecSlsLine.Amount <> 0 then begin
                            VarSumVATPercent += RecSlsLine."VAT %";
                            VarCountLineVAT += 1;
                        end;
                    until RecSlsLine.Next = 0;

                if VarSumVATPercent <> 0 then
                    VarHeadInfo[11] := 'GST' + ' @ ' + Format(Round(VarSumVATPercent / VarCountLineVAT, 0.1, '=')) + ' %'
                else
                    VarHeadInfo[11] := 'GST';

                //Bill to
                //  RecCust.Reset();

                RecCust.Reset();
                if RecCust.get("Bill-to Customer No.") then;
                RecProject.Reset();
                RecProject.SetRange("Customer No.", "Bill-to Customer No.");
                if RecProject.FindFirst() then;
                if RecProject."Levy payment option" <> 'PAID by Contractor' then
                    VarBillTo[1] := RecCust.Name
                else
                    VarBillTo[1] := RecProject."POC Contact Name";
                RecRegDetail.Reset();
                RecRegDetail.SetRange("Customer No.", "Bill-to Customer No.");
                if RecRegDetail.FindSet() then;
                VarBillTo[2] := RecRegDetail."Business Name";
                VarBillTo[3] := RecRegDetail."Certificate No.";
                VarBillTo[4] := "Bill-to Address";
                VarBillTo[5] := "Bill-to Address 2";

                if "Bill-to City" <> '' then begin
                    RecCountry.Reset;
                    if RecCountry.Get("Bill-to Country/Region Code") then
                        VarBillTo[6] := "Bill-to City" + ', ' + RecCountry.Name + ' ' + "Bill-to Post Code";
                end else begin
                    RecCountry.Reset;
                    if RecCountry.Get("Bill-to Country/Region Code") then
                        VarBillTo[6] := RecCountry.Name + ' ' + "Bill-to Post Code";
                end;

                // if RecContact.Get("Bill-to Contact No.") then begin
                VarBillTo[7] := 'Email ' + RecProject."POC Email";
                VarBillTo[8] := 'Phone ' + RecProject."POC Phone No.";
                // end;

                CompressArray(VarBillTo);

                //Bank Information
                RecBank.Reset();
                RecBank.SetCurrentKey("No.");
                RecBank.SetFilter("Default Bank", '%1', true);
                if RecBank.FindSet() then begin
                    i := 0;
                    repeat
                        if i = 0 then begin
                            VarBankInfo[1] := RecBank.Name;
                            VarBankInfo[2] := RecBank."Bank Account No.";
                            VarBankInfo[3] := RecBank."Bank Branch No.";
                            VarBankInfo[4] := RecBank."SWIFT Code";
                        end;
                        if i = 1 then begin
                            VarBankInfo2[1] := RecBank.Name;
                            VarBankInfo2[2] := RecBank."Bank Account No.";
                            VarBankInfo2[3] := RecBank."Bank Branch No.";
                            VarBankInfo2[4] := RecBank."SWIFT Code";
                        end;
                        if i = 2 then begin
                            VarBankInfo3[1] := RecBank.Name;
                            VarBankInfo3[2] := RecBank."Bank Account No.";
                            VarBankInfo3[3] := RecBank."Bank Branch No.";
                            VarBankInfo3[4] := RecBank."SWIFT Code";
                        end;
                        if i = 3 then begin
                            VarBankInfo4[1] := RecBank.Name;
                            VarBankInfo4[2] := RecBank."Bank Account No.";
                            VarBankInfo4[3] := RecBank."Bank Branch No.";
                            VarBankInfo4[4] := RecBank."SWIFT Code";
                        end;
                        if i = 4 then begin
                            VarBankInfo5[1] := RecBank.Name;
                            VarBankInfo5[2] := RecBank."Bank Account No.";
                            VarBankInfo5[3] := RecBank."Bank Branch No.";
                            VarBankInfo5[4] := RecBank."SWIFT Code";
                        end;
                        i += 1;
                    until RecBank.Next() = 0;
                end;

                //Footer value
                VarFootValDec[1] := Amount; //46 - Total (After discount)
                VarFootValDec[2] := "Amount Including VAT" - Amount; //47 - VAT
                VarFootValDec[3] := Amount + VarSumDisc; //48 - Subtotal
                VarFootValDec[4] := VarSumDisc; //49 - Discount
                VarFootValDec[5] := "Amount Including VAT"; //50 - Grand Total

                if VarSumDisc = 0 then
                    ReqPShowDisc := false
                else
                    ReqPShowDisc := true;
            end;
        }
    }

    var
        RecRegDetail: Record "Registration Details";
        RecProject: Record "Project Details";
        RecCompInfo: Record "Company Information";
        RecCust: Record Customer;
        RecGLSet: Record "General Ledger Setup";
        RecCountry: Record "Country/Region";
        RecBank: Record "Bank Account";
        RecSlsLine: Record "Sales Invoice Line";
        RecContact: Record Contact;
        ReqPDocTittleOpt: Option "Order";
        ReqPShowDisc: Boolean;
        ReqPBankSel: Code[20];
        ReqPSayingAmnt: Boolean;
        ReqPShowPicISO: Boolean;
        ReqPShowNonCommercial: Boolean;
        VarDocTittle: Text;
        VarCompInfo: array[20] of Text;
        VarHeadInfo: array[20] of Text;
        VarLinesValText: array[10] of Text;
        VarLinesValDec: array[10] of Decimal;
        VarFootValDec: array[8] of Decimal;
        VarBillTo: array[10] of Text;
        VarShipTo: array[10] of Text;
        VarBankInfo: array[10] of Text;
        VarBankInfo2: array[10] of Text;
        VarBankInfo3: array[10] of Text;
        VarBankInfo4: array[10] of Text;
        VarBankInfo5: array[10] of Text;
        i: Integer;
        VarSumVATPercent: Decimal;
        VarCountLineVAT: Integer;
        VarSumDisc: Decimal;
        VarSumWHT: Decimal;
        SeqNo: Integer;
        VarFootInfo1: Text;
        VarFootInfo2: Text;
        VarAddInfo: array[10] of Text;
        Saying: array[2] of Text;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        OutputNo: Integer;


}

