
{-----------------------------------------------------------D A T A D I R I P R I B A D I---------------------------------------------------------}

{Nama 		: Febriyananda Pratama Herawan	}
{Nim  		: 1301180027 					}
{Kelas		: IF - 42 - GAB01 				}
{Mata Kuliah: DAP 							}
{Topik 		: Aplikasi Penjualan Film   	}

{------------------------------------------------------ ARRAY 1 ---------------------------------------------------------------}

Program PenjualanFilm;
Uses Crt;
Const
	nMax = 100;
Type Struk = RECORD
	IdStruk,JenisMember : String;
	Tanggal,Bulan,Tahun : Integer;
	JumAwal,JumAfterDiskon,Diskon : Real;
End;
	arrStruk = Array [1..nMax] Of Struk;

{------------------------------------------------------ ARRAY 2 --------------------------------------------------------------}

TYPE datafilm = RECORD
    judul, genre : string;
    tahun, durasi, jumlah : integer;
    harga : longint;
    end;

TYPE judul_film = array [1..10] of datafilm;

TYPE genre1 = RECORD
    namagenre : string;
    judulfilm : judul_film;
    jumlahfilm : integer;
    end;

TYPE genre = array [1..10] of genre1;

Var
	arr_genre : genre;
	ListDataIdStruk : arrStruk;
	i,Pilih, N : Integer;
	z, y, jum_genre, jum_film : integer;

procedure showMenu(var N : integer);forward;

{-----------------------------------------------------------S H O W G E N R E -----------------------------------------------------------------}
PROCEDURE tampilkan_genre (VAR arr_genre : genre ; VAR z : integer);
VAR
i : integer;
BEGIN
CLRSCR;
    FOR i:=1 TO z DO
          WRITELN(i,'. ',arr_genre[i].namagenre);
END;

{-----------------------------------------------------------P I L I H  G E N R E -----------------------------------------------------------------}

PROCEDURE pilih_genre (VAR arr_genre:genre ; jum_genre : integer ; VAR z, N : integer);
   VAR
   i,j,tmp : integer;

   BEGIN
   tmp:=z;
      REPEAT
      z:=z+1;
      WRITE('   Masukkan genre ke-',z,' : ');
      READLN(arr_genre[z].namagenre);

      UNTIL z=jum_genre+tmp;

      arr_genre[z].jumlahfilm:=0;

      showMenu(N);

   END;
{-----------------------------------------------------------S H O W F I L M----------------------------------------------------------------}

PROCEDURE tampilkan_film(VAR arr_genre : genre ; y, z : integer);
    VAR
    i, n : integer;
    BEGIN
    CLRSCR;
    i:=0;
    FOR i:=1 TO z DO
        BEGIN
        WRITELN(i,'. ', arr_genre[i].namagenre);
           n:=1;
           FOR n:=1 TO arr_genre[i].jumlahfilm DO
            BEGIN
            IF arr_genre[i].judulfilm[n].harga<>0 THEN
               BEGIN
               WRITELN('   ',n,'.  Judul             : ',arr_genre[i].judulfilm[n].judul);
               WRITELN  ('       Tahun             : ',arr_genre[i].judulfilm[n].tahun);
               WRITELN  ('       Harga             : Rp.',arr_genre[i].judulfilm[n].harga,',00');
               READLN;
               END;
            END;

        WRITELN;
        END;
    READLN;
    END;
{-----------------------------------------------------------I N P U T F I L M-----------------------------------------------------------------}

PROCEDURE input_film (VAR arr_genre : genre; VAR N : integer ; pil : integer ; y : integer);
    BEGIN
      WRITELN;
      WRITE('Masukkan judul film ke-',y,' : ');
      READLN(arr_genre[pil].judulfilm[y].judul);
      WRITE('Masukkan tahun film keluar : ');
      READLN(arr_genre[pil].judulfilm[y].tahun);
      IF (arr_genre[pil].judulfilm[y].tahun>=2019) THEN
         BEGIN
         arr_genre[pil].judulfilm[y].durasi:=3;
         arr_genre[pil].judulfilm[y].harga:=50000;
         END
      ELSE
         IF   ((arr_genre[pil].judulfilm[y].tahun<2019) AND (arr_genre[pil].judulfilm[y].tahun>=2015)) THEN
            BEGIN
            arr_genre[pil].judulfilm[y].durasi:=4;
            arr_genre[pil].judulfilm[y].harga:=40000;
            END
         ELSE
            BEGIN
            arr_genre[pil].judulfilm[y].durasi:=4;
            arr_genre[pil].judulfilm[y].harga:=30000;
            END;
        showMenu(N);
    END;

