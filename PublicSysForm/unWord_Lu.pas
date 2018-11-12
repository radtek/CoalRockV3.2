unit unWord_Lu;
(*
By ¬��־ ��д 2013.09.06 Email:lgz2050@163.com
*)
interface
uses Word2000, ActiveX, Variants, Dialogs, SysUtils,Windows,Forms,Controls;
type
    TMyWord = class(TObject)
    private
        procedure connectword();

    public
        FWord: TWordApplication;        //word����
        FDoc: TWordDocument;            //�ĵ�����

        //�ļ��Ƿ���ʾ
        procedure WordVis(Vis:Boolean);
        //���ĵ�
        procedure OpenWord(sFileName:string);
        // ������ʾparent
        procedure SetParentWindow(pParent: TWinControl);
        // ���ñ䶯
        procedure Resize(Panel:TWinControl);
        //������ʾ����
        procedure SetZoomPercentage(Value:integer);
        //����
        procedure AddReturn();
        // ���ز�ͬ�����������루Word�汾��ͬ���������벻ͬ��
        function ReturnHeadingIndex(value:integer):integer;
        //��������
        procedure SetFont(FontName: string; FontSize: Integer;
                   FontBold: Boolean = False; FontUnderline: Boolean = False);
        //�������
        function AddTable(Col, Row: Integer): Table;
        // �ϲ���Ԫ��
        procedure TableCellMerge(tab:Table;Col1,Row1,Col2,Row2:integer);
        //���ñ����п�
        procedure setTableColumsWidth(Tab:Table;Col,Wids:integer);
        // ���ñ����и�
        procedure SetTableRowsHeight(Tab:Table;Row,Height:integer);
        // ���õ�Ԫ��� �߿���
        procedure TableBorders(Tab:Table;InSideLine,OutSideLine:integer);
        // ���������
        procedure InsertRow(Tab:Table;irow,InserCount:integer);
        //����ɾ����
        procedure  DeleteLastRow(Tab:Table);
        //���ñ���ɫ
        procedure SetTableBack(BackColor: ToleEnum);
        //�������
        procedure MoveDown(num: Integer = 1);
        //ѡ������
        procedure SelectDown(num: Integer = 1);
        //�������
        procedure Moveup(num:integer);
        //�������
        procedure MoveRight(num: Integer = 1);
         //�������
        procedure MoveLeft(num: Integer = 1);
        //ѡ������
        procedure SelectRight(num: Integer = 1);
        //д��
        procedure WriteText(Text: string; Value:integer);
        //����ʽ����һ�м�¼
        //��AddLine "��ע","����"
        //AddLine 'kk',"���� 1"
        procedure SetHeading(ititle:string;Level:integer);
      //  procedure AddLine(S: string; PStyle: olevariant);
        procedure AlignLine(Align: ToleEnum);
        //�����ҳ��
        procedure insertPage(value:integer);
        //�������ҳ��
        procedure insertPagenum(start:integer);
        // ����ҳü
        procedure insertpageHead(HeadValue1,HeadValue2:string);
        //����ҳ��
        procedure insertpageFoot(FootValue1,FootValue2:string);
        //��������
        procedure insertDate();
        //���ñ���һ�п���
        procedure SetTable(PTable: Table; ColumnIdx: Integer; Width: Integer);
        //���ñ���һ�и߶�
        procedure SetTableheight(PTable: Table; RowIdx: Integer; height:
        Integer);
        //����Ŀ¼
        procedure InsertContents(stratid,Endid,wdIn:integer);
        //������ǩ
        procedure createBookMark(BookMarkName: string);
        //�ƶ�����ǩ
        procedure GotoBookMark(BookMarkName: string);
        //ɾ����ǩ
        procedure DeleteBookMark(BookMarkName: string);
        //ճ��
        procedure paste();
        //�滻
        procedure Replace(Source, Target: string);
        //����
        procedure Save(FileName: string);
        // ����Ϊmht ��ʽ
        procedure SaveAs( FileName: string);
        //����ͼƬ
        procedure AddPicture(FileName: string;Bl:double);
        // Ϊ�ļ�����ˮӡ
        procedure InsetWaterBmp(Waterbmp,loginBmp:string;Left,Top,Width,Heigth:integer);
        procedure InsetBottomLine(Waterbmp:string;Left,Top,Width,Heigth:integer);
        //�Ƶ����
        procedure MoveEnd(id :integer);
        //�ϲ�
        procedure CellsMerge();
        // ����ҳ�߾�
        procedure setpagemargin(iTop,iBottom,iLeft,iRight:integer);
        // ������һ���ļ��������
        procedure InsertOtherfile(PathFile:string);
        // �趨�����о�
        procedure SetParagraphFormat(Value:integer);
        // ����ֽ�ŷ���
        procedure SetPageOrient(Value:integer);
        // ����ҳüҳ������һ�� ��ͬ ������ͬ
        procedure SetHeadFootSame(Value:integer);
        //�ر�ƴд������
        procedure CloseCheckGrammar(Value:Boolean);
        //���ö��������������ַ���
        procedure SetLeftOrRightIndex(Lf,Ri:integer);
        // ɾ���Զ����
        procedure RemoveAutoNumbers;
        constructor Create;
        destructor Destroy; override;
