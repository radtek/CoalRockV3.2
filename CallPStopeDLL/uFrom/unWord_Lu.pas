unit unWord_Lu;
(*
By 卢国志 编写 2013.09.06 Email:lgz2050@163.com
*)
interface
uses Word2000, ActiveX, Variants, Dialogs, SysUtils;
type
    TMyWord = class(TObject)
    private

        procedure connectword();
    public
        FWord: TWordApplication;        //word对象
        FDoc: TWordDocument;            //文档对象
        //文件是否显示
        procedure WordVis(Vis:Boolean);
        //打开文档
        procedure OpenWord(sFileName:string);
        //换行
        procedure AddReturn();
        //设置字体
        procedure SetFont(FontName: string; FontSize: Integer;
                   FontBold: Boolean = False; FontUnderline: Boolean = False);
        //插入表格
        function AddTable(Col, Row: Integer): Table;
        //设置背景色
        procedure SetTableBack(BackColor: ToleEnum);
        //鼠标下移
        procedure MoveDown(num: Integer = 1);
        //选择下移
        procedure SelectDown(num: Integer = 1);
        //鼠标上移
        procedure Moveup();
        //鼠标右移
        procedure MoveRight(num: Integer = 1);
        //选择右移
        procedure SelectRight(num: Integer = 1);
        //写字
        procedure WriteText(Text: string);
        //按样式插入一行记录
        //如AddLine "备注","正文"
        //AddLine 'kk',"标题 1"
        procedure SetHeading(ititle:string;Level:integer);
        procedure AlignLine(Align: ToleEnum);
        //插入分页符
        procedure insertPage();
        //插入插入页码
        procedure insertPagenum();
        //插入日期
        procedure insertDate();
        //设置表格一列宽度
        procedure SetTable(PTable: Table; ColumnIdx: Integer; Width: Integer);
        //设置表格一列高度
        procedure SetTableheight(PTable: Table; RowIdx: Integer; height:
        Integer);
        //插入目录
        procedure InsertContents();
        //创立书签
        procedure createBookMark(BookMarkName: string);
        //移动到标签
        procedure GotoBookMark(BookMarkName: string);
        //粘贴
        procedure paste();
        //替换
        procedure Replace(Source, Target: string);
        //保存
        procedure Save(FileName: string);
        //插入图片
        procedure AddPicture(FileName: string);
        //移到最后
        procedure MoveEnd();
        //合并
        procedure CellsMerge();
        //关闭Word
        procedure Close;
        constructor Create;
        destructor Destroy; override;
end;


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
    FWord := TWordApplication.Create(nil); //word对象
    FDoc := TWordDocument.Create(nil);  //文档对象

end;
procedure TMyWord.OpenWord(sFileName:string);
var
  //打开文件的参数
  FileName,CfCversions,ReadOnly,AddToRctFiles,PswDocument,PswTemplate,Revert,
  WPswDocument,WPswTemplate,Format,Encoding,Visible,OpenAndRepair,
  DocumentDirection,NoEncodingDialog,XMLTransform:OleVariant;
  docinx:OleVariant;
begin

// ===== 打开文件 =====
        docinx:=1;
        FWord.Visible := false;
        FileName:=sFileName;
        CfCversions :=  false;
        ReadOnly:=False;
        AddToRctFiles:= false;
        PswDocument:= '';
        PswTemplate:= '';
        Revert:=true;
        WPswDocument:= '';//文档密码
        WPswTemplate:= '';//模板密码
        Format:= EmptyParam;
        Encoding:= '';
        Visible:=true;
        OpenAndRepair:= EmptyParam;
        DocumentDirection:= EmptyParam;
        NoEncodingDialog:= EmptyParam;
        XMLTransform:=EmptyParam;
  if sFileName='' then  begin //建立新文档
      FWord.Connect;
      FDoc.Activate;

  end else begin   //打开文档
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
destructor TMyWord.Destroy;
begin
    //
    //FDoc.SaveAs('c:/1.doc');
    FDoc.Free;
    FWord.Disconnect;
    //退出一定退出word,by yl 2005.2.2
    //FWord.Quit;
    //FWord.Free;
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
Boolean
= False; FontUnderline: Boolean = False);
begin
    try
    //connectword();
      FWord.Selection.Font.Name := FontName;
      FWord.Selection.Font.Size := FontSize;
      if FontBold then
      FWord.Selection.Font.Bold := wdToggle;
      if FontUnderline then
      FWord.Selection.Font.Underline := wdUnderlineSingle;
    except
        SetFont(FontName, FontSize, FontBold, FontUnderline);
    end;
 
end;
 
