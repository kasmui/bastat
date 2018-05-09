Program RANDOMIZED_BLOCKS_AN0VA_2;
uses crt,dos,stat_m;
const mbaris = 40; mkolom = 5;
type ibaris = 1..mbaris;
	ikolom = 1..mkolom;
	data_F = array[1..3] of real;
	data_kol = array[1..mkolom] of byte;
	data_x = array[ibaris,ibaris,ikolom] of real;
var  i,j,l,k,kv1,kv2,replik,ntot,dka,dkb,dkd,dkab : byte;
	ftab : data_f;
	berkas : file of data_x;
	Jdata : file of byte;
	ps,opsi,opsi1,opsi2 : char;
	nama : string[14];
	x : data_x;
	kelvar : data_kol;
	sum_x,sum_x2,sum_tot,sum_bar,sum_ab,sum_ba,msa,msb,msd,
	msab,fkor,sum_aa,sum_bb,sum_xa,sum_xb,
	sum_xd,sum_xab,sum_a,sum_b,sum_d,
	test_f1,test_f2,test_f3 : real;
	reg : registers;
Label 01,02;

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

	procedure garis_mendatar(y:integer);
	var x : integer;
	begin
		for x := 2 to 78 do
		begin
			gotoxy(x,y);
			writeln('-');
		end;
	end;

	procedure garis_tegak(x:integer);
	var y:integer;
	begin
		for y := 2 to 11 do
		begin
			gotoxy(x,y);
			writeln(' ');
		end;
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
	  for i := 1 to 78 do write(' ');
     gotoxy(1,1);
     write(st);
     gotoxy(45,1); write('<<<<< Basic Statistics 1.1 >>>>>');
     textbackground(black);
     textcolor(white);
     gotoxy(1,2);
     write('==============================================================================');
    end;

    procedure tampilan2(st:string);
    begin
     clrscr;
     textbackground(brown); textcolor(white);
     for i := 1 to 78 do write(' ');
     gotoxy(30,1);
     write(st);
     textbackground(black);
     textcolor(white);
	 end;

Procedure Daftar_ANOVA;
begin
	tampilan2('TABEL RANDOMIZED BLOCKS ANOVA');
	textbackground(black);
	garis_mendatar(2);
	gotoxy(4,3);  writeln('Sumber');
	gotoxy(4,4);  writeln('variasi');
	gotoxy(19,3); writeln('Derajat');
	gotoxy(19,4); writeln('kebebasan');
	gotoxy(36,3); writeln('Jumlah');
	gotoxy(36,4); writeln('kuadrat');
	gotoxy(51,3); writeln('Rata-rata');
	gotoxy(51,4); writeln('kuadrat');
	gotoxy(69,3); writeln('F');
	gotoxy(69,4); writeln('data');

	garis_mendatar(5);
	gotoxy(4,6); writeln('A');
	gotoxy(4,7); writeln('B');
{	gotoxy(4,8); writeln('AxB');}
	gotoxy(4,8); writeln('Dalam');
	garis_mendatar(10);
	gotoxy(4,11); writeln('Total');
	garis_mendatar(12);
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
end;

procedure save;
begin
	clrscr;
	cbesar;
	tampilan('Randomized Blocks ANOVA');

	gotoxy(1,3);
	write('Nama File : '); readln(nama);
	assign(jdata,nama+'xi.dat');
	assign(berkas,nama+'.dat');
	rewrite(jdata);
	rewrite(berkas);
	gotoxy(1,22);
	write('Banyak variabel                        : 2');
	for i := 1 to 2 do
	begin
		repeat
			gotoxy(1,23); clreol;
			write('Banyak kelompok untuk variabel ke-',i,'    : '); readln(kelvar[i]);
		until kelvar[i] > 1;
	end;
	kv1 := kelvar[1]; kv2 := kelvar[2];
	write(jdata,kv1); write(jdata,kv2);
	replik := 1;
	write(jdata,replik);
	clrscr;
	tampilan('Randomized Blocks ANOVA');
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
				for l := 1 to replik do
				begin
					gotoxy((19*(i-1))+7,3);         write('A',i);
					gotoxy(1,j+3); 	  		write('B',j);
					gotoxy((19*(i-1))+(7*l),j+3);   write('-');
					gotoxy(1,24); clreol;
					write('Masukkan data(',i,j:2,l:2,') : '); readln(x[i,j,l]);
					{write(berkas,x);}
					gotoxy(1,24); clreol;
					gotoxy((19*(i-1))+(7*l),j+3);
					write(x[i,j,l]:3:2);
				end;
		end;
	end;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
				for l := 1 to replik do
				begin
					write(berkas,x);
				end;
		end;
	end;
	cmati;
	garis_mendatar(24);
	gotoxy(2,25); write('Tekan <Enter>... ');
	readln;
	cbesar;
	close(jdata);
	close(berkas);
end;