end;

var
     gWaveHwnd:Hwnd;

implementation

constructor TMyWord.Create();
begin
    inherited Create;
    Connectword();
  
end;
 
procedure TMyWord.connectword();
var
B: Boolean;
begin
   B := False;
   if (FWord = nil) then
            B := True
    else   begin
        try
            FDoc.Activate;
        except
            B := True;
        end;
 
    end;
 
    if not B then Exit;
    FWord := TWordApplication.Create(nil); //word����
    FDoc := TWordDocument.Create(nil);  //�ĵ�����

end;
procedure TMyWord.OpenWord(sFileName:string);
var
  //���ļ��Ĳ���
  FileName,CfCversions,ReadOnly,AddToRctFiles,PswDocument,PswTemplate,Revert,
  WPswDocument,WPswTemplate,Format,Encoding,Visible,OpenAndRepair,
  DocumentDirection,NoEncodingDialog,XMLTransform:OleVariant;
  docinx:OleVariant;
begin

// ===== ���ļ� =====
        docinx:=1;
        FWord.Visible := false;
        FileName:=sFileName;
        CfCversions :=  false;
        ReadOnly:=False;
        AddToRctFiles:= false;
        PswDocument:= '';
        PswTemplate:= '';
        Revert:=true;
        WPswDocument:= '';//�ĵ�����
        WPswTemplate:= '';//ģ������
        Format:= EmptyParam;
        Encoding:= '';
        Visible:=true;
        OpenAndRepair:= EmptyParam;
        DocumentDirection:= EmptyParam;
        NoEncodingDialog:= EmptyParam;
        XMLTransform:=EmptyParam;
        if sFileName='' then  begin //�������ĵ�
            FWord.Connect;
            FDoc.Activate;

        end else begin   //���ĵ�
           {
            const FileName: OleVariant; const ConfirmConversions: OleVariant;
                        const ReadOnly: OleVariant; const AddToRecentFiles: OleVariant;
                        const PasswordDocument: OleVariant; const PasswordTemplate: OleVariant;
                        const Revert: OleVariant; const WritePasswordDocument: OleVariant;
                        const WritePasswordTemplate: OleVariant; const Format: OleVariant;
                        const Encoding: OleVariant; const Visible: OleVariant;
                        const OpenAndRepair: OleVariant; const DocumentDirection: OleVariant;
                        const NoEncodingDialog: OleVariant; const XMLTransform: OleVariant


           }

             FWord.Documents.open(FileName,CfCversions,ReadOnly,AddToRctFiles,PswDocument,
             PswTemplate,Revert,WPswDocument,WPswTemplate,Format,Encoding,Visible
                );
      //       ,OpenAndRepair,DocumentDirection,NoEncodingDialog,XMLTransform);
               FDoc.ConnectTo(FWord.documents.Item(docinx));

            //
        end;

   FWord.Visible := true;


 end;
procedure TMyWord.DeleteBookMark(BookMarkName: string);
var
  Name: olevariant;
  i:integer;
begin
    Name:=BookMarkName;
    for i:= FWord.ActiveDocument.BookMarks.count downto 1 do
      if  FWord.ActiveDocument.BookMarks.item(i).Name =BookMarkName then
          FWord.ActiveDocument.BookMarks.item(i).Delete ;

end;

procedure TMyWord.DeleteLastRow(Tab: Table);
var
  insertLine: OleVariant ;
begin
   insertLine:= TAB.Rows.Last;
   Tab.Rows.Last.Select ;
   TAB.Rows.Last.Delete;

end;

destructor TMyWord.Destroy;
begin

    FreeAndNil(FDoc);
    FreeAndNil(FWord); //FWord.Disconnect;
    //�˳�һ���˳�word,by yl 2005.2.2