procedure TMyWord.SetHeading(ititle: string; Level: integer);
 {   Level = 1 一级标题 居中  加黑
             2 二级标题 left  加黑
             3 三级标题 left  加黑
             4 四级标题  居中  表
             5 五级标题  居中  图
             10 正文
   FontSize 字体字号
   Alin 居中方式 0 left 1 center  2 right
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
    end else begin  // 三级或者其他级标题
       FSize:=14;
       Bld:=1;
       Alin:=0;
       Spac:=13;
    end;

    if ititle='附录X' then  begin
       FSize:=14;
       Bld:=1;
       Alin:=0;
       Spac:=0;
    end;

    //寻找标题的内码
    Style_index:=ReturnHeadingIndex(Level);

    WriteText(ititle,0);                       //加入一行
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

//插入表格
function TMyWord.AddTable(Col, Row: Integer): Table;
var
DefaultTable: olevariant;
begin
    try
    connectword();
    DefaultTable := 1;
    Result := FDoc.Tables.Add(FWord.Selection.Range, Row, Col, DefaultTable,
    EmptyParam);
    except
        ShowMessage(Format('列%d,行%d', [Col, Row]));
        AddTable(Col, Row);
    end;
 
end;
 
//设置背景色
procedure TMyWord.SetTableBack(BackColor: ToleEnum);
begin
    try
    //connectword();
    FWord.Selection.Cells.Shading.BackgroundPatternColor := BackColor;
    except
        SetTableBack(BackColor);
    end;
 
end;
 
//选择下移
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
 
//鼠标下移
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
 
//鼠标上移
procedure TMyWord.Moveup();
var
Unit_: olevariant;
Count: olevariant;
Extend: olevariant;
begin
    Unit_ := wdLine;
    Count := 1;
    FWord.Selection.Moveup(Unit_, Count, Extend);
end;
 
//选择右移
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
 
//鼠标右移
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
 
//写字
procedure TMyWord.WriteText(Text: string);
begin
    try
    //connectword();
    FWord.Selection.TypeText(Text);
    except                              //防止呼叫失败
        WriteText(Text);
    end;
 
end;

procedure TMyWord.AlignLine(Align: ToleEnum);
begin
    FWord.Selection.ParagraphFormat.Alignment := Align;
end;
 
//插入分页符
procedure TMyWord.insertPage();
var
_Type: olevariant;
begin
    _Type := 7;
    FWord.Selection.InsertBreak(_Type);
end;
 
//插入日期
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
    DateTimeFormat := 'yyyy''年''M''月''d''日''';
    DateLanguage := wdSimplifiedChinese;
    CalendarType := wdCalendarWestern;
    FWord.Selection.InsertDateTime(DateTimeFormat, InsertAsField,
    InsertAsFullWidth, DateLanguage, CalendarType);
    except
        insertDate();
    end;
 
end;
 
//插入页码
procedure TMyWord.insertPagenum();
var
PSection: Section;
PageNumberAlignment: olevariant;
FirstPage: olevariant;
begin
    PSection := FWord.Selection.Sections.Item(1);
    PageNumberAlignment := 1;           //中间
    FirstPage := True;
    PSection.Footers.Item(wdHeaderFooterPrimary).PageNumbers.Add(PageNumberAlignment, FirstPage);
end;
 
//设置表格一列高度
procedure TMyWord.SetTableheight(PTable: Table; RowIdx: Integer; height:
Integer);
var
Prow: Row;
begin
    Prow := PTable.Rows.Item(RowIdx);
    Prow.SetHeight(height, wdAdjustNone);
end;
 
//设置表格一列宽度
procedure TMyWord.SetTable(PTable: Table; ColumnIdx: Integer; Width:
Integer);
begin
    PTable.Columns.Item(ColumnIdx).SetWidth(Width, wdAdjustNone);
end;
 
//插入目录
procedure TMyWord.InsertContents();
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
//    with FWord.ActiveDocument do
//    begin
//        pRange := FWord.Selection.Range;
//        RightAlignPageNumbers := True;
//        UseHeadingStyles := True;
//        UpperHeadingLevel := 1;
//        LowerHeadingLevel := 3;
//        IncludePageNumbers := True;
//        UseHyperlinks := True;
//        HidePageNumbersInWeb := True;
//        TablesOfContents.Add
//           (   pRange, UseHeadingStyles,
//              UpperHeadingLevel,
//              LowerHeadingLevel,
//              UseFields,
//              TableID,
//              RightAlignPageNumbers,
//              IncludePageNumbers,
//              AddedStyles, UseHyperlinks,
//              HidePageNumbersInWeb
//           );
//        TablesOfContents.Item(1).TabLeader := wdTabLeaderDots;
//        TablesOfContents.Format := wdIndexIndent;
//    end;
//
end;
 
//创立书签
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
 
//移动到标签
procedure TMyWord.GotoBookMark(BookMarkName: string);
var
What: olevariant;
Which: olevariant;
Count: olevariant;
Name: olevariant;
begin
    What := wdGoToBookmark;
    Name := 'BEGIN';
    FWord.Selection.GoTo_(What,
    Which,
    Count,
    Name)
end;
 
//粘贴
procedure TMyWord.paste();
begin
    FWord.Selection.paste;
end;
 
//替换
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
 
//保存
procedure TMyWord.Save(FileName: string);
var
OFilename: olevariant;
begin
    OFilename := FileName;
    FDoc.SaveAs(OFilename);
end;
 
//插入图片
procedure TMyWord.AddPicture(FileName: string);
var
LinkToFile, SaveWithDocument, Range: olevariant;
//index: olevariant;
begin
    //index := 0;
    //Range := FDoc.Bookmarks.Item(index).Range;
    //Range:=Fdoc.GoTo_;
    Range := Self.FWord.Selection.Range;
    LinkToFile := False;
    SaveWithDocument := True;
    FWord.Selection.InlineShapes.AddPicture(FileName, LinkToFile,
    SaveWithDocument, Range)
end;
 
//移到最后
procedure TMyWord.MoveEnd();
var
Unit_: olevariant;
Extend: olevariant;
begin
    Unit_ := wdStory;
    Extend := wdMove;
    FWord.Selection.EndKey(Unit_, Extend);
end;
 
//合并
procedure TMyWord.CellsMerge();
begin
    FWord.Selection.Cells.Merge;
end;
 
procedure TMyWord.Close;
begin
  FWord.Quit ;

end;

initialization
finalization
{ if FMyWord <> nil then
FMyWord.Free;
}
end.