PROCEDURE inputfilm (VAR arr_genre : genre; VAR N : integer ; jum_film, z : integer ; VAR y : integer);
    VAR
    j, m, pil : integer;
    BEGIN
    WRITELN;
    m:=y;
            WRITELN;
            REPEAT
            tampilkan_genre(arr_genre, z);
            WRITELN;
              WRITE('   Pilih genre film yang akan di inputkan : ');
              READLN(pil);
              CLRSCR;
            UNTIL (pil<=z);
            REPEAT
            BEGIN
            i:=i+1;
            y:=y+1;
            arr_genre[pil].jumlahfilm:=arr_genre[pil].jumlahfilm+1;
            input_film(arr_genre,N,pil,arr_genre[pil].jumlahfilm);

            READLN;
            END;
            UNTIL i=jum_film+m;
    END;

{-----------------------------------------------------------C H E C K T A N G G A L-----------------------------------------------------------------}

Function CheckTanggal ( Tanggal : Integer ; Bulan : Integer ) : Boolean;
Begin
	CheckTanggal := False;
		IF (( Tanggal > 31 ) or ( Tanggal < 1 ) or ( Bulan > 12 ) or ( Bulan < 1 )) Then
		Begin
			CheckTanggal := True;
		End
End;
{-----------------------------------------------------------C H E C K M E M B E R--------------------------------------------------------------------}

Function CheckMember ( Member : Integer ) : Boolean;
Begin
	CheckMember := True;
	IF ( Member In [1,2,3,4,5] ) Then
		Begin
			CheckMember := False;
		End;
End;
{-----------------------------------------------------------D I S K O N M E M B E R--------------------------------------------------------------------}

Function DiskonMember ( inputmember : Integer) : Integer;
Var
	Diskon : Integer;
Begin
	Case inputmember Of
		1 : Diskon := 5;
		2 : Diskon := 10;
		3 : Diskon := 20;
		4 : Diskon := 30;
		5 : Diskon := 50;
	End;
	DiskonMember:=Diskon;
End;

{--------------------------------------------------------J U M L A H B A Y A R A F T E R D I S K O N----------------------------------------------------}

Function JumlahBayarAfterDiskon (i : integer ; ListDataIdStruk : arrStruk) : Real;
Begin
	JumlahBayarAfterDiskon := (ListDataIdStruk[i].JumAwal - ((ListDataIdStruk[i].JumAwal*ListDataIdStruk[i].Diskon)/100));
End;

{--------------------------------------------------------C O D E M E M B E R-----------------------------------------------------------------------------}

Function CodeMember ( Member : Integer ) : String;
Var
	Code : String;
Begin
	Case Member Of
		1 : Code := 'Umum';
		2 : Code := 'Silver';
		3 : Code := 'Gold';
		4 : Code := 'Platinum';
		5 : Code := 'PlatinumPlus';
	End;
	CodeMember := Code;
End;
{--------------------------------------------------------D I S K O N A K H I R B U L A N ----------------------------------------------------------------------}

Function DiskonAkhirBulan ( Tanggal : Integer ; JumAwal : Real ) : Integer;
Begin
	DiskonAkhirBulan :=0;
	IF (( Tanggal = 31 ) And ( JumAwal >= 1500000)) Then
		Begin
			DiskonAkhirBulan := 10;
		End;
End;
{--------------------------------------------------------S E A R C H K O S O N G ------------------------------------------------------------------------------}

Function SearchKosong ( ListDataIdStruk : arrStruk ) : Integer;
Var
	Search : Integer;
	Found : Boolean;
