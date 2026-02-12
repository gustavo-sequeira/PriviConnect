unit ufrmDescontosAplicados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, sLabel, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TfrmDescontosAplicados = class(TForm)
    DBGrid1: TDBGrid;
    CDS: TClientDataSet;
    DataSource1: TDataSource;
    CDSNRREQ: TIntegerField;
    CDSVRREQ: TCurrencyField;
    CDSVRDESC: TCurrencyField;
    CDSVRLIQ: TCurrencyField;
    CDSDESCRFORM: TStringField;
    lblVrTOT: TsLabelFX;
    CDSVRTAB: TCurrencyField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDescontosAplicados: TfrmDescontosAplicados;

implementation

{$R *.dfm}

procedure TfrmDescontosAplicados.FormCreate(Sender: TObject);
begin
   CDS.CreateDataSet;
   CDS.Close;
   CDS.Open;
end;

end.
