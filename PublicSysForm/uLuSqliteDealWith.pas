unit uLuSqliteDealWith;

interface

uses
  Winapi.Windows,System.SysUtils, System.Classes,
  Vcl.StdCtrls,SQLiteTable3,Vcl.ComCtrls, Vcl.Graphics,System.StrUtils;
type


  TSqliteADOData=Class
      function DecodeUtf8Str(const S: UTF8String): WideString;
   private
     

   public
      Maindb: TSQLiteDatabase;

      function CreateSqlite(MinPath,DName: string):Boolean; // connected sqlite
      function GetBMPToSQlite(FileName,DataType:string;BMap:TBitMap):Boolean; overload;
      function GetBMPToSQlite(image_id:string;BMap:TBitMap):Boolean; overload;
      function GetBMPToSQlite(Bianma:integer;DataType:string;BMap:TBitMap):Boolean; overload;
      function GEtBMPMemoFromsqlite(id:String):String;

      function SaveBmpToSqlite(FileName:string;DataType:String;FS: TFileStream;
                               BianMa,Memo:string):Boolean;
      procedure SqliteComboList(Combo:TComboBox;sql,str1,str2,str3:AnsiString);//2016-5-31 sqllite读取数据
      function selectBasicYockYP(PY:String;Var YCName:string):Boolean;
      function GetWorkFaceGenerateTable(Gzmbh,CreatLeg:String;StrList:TStringList):Boolean;
      function GetRockTuliBmp(YockName:String):String;
      function GetMainVersion(Version :integer; var BF,CAption:string):Boolean;
     

      constructor Create(DataBaseName:String);
      destructor Destroy;
  End;

implementation

{ TSqliteADOData }

uses Lu_Public_BasicModual,pngimage,JPeg;


function TSqliteADOData.DecodeUtf8Str(const S: UTF8String): WideString;
var
    lenSrc,lenDst  : Integer;
begin
      lenSrc  := Length(S);
      if(lenSrc=0)then Exit;
      lenDst  := MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, nil, 0);
      SetLength(Result, lenDst);
      MultiByteToWideChar(CP_UTF8, 0, Pointer(S),lenSrc, Pointer(Result), lenDst);
end;

destructor TSqliteADOData.Destroy;
begin
    if Assigned(Maindb) then FreeAndNil(Maindb);

end;



function TSqliteADOData.GetBMPToSQlite(FileName, DataType: string;
  BMap: TBitMap): Boolean;
Var
    SQL,ExtName:String;
    sltb1: TSQLIteTable;
    ms:TMemoryStream;
    Png:TPngObject;
    jpg: TJPEGImage;