Begin
	Found := False;
	Search :=1;
	While (( NOT Found ) or ( Search <= nMax)) Do
		Begin
			IF (( ListDataIdStruk[Search].IdStruk = ' ') or ( NOT Found)) Then
				Begin
					Found := True;
					SearchKosong := Search;
				End
			Else
				Begin
					Search := Search + 1;
				End;
		End;
End;

{--------------------------------------------------------TA M P I L K A N L I S T B A R A N G -----------------------------------------------------------------}

Procedure TampilkanListFilm ( i : Integer ; ListDataIdStruk : arrStruk );
Begin
	Writeln ( 'ID Struk 					: ',ListDataIdStruk[i].IdStruk);
	Writeln ( 'Tanggal 						: ',ListDataIdStruk[i].Tanggal);
	Writeln ( 'Bulan 						: ',ListDataIdStruk[i].Bulan);
	Writeln ( 'Tahun						: ',ListDataIdStruk[i].Tahun);
	Writeln ( 'JenisMember 					: ',ListDataIdStruk[i].JenisMember);
	Writeln	( 'Diskon 						: ',ListDataIdStruk[i].Diskon:3:2);
	Writeln ( 'Jumlah Awal					: ',ListDataIdStruk[i].JumAwal:0:2);
	Writeln	( 'Jumlah Bayar After Diskon 	: ',ListDataIdStruk[i].JumAfterDiskon:0:2);
	Writeln;
End;

{--------------------------------------------------------C E K D A T A-----------------------------------------------------------------------------------------}

Function CekData ( N : Integer ; DataIdStruk : String ; ListDataIdStruk : arrStruk ) : Integer;
Var
	i : Integer;
	Found : Boolean;
Begin
	Found := False;
	i :=1;
	// CekData := 0;
	While (( i <= N) And ( NOT Found )) Do
		Begin
			IF ( DataIdStruk = ListDataIdStruk[i].IdStruk ) Then
				Begin
					// CekData := 1;
					Found := True;
				End
			Else
				i := i + 1;
		End;
	if (found) then
		CekData := i
	else
		CekData := -1;
End;


{--------------------------------------------------------C E K A R R A Y M A X---------------------------------------------------------------------------------}

Function CekArrayMax ( i : Integer ) : Boolean;
Begin
	IF ( i = nMax ) Then
		Begin
			CekArrayMax := true;
		End
	Else
		Begin
			CekArrayMax := false;
		End
End;

{--------------------------------------------------------I N P U T D A T A--------------------------------------------------------------------------------}

Procedure InputData (VAR ListDataIdStruk : arrStruk;VAR i : Integer );
Var
	Kalimat : String;
	Tanggal,Bulan,Tahun,Member,InputdiSini : Integer;
	JumAwal : Real;
	Ulang : String;