procedure load;
var n : byte;
label 001;
begin
	001:
	clrscr;
	cbesar;
	tampilan('Randomized Blocks ANOVA');
	gotoxy(1,3);
	write('Nama File : '); readln(nama);
	{$I-}
	assign(jdata,nama+'xi.dat');
	assign(berkas,nama+'.dat');
	reset(jdata);
	reset(berkas);
	{$I+}
	if IOresult = 0 then
	begin
		read(jdata,kv1); read(jdata,kv2); read(jdata,replik);
		for i := 1 to kv1 do
		begin
			for j := 1 to kv2 do
			begin
					for l := 1 to replik do
					begin
						read(berkas,x);
					end;
			end;
		end;
	end else
	begin
		clrscr;
		gotoxy(1,3); clreol;
		write(#7);
		cmati;
		writeln('File tidak ada ...!');
		write('Tekan <Esc> Keluar atau <Enter> Ulangi');
		opsi := readkey;
		if opsi = #27 then halt else goto 001;
	end;
	close(jdata);
	close(berkas);
end;

procedure display_data;
begin
	clrscr;
	printing;
	clrscr;
	tampilan('Randomized Blocks ANOVA');
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
				for l := 1 to replik do
				begin
					gotoxy((19*(i-1))+7,3); write('A',i);
					gotoxy(1,j+3); write('B',j);
					gotoxy((19*(i-1))+(7*l),j+3); write('-');
					gotoxy((19*(i-1))+(7*l),j+3);
					write(x[i,j,l]:3:2);
				end;
		end;
	end;
	if ps = '2' then intr(5,reg);
	garis_mendatar(24);
	cmati;
	if opsi <> #27 then
	begin
		gotoxy(2,25); write('Tekan <Enter>... ');
		readln;
	end;
	cbesar;
end;

procedure menu;
begin
	clrscr;
	textbackground(brown);
	textcolor(white);
	gotoxy(27,3); write('    RANDOMIZED BLOCKS ANOVA  ');
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
	'1' : save;
	'2' : load;
	'0' : halt;
	end;
end;

Begin
	01:
	warna(0,0,80,25,black);
	cbesar;
	repeat
		menu;
	until opsi1 in ['1','2','0'];
	if opsi1 = '0' then goto 01;
	if opsi1 = '2' then display_data;
	if opsi  = #27 then goto 01;
	sum_x := 0;
	sum_x2:= 0;
	for i := 1 to kv1 do
	begin
		for j := 1 to kv2 do
		begin
				for l := 1 to replik do
				begin
					sum_x := sum_x + x[i,j,l];
					sum_x2 := sum_x2 + sqr(x[i,j,l]);
				end;
		end;
	end;
	ntot := kv1*kv2*replik;
	fkor := sqr(sum_x)/ntot;
	sum_tot := sum_x2-fkor;

	sum_a := 0;
	for i := 1 to kv1 do
	begin
		sum_bar := 0;
		for j := 1 to kv2 do
		begin
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,l];
				end;
		end;
		sum_aa := sqr(sum_bar)/(ntot/kv1);
		sum_a := sum_a + sum_aa;
	end;
	sum_A := sum_a-fkor;

	sum_b := 0;
	for j := 1 to kv2 do
	begin
		sum_bar := 0;
		for i := 1 to kv1 do
		begin
				for l := 1 to replik do
				begin
					sum_bar := sum_bar + x[i,j,l];
				end;
		end;
		sum_bb := sqr(sum_bar)/(ntot/kv2);
		sum_b := sum_b + sum_bb;
	end;
	sum_b := sum_b-fkor;
	sum_d := sum_tot-sum_a-sum_b;

	dka := kv1-1;
	dkb := kv2-1;
	dkd:= dka*dkb;

	msa := sum_a/dka;
	msb := sum_b/dkb;
	msd := sum_d/dkd;

	test_f1 := msa/msd;
	test_f2 := msb/msd;

	clrscr;
	printing;
	clrscr;
	daftar_ANOVA;
	gotoxy(16,6);  writeln(dka:8);
	gotoxy(16,7);  writeln(dkb:8);
{	gotoxy(16,8);  writeln(dkab:8);}
	gotoxy(16,8);  writeln(dkd:8);
	gotoxy(16,11); writeln(ntot-1:8);

	gotoxy(33,6);  writeln(sum_a:10:4);
	gotoxy(33,7);  writeln(sum_b:10:4);
	gotoxy(33,8);  writeln(sum_d:10:4);
	gotoxy(33,11); writeln(sum_tot:10:4);

	gotoxy(50,6);  writeln(msa:10:4);
	gotoxy(50,7);  writeln(msb:10:4);
	gotoxy(50,8);  writeln(msd:10:4);
	gotoxy(50,11); writeln('-':6);

	gotoxy(65,6);  writeln(test_f1:10:4);
	gotoxy(65,7);  writeln(test_f2:10:4);
	gotoxy(65,8);  writeln('-':6);
	gotoxy(65,11); writeln('-':6);

	gotoxy(4,14);  write('F 0,95(',dka,';',dkd,') = '); readln(ftab[1]);
	if dkb <> dka then
	begin
		gotoxy(4,15);  write('F 0,95(',dkb,';',dkd,') = '); readln(ftab[2]);
	end else
	begin
		ftab[2] := ftab[1];
	end;

	if test_f1 >= ftab[1] then
	begin
		gotoxy(25,14);  write('Sumber variasi A     : Ada perbedaan signifikan ');
	end else
	begin
		gotoxy(25,14);  write('Sumber variasi A     : Tidak ada perbedaan signifikan');
	end;
	if test_f2 >= ftab[2] then
	begin
		gotoxy(25,15);  write('Sumber variasi B     : Ada perbedaan signifikan ')
	end else
	begin
		gotoxy(25,15);  write('Sumber variasi B     : Tidak ada perbedaan signifikan');
	end;
	if ps = '2' then intr(5,reg);
	tekan_esc;
	opsi2 := readkey;
	if opsi2 = #27 then halt
	else goto 01;
end.
