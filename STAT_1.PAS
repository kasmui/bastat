
{$N+}{$M 4000,0,0}
Program statistika;
uses printer,crt,dos,stat_m;
type rext  = array[1..100] of extended;
	  datar = array[1..100] of real;
	  datai = array[1..100] of integer;
	  data2 = array[1..50,1..50] of real;
	  screentype   = (mono,color);
const angs : array[1..10]  of string = ('A','B','C','D','E','F','G',
													 'H','I','J');
		toleransi  = 1.0e-5;
var
	x,xt,xtt,xb,zb,sigfixt,sigfixtt,fixt,fixtt,sigmafixt,sigmafixtt,
	mugab,sigmagab,propgab,tz,pel,O,E,OE,Lo,propsamp                : datar;
	f,fixi,frek,nkecgab,fri                                         : datai;
	total2,total12,kelas,prob2                                      : rext;
	k,s                                                             : data2;
	sigma,sbs,sigmaximu,sigmaxixbar,xbar,mu,sigmafx,sigmaxbar,
	rkecBes,sigmas,batas,fak,proppop,jprop,sigmaxpern,sangs,muxbar,
	muselgab,mujumgab,sigmapern,sigmaxbargab,sigmaper2n,sigmasgab,
	pqperngab,sigmaxperngab,muselpropgab,mujumpropgab,atas,bawah,
	itatas,itbawah,ttatas,ttbawah,akhir,delx,mid,ganjil,genap,
	total,total1,xi,prob,ft,ftt,sft,sftt,min,mak,minl,makl,dec,chi,
	att,chitab,angka_t, angka_r,interval,tl,jx,jx2                      : real;
	segmen,segmen2,bidang                                           : extended;
	jkel,prop,i,j,ii,jj,Nbes,nkec,Npn,Nbesmnkec,macpop,bagian,des,
	ndp,pilih,des1,fak1,fak2,fak3,angka,dk,probii,probi,fr,
	frektot,ng,si  : integer;
	nama,namaf                                          : string[10];
	opsi5,opsi,opsi2,opsi3,lagi,pmenu,dopsi,opsi1,opsi4,ps,jk        : char;
	stype : screentype;
	reg   : registers;
Label 10,20,30,40,50,60,70,80;

procedure Hapus_layar;
begin
	  clrscr;
	  textbackground(black);
	  textcolor(white);
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

Procedure terus;
const tulis2 = '';
	 tulis1 = 'Tekan <Enter>';
begin
	cmati;
	textbackground(cyan);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(white);
	gotoxy(79-length(tulis1),25); write(tulis1);
	gotoxy(2,25); write(tulis2);
	textbackground(black);
	opsi5 := readkey;
end;

Procedure ulang;
const tulis2 = '<T> Keluar';
	 tulis1 = '<Y> Menu';
begin
	cmati;
	textbackground(cyan);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(white);
	gotoxy(79-length(tulis1),25); write(tulis1);
	gotoxy(2,25); write(tulis2);
	textbackground(black);
	lagi := readkey;
end;

Procedure ulang2;
const tulis2 = '<Esc> Keluar';
	 tulis1 = '<Enter> Menu';
begin
	cmati;
	textbackground(cyan);
	for i := 1 to 79 do
	begin
		gotoxy(i,25); write(' ');
	end;
	textcolor(white);
	gotoxy(79-length(tulis1),25); write(tulis1);
	gotoxy(2,25); write(tulis2);
	textbackground(black);
	opsi3 := readkey;
end;


procedure min_mak(ndp : integer; var min,mak : real);
var i : integer;
begin
     min := x[1];
     mak := x[1];
     for i := 2 to ndp do
     begin
          if x[i] < min then min := x[i];
			 if x[i] > mak then mak := x[i];
	  end;
end;

procedure enter_data1(var ndp : integer);
type
	 kata     = string[10];
	 filereal = file of real;
	 fileint  = file of integer;
	 filekata = file of kata;
var
	namaf,nama : kata;
	fk    : filekata;
	fi    : fileint;
	frx    : filereal;

begin
	  clrscr;
	  cbesar;
	  tampilan('STATISTIKA DESKRIPTIF');
	  textbackground(black);
	  gotoxy(20,3); write('Nama File : '); readln(nama);
	  namaf := nama;
	  writeln;
	  assign(fk,nama);
	  assign(fi,nama+'.dat');
	  assign(frx,nama+'xi.dat');
	  rewrite(fk);
	  rewrite(fi);
	  rewrite(frx);
	  gotoxy(20,4); write('                      ');
	  gotoxy(20,4); write('Ukuran Sampel    = '); readln(ndp);
	  writeln;
	  for i := 1 to ndp do
	  begin
			 if i < 20 then
			 begin
					gotoxy(20,4+i); write('Data ',i,' = ');
					readln(x[i]);  write(frx,x[i]);
			 end else
			 begin
					gotoxy(45,i-15); write('Data ',i,' = ');
					readln(x[i]);  write(frx,x[i]);
			 end;
	  end;
	  min_mak(ndp,min,mak);
	  write(fk,nama);
	  write(fi,ndp);
	  close(fk);
	  close(fi);
	  close(frx);
end;

procedure load_data1(var ndp : integer);
type
	 kata     = string[10];
	 filereal = file of real;
	 fileint  = file of integer;
	 filekata = file of kata;
var
	nama : kata;
	fk    : filekata;
	fi    : fileint;
	frx    : filereal;
	metu	: char;
label 01;