Begin
	Clrscr;
	Ulang := 'Y';
	While ( LowerCase(Ulang) = 'y' ) Do
		Begin
			Write (' Apakah Anda Ingin Menambahkan Struk ? [Y/N] = ');
			Readln(Ulang);
			Clrscr;
			IF ( LowerCase(Ulang) = 'y') Then
				Begin
					IF ( NOT CekArrayMax(i)) Then
						Begin
							Write 	( 'Silahkan Masukan Tanggal Transaksi Anda [1 Sampai 31] : ');
							Readln(Tanggal);
							Write 	( 'Silahkan Masukan Bulan Transaksi Anda [1 Sampai 12] : ');
							Readln(Bulan);
							Write 	( 'Silahkan Masukan Tahun Transaksi Anda : ');
							Readln(Tahun);
							Writeln	( 'Silahkan Masukan Jenis Member Anda : ');
							Writeln ( '[1]=Umum, [2]=Silver, [3]=Gold, [4]=Platinum, [5]=PlatinumPlus: ');
							Write 	( 'Jenis Member : ');
							Readln(Member);
							Write 	( 'Silahkan Masukan Jumlah Transaksi Anda : ');
							Readln(JumAwal);
							IF (( NOT CheckTanggal ( Tanggal,Bulan )) And ( NOT CheckMember ( Member ))) Then
								Begin
									i := i + 1;
									Str(i,Kalimat);
									ListDataIdStruk[i].IdStruk 			:= 'IDBUY00' + Kalimat;
									ListDataIdStruk[i].Tanggal 			:= Tanggal;
									ListDataIdStruk[i].Bulan 			:= Bulan;
									ListDataIdStruk[i].Tahun			:= Tahun;
									ListDataIdStruk[i].JenisMember		:= CodeMember(Member);
									ListDataIdStruk[i].Diskon 			:= DiskonMember(Member) + DiskonAkhirBulan(Tanggal,JumAwal);
									ListDataIdStruk[i].JumAwal 			:= JumAwal;
									ListDataIdStruk[i].JumAfterDiskon 	:= JumlahBayarAfterDiskon(i,ListDataIdStruk);
								End
							Else
								Begin
									Clrscr;
									write( ' MOHON MAAF DATA YANG ADA INPUTKAN SALAH,MOHON PERIKSA KEMBALI,TERIMA KASIH ');
									Readln;
								End;
							writeln('Input berhasil');
							writeln('Tekan enter untuk kembali ke menu');
							readln();
							showMenu(N);
						End
						Else
							Begin
								If ( SearchKosong (ListDataIdStruk) <> 0) Then
									Begin
										InputdiSini := Searchkosong ( ListDataIdStruk );
										Str(InputdiSini,Kalimat);
										ListDataIdStruk[InputdiSini].IdStruk		:= 'IDBUY00' + Kalimat;
										ListDataIdStruk[InputdiSini].Tanggal		:= Tanggal;
										ListDataIdStruk[InputdiSini].Bulan			:= Bulan;
										ListDataIdStruk[InputdiSini].Tahun			:= Tahun;
										ListDataIdStruk[InputdiSini].JenisMember	:= CodeMember(Member);
										ListDataIdStruk[InputdiSini].Diskon			:= DiskonMember(Member);
										ListDataIdStruk[InputdiSini].JumAwal 		:= JumAwal;
										ListDataIdStruk[InputdiSini].JumAfterDiskon := JumlahBayarAfterDiskon(InputdiSini,ListDataIdStruk);
									End
								Else
									Begin
										Clrscr;
										Write ( 'INDEX ARRAY YANG ANDA INPUT SUDAH PENUH ');
									End
							End;
				End;
		End;
End;

{--------------------------------------------------------S H O W D A T A----------------------------------------------------------------------------------}

Procedure Show_Data ( VAR i : Integer; VAR DataIdStruk : arrStruk );
Var
	Show : Integer;
Begin
	Clrscr;
	Show := 1;
	While ( Show <= i ) Do
	Begin
		Writeln('ID Struk :',DataIdStruk[Show].IdStruk);
		Writeln('Tanggal :',DataIdStruk[Show].Tanggal);
		Writeln('Bulan	:',DataIdStruk[Show].Bulan);
		Writeln('Tahun :',DataIdStruk[Show].Tahun);
		Writeln('Jenis Member :',DataIdStruk[Show].JenisMember);
		Writeln('Diskon :',DataIdStruk[Show].Diskon:3:2);
		Writeln('Jumlah Awal :',DataIdStruk[Show].JumAwal:3:2);
		Writeln('Jumlah After Diskon :',DataIdStruk[Show].JumAfterDiskon:3:2);
		Writeln;
		Show := Show + 1;
	End;
End;

{--------------------------------------------------------E D I T  D A T A -------------------------------------------------------------------------------}

Procedure EditData ( i : Integer ; ListDataIdStruk : arrStruk );
Var
  Lihat,Member: Integer;
  DataIdStruk : String;
