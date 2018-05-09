Program kontingensi;
Uses crt,dos,stat_m;
type
	data2r = array[1..60,1..60] of real;
	data1r = array[1..100] of real;
	kata = string[10];
var
	dk,i,j,kolom,baris : byte;
	chitab,x1,x2,chi,n : real;
	nama,namaf : kata;
	n1,n2  : data2r;
	tot1,tot2 : data1r;
	reg : registers;
	ps,opsi1,opsi2 : char;
	fk : file of kata;
	fr : file of data2r;
	fi : file of byte;

procedure printing;
begin
	  clrscr;
	  textbackground(lightgray);
     textcolor(white);
     gotoxy(27,2); write('                             ');
     gotoxy(27,3); write('    TUJUAN OUTPUT :          ');
	  gotoxy(27,4); write(' 1. Display di monitor       ');
     gotoxy(27,5); write(' 2. Cetak di printer         ');
     gotoxy(27,6); write('                             ');
	  textcolor(yellow);
     gotoxy(27,4); write(' 1');
     gotoxy(27,5); write(' 2');
	  textbackground(brown);
     textcolor(yellow);
     gotoxy(27,8); write('    Pilihanku :              ');
     gotoxy(43,8);
     textbackground(black);
     ps := readkey;
     if ps = '1' then begin end;
end;

Procedure Warna(xb,yb,xe,ye : word; B : word);
begin
     for i := yb to ye do
     begin
          for j := xb to xe do
			 begin
               TextBackGround(B);
               GotoXY(i,j);
					write(char(255));
          end;
     end;
end;

    procedure tampilan(st:string);
    begin
     clrscr;
	  textbackground(brown);
	  textcolor(white);
	  for i := 1 to 76 do write(' ');
	  gotoxy(1,1);
	  write(st);
	  gotoxy(45,1); write('<<<<< Basic Statistics 1.1 >>>>>');
	  gotoxy(1,2);
	  textbackground(black);
	  write('============================================================================');
	 end;

Procedure tekan_esc;
const tulis2 = '<Esc> Keluar';
	 tulis1 = '<Enter> Ulang';
begin
	cmati;
	textbackground(cyan);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(white);
	gotoxy(79-length(tulis1),25);
	write(tulis1);
	gotoxy(2,25);
	write(tulis2);
	textbackground(black);
end;

procedure input;
Begin
	clrscr;
	cbesar;
	tampilan('Uji independensi dengan Chi kuadrat');
	write('Nama File : '); readln(nama);
	namaf := nama;
	writeln;
	assign(fk,nama);
	assign(fi,nama+'.dat');
	assign(fr,nama+'xi.dat');
	rewrite(fk);
	rewrite(fi);
	rewrite(fr);
	write('Jumlah faktor 1 : '); readln(kolom);
	write('Jumlah faktor 2 : '); readln(baris);
	write(fi,kolom);
	write(fi,baris);
	writeln;

	for i := 1 to baris do
	begin
		for j := 1 to kolom do
		begin
			write('Data [',i:2,j:2,'] = '); readln(n1[i,j]);
		end;
		writeln;
	end;

	for i := 1 to baris do
	begin
		for j := 1 to kolom do
		begin
			write(fr,n1);
		end;
	end;
	close(fk);
	close(fi);
	close(fr);
end;