begin
    Result:=True;
    ExtName:=UpperCase(Extractfileext(FileName));
    sql:= ' SELECT * from ImageStore where (imageFileName = '''+LowerCase(Trim(FileName))+''' ' +
          ' or imageFileName = '''+UpperCase(Trim(FileName))+''' )' +
          ' and DataType= '+ DataType;
    try
       sltb1:=Maindb.GetTable(sql);
       if sltb1.RowCount >0 then  begin

         ms := sltb1.FieldAsBlob(sltb1.FieldIndex['imageBlob']);
         ms.Position := 0;
         if ExtName='.PNG' then begin
           Png:=TPngObject.Create;
           png.LoadFromStream(ms);
           Bmap.Assign(PNG);
           Png.Free ;
         end else if ExtName='.BMP' then begin
           Bmap.LoadFromStream(ms);
         end else if ExtName='.JPG' then begin
            jpg := TJPEGImage.Create;
            jpg.LoadFromStream(ms);
            Bmap.Assign(jpg); // 因为 img 控件是基于bmp的
            jpg.Free;
         end;
       end;
    finally
       Result:=True;
       sltb1.Free;
    end;

end;

function TSqliteADOData.GEtBMPMemoFromsqlite(id: string): String;
Var
    SQL:String;
    sltb1: TSQLIteTable;
begin
   Result:='';
   try
   sql:= ' SELECT imagefileName,Memo from ImageStore where image_id = '+id;
   sltb1:=Maindb.GetTable(sql);
   if sltb1.RowCount >0 then
       if trim(sltb1.FieldByName['Memo'])<'' then
          Result:=sltb1.FieldByName['Memo']
       else Result:=sltb1.FieldByName['imagefileName']+'  图片';

   finally
     sltb1.Free;
   end;

end;

function TSqliteADOData.GetBMPToSQlite(Bianma:integer;DataType:string;BMap:TBitMap): Boolean;
Var
    SQL,ExtName,FileName:String;
    sltb1: TSQLIteTable;
    ms:TMemoryStream;
    Png:TPngObject;
    jpg: TJPEGImage;
begin
    Result:=True;

     sql:= ' SELECT * from ImageStore where  Bianma = '+IntToStr(Bianma) + ' and DataType= '+ DataType;

    try
       sltb1:=Maindb.GetTable(sql);
       if sltb1.RowCount >0 then  begin
         FileName:=sltb1.FieldByName['ImageFileName'];
         ExtName:=UpperCase(Extractfileext(FileName));
         ms := sltb1.FieldAsBlob(sltb1.FieldIndex['imageBlob']);
         ms.Position := 0;
         if ExtName='.PNG' then begin
           Png:=TPngObject.Create;
           png.LoadFromStream(ms);
           Bmap.Assign(PNG);
           Png.Free ;
         end else if ExtName='.BMP' then begin
           Bmap.LoadFromStream(ms);
         end else if ExtName='.JPG' then begin
            jpg := TJPEGImage.Create;
            jpg.LoadFromStream(ms);
            Bmap.Assign(jpg); // 因为 img 控件是基于bmp的
            jpg.Free;
         end;
       end;
    finally
       Result:=True;
       sltb1.Free;
    end;


end;

function TSqliteADOData.GetMainVersion(Version: integer; var BF,
  CAption:string): Boolean;
Var
    SQL:String;
    sltb1: TSQLIteTable;
begin
   Result:=False;
   try
     sql:='select * from ZDName where TableName= ''Version'' and Zdid =' +IntTostr(Version);
     sltb1:=Maindb.GetTable(sql);
     if sltb1.RowCount >0 then begin
         BF:=DecodeUtf8Str(sltb1.FieldByName['ZdName']);
         Caption:=DecodeUtf8Str(sltb1.FieldByName['Text']);
         Result:=true;
     end;

   finally
     sltb1.Free;
   end;


end;

function TSqliteADOData.GetBMPToSQlite(image_id: string; BMap: TBitMap): Boolean;
Var
    SQL,ExtName,FileName:String;
    sltb1: TSQLIteTable;
    ms:TMemoryStream;
    Png:TPngObject;
    jpg: TJPEGImage;
begin
    Result:=True;

    sql:= ' SELECT * from ImageStore where Image_id ='+ image_id;
    try
       sltb1:=Maindb.GetTable(sql);
       if sltb1.RowCount >0 then  begin
         FileName:=sltb1.FieldByName['ImageFileName'];
         ExtName:=UpperCase(Extractfileext(FileName));
         ms := sltb1.FieldAsBlob(sltb1.FieldIndex['imageBlob']);
         ms.Position := 0;
         if ExtName='.PNG' then begin
           Png:=TPngObject.Create;
           png.LoadFromStream(ms);
           Bmap.Assign(PNG);
           Png.Free ;
         end else if ExtName='.BMP' then begin
           Bmap.LoadFromStream(ms);
         end else if ExtName='.JPG' then begin
            jpg := TJPEGImage.Create;
            jpg.LoadFromStream(ms);
            Bmap.Assign(jpg); // 因为 img 控件是基于bmp的
            jpg.Free;
         end;
       end;
    finally
       Result:=True;
       sltb1.Free;
    end;
end;

function TSqliteADOData.GetRockTuliBmp(YockName: String): String;
var
  sql:string;
  sltb1: TSQLIteTable;

begin

    try
        sql:='SELECT tuli from BasicYock where gfmc ='''+Trim(YockName)+'''';
        sltb1:= Maindb.GetTable(sql);
       // if sltb1.RowCount >0 then  begin
           Result:=sltb1.FieldByName['tuli']+'.Bmp';
//        end else begin
//           Result:='';
//        end;
    finally
      sltb1.Free;
    end;
end;

function TSqliteADOData.GetWorkFaceGenerateTable(Gzmbh,CreatLeg:String;StrList: TStringList): Boolean;
var
  t_sql,Sql:string;
  sltb1: TSQLIteTable;
  lsz,lsz1,lsz2:string;
  lsz3:integer;
begin
    Result:=false;
    StrList.Clear ;
    try
        sql:='SELECT * from CreateTable where CreatLeg in ('+CreatLeg+') and used = 1';
        sltb1:= Maindb.GetTable(sql);
        while not sltb1.Eof do
        begin
            lsz2:=sltb1.FieldByName['CreateTableName'];
            lsz3:=strtoint(sltb1.FieldByName['CreatLeg']);
            if lsz3 = 2 then begin
               lsz1:='d_'+Gzmbh+'_'+lsz2+'';
               StrList.Add(lsz1);
            end;
             sltb1.Next;
        end;
        Result:=true;
    finally

      sltb1.Free;
    end;
end;

function TSqliteADOData.SaveBmpToSqlite(FileName, DataType: String;
  FS: TFileStream;BianMa,Memo:string): Boolean;
Var
    SQL:String;
    sltb1: TSQLIteTable;
    bmap:TBitMap;

    id:string;
begin
   Result:=true;
  try
   try
       FileName:=LowerCase(FileName);
        sql:= ' delete from  ImageStore  where DataType ='+DataType+'  and  Bianma= ' +
                  BianMa ;
        Maindb.ExecSQL(sql);
        sql:= ' insert into ImageStore (imageFileName,DataType,imageFileSizeBytes,BianMa,Memo) values('''+
                FileName+''','+DataType+','+intToStr(FS.Size)+','+BianMa+','''+Memo+''')';
        Maindb.ExecSQL(sql);
        sql:= ' SELECT image_id from ImageStore where imageFileName = '''+FileName+'''' +
              ' and DataType=' + DataType;
        sltb1:=Maindb.GetTable(sql);
        id:=sltb1.FieldByName['Image_id'];
        Maindb.UpdateBlob('UPDATE ImageStore set imageBlob = ? WHERE image_id = '+id,FS);
   except
     Result:=False;
   end;
  finally
     sltb1.Free ;
  end;
end;


function TSqliteADOData.selectBasicYockYP(PY:String;Var YCName:string):Boolean;
var
   sltb1: TSQLIteTable;
begin
    Result:=False;
    try
         sltb1:=Maindb.GetTable('select  gfmc from BasicYock where Py like '''+'%'+PY +'%'+'''');
         if sltb1.RowCount >0 then begin
            YCName:=UPPerCase(DecodeUtf8Str(sltb1.FieldByName['gfmc'])) ;
            Result:=True;
         end;
    finally
      sltb1.Free ;
    end;
end;

constructor TSqliteADOData.Create(DataBaseName: String);
begin
    if not Assigned(Maindb) then
       if not  CreateSqlite('',DataBaseName) then
       Public_Basic.MY_WriteLog('系统sqlite文件丢失！','[CreateSqlite]');

end;

function TSqliteADOData.CreateSqlite(MinPath, DName: string): Boolean;
var
   i:integer;
   dPath,inPath:String;
begin
       Result:=true;
       if Trim(MinPath)='' then
          inPath:=Public_Basic.Get_MyModulePath;
       i:=pos('.', DName);
       if i>0  then begin
             dPath :=inPath +DName;
       end else begin
             dPath :=inPath +DName+ '.db';
       end;
      // ShowMessage(MainDBPath);
       if not FileExists(dPath) then begin
              Result:=false;
              exit;
        end;
      Maindb := TSQLiteDatabase.Create(dPath);
end;

procedure TSqliteADOData.SqliteComboList(Combo: TComboBox; sql, str1, str2,
  str3: AnsiString);
var
     t_s1,t_s2,t_s3,S_tmp:AnsiString;
     sltb1,sltb2: TSQLIteTable;
     CTsql,wStr:string;
     TableName:string;
begin
    Combo.Clear ;

     sltb1:= Maindb.GetTable(UTF8Encode(sql));
     while not sltb1.eof do
       begin
           s_tmp:='';
           if str1<>'' then
             begin
               t_s1:=Trim(utf8decode(sltb1.FieldByName[str1]));
               s_tmp:=t_s1;

             end;
           if str2<>'' then
            begin
               t_s2:=Trim(utf8decode(sltb1.FieldByName[str2]));

               s_tmp:=s_tmp+'_'+t_s2;
            end;
           if str3<>'' then
             begin
               t_s3:=Trim(utf8decode(sltb1.FieldByName[str3])) ;

               s_tmp:=s_tmp+'_'+t_s3;

             end;

           combo.Items.Add(s_tmp);
           sltb1.Next ;
       end;
    sltb1.Free ;
    if combo.Items.Count >0 then
       combo.ItemIndex :=0;

end;


end.