//    FWord.Quit;
//    FWord.Free;
    inherited Destroy;
end;
procedure TMyWord.WordVis(Vis:Boolean);
begin
     FWord.Visible:=Vis;
end;
procedure TMyWord.AddReturn();
begin
    try
        FWord.Selection.TypeParagraph;
    except
        AddReturn();
    end;
 
end;
 
procedure TMyWord.SetFont(FontName: string; FontSize: Integer; FontBold:
      Boolean = False; FontUnderline: Boolean = False);
begin
    try
    //connectword();
      FWord.Selection.Font.Name := FontName;
      FWord.Selection.Font.Size := FontSize;
      if FontBold then begin
         FWord.Selection.Font.Bold :=wdToggle ;
      end else begin
         FWord.Selection.Font.Bold :=0 ;
      end;
      if FontUnderline then  begin
         FWord.Selection.Font.Underline := wdUnderlineSingle;
      end else begin
         FWord.Selection.Font.Underline :=wdUnderlineNone;
      end;
    except
        SetFont(FontName, FontSize, FontBold, FontUnderline);
    end;
 
end;
 
procedure TMyWord.SetHeadFootSame(Value: integer);
begin
    FWord.ActiveWindow.ActivePane.View.SeekView :=wdSeekCurrentPageFooter ;
     if Value =0 then   begin  //��ͬ
        FWord.Selection.HeaderFooter.LinkToPrevious:= true ;
     end else begin   // ��ͬ
        FWord.Selection.HeaderFooter.LinkToPrevious:= False ;
     end;
   FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument;
end;

procedure TMyWord.SetHeading(ititle: string; Level: integer);
 {   Level = 1 һ������ ����  �Ӻ�
             2 �������� left  �Ӻ�
             3 �������� left  �Ӻ�
             4 �ļ�����  ����  ��
             5 �弶����  ����  ͼ
             10 ����
   FontSize �����ֺ�
   Alin ���з�ʽ 0 left 1 center  2 right
   }

var
  outStyle: Style;
  v: olevariant;
  FSize,Alin,Spac,Bld:integer;
  Style_index:integer;
begin

    if (Level=4) or (Level=5) then  begin  //
       FSize:=10;
       Bld:=1;
       Alin:=1;
       Spac:=0;
    end else if (Level=1) then  begin
       FSize:=16;
       Bld:=1;
       Alin:=1;
       Spac:=13;
    end else if (Level=2) then  begin
       FSize:=16;
       Bld:=1;
       Alin:=0;
       Spac:=13;
    end else begin  // ������������������
       FSize:=14;
       Bld:=1;
       Alin:=0;
       Spac:=13;
    end;

    if ititle='��¼X' then  begin
       FSize:=14;
       Bld:=1;
       Alin:=0;
       Spac:=0;
    end;

    //Ѱ�ұ��������
    Style_index:=ReturnHeadingIndex(Level);

    WriteText(ititle,0);                       //����һ��
    try
         outStyle := FWord.ActiveDocument.Styles.Item(Style_index);
         outStyle.Font.Size :=FSize;
         outStyle.Font.Bold:= Bld;
         v := outStyle;
         FWord.Selection.Set_Style(v);
    except
         outStyle := FWord.ActiveDocument.Styles.Item(Style_index);
         outStyle.Font.Size :=FSize;
         outStyle.Font.Bold :=Bld;
         v := outStyle;
         FWord.Selection.Set_Style(v);
    end;
   FWord.Selection.ParagraphFormat.Alignment :=Alin;
   FWord.Selection.ParagraphFormat.SpaceBefore :=Spac;
   FWord.Selection.ParagraphFormat.SpaceAfter :=Spac;
   FWord.Selection.Typeparagraph;
end;

procedure TMyWord.SetLeftOrRightIndex(Lf, Ri: integer);
begin
    FWord.Selection.ParagraphFormat.CharacterUnitLeftIndent :=Lf;
    FWord.Selection.ParagraphFormat.CharacterUnitRightIndent:=Ri;
end;



procedure TMyWord.setpagemargin(iTop, iBottom, iLeft, iRight: integer);
{
   iTop, iBottom, iLeft, iRight  ���ͽ����ĵ�λ�Ǻ���
   ����� Ӣ��


}
begin
   FWord.ActiveDocument.PageSetup.TopMargin :=iTop/0.35;
   FWord.ActiveDocument.PageSetup.BottomMargin :=iBottom/0.35;
   FWord.ActiveDocument.PageSetup.LeftMargin :=iLeft/0.35;
   FWord.ActiveDocument.PageSetup.RightMargin :=iRight/0.35;
