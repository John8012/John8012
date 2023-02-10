codeunit 50105 UpdateAzureFormStatus
{

    procedure PaymentCompletedNotification(salesInvHeader: Record "Sales Invoice Header")
    var
        client: HttpClient;
        response: HttpResponseMessage;
        Headers: HttpHeaders;
        requestContent: HttpContent;
        ABSContainersetup: Record "AZBSA Blob Storage Connection";
        MyJobject: JsonObject;
        fullURL: Text;
        rowKey: Text;
        responseText: Text;
        ResponseMessage: HttpResponseMessage;
        RequestMessage: HttpRequestMessage;
        requestBody: Text;
        method: Text;
        formName: Text;
        extDocNo1: Text;
        extDocNo2: Text;
    begin
        ABSContainersetup.Reset();
        if ABSContainersetup.FindFirst() then;

        case salesInvHeader."Form Name" of
            'Form1':
                formName := 'cicform1';
            'Form2':
                formName := 'cicform1';
            'Form3':
                formName := 'cicform3';
            'Form4':
                formName := 'cicform4';
            'Form5':
                formName := 'cicform5';
            'Form6':
                formName := 'cicform6';
            'Form7':
                formName := 'cicform7';
            'Form8':
                formName := 'cicform8';
        end;

        if formName = 'cicform1' then begin
            extDocNo1 := CopyStr(salesInvHeader."External Document No.", 1, 1);
            extDocNo2 := LowerCase(CopyStr(salesInvHeader."External Document No.", 2));
            rowKey := '(PartitionKey=''' + salesInvHeader."Partition Key" + ''',RowKey=''' + extDocNo1 + extDocNo2 + ''')';
        end else
            rowKey := '(PartitionKey=''' + salesInvHeader."Partition Key" + ''',RowKey=''' + salesInvHeader."External Document No." + ''')';

        fullURL := StrSubstNo('%1%2%3/?%4', ABSContainersetup."Account URL",
                                            formName,
                                            rowKey,
                                            ABSContainersetup."SAS Token");
        UpdateAzureStorage(fullURL, salesInvHeader);
    end;

    procedure GetData(fullURL: Text): Text;
    var
        client: HttpClient;
        Headers: HttpHeaders;
        ResponseMessage: HttpResponseMessage;
        responseText: Text;
    begin
        Client.DefaultRequestHeaders.Clear();
        Client.DefaultRequestHeaders().TryAddWithoutValidation('Content-Type', 'application/json;odata=nometadata');
        Client.DefaultRequestHeaders().Add('Accept', 'application/json');

        Headers.Clear();
        Headers.TryAddWithoutValidation('Content-Type', 'application/json');
        Client.Get(fullURL, ResponseMessage);
        ResponseMessage.Content.ReadAs(responseText);
        exit(responseText);
    end;

    procedure UpdateAzureStorage(fullURL: Text; salesInvHeader: Record "Sales Invoice Header")
    var
        client: HttpClient;
        Headers: HttpHeaders;
        requestContent: HttpContent;
        ResponseMessage: HttpResponseMessage;
        MyJobject: JsonObject;
        rowKey: Text;
        requestBody: Text;
        method: Text;
        formName: Text;
        responseText: Text;
    begin
        responseText := GetData(fullURL);
        RequestBody := ParseAndUpdateJson(responseText, salesInvHeader);
        requestContent.WriteFrom(RequestBody);
        requestContent.GetHeaders(Headers);
        Client.DefaultRequestHeaders.Clear();
        Client.DefaultRequestHeaders().TryAddWithoutValidation('Content-Type', 'application/json;odata=nometadata');
        Client.DefaultRequestHeaders().Add('Accept', 'application/json; charset=utf-8');
        Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'application/json');
        Client.Put(fullURL, RequestContent, ResponseMessage);
        ResponseMessage.Content.ReadAs(responseText);
    end;

    local procedure ParseAndUpdateJson(responseText: Text; salesInvHeader: Record "Sales Invoice Header"): Text
    var
        varJsonObject: JsonObject;
        updatedText: Text;
    begin
        varJsonObject.ReadFrom(responseText);
        varJsonObject.Remove('PartitionKey');
        varJsonObject.Remove('RowKey');
        varJsonObject.Remove('Timestamp');
        varJsonObject.Remove('odata.metadata');
        varJsonObject.Remove('odata.etag');
        varJsonObject.Replace('InvoiceNo', salesInvHeader."Pre-Assigned No.");
        varJsonObject.Replace('Reviewer', 'CEO');
        varJsonObject.WriteTo(updatedText);
        exit(updatedText);
    end;
}