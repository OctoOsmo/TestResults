unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj, DB, IBCustomDataSet, IBDatabase, IBQuery;

type
  TMainForm = class(TForm)
    ButtonPrint: TButton;
    IBDatabaseMain: TIBDatabase;
    IBQueryResults: TIBQuery;
    IBTransactionMain: TIBTransaction;
    IBQuerySetup: TIBQuery;
    IBQuerySetupSIS_BAL: TIntegerField;
    IBQuerySetupOTL: TIntegerField;
    IBQuerySetupCHOR: TIntegerField;
    IBQuerySetupUDOVL: TIntegerField;
    IBQueryResultsN_STUD: TIntegerField;
    IBQueryResultsANS_COUNT: TIntegerField;
    IBQueryResultsRIGHT_ANS_COUNT: TIntegerField;
    IBQueryResultsFIO: TIBStringField;
    IBQueryResultsFAK: TIBStringField;
    IBQueryResultsPERCENT_OF_RIGHT: TFloatField;
    LabelCurrNumber: TLabel;
    IBQueryThemeName: TIBQuery;
    IBQueryThemeNameKOL_VOPR_TST: TIntegerField;
    IBQueryThemeNameKURS: TIBStringField;
    procedure ButtonPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure WordReplace(WordDoc: OleVariant; bookmark: string; str: string);
begin
WordDoc.activedocument.range.Find.execute
         (bookmark,EmptyParam, EmptyParam,EmptyParam,
          EmptyParam,EmptyParam,EmptyParam,EmptyParam,
          EmptyParam,str,1,EmptyParam,EmptyParam,EmptyParam,EmptyParam);
end;

procedure CertificatePrint(studentID: string; ansCount: string;
  rightAnsCount: string; FIO: string; faculty: string; grade: string; themeName: string; questCount: string);
var
  WordDoc: OleVariant;
  FileNameDot, FileNameExport, CurrDir: String;
begin
  FileNameDot := 'Справка.dot';
  FileNameExport := FIO+' '+studentID+'.doc';
  CurrDir := ExtractFilePath(Application.ExeName)+'Справки\';
  //export to word
  WordDoc:=CreateOleObject('word.Application');
  WordDoc.Application.Documents.Add(CurrDir + FileNameDot, EmptyParam,EmptyParam,EmptyParam);
  WordDoc.Visible := false;//make word invisible
  //FIO
  wordReplace(WordDoc,'@FIO',FIO);
  //Answer count
  wordReplace(WordDoc,'@ans_count', ansCount);
  //right answer count
  wordReplace(WordDoc,'@right_ans_count', rightAnsCount);
  //Faculty
  wordReplace(WordDoc,'@FAK', faculty);
  //Grade
  wordReplace(WordDoc,'@grade', grade);
  //Date
  wordReplace(WordDoc,'@date', DateToStr(SysUtils.Date)); 
  //Theme name
  wordReplace(WordDoc,'@Theme', themeName);
  //quest count
  wordReplace(WordDoc,'@questCount', questCount);
  WordDoc.ActiveDocument.SaveAs(CurrDir + FileNameExport);
  WordDoc.Quit;
end;

function GetGrade(percent: integer; otl: integer; hor: integer; udov: integer): string;
begin
if(percent < udov)
then
  result := 'Неудовлетворительно'
else
  if(percent < hor)
  then
  result := 'Удовлетворительно'
  else
    if(percent < otl)
    then
      result := 'Хорошо'
    else
      result := 'Отлично';
end;

procedure TMainForm.ButtonPrintClick(Sender: TObject);
var
  otl, hor, udov: integer;
  grade, themeName, questCount: string;
begin
  //get Theme name and question count
  IBQueryThemeName.Open;
  themeName := IBQueryThemeNameKURS.AsString;
  questCount := IBQueryThemeNameKOL_VOPR_TST.AsString;
  IBQueryThemeName.Close;
  IBQuerySetup.Open;//get grade setup
  otl := IBQuerySetupOTL.AsInteger;
  hor := IBQuerySetupCHOR.AsInteger;
  udov := IBQuerySetupUDOVL.AsInteger;
  IBQuerySetup.Close;
  IBQueryResults.Open;//export results
  while not IBQueryResults.Eof do
  begin
    LabelCurrNumber.Caption := 'Сейчас выгружается: '+IBQueryResultsFIO.AsString;
    grade := GetGrade(IBQueryResultsPERCENT_OF_RIGHT.AsInteger, otl, hor, udov);
    CertificatePrint(IBQueryResultsN_STUD.AsString, IBQueryResultsANS_COUNT.AsString,
      IBQueryResultsRIGHT_ANS_COUNT.AsString, IBQueryResultsFIO.AsString, IBQueryResultsFAK.AsString,
      grade, themeName, questCount);
    IBQueryResults.Next;
  end;
  IBQueryResults.Close;                                                          
  LabelCurrNumber.Caption := 'Печать справок завершена'+IBQueryResultsFIO.AsString;
end;

end.
