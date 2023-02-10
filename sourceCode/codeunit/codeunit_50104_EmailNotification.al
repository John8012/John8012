codeunit 50104 EmailNotification
{
    trigger OnRun()
    begin
        SendInvoiceDueNotificationToCustomer('');
        sendOverdue97('');
    end;

    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesInvHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        DummyReportSelections: Record "Report Selections";
        eMail: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        ContractorStatement: Report "Contractor Statement";
        tempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        CustRecRef: RecordRef;
        BlobInStream: InStream;
        BlobOutStream: OutStream;
        BlobCustInStream: InStream;
        BlobCustOutStream: OutStream;
        EmailID: List of [Text];
        varEmail: list of [Text];
        varseparator: Text;
        varEmailCount: Integer;
        Subject: Text;
        Body: Text;
        AttachmentName: Text;
        returnValue: Boolean;

    procedure SendPaymentNotificationToCEO(SalesHeader: Record "Sales Header")
    begin
        SalesReceivablesSetup.Get();
        Clear(EmailID);

        varseparator := ';';
        if SalesReceivablesSetup."CEO Email" <> '' then begin
            if StrPos(SalesReceivablesSetup."CEO Email", varseparator) <> 0 then begin
                varEmail := SalesReceivablesSetup."CEO Email".Split(varseparator);
                for varEmailCount := 1 to varEmail.Count do begin
                    EmailID.Add(varEmail.Get(varEmailCount));
                end;
            end else
                EmailID.Add(SalesReceivablesSetup."CEO Email");
        end;

        CLEAR(Body);
        Subject := StrSubstNo('Invoice : %1 Preliminary Certificate', SalesHeader."No.");

        Body := 'Hi CEO, <br>';

        if SalesHeader."Remaining Amount" = 0 then
            Body += 'Contractor ' + SalesHeader."Bill-to Customer No." + '  is completed. '
        else
            Body += 'Contractor ' + SalesHeader."Bill-to Customer No." + '  Paid Patially. please release Premilinary certificate for contractor. ';

        Body += '<a href ="https://constructioncouncil.azurewebsites.net/">CIC Portal</a> ';

        Clear(EmailMessage);

        EmailMessage.Create(EmailID, Subject, Body, true);
        CLEAR(eMail);
        if eMail.Send(EmailMessage) then;
    end;

    procedure SendNotificationToCEO(SalesInvHeader: Record "Sales Invoice Header")
    begin
        SalesReceivablesSetup.Get();
        Clear(EmailID);

        varseparator := ';';
        if SalesReceivablesSetup."CEO Email" <> '' then begin
            if StrPos(SalesReceivablesSetup."CEO Email", varseparator) <> 0 then begin
                varEmail := SalesReceivablesSetup."CEO Email".Split(varseparator);
                for varEmailCount := 1 to varEmail.Count do begin
                    EmailID.Add(varEmail.Get(varEmailCount));
                end;
            end else
                EmailID.Add(SalesReceivablesSetup."CEO Email");
        end;

        CLEAR(Body);
        Subject := StrSubstNo('Invoice : %1 dated %2', SalesInvHeader."No.", Format(SalesInvHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'));

        Body := 'Dear Sir, Payment for Invoice No ' + SalesInvHeader."No." + ' is completed. <a href ="https://constructioncouncil.azurewebsites.net/">CIC Portal</a> ';

        Clear(EmailMessage);

        EmailMessage.Create(EmailID, Subject, Body, true);
        CLEAR(eMail);
        if eMail.Send(EmailMessage) then;
    end;

    procedure SendInvoiceDueNotificationToCustomer(DocNo: Code[20])
    begin
        SalesInvHeader.Reset();
        if DocNo <> '' then
            SalesInvHeader.SetRange("No.", DocNo);
        SalesInvHeader.SetFilter("Remaining Amount", '>%1', 0);
        SalesInvHeader.SetFilter("Posting Date", '%1|%2|%3', CalcDate('-30D', Today), CalcDate('-60D', Today), CalcDate('-90D', Today));
        if SalesInvHeader.FindSet() then begin
            repeat
                Customer.Reset();
                if Customer.get(SalesInvHeader."Bill-to Customer No.") then;
                Customer.TestField("E-Mail");
                varseparator := ';';
                Clear(EmailID);
                Clear(varEmail);
                if Customer."E-Mail" <> '' then begin
                    if StrPos(Customer."E-Mail", varseparator) <> 0 then begin
                        varEmail := Customer."E-Mail".Split(varseparator);
                        for varEmailCount := 1 to varEmail.Count do begin
                            EmailID.Add(varEmail.Get(varEmailCount));
                        end;
                    end else
                        EmailID.Add(Customer."E-Mail");
                end;

                SalesInvHeader.CalcFields("Remaining Amount");
                Subject := StrSubstNo('Invoice : %1 dated %2 for %3 days notification', SalesInvHeader."No.", Format(SalesInvHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'), SalesInvHeader."Posting Date" - Today);

                Clear(Body);
                Body := 'Dear ' + Customer.Name + ' - ' + Customer."No." + ', <br> <br> I hope you’re well. Please see attached invoice number ' + SalesInvHeader."No." + ', ';

                Body += 'payment E ' + format(SalesInvHeader."Remaining Amount") + ' due on ' + Format(SalesInvHeader."Due Date", 0, '<Day,2>/<Month,2>/<Year4>');

                Body += '.<br> Please let us know when we can expect to receive payment for this invoice. If you have any queries, don’t hesitate to let us know.';

                Body += '<br> <br> Kind regards,';

                Body += '<br> <br> Accounts Admin';

                Clear(EmailMessage);
                EmailMessage.Create(EmailID, Subject, Body, true);

                clear(BlobInStream);
                Clear(BlobOutStream);
                Clear(tempBlob);
                Clear(AttachmentName);
                TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
                Clear(DummyReportSelections);
                DummyReportSelections.SetFilter(Usage, '%1', DummyReportSelections.Usage::"S.Invoice");
                DummyReportSelections.SetFilter(Sequence, '%1', '1');
                if DummyReportSelections.FindFirst() then;
                RecRef.GetTable(SalesInvHeader);
                returnValue := Report.SaveAs(DummyReportSelections."Report ID", '', ReportFormat::Pdf, BlobOutStream, RecRef);
                TempBlob.CreateInStream(BlobInStream, TextEncoding::UTF8);
                AttachmentName := 'Sales Invoice.pdf';
                EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobInStream);

                CustRecRef.GetTable(Customer);
                Clear(tempBlob);
                Clear(BlobCustInStream);
                Clear(BlobCustOutStream);
                Clear(AttachmentName);
                Clear(ContractorStatement);
                TempBlob.CreateOutStream(BlobCustOutStream, TextEncoding::UTF8);
                ContractorStatement.InitializeRequestfromMail(CalcDate('-1Y', Today), SalesInvHeader."Posting Date", true, Customer."No.");
                returnValue := ContractorStatement.SaveAs('', ReportFormat::Pdf, BlobCustOutStream, CustRecRef);
                TempBlob.CreateInStream(BlobCustInStream, TextEncoding::UTF8);
                AttachmentName := 'Contractor Statement.pdf';
                EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobCustInStream);

                CLEAR(eMail);
                if eMail.Send(EmailMessage) then;
                if (SalesInvHeader."Posting Date" = CalcDate('-90D', Today)) then
                    sendLetterOfDemand(SalesInvHeader."No.");
            //end;
            until SalesInvHeader.Next() = 0;
        end;
    end;

    procedure sendLetterOfDemand(DocNo: Code[20])
    var
        LetterOfDemand: Report "Letter Of Demand";
    begin
        SalesInvHeader.Reset();
        SalesInvHeader.SetRange("No.", DocNo);
        if SalesInvHeader.FindFirst() then begin
            Customer.Reset();
            if Customer.get(SalesInvHeader."Bill-to Customer No.") then;
            Customer.TestField("E-Mail");
            varseparator := ';';
            Clear(EmailID);
            Clear(varEmail);
            if Customer."E-Mail" <> '' then begin
                if StrPos(Customer."E-Mail", varseparator) <> 0 then begin
                    varEmail := Customer."E-Mail".Split(varseparator);
                    for varEmailCount := 1 to varEmail.Count do begin
                        EmailID.Add(varEmail.Get(varEmailCount));
                    end;
                end else
                    EmailID.Add(Customer."E-Mail");
            end;

            SalesInvHeader.CalcFields("Remaining Amount");
            Subject := StrSubstNo('Invoice : %1 dated %2 for Letter of Demand', SalesInvHeader."No.", Format(SalesInvHeader."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'));

            Clear(Body);
            Body := 'Dear ' + Customer.Name + ' - ' + Customer."No." + ', <br> <br> I hope you’re well. Please see attached invoice number ' + SalesInvHeader."No." + ', ';

            Body += 'payment E ' + format(SalesInvHeader."Remaining Amount") + ' due for ' + Format(SalesInvHeader."Due Date", 0, '<Day,2>/<Month,2>/<Year4>');

            Body += '.<br> Please let us know when we can expect to receive payment for this invoice. If you have any queries, don’t hesitate to let us know.';

            Body += '<br> <br> Kind regards,';

            Body += '<br> <br> Accounts Admin';

            Clear(EmailMessage);
            EmailMessage.Create(EmailID, Subject, Body, true);

            clear(BlobInStream);
            Clear(BlobOutStream);
            Clear(tempBlob);
            Clear(AttachmentName);
            Clear(LetterOfDemand);

            TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
            RecRef.GetTable(SalesInvHeader);
            returnValue := LetterOfDemand.SaveAs('', ReportFormat::Pdf, BlobOutStream, RecRef);
            TempBlob.CreateInStream(BlobInStream, TextEncoding::UTF8);
            AttachmentName := 'Letter Of Demand.pdf';
            EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobInStream);

            CLEAR(eMail);
            if eMail.Send(EmailMessage) then;
        end;
    end;


    procedure sendOverdue97(DocNo: Code[20])
    var
        contractorStatement: Report "Contractor Statement";
        LetterOfDemand: Report "Letter Of Demand";
        demandDate: Date;
    begin
        SalesInvHeader.Reset();
        if DocNo <> '' then
            SalesInvHeader.SetRange("No.", DocNo);
        SalesInvHeader.SetFilter("Remaining Amount", '>%1', 0);
        SalesInvHeader.SetFilter("Posting Date", '%1', CalcDate('-97D', Today));
        if SalesInvHeader.FindSet() then begin
            repeat
                Customer.Reset();
                if Customer.get(SalesInvHeader."Bill-to Customer No.") then;
                Customer.TestField("E-Mail");
                varseparator := ';';
                Clear(EmailID);
                Clear(varEmail);
                if Customer."E-Mail" <> '' then begin
                    if StrPos(Customer."E-Mail", varseparator) <> 0 then begin
                        varEmail := Customer."E-Mail".Split(varseparator);
                        for varEmailCount := 1 to varEmail.Count do begin
                            EmailID.Add(varEmail.Get(varEmailCount));
                        end;
                    end else
                        EmailID.Add(Customer."E-Mail");
                end;

                SalesInvHeader.CalcFields("Remaining Amount");
                Subject := StrSubstNo('Invoice : %1 Handovered to Legal Department', SalesInvHeader."No.");

                Clear(Body);
                demandDate := CalcDate('-7D', Today);

                Body := 'Dear Sir/Madam... <br> At this time we still have not heard from you in regards to the letter of demand dated ' + Format(demandDate, 0, '<Day,2>/<Month,2>/<Year4>');

                Body += ' for E ' + format(SalesInvHeader."Remaining Amount") + ' which was due on ' + Format(SalesInvHeader."Due Date", 0, '<Day,2>/<Month,2>/<Year4>');

                Body += '. Nor have we gotten a positive response from you. Because we have failed in our attempt to work this out with you directly, we regret to ';

                Body += 'inform you that we have reported this issue to the legal department and turned this letter ';

                Body += 'of demand over to our attorneys who will be in contact with you in regard to the payment';

                Clear(EmailMessage);
                EmailMessage.Create(EmailID, Subject, Body, true);

                CustRecRef.GetTable(Customer);
                Clear(tempBlob);
                Clear(BlobCustInStream);
                Clear(BlobCustOutStream);
                Clear(AttachmentName);
                Clear(ContractorStatement);
                TempBlob.CreateOutStream(BlobCustOutStream, TextEncoding::UTF8);
                ContractorStatement.InitializeRequestfromMail(CalcDate('-1Y', Today), SalesInvHeader."Posting Date", true, Customer."No.");
                returnValue := ContractorStatement.SaveAs('', ReportFormat::Pdf, BlobCustOutStream, CustRecRef);
                TempBlob.CreateInStream(BlobCustInStream, TextEncoding::UTF8);
                AttachmentName := 'Contractor Statement.pdf';
                EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobCustInStream);

                clear(BlobInStream);
                Clear(BlobOutStream);
                Clear(tempBlob);
                Clear(AttachmentName);
                Clear(LetterOfDemand);

                TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
                RecRef.GetTable(SalesInvHeader);
                returnValue := LetterOfDemand.SaveAs('', ReportFormat::Pdf, BlobOutStream, RecRef);
                TempBlob.CreateInStream(BlobInStream, TextEncoding::UTF8);
                AttachmentName := 'Letter Of Demand.pdf';
                EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobInStream);

                CLEAR(eMail);
                if eMail.Send(EmailMessage) then;
            until SalesInvHeader.Next() = 0;
        end;
    end;

    procedure LevysendOverdue97()
    var
        contractorStatement: Report "Contractor Statement";
        LetterOfDemand: Report "Letter Of Demand Summary";
        demandDate: Date;
        SalesHeader: Record "Sales Header";
        CustomerNo: Code[20];
        SalesHeader2: Record "Sales Header";
    begin
        CustomerNo := '';
        SalesHeader.Reset();
        SalesHeader.SetCurrentKey("Bill-to Customer No.");
        // if DocNo <> '' then
        //SalesHeader.SetRange("No.", DocNo);
        //CUST034
        // SalesHeader.SetRange("Bill-to Customer No.", 'CUST034');
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("Levy Invoice", true);
        SalesHeader.SetFilter("Remaining Amount", '>%1', 0);
        SalesHeader.SetFilter("Posting Date", '%1', CalcDate('-97D', Today));
        // SalesHeader.SetFilter("Posting Date", '<%1', CalcDate('-39D', Today));
        if SalesHeader.FindSet() then begin
            repeat
                if CustomerNo <> SalesHeader."Bill-to Customer No." then begin
                    Customer.Reset();
                    if Customer.get(SalesHeader."Bill-to Customer No.") then;
                    Customer.TestField("E-Mail");
                    varseparator := ';';
                    Clear(EmailID);
                    Clear(varEmail);
                    if Customer."E-Mail" <> '' then begin
                        if StrPos(Customer."E-Mail", varseparator) <> 0 then begin
                            varEmail := Customer."E-Mail".Split(varseparator);
                            for varEmailCount := 1 to varEmail.Count do begin
                                EmailID.Add(varEmail.Get(varEmailCount));
                            end;
                        end else
                            EmailID.Add(Customer."E-Mail");
                    end;

                    // SalesHeader.CalcFields("Remaining Amount");
                    Subject := 'Letter of Demand';

                    Clear(Body);
                    demandDate := CalcDate('-7D', Today);

                    Body := 'Dear Sir/Madam... <br> We therefore request that you make payment of the amount of E 21,202.92 within 7 days of receiving this correspondence or contact our Finance office on 24049848/24041497, failing which the outstanding debt legal action will be taken against you.';
                    Body += 'Looking forward to your most favourable response ' + Format(demandDate, 0, '<Day,2>/<Month,2>/<Year4>');


                    Clear(EmailMessage);
                    EmailMessage.Create(EmailID, Subject, Body, true);

                    CustRecRef.GetTable(Customer);
                    // Clear(tempBlob);
                    // Clear(BlobCustInStream);
                    // Clear(BlobCustOutStream);
                    // Clear(AttachmentName);
                    // Clear(ContractorStatement);
                    // TempBlob.CreateOutStream(BlobCustOutStream, TextEncoding::UTF8);
                    // ContractorStatement.InitializeRequestfromMail(CalcDate('-1Y', Today), SalesInvHeader."Posting Date", true, Customer."No.");
                    // returnValue := ContractorStatement.SaveAs('', ReportFormat::Pdf, BlobCustOutStream, CustRecRef);
                    // TempBlob.CreateInStream(BlobCustInStream, TextEncoding::UTF8);
                    // AttachmentName := 'Contractor Statement.pdf';
                    // EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobCustInStream);

                    clear(BlobInStream);
                    Clear(BlobOutStream);
                    Clear(tempBlob);
                    Clear(AttachmentName);
                    Clear(LetterOfDemand);

                    TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
                    SalesHeader2.Reset();
                    SalesHeader2.SetRange("Bill-to Customer No.", SalesHeader."Bill-to Customer No.");
                    SalesHeader2.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                    SalesHeader2.SetRange("Levy Invoice", true);
                    SalesHeader2.SetFilter("Remaining Amount", '>%1', 0);
                    SalesHeader2.SetFilter("Posting Date", '%1', CalcDate('-97D', Today));
                    //SalesHeader2.SetFilter("Posting Date", '<%1', CalcDate('-39D', Today));
                    if SalesHeader2.FindSet() then;
                    RecRef.GetTable(SalesHeader2);
                    returnValue := LetterOfDemand.SaveAs('', ReportFormat::Pdf, BlobOutStream, RecRef);
                    TempBlob.CreateInStream(BlobInStream, TextEncoding::UTF8);
                    AttachmentName := 'Letter Of Demand.pdf';
                    EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobInStream);

                    CLEAR(eMail);
                    if eMail.Send(EmailMessage) then;
                    CustomerNo := SalesHeader."Bill-to Customer No.";
                end;
            until SalesHeader.Next() = 0;

        end;
    end;

    procedure LevysendOverdue90()
    var
        contractorStatement: Report "Contractor Statement";
        LetterOfDemand: Report "Letter Of Demand Summary";
        demandDate: Date;
        SalesHeader: Record "Sales Header";
        CustomerNo: Code[20];
        SalesHeader2: Record "Sales Header";
    begin
        CustomerNo := '';
        SalesHeader.Reset();
        SalesHeader.SetCurrentKey("Bill-to Customer No.");
        // if DocNo <> '' then
        //SalesHeader.SetRange("No.", DocNo);
        //CUST034
        // SalesHeader.SetRange("Bill-to Customer No.", 'CUST034');
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
        SalesHeader.SetRange("Levy Invoice", true);
        SalesHeader.SetFilter("Remaining Amount", '>%1', 0);
        SalesHeader.SetFilter("Posting Date", '%1', CalcDate('-90D', Today));
        // SalesHeader.SetFilter("Posting Date", '<%1', CalcDate('-39D', Today));
        if SalesHeader.FindSet() then begin
            repeat
                if CustomerNo <> SalesHeader."Bill-to Customer No." then begin
                    Customer.Reset();
                    if Customer.get(SalesHeader."Bill-to Customer No.") then;
                    Customer.TestField("E-Mail");
                    varseparator := ';';
                    Clear(EmailID);
                    Clear(varEmail);
                    if Customer."E-Mail" <> '' then begin
                        if StrPos(Customer."E-Mail", varseparator) <> 0 then begin
                            varEmail := Customer."E-Mail".Split(varseparator);
                            for varEmailCount := 1 to varEmail.Count do begin
                                EmailID.Add(varEmail.Get(varEmailCount));
                            end;
                        end else
                            EmailID.Add(Customer."E-Mail");
                    end;

                    // SalesHeader.CalcFields("Remaining Amount");
                    Subject := 'Letter of Demand';

                    Clear(Body);
                    demandDate := CalcDate('-7D', Today);

                    Body := 'Dear Sir/Madam... <br> We therefore request that you make payment of the amount of E 21,202.92 within 7 days of receiving this correspondence or contact our Finance office on 24049848/24041497, failing which the outstanding debt legal action will be taken against you.';
                    Body += 'Looking forward to your most favourable response ' + Format(demandDate, 0, '<Day,2>/<Month,2>/<Year4>');


                    Clear(EmailMessage);
                    EmailMessage.Create(EmailID, Subject, Body, true);

                    CustRecRef.GetTable(Customer);
                    // Clear(tempBlob);
                    // Clear(BlobCustInStream);
                    // Clear(BlobCustOutStream);
                    // Clear(AttachmentName);
                    // Clear(ContractorStatement);
                    // TempBlob.CreateOutStream(BlobCustOutStream, TextEncoding::UTF8);
                    // ContractorStatement.InitializeRequestfromMail(CalcDate('-1Y', Today), SalesInvHeader."Posting Date", true, Customer."No.");
                    // returnValue := ContractorStatement.SaveAs('', ReportFormat::Pdf, BlobCustOutStream, CustRecRef);
                    // TempBlob.CreateInStream(BlobCustInStream, TextEncoding::UTF8);
                    // AttachmentName := 'Contractor Statement.pdf';
                    // EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobCustInStream);

                    clear(BlobInStream);
                    Clear(BlobOutStream);
                    Clear(tempBlob);
                    Clear(AttachmentName);
                    Clear(LetterOfDemand);

                    TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
                    SalesHeader2.Reset();
                    SalesHeader2.SetRange("Bill-to Customer No.", SalesHeader."Bill-to Customer No.");
                    SalesHeader2.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                    SalesHeader2.SetRange("Levy Invoice", true);
                    SalesHeader2.SetFilter("Remaining Amount", '>%1', 0);
                    SalesHeader2.SetFilter("Posting Date", '%1', CalcDate('-90D', Today));
                    //SalesHeader2.SetFilter("Posting Date", '<%1', CalcDate('-39D', Today));
                    if SalesHeader2.FindSet() then;
                    RecRef.GetTable(SalesHeader2);
                    returnValue := LetterOfDemand.SaveAs('', ReportFormat::Pdf, BlobOutStream, RecRef);
                    TempBlob.CreateInStream(BlobInStream, TextEncoding::UTF8);
                    AttachmentName := 'Letter Of Demand.pdf';
                    EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobInStream);

                    CLEAR(eMail);
                    if eMail.Send(EmailMessage) then;
                    CustomerNo := SalesHeader."Bill-to Customer No.";
                end;
            until SalesHeader.Next() = 0;

        end;
    end;

    procedure AssessmentLetter(SalesInvHeader: Record "Sales Header")
    var
        salesHeader: Record "Sales Header";
        assessmentLetterLevy: Report "Assessment Letter Levy";
        demandDate: Date;
    begin
        salesHeader.Reset();
        salesHeader.SetRange("Document Type", SalesInvHeader."Document Type");
        salesHeader.SetRange("No.", SalesInvHeader."No.");
        if salesHeader.FindFirst() then begin
            Customer.Reset();
            if Customer.get(salesHeader."Bill-to Customer No.") then;
            Customer.TestField("E-Mail");
            varseparator := ';';
            Clear(EmailID);
            Clear(varEmail);
            if Customer."E-Mail" <> '' then begin
                if StrPos(Customer."E-Mail", varseparator) <> 0 then begin
                    varEmail := Customer."E-Mail".Split(varseparator);
                    for varEmailCount := 1 to varEmail.Count do begin
                        EmailID.Add(varEmail.Get(varEmailCount));
                    end;
                end else
                    EmailID.Add(Customer."E-Mail");
            end;

            Subject := StrSubstNo('Invoice : %1 Assessment Letter', salesHeader."No.");

            Clear(Body);

            Body := 'Dear Sir/Madam... <br> Please find the attachement of Assessment Letter';

            Clear(EmailMessage);
            EmailMessage.Create(EmailID, Subject, Body, true);

            clear(BlobInStream);
            Clear(BlobOutStream);
            Clear(tempBlob);
            Clear(AttachmentName);
            Clear(assessmentLetterLevy);

            TempBlob.CreateOutStream(BlobOutStream, TextEncoding::UTF8);
            RecRef.GetTable(salesHeader);
            returnValue := assessmentLetterLevy.SaveAs('', ReportFormat::Pdf, BlobOutStream, RecRef);
            TempBlob.CreateInStream(BlobInStream, TextEncoding::UTF8);
            AttachmentName := 'Assessment Letter.pdf';
            EmailMessage.AddAttachment(AttachmentName, 'PDF', BlobInStream);

            CLEAR(eMail);
            if eMail.Send(EmailMessage) then;
        end;
    end;
}