Begin
  clrscr;
  write('SILAHKAN ANDA MASUKKAN ID DATA YANG INGIN DIUBAH  : ');
  readln(DataIdStruk);
  Lihat :=  CekData(i, DataIdStruk, ListDataIdStruk);
  IF (Lihat <> -1) Then
    begin
      Writeln('Data Awal Film ');
      TampilkanListFilm (Lihat, ListDataIdStruk);
      writeln('Data Baru Film ');
      write('Tanggal [1-31]        : ');
      readln(ListDataIdStruk[Lihat].Tanggal);
      write('Bulan   [1-12]        : ');
      readln(ListDataIdStruk[Lihat].Bulan);
      write('Tahun                 : ');
      readln(ListDataIdStruk[Lihat].Tahun);
      writeln('[1] = Umum, [2] = Silver, [3] = Gold, [4] = Platinum, [5] = PlatinumPlus');
      write('Jenis Member          : ');
      readln(Member);
      ListDataIdStruk[Lihat].JenisMember := CodeMember(Member);
      write('Jumlah Awal           : ');
      readln(ListDataIdStruk[Lihat].JumAwal);
      ListDataIdStruk[Lihat].Diskon := DiskonMember(Member) +  DiskonAkhirBulan (ListDataIdStruk[Lihat].Tanggal, ListDataIdStruk[Lihat].JumAwal);
      ListDataIdStruk[Lihat].JumAfterDiskon := JumlahBayarAfterDiskon (Lihat,ListDataIdStruk);
      writeln('BERHASIL SUKSES MENGEDIT DATA! ');
      writeln;
      clrscr;
    end
  else
    begin
      writeln('MOHON MAAF ID DATA TIDAK DITEMUKAN!');
    end;
end;

{--------------------------------------------------------D E L E T E  D A T A -------------------------------------------------------------------------------}

procedure Deletedata(var i : integer; VAR ListDataIdStruk : arrStruk);
var
  DataIdStruk : string;
  show,Lihat : integer;
begin
  clrscr;
  write('MASUKKAN ID STRUK DATA YANG INGIN ANDA HAPUS (CONTOH. IDBUY001 : ');
  readln(DataIdStruk);
  Lihat :=  CekData (i, DataIdStruk, ListDataIdStruk);
  If(Lihat <> 0) then
    Begin
      For show := Lihat to i-1 Do
      begin
        ListDataIdStruk[show].IdStruk := ListDataIdStruk[show+1].IdStruk;
        ListDataIdStruk[show].Tanggal := ListDataIdStruk[show+1].Tanggal;
        ListDataIdStruk[show].Bulan := ListDataIdStruk[show+1].Bulan;
        ListDataIdStruk[show].Tahun := ListDataIdStruk[show+1].Tahun;
        ListDataIdStruk[show].JenisMember := ListDataIdStruk[show+1].JenisMember;
        ListDataIdStruk[show].Diskon := ListDataIdStruk[show+1].Diskon;
        ListDataIdStruk[show].JumAwal := ListDataIdStruk[show+1].JumAwal;
        ListDataIdStruk[show].JumAfterDiskon := ListDataIdStruk[show+1].JumAfterDiskon;
      end;
        i := i - 1;
        writeln('SELAMAT ANDA SUKSES MENGHAPUS BARANG ');
        readln;
        clrscr;
    end
  else
    begin
      writeln('MOHON MAAF ID STRUK DATA TIDAK DITEMUKAN');
    end;
end;

{--------------------------------------------------------S E A R C H D A T A  ---------------------------------------------------------------------------}

Procedure searchdata( i : integer; ListDataIdStruk : arrStruk);
VAR
  z,j,Cari1,Cari2 : Integer;
  Cek  : boolean;