end;

//�������
function TMyWord.AddTable(Col, Row: Integer): Table;
var
DefaultTable: olevariant;
begin
    try
       connectword();
       DefaultTable := 1;
       Result := FDoc.Tables.Add(FWord.Selection.Range, Row, Col, DefaultTable,
                 EmptyParam);

       Result.Rows.Alignment:=wdAlignParagraphCenter;
    except
        ShowMessage(Format('��%d,��%d', [Col, Row]));
        AddTable(Col, Row);
    end;
 
end;
 
//���ñ���ɫ
procedure TMyWord.SetTableBack(BackColor: ToleEnum);
begin
    try
    //connectword();
    FWord.Selection.Cells.Shading.BackgroundPatternColor := BackColor;
    except
        SetTableBack(BackColor);
    end;
 
end;
 

procedure TMyWord.setTableColumsWidth(Tab: Table; Col, Wids: integer);
begin
     Tab.Columns.Item(col).Width :=Wids/0.35;
end;

//ѡ������
procedure TMyWord.SelectDown(num: Integer = 1);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
    Count := num;
    Unit_ := wdLine;
    Extend := wdExtend;
    FWord.Selection.MoveDown(Unit_, Count, Extend);
    except
        MoveDown();
    end;
 
end;
 
//�������
procedure TMyWord.MoveDown(num: Integer = 1);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
    Count := num;
    Unit_ := wdLine;
    FWord.Selection.MoveDown(Unit_, Count, Extend);
    except
        MoveDown();
    end;
 
end;
 
//�������
procedure TMyWord.Moveup(num:integer);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    Unit_ := wdLine;
    Count := num;
    FWord.Selection.Moveup(Unit_, Count, Extend);
end;

//ѡ������
procedure TMyWord.SelectRight(num: Integer = 1);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
    Unit_ := wdCharacter;
    Count := num;
    Extend := wdExtend;
    FWord.Selection.MoveRight(Unit_, Count, Extend);
    except
        MoveRight();
    end;
 
end;
 
//�������
procedure TMyWord.MoveRight(num: Integer = 1);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
    Unit_ := wdCell;
    Count := num;
    FWord.Selection.MoveRight(Unit_, Count, Extend);
    except
        MoveRight();
    end;
 
end;
 
//д��
procedure TMyWord.WriteText(Text: string; Value:integer);
begin
    try
       if Value  =1 then  begin
          SetParagraphFormat(1); // 1.5 ���о�
       end else begin
          SetParagraphFormat(0);
       end;

       FWord.Selection.TypeText(Text);
    except                            //��ֹ����ʧ��
        WriteText(Text,0);
    end;
 
end;

procedure TMyWord.AlignLine(Align: ToleEnum);
{
   0 left
   1 center
   2 right

}
begin
    FWord.Selection.ParagraphFormat.Alignment := Align;
end;
 
//�����ҳ��
procedure TMyWord.insertPage(value:integer);
var
_Type: olevariant;
begin            //  wdPageBreak
     
   if value=0 then  begin
       { �ֽڷ�����һҳ}
       {wdSectionBreakContinuous}
       _Type := wdPageBreak;
       FWord.Selection.InsertBreak(_Type);
   end else if value =1 then begin
       _Type := wdSectionBreakContinuous;
       FWord.Selection.InsertBreak(_Type);

   end else if value =2  then begin
        _Type := wdSectionBreakNextPage;
        FWord.Selection.InsertBreak(_Type);
   end;



end;
 
procedure TMyWord.insertpageFoot(FootValue1,FootValue2:String);
var
    mmm,nnn,aaa:OleVariant;
    tab:Table;
    ileft:integer;
