page 50100 "Purchase Requisition"
{
    Caption = 'Purchase Requisition';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Approve,Request Approval,Print/Send,Requisition,Release,Navigate';
    RefreshOnActivate = true;
    SourceTable = "Purchase Header";
    SourceTableView = WHERE("Document Type" = FILTER(Requisition));

    layout
    {
        area(content)
        {

            group(General)
            {
                Caption = 'General';
                Editable = Invoiced;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    Caption = 'Purchase Requisition Number';
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                // field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Vendor No.';
                // }
                // field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Vendor Name';
                // }

                field(Preparer; Rec.Preparer)
                {
                    Caption = 'Preparer';
                    ApplicationArea = All;
                }
                field(Requestor; Rec.Requestor)
                {
                    Caption = 'Requester';
                    ApplicationArea = All;
                }
                field("Requisition Purpose"; Rec."Requisition Purpose")
                {
                    ApplicationArea = All;
                }
                field("Requisition Reason"; Rec."Requisition Reason")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Expected delivery date "; Rec."Expected delivery date ")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    StyleExpr = StatusStyleTxt;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                group(requitionDetailsGroup)
                {
                    Caption = 'Requisition Details';
                    field(requitionDetails; requitionDetails)
                    {
                        MultiLine = true;
                        ApplicationArea = All;
                        Importance = Additional;
                        ShowCaption = false;
                        trigger OnValidate()
                        begin
                            Rec.setRequitionDetails(requitionDetails);
                        end;
                    }
                }
            }
            part(PurchLines; "Purchase Requisition Subform")
            {
                ApplicationArea = Suite;
                Editable = Invoiced;
                Enabled = true;
                SubPageLink = "Document No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Requisition")
            {
                Caption = '&Requisition';
                Enabled = Invoiced;
                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category7;
                    RunObject = Page "Purch. Comment Sheet";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                  "No." = FIELD("No."),
                                  "Document Line No." = CONST(0);
                    ToolTip = 'View or add comments for the record.';
                    Enabled = Invoiced;
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Enabled = Invoiced;
                    Image = Dimensions;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim;
                        CurrPage.SaveRecord;
                    end;
                }
                action(Approvals)
                {
                    AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category7;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';
                    Enabled = Invoiced;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalsPurchase(Rec);
                    end;
                }
            }
        }
        area(processing)
        {
            group(Approval)
            {
                Caption = 'Approval';
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Enabled = Invoiced;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject to approve the incoming document.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Enabled = Invoiced;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the approval to a substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Enabled = Invoiced;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;
                    Enabled = Invoiced;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(Action92)
            {
                Caption = 'Print';
                Visible = false;
                action(Print)
                {
                    ApplicationArea = Suite;
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';
                    Enabled = Invoiced;
                    trigger OnAction()
                    var
                        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
                    begin
                        LinesInstructionMgt.PurchaseCheckAllLinesHaveQuantityAssigned(Rec);
                        DocPrint.PrintPurchHeader(Rec);
                    end;
                }
            }
            group(Action3)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                action(Release)
                {
                    Enabled = Invoiced;
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';
                    ToolTip = 'Release the document to the next stage of processing. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualRelease(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = (Rec.Status <> Rec.Status::Open) OR Invoiced;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedOnly = true;
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    trigger OnAction()
                    var
                        ReleasePurchDoc: Codeunit "Release Purchase Document";
                    begin
                        ReleasePurchDoc.PerformManualReopen(Rec);
                        CurrPage.PurchLines.PAGE.ClearTotalPurchaseHeader();
                    end;
                }
            }
            group("F&unctions")
            {
                group("Make Order")
                {
                    Caption = 'Make Quote';
                    Image = MakeOrder;

                    action(MakeQuote)
                    {
                        Enabled = Invoiced;
                        ApplicationArea = Suite;
                        Caption = 'Make Quote';
                        Image = MakeOrder;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ToolTip = 'Convert the purchase requisition to a purchase quote.';

                        trigger OnAction()
                        begin
                            if Rec.Status = Rec.Status::Released then
                                CODEUNIT.Run(CODEUNIT::"Purch.-Req to Quote (Yes/No)", Rec)
                            else
                                Error('Document must be approved and released before you can perform this action.');
                        end;
                    }
                    action(Navigate)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Quotes';
                        Image = MakeOrder;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ToolTip = 'Navigate to related purchase quote.';
                        RunObject = Page "Purchase Quotes";
                        RunPageLink = "Requisition No." = field("No.");
                    }
                    action(NavigateToOrder)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Order';
                        Image = Order;
                        Promoted = true;
                        PromotedCategory = Process;
                        PromotedIsBig = true;
                        ToolTip = 'Navigate to related purchase order.';
                        RunObject = Page "Purchase Order List";
                        RunPageLink = "Requisition No." = field("No.");
                    }
                }
                // action(CopyDocument)
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Copy Document';
                //     Ellipsis = true;
                //     Enabled = "No." <> '';
                //     Image = CopyDocument;
                //     Promoted = true;
                //     PromotedCategory = Process;
                //     ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                //     trigger OnAction()
                //     begin
                //         CopyDocument();
                //         if Get("Document Type", "No.") then;
                //     end;
                // }
                // action("Archive Document")
                // {
                //     ApplicationArea = Suite;
                //     Caption = 'Archi&ve Document';
                //     Image = Archive;
                //     ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';

                //     trigger OnAction()
                //     begin
                //         ArchiveManagement.ArchivePurchDocument(Rec);
                //         CurrPage.Update(false);
                //     end;
                // }

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist OR Invoiced;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if ApprovalsMgmt.CheckPurchaseApprovalPossible(Rec) then
                            ApprovalsMgmt.OnSendPurchaseDocForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR Invoiced;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OnCancelPurchaseApprovalRequest(Rec);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        StatusStyleTxt := Rec.GetStatusStyleText();
        requitionDetails := Rec.getRequitionDetails();
    end;

    trigger OnAfterGetRecord()
    begin
        BuyFromContact.GetOrClear(Rec."Buy-from Contact No.");
        PayToContact.GetOrClear(Rec."Pay-to Contact No.");

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", Rec."Document Type");
        PurchaseLine.SetRange("Document No.", Rec."No.");
        PurchaseLine.SetFilter("Quantity Invoiced", '<>%1', 0);
        if PurchaseLine.FindFirst() then
            Invoiced := false
        else
            Invoiced := true;

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        CurrPage.SaveRecord;
        exit(Rec.ConfirmDeletion);
    end;

    trigger OnInit()
    begin
        ShowShippingOptionsWithLocation := ApplicationAreaMgmtFacade.IsLocationEnabled or ApplicationAreaMgmtFacade.IsAllDisabled;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."Responsibility Center" := UserMgt.GetPurchasesFilter;

        if (not DocNoVisible) and (rec."No." = '') then
            rec.SetBuyFromVendorFromFilter;
    end;

    trigger OnOpenPage()
    begin
        Rec.SetSecurityFilterOnRespCenter();
        Rec.SetRange("Date Filter", 0D, WorkDate());

        PurchaseLine.Reset();
        PurchaseLine.SetRange("Document Type", Rec."Document Type");
        PurchaseLine.SetRange("Document No.", Rec."No.");
        PurchaseLine.SetFilter("Quantity Invoiced", '<>%1', 0);
        if PurchaseLine.FindFirst() then
            Invoiced := false
        else
            Invoiced := true;
    end;

    var
        PurchaseLine: Record "Purchase Line";
        BuyFromContact: Record Contact;
        PayToContact: Record Contact;
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
        DocPrint: Codeunit "Document-Print";
        UserMgt: Codeunit "User Setup Management";
        [InDataSet]
        StatusStyleTxt: Text;
        HasIncomingDocument: Boolean;
        DocNoVisible: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        ShowShippingOptionsWithLocation: Boolean;
        requitionDetails: Text;
        Invoiced: Boolean;
        EverythingInvoiced: Boolean;


    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        HasIncomingDocument := Rec."Incoming Document Entry No." <> 0;
    end;
}

