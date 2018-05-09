Program regresi_multiple;
uses crt,stat_m,stat_mat,dos;
{const max = 100;
imax = 10;

type indeks_1 = 1..max;
	  indeks_2 = 1..imax;
	  matrix = array[indeks_1,indeks_2] of real;
	  vektor = array[indeks_2] of real;
        }
var x,c,xx : matrix;
	 a,t,y,z : vektor;
	 b,r,mse : real;
	 i,j,k,n,m :byte;
	 baris,kolom : byte;
	 nama : string[10];
	 opsi1,opsi2,ps : char;
	 reg : registers;


procedure printing;
begin
     clrscr;
     textbackground(blue);
	  textcolor(white);
	  cbesar;
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
	  cmati;
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
	  writeln('============================================================================');
	 end;

Procedure tunggu;
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
	gotoxy(2,25); write(tulis2);
	gotoxy(79-length(tulis1),25); write(tulis1);
	opsi2 := readkey;
end;


	procedure simpan_data(var kolom,baris : byte; var x : matrix; var y : vektor);
	var
		 filv : file of vektor;
		 film : file of matrix;
		 fb	: file of byte;
		 nama :  string[10];
		 ada : boolean;
		 metu : char;
	label 01;
	begin
		clrscr;
		cbesar;
		tampilan('Regresi multipel');
		write('Jumlah pasangan data      : '); readln(baris);
		write('Jumlah variabel bebas     : '); readln(kolom);
		m := kolom+1;
		n := baris;
		k := m;

		writeln;
		write('Nama file : '); readln(nama);


		assign(film,nama+'xi.dat');
		assign(filv,nama+'yi.dat');
		rewrite(film);
		rewrite(filv);

		writeln;

		clrscr;
		writeln('X:');
		for i := 1 to baris do
		begin
			gotoxy(1,i+2); write(i,'.');
			x[i,1] := 1;
			for j := 2 to kolom+1 do
			begin
				gotoxy(10*(j-1),i+2);
				readln(x[i,j]);
			end;
		end;

		for i := 1 to baris do
		begin
			x[i,kolom+2] := x[i,1]*x[i,1];
			x[i,kolom+3] := x[i,2]*x[i,2];
			x[i,kolom+4] := x[i,1]*x[i,2];
		end;

		for i := 1 to baris do
		begin
			write(film,x);
		end;


		gotoxy(75,2); writeln('Y:');
		for i := 1 to baris do
		begin
			gotoxy(75,i+2);readln(y[i]);
		end;

		for i := 1 to baris do
		begin
			write(filv,y);
		end;

		cmati;
		{writeln;
		writeln;
		writeln('Tunggu...');
		writeln('         ');}

		close(film);
		close(filv);
		tekan_enter;
	end;

	procedure ambil_data(var kolom,baris : byte; var x : matrix; var y : vektor);
	var
		 filv : file of vektor;
		 film : file of matrix;
		 nama :  string[10];
		 ada : boolean;
		 metu : char;
	label 01;
	begin
		01:
		clrscr;
		cbesar;
		tampilan('Regresi multipel');
		write('Nama file : '); readln(nama);
		writeln;
		write('Banyaknya pasangan data (maks 20) : '); readln(baris);
		write('Banyaknya variabel bebas (maks 5) : '); readln(kolom);

		m := kolom+1;
		n := baris;
		k := m;
		{$I-}
		assign(film,nama+'xi.dat');
		assign(filv,nama+'yi.dat');
		reset(film);
		reset(filv);
		{$I+}
		ada := (IOResult = 0);
		if ada then
		begin
			for i := 1 to baris do
			begin

				read(film,x);
			end;
			for i := 1 to baris do
			begin
				read(filv,y);
			end;

		end;
		if not ada then
		begin
				  clrscr;
				  cmati;
				  textcolor(lightred); write(#7);
				  gotoxy(20,5); write('FILE TIDAK ADA ! ');
				  gotoxy(20,7); write('Tekan <Esc> Keluar atau <Enter> Ulang');
				  metu := readkey;
				  if metu = #27 then halt else goto 01;
		end;
		close(film);
		close(filv);
	end;

	procedure hasilnya;
	begin
	  clrscr;
	  cmati;
	  tampilan('Regresi multipel');
	  writeln('Koefisien-koefisien regresi: ');
	  kali_transpose_1(k,n,x,y,z);
	  kali_transpose_2(k,n,x,x);
	  matriks_invers(k,x,x);
	  kali_matriks_2(k,k,1,x,z,a);
	  for i := 1 to k do
	  begin
			writeln('a-',i-1,':',a[i]:15:6);
	  end;
	  tekan_enter;
	  clrscr;
	  tampilan('Regresi multipel');
	  anova(k,n,a,y,z,r,mse);
	  tekan_enter;

	  clrscr;
	  tampilan('Regresi multipel');
	  writeln('Matriks varian-kovarian:');
	  varian_kovarian_2(k,x,mse,xx);
	  for i := 1 to k do
	  begin
			 for j := 1 to k do
			 begin
				  writeln(xx[i,j]:15:10,'':5);
			 end;
			 writeln;
	  end;
	  tekan_enter;

	  clrscr;
	  tampilan('Regresi multipel');
	  writeln('Tes t untuk koefisien-koefisien regresi:');
	  test_t(k,xx,a,t);
	  for i := 2 to k do
	  begin
			writeln('t(a-',i-1,'):',t[i]:15:6);
	  end;
	  tekan_enter;

	  clrscr;
	  tampilan('Regresi multipel');
	  writeln('Estimasi untuk koefisien-koefisien regresi:');
	  cbesar;
	  estimasi(n,k,xx,x);
	  for i := 1 to k do
	  begin
			writeln(a[i]-x[i,i]:15:6,'':5,'< a-',i-1,' <','':3,a[i]+x[i,i]:15:6);
	  end;
	  cmati;
	end;

	procedure menu;
	begin
		clrscr;
		textbackground(brown);
		textcolor(white);
		cbesar;
		gotoxy(27,3); write('    REGRESI MULTIPEL         ');
		textbackground(blue);
		textcolor(white);
		gotoxy(27,5); write('                             ');
		gotoxy(27,8); write(' X. [MENU UTAMA]             ');
		gotoxy(27,6); write(' A. Memasukkan data baru     ');
		gotoxy(27,7); write(' B. Mengambil data tersimpan ');
		gotoxy(27,9); write('                             ');
		textcolor(yellow);
		gotoxy(27,8); write(' X');
		gotoxy(27,6); write(' A');
		gotoxy(27,7); write(' B');
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
		case upcase(opsi1) of
		'A' : begin
					simpan_data(kolom,baris,x,y); {hasilnya;}
				end;
		'B' : begin
					ambil_data(kolom,baris,x,y);  {hasilnya;}
				end;
		'X' : halt;
		end;
	 end;


Begin
	  clrscr;
	  repeat
			  clrscr;
			  warna(0,0,80,25,black);
			  menu;
			  clrscr;
			  printing;
			  hasilnya;
			  if ps = '2' then intr(5,reg);
			  tunggu;
	  until opsi2 = #27;
end.