begin
      mmm:=wdLine;
      nnn:=1;
      aaa:=wdFieldPage;
     FWord.ActiveWindow.ActivePane.View.SeekView :=wdSeekCurrentPageFooter ;
     //FWord.Selection.PageSetup.OddAndEvenPagesHeaderFooter:=-1;
    // FWord.Selection.HeaderFooter.LinkToPrevious :=False;
     FWord.Selection.Move(mmm,nnn);
     FWord.Selection.ParagraphFormat.Alignment :=wdAlignParagraphRight;// wdAlignParagraphCenter;
     // ҳ�ź���
     FWord.Selection.WholeStory ;
     FWord.Selection.ParagraphFormat.Borders.Item(wdBorderLeft).LineStyle:=wdLineStyleNone;
     FWord.Selection.ParagraphFormat.Borders.Item(wdBorderRight).LineStyle:=wdLineStyleNone;
     FWord.Selection.ParagraphFormat.Borders.Item(wdBorderBottom).LineStyle:=wdLineStyleNone;
     FWord.Selection.ParagraphFormat.Borders.Item(wdBordertop).LineStyle:=wdLineStyleSingle;
     FWord.Selection.ParagraphFormat.Borders.Item(wdBordertop).LineWidth:=wdLinewidth050pt;
     FWord.Selection.ParagraphFormat.Borders.DistanceFromTop:=1;
     FWord.Selection.ParagraphFormat.Borders.DistanceFromLeft :=4;
     FWord.Selection.ParagraphFormat.Borders.DistanceFromBottom:=1;
     FWord.Selection.ParagraphFormat.Borders.DistanceFromRight:=4;
     FWord.Selection.ParagraphFormat.Borders.Shadow :=False;

//      if FWord.Selection.HeaderFooter.Index= wdHeaderFooterFirstPage  then begin
//         FWord.Selection.InsertAfter('');
//      end else if FWord.Selection.HeaderFooter.Index= wdHeaderFooterPrimary  then begin
//         FWord.Selection.InsertAfter(FootValue1);
//      end else if FWord.Selection.HeaderFooter.Index= wdHeaderFooterEvenPages  then begin
//         FWord.Selection.InsertAfter(FootValue2);
//      end;

     FWord.Selection.InsertAfter(FootValue1);
     FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument;

end;

procedure TMyWord.insertpageHead(HeadValue1,HeadValue2:String);
var
    mmm,nnn,aaa:OleVariant;
begin
    mmm:=wdLine;
    nnn:=1;
    aaa:=wdFieldPage;
    FWord.ActiveWindow.ActivePane.View.SeekView :=wdSeekCurrentPageHeader ;
//    FWord.Selection.PageSetup.OddAndEvenPagesHeaderFooter:=-1;
    FWord.Selection.Move(mmm,nnn);
 //   FWord.Selection.HeaderFooter.LinkToPrevious:= False ;

    FWord.Selection.ParagraphFormat.Alignment := wdAlignParagraphLeft;

    FWord.Selection.InsertAfter(HeadValue2);
   // FWord.Selection.PageSetup.DifferentFirstPageHeaderFooter :=-1;
    FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument;

end;

//��������
procedure TMyWord.insertDate();
var
DateTimeFormat: olevariant;
InsertAsField: olevariant;
InsertAsFullWidth: olevariant;
DateLanguage: olevariant;
CalendarType: olevariant;
begin
    try
    InsertAsField := False;
    InsertAsFullWidth := False;
    DateTimeFormat := 'yyyy''��''M''��''d''��''';
    DateLanguage := wdSimplifiedChinese;
    CalendarType := wdCalendarWestern;
    FWord.Selection.InsertDateTime(DateTimeFormat, InsertAsField,
    InsertAsFullWidth, DateLanguage, CalendarType);
    except
        insertDate();
    end;
 
end;
 
procedure TMyWord.InsertOtherfile(PathFile: string);
begin
   FWord.Selection.InsertFile(PathFile,'',False,False,False) ;
end;

//����ҳ��
procedure TMyWord.insertPagenum(start:integer);
var
PSection: Section;
PageNumberAlignment: olevariant;
FirstPage: olevariant;
_Type: olevariant;
begin
    PSection := FWord.Selection.Sections.Item(1);
    PageNumberAlignment := 2;           // 0 ���  1 �м�  2 �Ҳ�
    FirstPage := True;
    PSection.Footers.Item(wdHeaderFooterPrimary).PageNumbers.Add(PageNumberAlignment, FirstPage);

   if start = 1 then  begin
        FWord.ActiveWindow .ActivePane.View.SeekView:= wdSeekCurrentPageFooter;
       // FWord.Selection.HeaderFooter.LinkToPrevious :=False;
        With FWord.Selection.HeaderFooter.PageNumbers   do begin
            NumberStyle:= wdPageNumberStyleArabic;
            HeadingLevelForChapter:= 0;
            IncludeChapterNumber:=False ;
            ChapterPageSeparator:= wdSeparatorHyphen ;
            RestartNumberingAtSection:= True ;
            StartingNumber:= 1;
        end;
       FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument;
   end else begin
        FWord.ActiveWindow .ActivePane.View.SeekView:= wdSeekCurrentPageFooter;
        FWord.Selection.HeaderFooter.LinkToPrevious :=true;
        With FWord.Selection.HeaderFooter.PageNumbers   do begin
            NumberStyle:= wdPageNumberStyleArabic;
            HeadingLevelForChapter:= 0;
            IncludeChapterNumber:=False ;
            ChapterPageSeparator:= wdSeparatorHyphen ;
            RestartNumberingAtSection:= FALSE ;
            StartingNumber:= 0;
        end;
        FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument;
   end;
