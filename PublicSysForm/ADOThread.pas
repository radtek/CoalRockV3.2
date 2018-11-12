unit ADOThread;

interface

uses  
  Classes,StdCtrls,ADODB,uIRockPress;
type  
  TADOThread = class(TThread)  
  private  
    { Private declarations }  
    FMemo:TMemo;
    FEdit:TEdit;
    ConnString:WideString;
    FSQLString:string;
    FObjusers: TIRockPress;
    elapsedtime:string;
    fcount:integer;
    procedure  UpdateCount;
  protected  
    procedure  Execute; override;  
  public  
    constructor  Create(SQL:string;LM:TMemo;LEdit:TEdit;uObjusers:TIRockPress);
  end   ;

implementation
uses  SysUtils,ActiveX,  ReadSqlDataMainform,StrUtils ;
{ TADOThread }

constructor TADOThread.Create(SQL: string; LM: TMemo;LEdit:TEdit;uObjusers:TIRockPress);
begin
  ConnString:=formMain.ADOConnection1.ConnectionString;
  FMemo:=LM;
  FEdit:=LEdit;
  FSQLString:=SQL;
  FObjusers:=uObjusers;
  Inherited  Create(False)
end;

procedure TADOThread.Execute;
var  
  Qry:TADOQuery;
  DataSet:TADODataSet;
  i:Integer;
  TableName,sql:String;

begin  
  { Place thread code here }  
  FreeOnTerminate:=True;
  CoInitialize(nil);  
    //必须调用（需Uses ActiveX）
  DataSet:=TADODataSet.Create(nil);
  Qry:=TADOQuery.Create(nil);
  fcount:=0;  
  try
     DataSet.ConnectionString:= ConnString;
     Qry.ConnectionString:=ConnString;   //必须有自己的连接
     FMemo.Clear;
     FObjusers.setGzmbm('1309');
     FObjusers.Begintrans;
     DataSet.Close;
     DataSet.CommandText:='SELECT  TABLE_NAME FROM INFORMATION_SCHEMA.TABLES ';
     DataSet.Open ;
     while not DataSet.Eof And  not Terminated do  begin
        TableName:=DataSet.FieldByName('TABLE_NAME').AsString;
        if LeftStr(TableName,10)<>'datavalues' then  begin
           DataSet.Next;continue;
        end;
          Qry.Close;
          Qry.SQL.Clear;
          sql:='select  * from db_owner.'+TableName+' where bh ='+FEdit.Text+'' ;
          Qry.SQL.Add(sql);
          Qry.Open;
          Qry.First ;
          while not Qry.Eof  And  not Terminated do  begin

                 if FObjusers.InPutdata(StrToInt(Trim(Qry.FieldByName('bh').AsString)),
                                                  Qry.FieldByName('generatetime').AsString,
                                                  Qry.FieldByName('datavalue').AsFloat ,
                                                  Qry.FieldByName('datavalue').AsFloat*0.5,
                                                  Qry.FieldByName('datavalue').AsFloat*0.8,
                                                  Qry.FieldByName('datavalue').AsFloat*1,
                                                  elapsedtime ) =1 then begin
                      fcount:=fcount+1;
                       //如果不调用Synchronize，会出现Canvas Does NOT Allow Drawing
                     Synchronize(UpdateCount);
                  end else begin
                    // exit;
                  end;

            Qry.Next;
          end;
            Qry.Close ;
        DataSet.Next;
     end; // end while

  finally
    FObjusers.CommitTrans(elapsedtime);
    fcount:=-1;
    Synchronize(UpdateCount);
    DataSet.Close ;
    DataSet.Free;
    Qry.Free;
  end ;  
  CoUninitialize;

end;  
procedure TADOThread.UpdateCount;
begin

     FMemo.Lines.Add(IntTostr(Fcount)+':Successed! elapsed time :'+elapsedtime);
end;

end.