procedure load;
var metu : char;
label 01;
Begin
	01:
	clrscr;
	cbesar;
	tampilan('Nonparametrik : Uji independensi ');
	gotoxy(20,4); write('Nama File : '); readln(nama);
	namaf := nama;
	writeln;
	{$I-}
	assign(fk,nama);
	assign(fi,nama+'.dat');
	assign(fr,nama+'xi.dat');
	reset(fk);
	reset(fi);
	reset(fr);
	{$I+}
	if IOResult = 0 then
	begin
			 clrscr;
			 read(fi,kolom);
			 read(fi,baris);
			 for i := 1 to baris do
			 begin
				for j := 1 to kolom do
				begin
					read(fr,n1);
				end;
			 end;
	end else
	begin
			 clrscr;
			 textcolor(lightred);
			 gotoxy(10,3); write('File tidak ditemukan !');
			 write(#7);
			 gotoxy(10,7); write('Tekan <Esc> Keluar atau <Enter> Ulang');
			 metu := readkey;
			 if metu = #27 then halt else goto 01;
	end;
	close(fk);
	close(fi);
	close(fr);
end;

	 procedure menu;
	 begin
		clrscr;
		textbackground(brown);
		textcolor(white);
		gotoxy(27,3); write('     TABEL KONTINGENSI       ');
		textbackground(blue);
		textcolor(white);
		gotoxy(27,5); write('                             ');
		gotoxy(27,6); write(' 0. [MENU UTAMA]             ');
		gotoxy(27,7); write(' 1. Memasukkan data baru     ');
		gotoxy(27,8); write(' 2. Mengambil data tersimpan ');
		gotoxy(27,9); write('                             ');
		textcolor(yellow);
		gotoxy(27,6); write(' 0');
		gotoxy(27,7); write(' 1');
		gotoxy(27,8); write(' 2');
		textbackground(cyan);
		textcolor(yellow);
		gotoxy(27,11); write('    Pilihanku :              ');
		gotoxy(43,11);
		cmati;
		i := 0;
		repeat
			  textbackground(black);
			  textcolor(i);
			  gotoxy(35,23);
			  write(Hbesar('programer:'));
			  gotoxy(32,24);
			  write('Drs. Kasmui, M.Si');
			  gotoxy(28,25);
			  write(Hbesar('jurusan kimia fmipa unnes'));
			  textbackground(cyan);
			  textcolor(i+6);
			  gotoxy(45,11); write('-');
			  delay(300);
			  inc(i,1);
		until keypressed;
		textbackground(black);
		textcolor(white);
		opsi1 := readkey;
		case opsi1 of
		'1' : input;
		'2' : load;
		'0' : halt;
		end;
	 end;

procedure tabelchi;
begin
	  case dk of
     1    :  chitab := 3.84;  2    :  chitab := 5.99;  3    :  chitab := 7.81;
	  4    :  chitab := 9.49;  5    :  chitab := 11.1;  6    :  chitab := 12.6;
	  7    :  chitab := 14.1;  8    :  chitab := 15.5;  9    :  chitab := 16.9;
     10   :  chitab := 18.3;  11   :  chitab := 19.7;  12   :  chitab := 21.0;
     13   :  chitab := 22.4;  14   :  chitab := 23.7;  15   :  chitab := 25.0;
     16   :  chitab := 26.3;  17   :  chitab := 27.6;  18   :  chitab := 28.9;
     19   :  chitab := 30.1;  20   :  chitab := 31.4;  21   :  chitab := 32.7;
	  22   :  chitab := 33.9;  23   :  chitab := 35.2;  24   :  chitab := 36.4;
	  25   :  chitab := 37.7;  26   :  chitab := 38.9;  27   :  chitab := 40.1;
	  28   :  chitab := 41.3;  29   :  chitab := 42.6;  30   :  chitab := 43.8;
	  40   :  chitab := 55.8;  50   :  chitab := 67.5;  60   :  chitab := 79.1;
	  70   :  chitab := 90.5;  80   :  chitab := 101.9; 90   :  chitab := 118.1;
	  end;
end;

procedure hitung;
begin
	tot1[j] := 0;
	for j := 1 to kolom do
	begin
		for i := 1 to baris do
		begin
			tot1[j] := tot1[j] + n1[i,j];
		end;
	end;

	n := 0;
	tot2[i] := 0;
	for i := 1 to baris do
	begin
		for j := 1 to kolom do
		begin
			tot2[i] := tot2[i] + n1[i,j];
		end;
		n := n + tot2[i];
	end;

	for i := 1 to baris do
	begin
		for j := 1 to kolom do
		begin
			n2[i,j] := tot1[j]*tot2[i]/n;
		end;
	end;

	chi := 0;
	for i := 1 to baris do
	begin
		for j := 1 to kolom do
		begin
			x1 := n1[i,j]-n2[i,j];
			x2 := sqr(x1)/n2[i,j];
			chi := chi + x2;
		end;
	end;
	dk := (kolom-1)*(baris-1);
	tabelchi;
end;

begin
	repeat
	warna(0,0,80,25,black);
	cbesar;
	repeat
		menu;
	until opsi1 in ['1','2','0'];
	clrscr;
	printing;
	clrscr;
	tampilan('Nonparametrik : Uji independensi ');
	for i := 1 to baris do
	begin
		for j := 1 to kolom do
		begin
			gotoxy(5+10*j,3+i); write(n1[i,j]:10:3);
		end;
	end;
	hitung;
	gotoxy(5,5); 		 write('Faktor 2');
	gotoxy(5,baris+4); write('Jumlah');
	for j := 1 to kolom do
	begin
		gotoxy(5+10*j,baris+4); write(tot1[j]:10:3);
	end;

	gotoxy(30,3); write('Faktor 1');
	gotoxy(15+10*kolom,3); write('Jumlah':10);
	for i := 1 to baris do
	begin
		gotoxy(15+10*kolom,3+i); write(tot2[i]:10:3);
	end;
	gotoxy(15+10*kolom,4+baris); write(n:10:3);
	if kolom < 5 then
	begin
		gotoxy(25+10*kolom,3); write('Probab.':12);
		for i := 1 to baris do
		begin
			gotoxy(25+10*kolom,3+i); write(tot2[i]/n:10:3);
		end;
	end;
	writeln;
	gotoxy(5,6+baris);  write('Chi data  = ',chi:5:4);
	gotoxy(5,7+baris);  write('alpha     = 0,05');
	gotoxy(5,8+baris);  write('dk        = ',dk);
	gotoxy(5,9+baris);  write('Chi tabel = ',chitab:4:2);
	gotoxy(5,11+baris); write('Kesimpulan :');

	if chi > chitab then
	begin
		gotoxy(5,12+baris);
		write('Karena Chi data > Chi tabel maka');
		gotoxy(5,13+baris);
		write('faktor 1 ada ketergantungan terhadap faktor 2');
	end else
	begin
		gotoxy(5,12+baris);
		write('Karena Chi data < Chi tabel maka');
		gotoxy(5,13+baris);
		write('faktor 1 tidak ada ketergantungan terhadap faktor 2');
	end;
	if ps = '2' then intr(5,reg);
	tekan_esc;
	until readkey = #27;
end.