end;
 
procedure TMyWord.InsertRow(Tab: Table; irow, InserCount: integer);
var
  insertLine: OleVariant ;
begin
   insertLine:= TAB.Rows.Last;
   TAB.Rows.Add(insertLine) ;
end;

procedure TMyWord.InsetBottomLine(Waterbmp: string; Left, Top, Width,
  Heigth: integer);
 var
   linkflag,prange:OleVariant;
   OleVar:OLEVariant;
begin
  linkflag:=False;
  prange:=FWord.ActiveWindow.Selection.range;
  FWord.Selection.Sections.Item(1).Footers.Item(1).Range.Select;
  FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.AddPicture(Widestring(Waterbmp), linkflag,
  EmptyParam, prange, EmptyParam, EmptyParam, EmptyParam, EmptyParam) ;
  OleVar := FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Count;
  FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Height := Heigth/10/0.35;
  FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Width := Width/0.35;
  FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Left := Left/0.35;
  FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Top := Top/0.35;
  //
  FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument;  //�ص�����ҳ��
  FWord.ActiveWindow.ActivePane.View.type_ :=wdPrintView; // �ص�ҳ����ͼ

end;

procedure TMyWord.InsetWaterBmp(Waterbmp,loginBmp: string;Left,Top,Width,Heigth:integer);
 var
   linkflag,prange:OleVariant;
   OleVar:OLEVariant;
begin
  linkflag:=False;
  prange:=FWord.ActiveWindow.Selection.range;

 // FWord.ActiveDocument.Sections.Item(1).Headers.Item(1).Range.Select;
  FWord.Selection.Sections.Item(1).Headers.Item(1).Range.Select;
  if Waterbmp <>'' then  begin    // ����ͼ�� ����
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.AddPicture(Widestring(Waterbmp), linkflag,
      EmptyParam, prange, EmptyParam, EmptyParam, EmptyParam, EmptyParam) ;
      OleVar := FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Count;
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Height := Heigth/0.35;
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Width := Width/0.35;
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Left := Left/0.35;
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Top := Top/0.35;
  end;
  //
  if loginBmp <>'' then  begin    // ����ͼ�� ����
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.AddPicture(Widestring(loginBmp), linkflag,
      EmptyParam, prange, EmptyParam, EmptyParam, EmptyParam, EmptyParam) ;
      OleVar := FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Count;
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Height := 5/0.35;
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Width := 5/0.35;
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Left := 0/0.35;
      FWord.ActiveWindow.ActivePane.selection.HeaderFooter.Shapes.Item(OleVar).Top := 0/0.35;
  end;

  FWord.ActiveWindow.ActivePane.View.SeekView := wdSeekMainDocument;  //�ص�����ҳ��
  FWord.ActiveWindow.ActivePane.View.type_ :=wdPrintView; // �ص�ҳ����ͼ
end;

//���ñ���һ�и߶�
procedure TMyWord.SetTableheight(PTable: Table; RowIdx: Integer; height:
Integer);
var
Prow: Row;
begin
    Prow := PTable.Rows.Item(RowIdx);
    Prow.SetHeight(height, wdAdjustNone);
end;
 
procedure TMyWord.SetTableRowsHeight(Tab: Table; Row, Height: integer);
begin
    Tab.Rows.Item(Row).Height:=Height/0.35;
end;

procedure TMyWord.SetZoomPercentage(Value: integer);
begin
      FWord.ActiveWindow.View.Zoom.Percentage:=Value;
end;

procedure TMyWord.TableBorders(Tab: Table; InSideLine, OutSideLine: integer);
begin
    Tab.Borders.InsideLineStyle :=InSideLine;
    Tab.Borders.OutsideLineStyle:= OutSideLine;
end;

procedure TMyWord.TableCellMerge(tab: Table; Col1, Row1, Col2, Row2: integer);
begin
   tab.Cell(row1,col1).Merge(tab.Cell(Row2,Col2));
   tab.Borders.InsideLineStyle:=0;

end;