begin
  write('Silahkan Masukkan Bulan : ');
  readln(Cari1);
  write('Silahkan Masukkan Tahun : ');
  readln(Cari2);
  Cek := False;
  writeln;
  writeln('       Hasil Pencarian Data ID Struk Berhasil dengan Bulan ',Cari1,' dan Tahun ',Cari1 );
  writeln('==========================================================================');
  z := 0;
  for j := 1 to i do
    Begin
      If  (ListDataIdStruk[j].Bulan = Cari1) And (ListDataIdStruk[j].Tahun = Cari2) then
      Begin
          z := z+1;
          writeln('ID Struk              : ',ListDataIdStruk[j].IdStruk);
          writeln('Tanggal               : ',ListDataIdStruk[j].Tanggal);
          writeln('Bulan                 : ',ListDataIdStruk[j].Bulan);
          writeln('Tahun                 : ',ListDataIdStruk[j].Tahun);
          writeln('Jenis Member          : ',ListDataIdStruk[j].JenisMember);
          writeln('Diskon                : ',ListDataIdStruk[j].Diskon);
          writeln('Jumlah Awal           : ',ListDataIdStruk[j].JumAwal:3:2);
          writeln('Jumlah Setelah Diskon : ',ListDataIdStruk[j].JumAfterDiskon:3:2);
          writeln;
          Cek := true;
      End;
    End;
    If NOT Cek Then
    begin
      writeln('              TIDAK ADA DATA BULAN ',Cari1,' PADA TAHUN ',Cari2,'     ');
       writeln('==============================================================================')
    End;
End;

{--------------------------------------------------------S O R T I N G D A T A---------------------------------------------------------------------------}

Procedure Selectionsort(N : integer; VAR ListDataIdStruk : arrStruk);
var
        j,i,max: integer;
        temp : Struk;
begin
        for i := 1 to N - 1 do
        begin
                max := i;
                for j := i + 1 to n do
                begin
                        if (ListDataIdStruk[j].JumAfterDiskon > ListDataIdStruk[max].JumAfterDiskon) then
                        begin

                                temp := ListDataIdStruk[j];
                                ListDataIdStruk[j] := ListDataIdStruk[max];
                                ListDataIdStruk[max] := temp;
                        end;
                end;
        end;
end;
{--------------------------------------------------------E X I T M E N U  -------------------------------------------------------------------------------}

Procedure Exit();
Begin
	Clrscr;
	Writeln ();
	Writeln ();
	Writeln ('TERIMA KASIH TELAH MENGGUNAKAN PROGRAM KAMI');
	Writeln ();
	Writeln ();
End;

{--------------------------------------------------------I N P U T M E N U  -----------------------------------------------------------------------------}

procedure InputMenu();
var
	Pilih : integer;
begin
	Readln(Pilih);
	Case Pilih Of
		1: InputData(ListDataIdStruk, N);
		2: Show_Data(N,ListDataIdStruk);
		3: searchData(N,ListDataIdStruk);
		4: Selectionsort(N,ListDataIdStruk);
		5: EditData (N,ListDataIdStruk);
		6: Deletedata (N,ListDataIdStruk);
		7: BEGIN
            WRITE('   Jumlah genre yang akan dimasukkan : ');
            READLN(jum_genre);
            pilih_genre(arr_genre, jum_genre, z, N);
            END;
        8: BEGIN
            IF z>0 THEN
              BEGIN
              WRITE('   Jumlah film yang akan dimasukkan : ');
              READLN(jum_film);
              inputfilm(arr_genre,N,jum_film,z,y);
              END;
            END;
        9: BEGIN
            tampilkan_film(arr_genre,y,z);
       	    END;
		0: Exit ();
		else
			writeln('Input tidak valid');
			showMenu(N);
	end;
end;

{--------------------------------------------------------T A M P I L K A N M E N U ----------------------------------------------------------------------}

procedure ShowMenu(var N : integer);
Begin
	clrscr;
	WRITELN;
    WRITELN('                   Movie MARKET                  ');
    WRITELN('      Jln. Platinum No.01 Bandung, Jawa Barat      ');
    WRITELN('___________________________________________________');
    WRITELN;
    WRITELN('                      M E N U                      ');
	writeln('1. Input Id Struk ');
	writeln('2. Output Id Struk');
	Writeln('3. search Data');
	writeln('4. Sort Data Id Struk');
	writeln('5. Edit Id Struk');
	Writeln('6. Delete Data ');
	writeln('7. Genre');
	writeln('8. Film');
	writeln('9. Tampilkan Film');
	Writeln('0. Exit ');
	writeln;
	writeln('Silahkan Pilih menu : ');
	InputMenu();
End;

begin

	N := 0;
	ShowMenu(N);

End.
// ListDataIdStruk(N);






