begin
	  01:
	  clrscr;
	  cbesar;
	  tampilan('STATISTIKA DESKRIPTIF');
	  textbackground(black);
	  gotoxy(20,3); write('Nama File                : '); readln(nama);
	  namaf := nama;
	  gotoxy(20,4); write('Pilihan variabel (x/y/w) : ');
	  dopsi := readkey;
	  assign(fk,nama);
	  assign(fi,nama+'.dat');
	  assign(frx,nama+dopsi+'i.dat');
	  {$I-}
	  reset(fk);
	  reset(fi);
	  reset(frx);
	  {$I+}
	  if IOResult = 0 then
	  begin
			 clrscr;
			 read(fk,nama);
			 read(fi,ndp);
			 for i := 1 to ndp do
			 begin
					read(frx,x[i]);
			 end;
	  end else
	  begin
			 clrscr;
			 cmati;
			 gotoxy(10,3); write('File tidak ditemukan !');
			 gotoxy(10,7); write('Tekan <Esc> Keluar atau <Enter> Ulang');
			 write(#7);
			 metu := readkey;
			 if metu = #27 then halt else goto 01;
	  end;
	  min_mak(ndp,min,mak);
	  close(fk);
	  close(fi);
	  close(frx);
end;

procedure enter_data2(var ndp : integer);
type
	 kata     = string[10];
	 filereal = file of real;
	 fileint  = file of integer;
	 filekata = file of kata;
var
	nama : kata;
	fk    : filekata;
	fi,w  : fileint;
	frx    : filereal;

begin
	  clrscr;
	  cbesar;
	  tampilan('STATISTIKA DESKRIPTIF');
	  textbackground(black);
	  gotoxy(20,3); write('Nama File : '); readln(nama);
	  writeln;
	  assign(fk,nama);
	  assign(fi,nama+'.dat');
	  assign(w,nama+'fi.dat');
	  assign(frx,nama+'xi.dat');
	  rewrite(fk);
	  rewrite(fi);
	  rewrite(frx);
	  rewrite(w);
	  gotoxy(20,3); write('                      ');
	  gotoxy(20,3); write('Banyaknya data = '); readln(ndp);
	  writeln;
	  for i := 1 to ndp do
	  begin
			 gotoxy(20,4+i); write('Data ',i,' = '); readln(x[i]);
			 write(frx,x[i]);
			 gotoxy(40,4+i); write('Frek data ke-',i,' = '); readln(f[i]);
			 write(w,f[i]);
	  end;
	  min_mak(ndp,min,mak);
	  {for i := 1 to ndp do
	  begin
			 gotoxy(40,4+i); write('Frek data ke-',i,' = '); readln(f[i]);
			 write(w,f[i]);
	  end;}
	  write(fk,nama);
	  write(fi,ndp);
	  close(frx);
	  close(fi);
	  close(frx);
	  close(w);
end;

procedure load_data2(var ndp : integer);
type
	 kata = string[10];
	 filereal = file of real;
	 fileint = file of integer;
	 filekata = file of kata;
var
	nama : kata;
	fk    : filekata;
	fi,w  : fileint;
	frx    : filereal;
begin
	  clrscr;
	  cbesar;
	  tampilan('STATISTIKA DESKRIPTIF');
	  textbackground(black);
	  gotoxy(20,3); write('Nama file : '); readln(nama);
	  assign(fk,nama);
	  assign(fi,nama+'.dat');
	  assign(w,nama+'fi.dat');
	  assign(frx,nama+'xi.dat');
	  reset(fk);
	  reset(fi);
	  reset(frx);
	  reset(w);
	  read(fk,nama);
	  read(fi,ndp);
	  for i := 1 to ndp do
	  begin
			 read(frx,x[i]);
			 read(w,f[i]);
	  end;
	  min_mak(ndp,min,mak);
	  close(fk);
	  close(fi);
	  close(frx);
	  close(w);
end;

procedure menu1;
begin
	  clrscr;
	  repeat
	  textbackground(black);
	  clrscr;
	  cbesar;
	textbackground(cyan);
	  textcolor(Yellow);
	gotoxy(20,2);   write('          STATISTIKA DESKRIPTIF         ');
	textbackground(blue);
	  textcolor(white);

	  gotoxy(20,4);   write(' A. Simpangan baku populasi             ');
	  gotoxy(20,5);   write(' B. Simpangan baku sampel               ');
	  gotoxy(20,6);   write(' C. Simpangan baku distribusi populasi  ');
	  gotoxy(20,7);   write(' D. Simpangan baku distribusi sampel    ');
	  gotoxy(20,8);   write(' E. Rerata distribusi rata-rata         ');
	  gotoxy(20,9);  write(' F. Simpangan baku distribusi rerata    ');
	  gotoxy(20,10);  write(' G. Simpangan baku simpangan baku       ');
	  gotoxy(20,11);  write(' H. Simpangan baku proporsi             ');
	  gotoxy(20,12);  write(' I. Simpangan baku populasi gabungan    ');
	  gotoxy(20,13);  write(' J. Probabilitas data 1                 ');
	  gotoxy(20,14);  write(' K. Probabilitas data 2                 ');
	  gotoxy(20,15);  write(' L. Probabilitas untuk Z tertentu       ');
	  gotoxy(20,16);  write(' M. Daftar tabel Z                      ');
	  gotoxy(20,17);  write(' N. Uji normalitas dengan CHIý          ');
	  gotoxy(20,18);  write(' O. Uji normalitas dengan uji Lilliefors');
	  gotoxy(20,19);   write(' X. [MENU UTAMA]                        ');
	  textcolor(yellow);
	  gotoxy(20,4);   write(' A');
	  gotoxy(20,5);   write(' B');
	  gotoxy(20,6);   write(' C');
	  gotoxy(20,7);   write(' D');
	  gotoxy(20,8);   write(' E');
	  gotoxy(20,9);  write(' F');
	  gotoxy(20,10);  write(' G');
	  gotoxy(20,11);  write(' H');
	  gotoxy(20,12);  write(' I');
	  gotoxy(20,13);  write(' J');
	  gotoxy(20,14);  write(' K');
	  gotoxy(20,15);  write(' L');
	  gotoxy(20,16);  write(' M');
	  gotoxy(20,17);  write(' N');
	  gotoxy(20,18);  write(' O');
	  gotoxy(20,19);  write(' X');
	  textbackground(brown);
	  textcolor(Yellow);
	  gotoxy(20,21);  write('              Pilihanku :               ');

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
			  textbackground(red);
			  textcolor(i+6);
			  gotoxy(48,21); write('-');
			  delay(300);
			  inc(i,1);
	  until keypressed;
	  cbesar;
	  opsi := readkey;
	  textbackground(cyan);
	  textcolor(Yellow);
	  case opsi of
	  'x','X' : pilih := 0;
	  'a','A' : pilih := 1;
	  'b','B' : pilih := 2;
	  'c','C' : pilih := 3;
	  'd','D' : pilih := 4;
	  'e','E' : pilih := 5;
	  'f','F' : pilih := 6;
	  'g','G' : pilih := 7;
	  'h','H' : pilih := 8;
	  'i','I' : pilih := 9;
	  'j','J' : pilih := 10;
	  'k','K' : pilih := 11;
	  'l','L' : pilih := 12;
	  'm','M' : pilih := 13;
	  'n','N' : pilih := 14;
	  'o','O' : pilih := 15;
	  end;
	  until opsi in ['x','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o',
			  'X','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O'];
	  clrscr;
end;

procedure menu2(var ndp : integer);
begin
	  clrscr;
	  tampilan('STATISTIKA DESKRIPTIF');
	  textbackground(3);
	  textcolor(white);
	  cbesar;
	  gotoxy(27,3); write('                             ');
	  gotoxy(27,4); write(' 0. [MENU]                   ');
	  gotoxy(27,5); write(' 1. Memasukkan data baru     ');
	  gotoxy(27,6); write(' 2. Mengambil data tersimpan ');
	  gotoxy(27,7); write('                             ');
	  textcolor(yellow);
	  gotoxy(27,4); write(' 0');
	  gotoxy(27,5); write(' 1');
	  gotoxy(27,6); write(' 2');
	  textbackground(brown);
	  textcolor(yellow);
	  gotoxy(27,9); write('    Pilihanku :              ');
	  gotoxy(43,9);
	  textbackground(black);
	  cmati;
end;

procedure printing;
begin
	  clrscr;
	  textbackground(7);
	  textcolor(white);
	  cbesar;
	  gotoxy(27,2); write('                             ');
	  gotoxy(27,3); write(' 0. [MENU]                   ');
	  gotoxy(27,4); write(' 1. Display di monitor       ');
	  gotoxy(27,5); write(' 2. Cetak di printer         ');
	  gotoxy(27,6); write('                             ');
	  textcolor(yellow);
	  gotoxy(27,3); write(' 0');
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

procedure normalitas;
begin
	  dec := 1/des1;
	  sft := 0;
	  sftt := 0;
	  frektot := 0;
	  for j := 0 to jkel do
	  begin
			 frek[j+1]  := 0;
			 k[j+1,1]   := dec*(angka_r+(j*interval));
			 k[j+1,2]   := dec*(j+angka_r+(j+1)*(interval-1));
			 att := k[j+1,2];
			 xt[j+1]    := (k[j+1,1]+k[j+1,2])/2;
			 xtt[j+1]   := sqr(xt[j+1]);
			 xb[j+1]    := k[j+1,1]-(dec/2);
			 xb[jkel+1] := k[jkel,2]+(dec/2);
			 for i := 1 to Nbes do
			 begin
					if (x[i] >= k[j+1,1]) and (x[i] <= k[j+1,2]) then
					begin
						  f[j+1] := 1;
					end else
					begin
						  f[j+1] := 0;
					end;
					frek[j+1] := frek[j+1] + f[j+1];
			 end;
			 frektot         := frektot + frek[j];
			 fixt[j+1]       := frek[j+1]*xt[j+1];
			 ft              := fixt[j+1];
			 sft             := sft  + ft;
			 fixtt[j+1]      := frek[j+1]*xtt[j+1];
			 ftt             := fixtt[j+1];
			 sftt            := sftt  + ftt;
	  end;
	  xbar := sft/Nbes;
	  sbs  := sqrt((Nbes*sftt-sqr(sft))/(Nbes*(Nbes-1)));
	  if sbs = 0 then sbs := 0.000001;
	  for j := 1 to jkel+2 do
	  begin
			 zb[j] := (xb[j]-xbar)/sbs;
	  end;
end;

procedure Simpson(atas,bawah : real; var total : extended); forward;
procedure integrasi2; forward;

procedure normal;
begin
	  gotoxy(1,3);
	  writeln(' No.     Xb        Zi     Tabel Z        P     Ei = P*n',
				 '   Oi = fi    CHIý ');
	  for j := (1+des) to (jkel+1+des) do
	  begin
			 gotoxy(1,3+(j-des));
			 if j = 1+des then xb[j] := angka_r-(dec/2);
			 write((j-des):3,'.',xb[j]:8:3,zb[j]:11:4);
	  end;
	  for ii := 1+des to jkel+1+des do
	  begin
			 sigma   := 1;
			 mu      := 0;
			 itbawah := 0;
			 itatas  := zb[ii];
			 integrasi2;
			 pel[ii] := prob + (ii-ii);
			 tz[ii]  := pel[ii];
	  end;
end;

procedure chisquare;
begin
	  normal;
	  for j := 1+des to jkel+1+des do
	  begin
			 gotoxy(27,3+(j-des)); write(tz[j]:7:4);
	  end;
	  for j := 1+des to jkel+des do
	  begin
			 pel[j] := tz[j+1] - tz[j];
			 gotoxy(39,4+(j-des)); write(pel[j]:6:4);
	  end;
	  for j := 1+des to jkel+des do
	  begin
			 E[j] := pel[j]*Nbes;
			 gotoxy(49,4+(j-des)); write(E[j]:6:4);
	  end;
	  for j := 1+des to jkel+des do
	  begin
			 gotoxy(60,4+(j-des)); write(frek[(j)]:3);
	  end;
	  chi := 0;
	  for j := 1+des to jkel+des do
	  begin
			 OE[j] := sqr(frek[j]-E[j])/E[j];
			 gotoxy(67,4+(j-des)); write(OE[j]:8:4);
			 chi   := chi + OE[j];
	  end;
	  gotoxy(61,5+jkel); write('äCHIý = ',chi:7:4);
end;

procedure tabelchi;
begin
     dk := jkel-3;
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
	  28   :  chitab := 41.3;  29   :  chitab := 42.6;  30..39   :  chitab := 43.8;
	  40..49   :  chitab := 55.8;  50..59   :  chitab := 67.5;  60..69   :  chitab := 79.1;
	  70..79   :  chitab := 90.5;  80..89   :  chitab := 101.9; 90..99   :  chitab := 118.1;
     end;
end;

procedure faktorial;
begin
     fak1 := 1;
     Npn := (Nbes-nkec) + 1;
     for i := Npn to Nbes do
     begin
          fak1 := fak1 *i;
     end;
	  fak2 := 1;
     for i := 2 to nkec do
	  begin
          fak2 := fak2 *i;
     end;
     fak := fak1/fak2;
end;

procedure SEDrata;
begin
     rkecbes := nkec/Nbes;
     if rkecbes <= 0.05 then
	  begin
          sigmaxbar := sqrt((sqr(sigma)/nkec));
     end else
     begin
          sigmaxbar := sqrt((sqr(sigma)/nkec))*sqrt((Nbes-nkec)/(Nbes-1));
     end;
end;

procedure SESimbak;
begin
     rkecbes := nkec/Nbes;
     if rkecbes <= 0.05 then
     begin
          sigmas := sigma/sqrt(2*nkec);
     end else
     begin
          sigmas := sigma/sqrt(2*nkec)*sqrt((Nbes-nkec)/(Nbes-1));
     end;
end;

procedure SEPop;
begin
     mu := 0;
     for i := 1 to Nbes do
     begin
          mu := mu + x[i];
	  end;
     mu := mu/Nbes;
	  sigmaximu := 0;
     for i := 1 to Nbes do
     begin
          sigmaximu := sigmaximu + sqr((x[i]-mu));
     end;
     sigma := sqrt(sigmaximu/Nbes);
end;

procedure SEProp;
begin
	  SEPop; faktorial;
     jprop := 0;
     for i := 1 to Nbes do
     begin
          if x[i] > batas then
          begin
               prop := 1;
			 end else
          begin
					prop := 0;
          end;
          jprop := jprop + prop;
     end;
     proppop := jprop/Nbes;
     rkecbes := nkec/Nbes;
     if rkecbes <= 0.05 then
     begin
          sigmaxpern := sqrt(proppop*(1-proppop)/nkec);
     end else
	  begin
          sigmaxpern := sqrt((proppop*(1-proppop)/nkec)*
                        ((Nbes-nkec)/(Nbes-1)));
     end;
end;

procedure SEPopf;
begin
     Nbes := 0; mu := 0;
	  for i := 1 to nkec do
     begin
          mu := mu + x[i]*f[i];
          Nbes := Nbes + f[i];
     end;
     sigmafx := mu;
     mu := mu/Nbes;
     sigmaximu := 0;
     for i := 1 to nkec do
     begin
			 sigmaximu := sigmaximu + sqr((x[i]-mu));
     end;
     sigma := sqrt(sigmaximu/Nbes);
end;

procedure SESamp;
begin
	  xbar := 0;
     jx := 0;
	  jx2 := 0;
     for i := 1 to nkec do
     begin
          xbar := xbar + x[i];
          jx   := jx + x[i];
          jx2  := jx2 + sqr(x[i]);
     end;
     xbar := xbar/nkec;
     sigmaxixbar := 0;
     for i := 1 to nkec do
	  begin
          sigmaxixbar := sigmaxixbar + sqr((x[i]-xbar))
     end;
     sbs := sqrt(sigmaxixbar/(nkec-1))
end;

Procedure Tabel_L(var tl : real);
begin
	  if nkec <= 20 then
	  begin
          case nkec of
          4 : tl := 0.381;        5 : tl := 0.337;       6 : tl := 0.319;
          7 : tl := 0.3;          8 : tl := 0.285;       9 : tl := 0.271;
          10: tl := 0.239;        11: tl := 0.249;       12: tl := 0.242;
          13: tl := 0.234;        14: tl := 0.227;       15: tl := 0.220;
          16: tl := 0.213;        17: tl := 0.206;       18: tl := 0.2;
          19: tl := 0.195;        20: tl := 0.19;        25: tl := 0.173;
          30: tl := 0.161;
          end;
	  end else
     begin
          tl := 0.886/sqrt(nkec);
     end;
end;

Procedure Lilliefors;
begin
	  SESamp;
	  gotoxy(1, 3); write('No.');
	  gotoxy(6, 3); write('Xi');
	  gotoxy(17,3); write('Zi');
	  gotoxy(27,3); write('F(Zi)');
	  gotoxy(35,3); write('f(Z<=Zi)  fi      S(Zi)');
	  gotoxy(61,3); write('F(Zi)-S(Zi)');
	  if nkec < 20 then
	  begin
			for i := 1 to nkec do
			begin
				gotoxy(1,3+i); write(i:1,'.');
			end;
	  end;
	  if nkec > 19 then
	  begin
			 gotoxy(6,6);
			 write('Saran :');
			 gotoxy(6,7);
			 write('Karena sampel berukuran besar maka sebaiknya menggunakan');
			 gotoxy(6,8);
			 write('uji normalitas dengan Chiý');
	  end;

	  for i := 1 to nkec do
	  begin
			 gotoxy(5,3+i);
			 if nkec < 20 then
			 write(x[i]:6:3);
			 zb[i] := (x[i]-xbar)/sbs;
			 gotoxy(15,3+i);
			 if nkec < 20 then
			 write(zb[i]:6:3);
	  end;
	  for ii := 1 to nkec do
	  begin
			 sigma   := 1;
			 mu      := 0;
			 itbawah := 0;
			 itatas  := zb[ii];
			 integrasi2;
			 pel[ii] := prob + (ii-ii);
			 tz[ii]  := 0.5 + pel[ii];
			 gotoxy(25,3+ii);
			 if nkec < 20 then
			 write(tz[ii]:7:4)
	  end;
	  for i := 1 to nkec do
	  begin
			 fr := 0;
			 ii := 1;
			 si := 0;
			 repeat
					 if x[i] <= x[ii] then fr := fr + 1;
					 if x[i] = x[ii] then si := si + 1;
					 inc(ii,1);
			 until ii > nkec;
			 fri[i] := si;
			 fr := fr - 1;
			 fr := nkec-fr;
			 fr := fr + (fri[i]-1);
			 propsamp[i] := fr/nkec;
			 gotoxy(37,3+i);
			 if nkec < 20 then
			 write(fr:2,fri[i]:8,propsamp[i]:12:4);
			 Lo[i] := abs(tz[i]-propsamp[i]);
			 gotoxy(64,3+i);
			 if nkec < 20 then
			 write(Lo[i]:6:4)
	  end;
	  makl := Lo[1];
	  for i := 2 to nkec do
	  begin
			 if Lo[i] > makl then makl := Lo[i];
	  end;
	  if nkec < 20 then
	  begin
			gotoxy(53,4+nkec);
			write('L data = ');
			gotoxy(64,4+nkec);
			write(makl:6:4);
	  end else
	  begin
			gotoxy(5,20);
			write('L data = ');
			gotoxy(16,20);
			write(makl:6:4);
	  end;
	  Tabel_L(tl);
	  if nkec < 20 then
	  begin
			gotoxy(5,5+nkec);
			write('Harga kritis L tabel ',nkec,' buah data = ',tl:6:4);
	  end else
	  begin
			gotoxy(5,21);
			write('Harga kritis L tabel ',nkec,' buah data = ',tl:6:4);
	  end;

	  if makl < tl then
	  begin
			 if nkec < 20 then
			 begin
				gotoxy(5,6+nkec);
				write('Karena harga L data < L tabel maka data berdistribusi normal');
			 end else
			 begin
				gotoxy(5,22);
				write('Karena harga L data < L tabel maka data berdistribusi normal');
			 end;
	  end;
	  if makl > tl then
	  begin
			 if nkec < 20 then
			 begin
				gotoxy(5,6+nkec);
				write('Karena harga L data > L tabel maka data berdistribusi tidak normal');
			 end else
			 begin
				gotoxy(5,22);
				write('Karena harga L data > L tabel maka data berdistribusi tidak normal');
			 end;
     end;
end;

procedure SESampf;
begin
     Nbes := 0; xbar := 0;
     for i := 1 to nkec do
     begin
          xbar := xbar + x[i]*f[i];
          Nbes := Nbes + f[i];
     end;
     sigmafx := xbar;
	  xbar := xbar/Nbes;
	  sigmaxixbar := 0;
     for i := 1 to nkec do
     begin
          sigmaxixbar := sigmaxixbar + sqr((x[i]-xbar))
	  end;
     sbs := sqrt(sigmaxixbar/(Nbes-1))
end;

procedure Distribusi_sampling_rata2;
begin
     SEPop; writeln; faktorial;
     sangs := 0; muxbar := 0;
     for i := 1 to trunc(fak) do
     begin
          for j := 1 to nkec do
          begin
               gotoxy(1,4); write('Skore sampel S',i,'',angs[j],' = ');
               readln(s[i,j]);
					gotoxy(1,4); write('                                     ');
					sangs := sangs + s[i,j];
               sangs := sangs/nkec;
          end;
          muxbar := muxbar + sangs;
			 writeln;
     end;
     muxbar := muxbar/fak;
end;

procedure SERataGab;
begin
     sigmapern := 0; muselgab := 0; mujumgab := 0;
     pqperngab := 0; muselpropgab := 0; mujumpropgab  := 0;
     for i := 1 to macpop do
     begin
          sigmapern     := sigmapern + sqr(sigmagab[i])/nkecgab[i];
          sigmaper2n    := sigmaper2n + sqr(sigmagab[i])/(2*nkecgab[i]);
          pqperngab     := pqperngab + (propgab[i]*(1-propgab[i]))/
									nkecgab[i];
			 muselgab      := mugab[i] - muselgab;
          mujumgab      := mujumgab + mugab[i];
          muselpropgab  := propgab[i] - muselpropgab;
          mujumpropgab  := mujumpropgab + propgab[i];
	  end;
     muselgab      := -muselgab;
     muselpropgab  := -muselpropgab;
     sigmaxbargab  := sqrt(sigmapern);
     sigmasgab     := sqrt(sigmaper2n);
	  sigmaxperngab := sqrt(pqperngab);
end;

procedure Simpson(atas,bawah : real; var total : extended);
     function Fx(xi : real) : extended;
     var normal,zet : real;
         expon      : extended;
     begin
          normal := sigma*sqrt(2*pi);
			 zet    := sqr((xi-mu)/sigma);
			 expon  := exp(-0.5*zet);
          Fx     := (1/normal)*expon;
     end;
begin
	  bagian := 2; j := 1;
     delx := (atas-bawah)/bagian;
     ganjil := fx(bawah+delx);
     genap := 0;
     akhir := Fx(bawah)+Fx(atas);
	  total := (akhir+4*ganjil)*delx/3;
     repeat
           bagian := bagian*2;
           total1 := total;
           delx := (atas-bawah)/bagian;
           genap := genap + ganjil;
           ganjil := 0;
           for i := 1 to (bagian div 2) do
           begin
					 xi := bawah + delx*(2.0*i-1.0);
					 ganjil := ganjil + Fx(xi);
           end;
           total := (akhir + 4*ganjil+2*genap)* delx/3;
           j := j + 1;
	  until abs(total - total1) <= abs(toleransi*total);
end;

procedure integrasi1;
begin
	  menu2(Nbes);
     SEPop;
     simpson(itatas,itbawah,segmen);
     prob := segmen;
end;

procedure integrasi2;
begin
     simpson(itatas,itbawah,segmen);
	  prob := (segmen);
end;

procedure display_data(nama : string; var ndp : Integer);
var namaf : string[20];
begin
     gotoxy(45,4); write('Data pilihan ',upcase(opsi));
     namaf := nama;
     gotoxy(60,4); write(' file : ',namaf);
     if ndp < 39 then
	  begin
          for i := 1 to ndp do
          begin
               if i < 20 then
               begin
                    gotoxy(45,i+4); writeln(i,'. ');
                    gotoxy(50,i+4); writeln(x[i]:3:2);
               end else
               begin
						  gotoxy(60,i-15); writeln(i,'. ');
						  gotoxy(65,i-15); writeln(x[i]:3:2);
					end;
          end;
     end else
	  begin
          for i := 1 to ndp do
          begin
               if i < 20 then
               begin
						  gotoxy(45,i+4); writeln(i,'. ');
                    gotoxy(50,i+4); writeln(x[i]:3:2);
               end else
               begin
                    if (i >= 20) and (i < 38) then
                    begin
                         gotoxy(60,i-15); writeln(i,'. ');
                         gotoxy(65,i-15); writeln(x[i]:3:2);
                    end else
						  begin
								 if i = 38 then
								 begin
                              gotoxy(60,23);
                              writeln('38.  Dst ...');
								 end;
                         if i > 38 then
                         begin
                         end;
                    end;
					end;
          end;
     end;
	  ng := ndp+4;
	  if ndp > 20  then ng := 23;
     for i := 2 to ng do
     begin
          gotoxy(40,i); writeln('+');
     end;
end;

procedure ketab1;
begin
	  gotoxy(15,1); write('TABEL Z : Luas di bawah lengkungan normal standar 0 - Z');
	  gotoxy(5,5); write('0'); gotoxy(5,7); write('1'); gotoxy(5,9); write('2');
	  gotoxy(5,11); write('3'); gotoxy(5,13); write('4'); gotoxy(5,15); write('5');
	  gotoxy(5,17); write('6'); gotoxy(5,19); write('7'); gotoxy(5,21); write('8');
     gotoxy(5,23); write('9'); gotoxy(5,3);  write('Z');
     for i := 4 to 80 do
	  begin
          gotoxy(i,4); write('Ä'); gotoxy(i,2); write('Ä'); gotoxy(i,24); write('Ä');
     end;
     for i := 3 to 23 do
     begin
          gotoxy(7,i); write('³'); gotoxy(3,i); write('³'); gotoxy(80,i); write('³');
     end;
end;

procedure ketab2;
begin
	  gotoxy(15,1); write('TABEL Z : Luas di bawah lengkungan normal standar 0 - Z');
     gotoxy(15,3); write('0'); gotoxy(22,3); write('1'); gotoxy(29,3); write('2');
     gotoxy(36,3); write('3'); gotoxy(43,3); write('4'); gotoxy(50,3); write('5');
     gotoxy(57,3); write('6'); gotoxy(64,3); write('7'); gotoxy(71,3); write('8');
     gotoxy(78,3); write('9'); gotoxy(5,3);  write('Z');
     for i := 4 to 80 do
     begin
          gotoxy(i,4); write('Ä'); gotoxy(i,2); write('Ä'); gotoxy(i,24); write('Ä');
	  end;
     for i := 3 to 23 do
     begin
          gotoxy(7,i); write('³'); gotoxy(2,i); write('³'); gotoxy(80,i); write('³');
     end;
end;

begin
	  10:
	  clrscr;
          Hapus_layar;
	  repeat
	  clrscr;
	  warna(0,0,80,25,black);
	  menu1;
	  warna(0,0,80,25,black);
	  if pilih = 0 then HALT;
	  if pilih = 1 then
	  begin
			 menu2(Nbes);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(Nbes);
			 '2': Load_data1(Nbes);
			 end;
			 tampilan('Simpangan baku populasi');
			 display_data(namaf,Nbes);
			 SEPop;
			 gotoxy(1,5); writeln('Ukuran populasi           = ',Nbes);
			 gotoxy(1,6); writeln('Rata-rata populasi        = ',mu:3:4);
			 gotoxy(1,7); writeln('Standar error populasi    = ',sigma:3:4);
			 gotoxy(1,8); writeln('Data minimal              = ',min:3:4);
			 gotoxy(1,9); writeln('Data maksimal             = ',mak:3:4);
	  end;
	  if pilih = 3 then
	  begin
			 menu2(nkec);
			 pmenu := readkey;
			 case pmenu of
			 '0' : goto 10;
			 '1' : Enter_data2(nkec);
			 '2' : Load_data2(nkec);
			 end;
			 tampilan('Simpangan baku distribusi populasi');
			 display_data(namaf,nkec);
			 SEPopf;
			 gotoxy(1,5); writeln('Jumlah populasi           = ',nkec);
			 gotoxy(1,6); writeln('Ukuran populasi           = ',Nbes);
			 gotoxy(1,7); writeln('Jumlah f * x              = ',sigmafx:3:4);
			 gotoxy(1,8); writeln('Rata-rata populasi        = ',mu:3:4);
			 gotoxy(1,9); writeln('Standar error populasi    = ',sigma:3:4);
	  end;
	  if pilih = 2 then
	  begin
			 menu2(nkec);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nkec);
			 '2': Load_data1(nkec);
			 end;
			 tampilan('Simpangan baku sampel');
			 display_data(namaf,nkec);
			 SESamp;
			 gotoxy(1,5); write('Ukuran sampel           = ',nkec);
			 gotoxy(1,6); write('Rata-rata sampel        = ',xbar:3:4);
			 gotoxy(1,7); write('Standar error sampel    = ',sbs:3:4);
			 gotoxy(1,8); write('Variansi sampel         = ',sqr(sbs):3:4);
			 gotoxy(1,9); write('Data minimal            = ',min:3:4);
			 gotoxy(1,10);write('Data maksimal           = ',mak:3:4);
			 gotoxy(1,11);write('Jumlah X                = ',jx:3:4);
			 gotoxy(1,12);write('Jumlah Xý               = ',jx2:3:4);
	  end;
	  if pilih = 4 then
	  begin
			 menu2(nkec);
			 pmenu := readkey;
			 case pmenu of
			 '0' : goto 10;
			 '1' : Enter_data2(nkec);
			 '2' : Load_data2(nkec);
			 end;
			 tampilan('Simpangan baku distribusi sampel');
			 display_data(namaf,nkec);
			 SESampf;
			 gotoxy(1,5); write('Jumlah sampel           = ',nkec);
			 gotoxy(1,6); write('Ukuran sampel           = ',Nbes);
			 gotoxy(1,7); write('Jumlah f * x            = ',sigmafx:3:4);
			 gotoxy(1,8); write('Rata-rata sampel        = ',xbar:3:4);
			 gotoxy(1,9); write('Standar error sampel    = ',sbs:3:4);
	  end;
	  if pilih = 5 then
	  begin
			 menu2(Nbes);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(Nbes);
			 '2': Load_data1(Nbes);
			 end;
			 nkec := Nbes;
			 tampilan('Rata-rata distribusi rata-rata');
			 Distribusi_sampling_rata2;
			 display_data(namaf,Nbes);
			 SEDrata;
			 gotoxy(1,6); writeln('Ukuran sampel             = ',nkec);
			 gotoxy(1,7); writeln('Banyaknya sampel          = ',fak:3:0);
			 gotoxy(1,8); writeln('Rata-rata populasi        = ',mu:3:4);
			 gotoxy(1,9); writeln('Standar error populasi    = ',sigma:3:4);
			 gotoxy(1,10);writeln('Rerata distribusi rerata  = ',muxbar:3:4);
			 gotoxy(1,11);writeln('Standar error rata-rata   = ',sigmaxbar:3:6);
	  end;
	  if pilih = 6 then
	  begin
			 menu2(Nbes);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nbes);
			 '2': Load_data1(nbes);
			 end;
			 clrscr;
			 tampilan('Simpangan baku distribusi rata-rata');
			 gotoxy(20, 3); write('                                           ');
			 gotoxy(20, 3); write('Ukuran sampel    = '); readln(nkec);
			 tampilan('Simpangan baku distribusi rata-rata');
			 display_data(namaf,Nbes);
			 SEPop;
			 faktorial;
			 SEDrata;
			 gotoxy(1,5); writeln('Ukuran populasi           = ',Nbes);
			 gotoxy(1,6); writeln('Ukuran sampel             = ',nkec);
			 gotoxy(1,7); writeln('Banyaknya sampel          = ',fak:0:0);
			 gotoxy(1,8); writeln('Rata-rata populasi        = ',mu:3:4);
			 gotoxy(1,9); writeln('Standar error populasi    = ',sigma:3:4);
			 gotoxy(1,10);writeln('Standar error rata-rata   = ',sigmaxbar:3:4);
	  end;
	  if pilih = 7 then
	  begin
			 menu2(Nbes);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nbes);
			 '2': Load_data1(nbes);
			 end;
			 clrscr;
			 tampilan('Simpangan baku simpangan baku');
			 gotoxy(20, 3); write('                                           ');
			 gotoxy(20,3); write('Ukuran sampel   = '); readln(nkec);
			 tampilan('Simpangan baku simpangan baku');
			 display_data(namaf,Nbes);
			 SEPop;
			 faktorial;
			 SESimbak;
			 gotoxy(1,5); writeln('Ukuran populasi              = ',Nbes);
			 gotoxy(1,6); writeln('Ukuran sampel                = ',nkec);
			 gotoxy(1,7); writeln('Banyaknya sampel             = ',fak:0:0);
			 gotoxy(1,8); writeln('Rata-rata populasi           = ',mu:3:4);
			 gotoxy(1,9); writeln('Standar error populasi       = ',sigma:3:4);
			 gotoxy(1,10);writeln('Standar error simpangan baku = ',sigmas:3:4);
	  end;
	  if pilih = 8 then
	  begin
			 menu2(Nbes);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nbes);
			 '2': Load_data1(nbes);
			 end;
			 clrscr;
			 tampilan('Simpangan baku proporsi');
			 gotoxy(20, 2); write('                      ');
			 gotoxy(20, 2); write('Ukuran sampel   = '); readln(nkec);
			 gotoxy(20, 3); write('Ukuran batas    = '); readln(batas);
			 tampilan('Simpangan baku proporsi');
			 display_data(namaf,Nbes);
			 SEProp;
			 faktorial;
			 gotoxy(1,5); writeln('Ukuran populasi              = ',Nbes);
			 gotoxy(1,6); writeln('Ukuran sampel                = ',nkec);
			 gotoxy(1,7); writeln('Banyaknya sampel             = ',fak:0:0);
			 gotoxy(1,8); writeln('Ukuran batas                 = ',batas:3:4);
			 gotoxy(1,9); writeln('Rata-rata populasi           = ',mu:3:4);
			 gotoxy(1,10);writeln('Standar error populasi       = ',sigma:3:4);
			 gotoxy(1,11);writeln('Proporsi populasi            = ',proppop:3:4);
			 gotoxy(1,12);writeln('Standar error proporsi       = ',sigmaxpern:3:4);
	  end;
	  if pilih = 9 then
	  begin
			 clrscr;
			 tampilan('Simpangan baku populasi gabungan');
			 gotoxy(20, 3); write('Macam populasi           = '); readln(macpop);
			 clrscr;
			 for i := 1 to macpop do
			 begin
					clrscr;
					gotoxy(20, 4); write('Ukuran sampel ',i,'          = '); readln(nkecgab[i]);
					gotoxy(20, 5); write('Rata-rata populasi ',i,'     = '); readln(mugab[i]);
					gotoxy(20, 6); write('Harga sigma populasi ',i,'   = '); readln(sigmagab[i]);
					gotoxy(20, 7); write('Proporsi populasi ',i,'      = '); readln(propgab[i]);
					writeln;
			 end;
			 tampilan('Simpangan baku populasi gabungan');
			 SERataGab;
			 gotoxy(1,5); writeln('Ukuran populasi                         = ',macpop);
			 for i := 1 to macpop do
			 begin
					gotoxy(1,5+i); writeln('Ukuran sampel ',i,'                         = ',nkecgab[i]);
					gotoxy(1,7+i); writeln('Rata-rata populasi         ',i,'            = ',mugab[i]:3:4);
					gotoxy(1,9+i); writeln('Standar error populasi            ',i,'     = ',sigmagab[i]:3:4);
					gotoxy(1,11+i);writeln('Proporsi populasi           ',i,'           = ',propgab[i]:3:4);
					writeln;
			 end;
			 gotoxy(1,15); writeln('Rata-rata distribusi selisih rata-rata  = ',muselgab:3:4);
			 gotoxy(1,16); writeln('Rata-rata distribusi jumlah rata-rata   = ',mujumgab:3:4);
			 gotoxy(1,17); writeln('Rata-rata selisih proporsi gabungan     = ',muselpropgab:3:4);
			 gotoxy(1,18); writeln('Rata-rata jumlah proporsi gabungan      = ',mujumpropgab:3:4);
			 gotoxy(1,19); writeln('Standar error rata-rata gabungan        = ',sigmaxbargab:3:4);
			 gotoxy(1,20); writeln('Standar error simpangan baku gabungan   = ',sigmasgab:3:4);
			 gotoxy(1,21); writeln('Standar error proporsi gabungan         = ',sigmaxperngab:3:4);
	  end;
	  if pilih = 10 then
	  begin
			 menu2(Nbes);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nbes);
			 '2': Load_data1(nbes);
			 end;
			 clrscr;
			 tampilan('Probabilitas data 1');
			 gotoxy(20,3);  write('Data terrendah               = ',min:3:4);
			 gotoxy(20,4);  write('Data tertinggi               = ',mak:3:4);
			 gotoxy(20,6);  write('Rata-rata                    = ',mu:3:3);
			 gotoxy(20,7);  write('Standar error                = ',sigma:3:4);
			 gotoxy(20,9);  write('Batas bawah integral         = '); readln(itbawah);
			 gotoxy(20,10); write('Batas atas integral          = '); readln(itatas);
			 integrasi1;
			 clrscr;
			 tampilan('Probabilitas data 1');
			 display_data(namaf,Nbes);
			 gotoxy(1,5);  writeln('Ukuran populasi              = ',Nbes);
			 gotoxy(1,6);  writeln('Rata-rata populasi           = ',mu:3:3);
			 gotoxy(1,7);  writeln('Standar error populasi       = ',sigma:3:4);
			 gotoxy(1,8);  writeln('Batas bawah nilai            = ',itbawah:3:3);
			 gotoxy(1,9);  writeln('Batas atas nilai             = ',itatas:3:2);
			 gotoxy(1,10); writeln('Probabilitas data            = ',prob:3:4);
	  end;
	  if pilih = 11 then
	  begin
			 clrscr;
			 tampilan('Uji normalitas dengan Chiý');
          gotoxy(20, 3); write('Harga Standard Error           = '); readln(sigma);
          gotoxy(20, 4); write('Harga rata-rata                = '); readln(mu);
          gotoxy(20, 5); write('Batas bawah integral tertentu  = '); readln(itbawah);
          gotoxy(20, 6); write('Batas atas integral tertentu   = '); readln(itatas);
          tampilan('Probabilitas data 1');
          integrasi2;
          gotoxy(1,6);  writeln('Rata-rata populasi           = ',mu:3:3);
          gotoxy(1,7);  writeln('Standar error populasi       = ',sigma:3:4);
          gotoxy(1,8);  writeln('Batas bawah nilai            = ',itbawah:3:3);
          gotoxy(1,9);  writeln('Batas atas nilai             = ',itatas:3:3);
          gotoxy(1,10); writeln('Probabilitas data            = ',prob:3:4);
	  end;
     if pilih = 12 then
     begin
					 clrscr;
					 sigma   := 1;
					 mu      := 0;
					 itbawah := 0;
					 tampilan('Probabilitas Z tertentu');
					 gotoxy(1,4); write('Probabilitas untuk harga Z tertentu : ');
					 gotoxy(1,7); write('Probabilitas untuk Z                = ');
					 gotoxy(1,6); write('Harga Z                             =    '); readln(itatas);
					 integrasi2;
					 gotoxy(1,4); write('Probabilitas untuk harga Z tertentu : ');
					 gotoxy(1,6); write('Harga Z                             = ',itatas:3:8);
					 gotoxy(1,7); write('Probabilitas untuk Z                = ',prob:3:8);
	  end;
	  if pilih = 13 then
	  begin
			 clrscr;
			 tampilan('Tabel Z');
			 writeln('Pilihan :');
			 writeln;
          writeln('1. Display di monitor 1');
          writeln('2. Display di monitor 2');
          writeln('3. Cetak di printer');
          writeln;
          write('Pilihan : '); readln(pilih);
          clrscr;
          cmati;
          if pilih = 1 then
          begin
               sigma   := 1;
               mu      := 0;
               itbawah := 0;
               gotoxy(3,5);  write('0.0'); gotoxy(3,7);   write('0.1');
               gotoxy(3,9);  write('0.2'); gotoxy(3,11);  write('0.3');
               gotoxy(3,13); write('0.4'); gotoxy(3,15);  write('0.5');
               gotoxy(3,17); write('0.6'); gotoxy(3,19);  write('0.7');
					gotoxy(3,21); write('0.8'); gotoxy(3,23);  write('0.9');
               itatas := 0;
               probii := 0;
               ketab2;
               repeat
                     itatas := 0.1*probii;
                     probi := 0;
                     repeat
                           integrasi2;
                           pel[probi] := prob + (probi-probi);
                           itatas := itatas + 0.01;
                           gotoxy(10+probi*7,probii*2+5);
                           write(pel[probi]:4:4);
                           probi := probi + 1;
                     until itatas >= (probii+1)*0.1;
                     probii := probii + 1;
               until itatas >= 1.0;
               gotoxy(35,25); write('Continued ...');
               readln; clrscr;
					gotoxy(3,5);  write('1.0'); gotoxy(3,7);   write('1.1');
               gotoxy(3,9);  write('1.2'); gotoxy(3,11);  write('1.3');
               gotoxy(3,13); write('1.4'); gotoxy(3,15);  write('1.5');
               gotoxy(3,17); write('1.6'); gotoxy(3,19);  write('1.7');
               gotoxy(3,21); write('1.8'); gotoxy(3,23);  write('1.9');
               sigma   := 1;
               mu      := 0;
               itbawah := 0;
               itatas  := 1.0;
               probii  := 0;
               ketab2;
               repeat
                     itatas := 1+0.1*probii;
                     probi := 0;
                     repeat
                           integrasi2;
                           pel[probi] := prob + (probi-probi);
                           itatas := itatas + 0.01;
                           gotoxy(10+probi*7,probii*2+5);
									write(pel[probi]:4:4);
                           probi := probi + 1;
                     until itatas >= ((probii+1)*0.1)+1;
                     probii := probii + 1;
               until itatas >= 2.0;
               gotoxy(35,25); write('Continued ...');
               readln; clrscr;
               gotoxy(3,5);  write('2.0'); gotoxy(3,7);   write('2.1');
               gotoxy(3,9);  write('2.2'); gotoxy(3,11);  write('2.3');
               gotoxy(3,13); write('2.4'); gotoxy(3,15);  write('2.5');
               gotoxy(3,17); write('2.6'); gotoxy(3,19);  write('2.7');
               gotoxy(3,21); write('2.8'); gotoxy(3,23);  write('2.9');
               sigma   := 1;
               mu      := 0;
               itbawah := 0;
               itatas  := 2.0;
               probii  := 0;
               ketab2;
               repeat
							itatas := 2+0.1*probii;
                     probi  := 0;
                     repeat
                           integrasi2;
                           pel[probi] := prob + (probi-probi);
                           itatas := itatas + 0.01;
                           gotoxy(10+probi*7,probii*2+5);
                           write(pel[probi]:4:4);
                           probi := probi + 1;
                     until itatas >= ((probii+1)*0.1)+2-0.01;
                     probii := probii + 1;
               until itatas >= 3.0-0.01;
               gotoxy(35,25); write('Continued ...');
               readln; clrscr;
               gotoxy(3,5);  write('3.0'); gotoxy(3,7);   write('3.1');
               gotoxy(3,9);  write('3.2'); gotoxy(3,11);  write('3.3');
               gotoxy(3,13); write('3.4'); gotoxy(3,15);  write('3.5');
               gotoxy(3,17); write('3.6'); gotoxy(3,19);  write('3.7');
               gotoxy(3,21); write('3.8'); gotoxy(3,23);  write('3.9');
					sigma := 1;
               mu := 0;
               itbawah := 0;
               itatas := 3.0;
               probii := 0;
               ketab2;
               repeat
                     itatas := 3+0.1*probii;
                     probi := 0;
                     repeat
                           integrasi2;
                           pel[probi] := prob + (probi-probi);
                           itatas := itatas + 0.01;
                           gotoxy(10+probi*7,probii*2+5);
                           write(pel[probi]:4:4);
                           probi := probi + 1;
                     until itatas >= ((probii+1)*0.1)+3-0.01;
                     probii := probii + 1;
               until itatas >= 4.0-0.01;
			 end;
          if pilih = 3 then
          begin
               writeln(lst,'  TABEL Z :');
               writeln(lst);
               write(lst,'0':8,'1':8,'2':8,'3':8,'4':8,'5':8,'6':8,'7':8,'8':8,'9':8);
               sigma := 1;
               mu := 0;
               itbawah := 0;
               itatas := 0;
               probi := 0;
               repeat
                     integrasi2;
                     pel[probi] := prob + (probi-probi);
                     itatas := itatas + 0.01;
                     write(lst,pel[probi]:8:4);
                     inc(probi);

               until itatas >= 4.5-0.01;
			 end;
          if pilih = 2 then
          begin
               gotoxy(1,3);
               write('0.0':12,'0.1':7,'0.2':7,'0.3':7,'0.4':7,'0.5':7,'0.6':7);
               write('0.7':7 ,'0.8':7,'0.9':7);
               sigma := 1; mu := 0; itbawah := 0;
               itatas := 0;  probii := 0;
               ketab1;
               repeat
                     itatas := 0.1*probii; probi := 0;
                     repeat
                           integrasi2;
                           pel[probi] := prob + (probi-probi);
                           itatas := itatas + 0.01;
                           gotoxy(10+probii*7,probi*2+5);
                           write(pel[probi]:4:4);
                           probi := probi + 1;
                     until itatas >= (probii+1)*0.1;
							probii := probii + 1;
               until itatas >= 1.0;
               gotoxy(35,25); write('Continued ...');
               readln; clrscr;
               gotoxy(1,3);
               write('1.0':12,'1.1':7,'1.2':7,'1.3':7,'1.4':7,'1.5':7,'1.6':7);
               write('1.7':7 ,'1.8':7,'1.9':7);
               sigma := 1; mu := 0; itbawah := 0;
               itatas := 1.0;  probii := 0;
               ketab1;
               repeat
                     itatas := 1+0.1*probii; probi := 0;
                     repeat
                           integrasi2;
                           pel[probi] := prob + (probi-probi);
                           itatas := itatas + 0.01;
                           gotoxy(10+probii*7,probi*2+5);
                           write(pel[probi]:4:4);
                           probi := probi + 1;
							until itatas >= ((probii+1)*0.1)+1;
                     probii := probii + 1;
               until itatas >= 2.0;
               gotoxy(35,25); write('Continued ...');
               readln; clrscr;
               gotoxy(1,3);
               write('2.0':12,'2.1':7,'2.2':7,'2.3':7,'2.4':7,'2.5':7,'2.6':7);
               write('2.7':7 ,'2.8':7,'2.9':7);
               sigma := 1; mu := 0; itbawah := 0;
               itatas := 2.0;  probii := 0;
               ketab1;
               repeat
                     itatas := 2+0.1*probii; probi := 0;
                     repeat
                           integrasi2;
                           pel[probi] := prob + (probi-probi);
                           itatas := itatas + 0.01;
                           gotoxy(10+probii*7,probi*2+5);
                           write(pel[probi]:4:4);
									probi := probi + 1;
                     until itatas >= ((probii+1)*0.1)+2-0.01;
                     probii := probii + 1;
               until itatas >= 3.0-0.01;
               gotoxy(35,25); write('Continued ...');
               readln; clrscr;
               gotoxy(1,3);
               write('3.0':12,'3.1':7,'3.2':7,'3.3':7,'3.4':7,'3.5':7,'3.6':7);
               write('3.7':7 ,'3.8':7,'3.9':7);
               sigma := 1; mu := 0; itbawah := 0;
               itatas := 3.0;  probii := 0;
               ketab1;
               repeat
                     itatas := 3+0.1*probii; probi := 0;
                     repeat
                           integrasi2;
                           pel[probi] := prob + (probi-probi);
                           itatas := itatas + 0.01;
                           gotoxy(10+probii*7,probi*2+5);
									write(pel[probi]:4:4);
                           probi := probi + 1;
                     until itatas >= ((probii+1)*0.1)+3-0.01;
                     probii := probii + 1;
               until itatas >= 4.0-0.01;
          end;
	  end;
	  if pilih = 14 then
	  begin
			 menu2(nbes);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nbes);
			 '2': Load_data1(nbes);
			 end;
			 clrscr;
			 printing;
			 if ps = '0' then goto 10;
			 clrscr;
			 if pilih = 14 then
			 begin
					cbesar;
					tampilan('Uji normalitas dengan Chiý');
					gotoxy(20,3);  write('Angka desimal data = '); readln(des);
					gotoxy(20,4);  write('Jumlah kelas sendiri atau otomatis - (S/O) ? ');
					readln(jk);
					if upcase(jk) = 'S' then
					begin
						gotoxy(20,5);  write('Jumlah kelas       = '); readln(jkel);
					end;
					if upcase(jk) = 'O' then
					begin
						jkel := round(1 + 3.322*(ln(nbes)/ln(10)));
						gotoxy(20,5);  write('Jumlah kelas       = ',jkel:3);
					end;
					gotoxy(20,6);  write('Data terrendah     = ',min:3:4);
					gotoxy(20,7);  write('Data tertinggi     = ',mak:3:4);
					gotoxy(20,9);  write('Anda ingin memasukkan data terendah dan');
					gotoxy(20,10); write('data tertinggi yang baru ?');
					gotoxy(20,11); write('Tekan Y atau T ! ');
               opsi2 := readkey;
               if upcase(opsi2) = 'Y' then
               begin
						  gotoxy(20,13); write('Data terrendah     = '); readln(angka_r);
						  gotoxy(20,14); write('Data tertinggi     = '); readln(angka_t);
					end else
					begin
						  angka_r := min;
						  angka_t := mak;
					end;
			 end;
			 tampilan('Uji normalitas dengan Chiý');
			 display_data(namaf,nbes);
			 SEPop;
			 {SESamp;}
			 case des of
			 0 : des1 := 1;
			 1 : des1 := 10;
			 2 : des1 := 100;
			 3 : des1 := 1000;
			 4 : des1 := 10000;
			 end;
			 interval := ((angka_t-angka_r)/jkel);
			 interval := round(des1*interval);
			 gotoxy(1,5);  writeln('Ukuran sampel               = ',nbes);
			 gotoxy(1,6);  writeln('Jumlah kelas                = ',jkel);
			 gotoxy(1,7);  writeln('Data terrendah              = ',min:3:4);
			 gotoxy(1,8);  writeln('Data tertinggi              = ',mak:3:4);
			 gotoxy(1,9);  writeln('interval                    = ',interval:3:4);
			 gotoxy(1,10); writeln('Rata-rata sampel            = ',xbar:3:4);
			 gotoxy(1,11); writeln('Standar error sampel        = ',sbs:3:4);
			 terus;
			 tampilan('Uji normalitas dengan Chiý');
			 repeat
					 normalitas;
					 if frektot < Nbes then jkel := jkel + 1;
			 until (frektot = Nbes);
			 if des = 1 then jkel := jkel-1;
			 if des = 2 then jkel := jkel-2;
			 gotoxy(1,3);
			 writeln('Kelas   Int. Data      xi   fi      xiý     fi*xi         fi*xiý ');
			 for j := des to (jkel+des)-1 do
			 begin
					gotoxy(1,4+j);  write((j+1)-des:3,'.');
					if j = des then k[j+1,1] := angka_r;
					gotoxy(8,4+j);  write(k[j+1,1]:3:2,' - ',k[j+1,2]:3:2);
					gotoxy(21,4+j); write(xt[j+1]:6:1);
					gotoxy(27,4+j); write(frek[j+1]:4);
					gotoxy(35,4+j); write(xtt[j+1]:4:2);
					gotoxy(45,4+j); write(fixt[j+1]:4:2);
					gotoxy(59,4+j); write(fixtt[j+1]:5:2);
			 end;
			 gotoxy(27,5+(jkel+des-1)); write(frektot:4);
			 gotoxy(45,5+(jkel+des-1)); write(sft:4:2);
			 gotoxy(58,5+(jkel+des-1)); write(sftt:5:2);
			 sbs := sqrt(((nbes*sftt)-(sqr(sft)))/(nbes*(nbes-1)));
			 gotoxy(1,7+jkel); write('Rerata sampel  = ',sft/nbes:3:4);
			 gotoxy(1,8+jkel); write('SE sampel      = ',sbs:3:4);
			 if ps = '2' then intr(5,reg);
			 terus;
			 tampilan('Uji normalitas dengan Chiý');
			 normal;
          tampilan('Uji normalitas dengan Chiý');
          chisquare;
          tabelchi;
			 gotoxy(1,7+jkel); write('ÄÄ¯ CHIý(0,95)(dk = ',jkel-3,' ) = ',chitab:7:2);
			 if (chi <= chitab) then
			 begin
					gotoxy(1,8+jkel); write('ÄÄ¯ Karena CHIý data ó CHIý (0,95) dengan dk = ',jkel-3,',');
					gotoxy(1,9+jkel); write('ÄÄ¯ maka data dikatakan berdistribusi normal');
					gotoxy(1,10+jkel); write('ÄÄ¯ pada derajat konfidensi 95 % atau taraf signifikansi 5 %.');
			 end else
			 begin
					gotoxy(1,8+jkel); write('ÄÄ¯ Karena CHIý data > CHIý (0,95) dengan dk = ',jkel-3,',');
					gotoxy(1,9+jkel); write('ÄÄ¯ maka data dikatakan tidak berdistribusi normal');
					gotoxy(1,10+jkel); write('ÄÄ¯ pada derajat konfidensi 95 % atau taraf signifikansi 5 %.');
          end;
          if ps = '2' then intr(5,reg);
     end;
     if pilih = 15 then
     begin
                menu2(nkec);
                pmenu := readkey;
                case pmenu of
                '0': goto 10;
                '1': Enter_data1(nkec);
                '2': Load_data1(nkec);
                end;
                clrscr;
					 printing;
                if ps = '0' then goto 10;
                clrscr;
                tampilan('Uji Lilliefors');
                display_data(namaf,nkec);
                SESamp;
                gotoxy(1,5); write('Ukuran sampel           = ',nkec);
                gotoxy(1,6); write('Rata-rata sampel        = ',xbar:3:4);
                gotoxy(1,7); write('Standar error sampel    = ',sbs:3:4);
                gotoxy(1,8); write('Data minimal            = ',min:3:4);
                gotoxy(1,9); write('Data maksimal           = ',mak:3:4);
                terus;
                tampilan('Uji Lilliefors');
                Lilliefors;
                if ps = '2' then intr(5,reg);
     end;
     ulang;
     gelap;
     until (upcase(opsi) = 'x') or (upcase(opsi) = 'X') or (upcase(lagi) = 't') or (upcase(lagi) = 'T');
end.