//���ñ���һ�п���
procedure TMyWord.SetPageOrient(Value: integer);
{
  O  ��������
  1  ��������
}
begin
   if Value =0  then  begin
     FWord.Selection.PageSetup.Orientation:= wdOrientPortrait;
   end else begin
     FWord.Selection.PageSetup.Orientation:= wdOrientLandscape;
   end;
end;

procedure TMyWord.SetParagraphFormat(Value: integer);
{
  0 ��1���о� Ĭ��
  1 �� 1.5���о�
}
begin
  if Value=0 then  begin
     FWord.Selection.ParagraphFormat.LineSpacingRule:= wdLineSpaceSingle;
  end else begin
     FWord.Selection.ParagraphFormat.LineSpacingRule:= wdLineSpace1pt5;
  end;

end;



procedure TMyWord.SetParentWindow(pParent: TWinControl);
var
    lWaveHwnd : Hwnd;
    lWidth, lHeight: Integer;
    lWindowCaption: String;
begin
    //lwaveHwnd := FindWindow(nil,'Microsoft Word');//���ڱ���
    lWindowCaption := FWord.ActiveWindow.Caption;
    lwaveHwnd := FindWindow(nil,pWideChar(lWindowCaption+' - Word'));//���ڱ���
    if lwaveHwnd=0 then  begin
       lwaveHwnd := FindWindow(nil,pWideChar(lWindowCaption+' - Microsoft Word'));//���ڱ���
    end;

    Windows.SetWindowLong(lWaveHwnd,GWL_STYLE,GetWindowLong(lWaveHwnd, GWL_STYLE)
    and not (WS_CAPTION or WS_SYSMENU));
    Windows.SetParent(lWaveHwnd,pParent.Handle);
    gWaveHwnd:=lWaveHwnd;
    lWidth := pParent.Width;
    lHeight := pParent.Height;
    Windows.MoveWindow(lWaveHwnd,0,0,lWidth,lHeight,false);
    //mParent := pParent;
end;

procedure TMyWord.SetTable(PTable: Table; ColumnIdx: Integer; Width:
Integer);
begin
    PTable.Columns.Item(ColumnIdx).SetWidth(Width, wdAdjustNone);
end;
 
//����Ŀ¼
procedure TMyWord.InsertContents(stratid,Endid,wdin:integer);
{

   wdin =0  Ŀ¼����������ϴ�
         1  Ŀ¼������ �����С
}
var
    pRange:WordRange;
    UseHeadingStyles: olevariant;
    UpperHeadingLevel: olevariant;
    LowerHeadingLevel: olevariant;
    UseFields: olevariant;
    TableID: olevariant;
    RightAlignPageNumbers: olevariant;
    IncludePageNumbers: olevariant;
    AddedStyles: olevariant; UseHyperlinks: olevariant;
    HidePageNumbersInWeb: olevariant;
begin
    with FWord.ActiveDocument do
    begin
        pRange := FWord.Selection.Range;
        RightAlignPageNumbers := True;
        UseHeadingStyles := true;
        UpperHeadingLevel := stratid;
        LowerHeadingLevel := Endid;
        IncludePageNumbers := True;
        UseHyperlinks := True;
        HidePageNumbersInWeb := True;
        TablesOfContents.Add
           (   pRange, UseHeadingStyles,
               UpperHeadingLevel,
               LowerHeadingLevel,
               UseFields,
               TableID,
               RightAlignPageNumbers,
               IncludePageNumbers,
               AddedStyles, UseHyperlinks,
               HidePageNumbersInWeb
           );
        TablesOfContents.Item(1).TabLeader := wdTabLeaderDots;//wdTabLeaderDots;
         if wdin=0 then  begin
             TablesOfContents.Format := wdIndexIndent;  // wdIndexIndent
         end else begin
             TablesOfContents.Format := wdIndexRunin;//wdIndexRunin ;
         end;
    end;

end;
 
//������ǩ
procedure TMyWord.createBookMark(BookMarkName: string);
var
pRange: olevariant;
begin
    pRange := FWord.Selection.Range;
    with FWord.ActiveDocument.Bookmarks do
    begin
        Add(BookMarkName, pRange);
        DefaultSorting := wdSortByName;
        ShowHidden := False;
    end;
 
end;
 
//�ƶ�����ǩ
procedure TMyWord.GotoBookMark(BookMarkName: string);
var
What: olevariant;
Which: olevariant;
Count: olevariant;
Name: olevariant;
begin
    What := wdGoToBookmark;
    Name :=BookMarkName;
    FWord.Selection.GoTo_(What,
    Which,
    Count,
    Name)
end;
 
//ճ��
procedure TMyWord.paste();
begin
    FWord.Selection.paste;
end;
 
//�滻
procedure TMyWord.RemoveAutoNumbers;
begin
   FWord.Selection.Range.ListFormat.RemoveNumbers(wdNumberAllNumbers);
end;

procedure TMyWord.Replace(Source, Target: string);
var
FindText: olevariant;
PWrap: olevariant;
ReplaceWith: olevariant;
Replace: olevariant;
begin
    FWord.Selection.Find.ClearFormatting;
    FWord.Selection.Find.Replacement.ClearFormatting;
    FindText := Source;
    PWrap := wdFindContinue;
    ReplaceWith := Target;
    Replace := wdReplaceAll;
    with FWord.Selection.Find do
    begin
        {Text := source;
        Replacement.Text := Target;
        forward := True;
        Wrap := wdFindContinue;
        Format := False;
        MatchCase := False;
        MatchWholeWord := False;
        MatchByte := True;
        MatchWildcards := False;
        MatchSoundsLike := False;
        MatchAllWordForms := False;
        }
        Execute(FindText, EmptyParam, EmptyParam, EmptyParam, EmptyParam,
        EmptyParam,
        EmptyParam, PWrap, EmptyParam, ReplaceWith, Replace, EmptyParam,
        EmptyParam, EmptyParam, EmptyParam);
    end;
 
end;
 
procedure TMyWord.Resize(Panel: TWinControl);
begin
  if gWaveHwnd<>0 then
  begin
    FWord.ActiveWindow.Height := Panel.Height;
    FWord.ActiveWindow.Width := Panel.Width;
    Windows.MoveWindow(gWaveHwnd,0,0,Panel.Width,Panel.Height,false);
  end;
end;

function TMyWord.ReturnHeadingIndex(value: integer): integer;
var
  i:integer;
  title:String;
begin
  Result:=15;
  title:='���� '+IntTostr(Value);
  for I := 1 to FWord.ActiveDocument.Styles.Count  do  begin
      if FWord.ActiveDocument.Styles.Item(i).NameLocal=title then begin
         Result:=i;
         break;
      end;

  end;

end;

//����
procedure TMyWord.Save(FileName: string);
var
OFilename: olevariant;
begin
    OFilename := FileName;
    FDoc.SaveAs(OFilename);
end;
 
procedure TMyWord.SaveAs(FileName: string);
 var
    OFilename: olevariant;
begin
    OFilename := FileName;
    FDoc.SaveAs(OFilename,9);
end;

//����ͼƬ
procedure TMyWord.AddPicture(FileName: string;Bl:double);
var
LinkToFile, SaveWithDocument, Range: olevariant;
tm_B:InlineShape;
begin
    //index := 0;
    //Range := FDoc.Bookmarks.Item(index).Range;
    //Range:=Fdoc.GoTo_;
    Range := Self.FWord.Selection.Range;
    LinkToFile := False;
    SaveWithDocument := True;
    tm_B:=FWord.Selection.InlineShapes.AddPicture(FileName, LinkToFile,
          SaveWithDocument, Range);
    tm_B.Height:= tm_B.Height*bl ;
    tm_B.Width :=tm_B.Width *bl;
end;

//�Ƶ����
procedure TMyWord.MoveEnd(id :integer);
{  0 ȫ�ĵ����  1 �½� �����}
var
Unit_: olevariant;
Extend: olevariant;
begin
    if id=0 then  begin //
         Unit_ := wdStory;
         Extend := wdMove;
    end else begin
         Unit_ := wdLine;
         Extend := wdMove;
    end;

    FWord.Selection.EndKey(Unit_, Extend);
end;
 
procedure TMyWord.MoveLeft(num: Integer);
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    try
    //connectword();
    Unit_ := wdCell;
    Count := num;
    FWord.Selection.MoveLeft(Unit_, Count, Extend);
    except
        MoveRight();
    end;
end;

//�ϲ�


procedure TMyWord.CellsMerge();
begin
    FWord.Selection.Cells.Merge;
end;
 
procedure TMyWord.CloseCheckGrammar(Value: Boolean);
begin
   FWord.Options.CheckSpellingAsYouType :=Value;
   FWord.Options.CheckGrammarAsYouType :=Value;
   FWord.Options.CheckGrammarWithSpelling:=Value;
   FWord.Options.CheckHangulEndings:=Value;
   FWord.Options.ShowReadabilityStatistics :=Value;

end;

initialization
finalization
{ if FMyWord <> nil then
FMyWord.Free;
}
end.