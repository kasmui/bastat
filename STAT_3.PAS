{$N+}{$M 8000,0,0}
Program statistika_eksloratif_komparatif;
uses printer,crt,dos,stat_gam,stat_m;
type
    datar = array[1..200] of real;
     screentype   = (mono,color);
const
     toleransi  = 1.0e-5;
     tol        = 1e-5;

var
   reg : registers;
   x,y,w                              : datar;
   sigma,sbs,xxbar,xsbs,yxbar,ysbs,xbar,mu,sigmaxbar,sigmaximu,
   sigmaxixbar,sigmas,batas,proppop,jprop,atas,proppop1,proppop2,
   bawah,itatas,itbawah,ttatas,ttbawah,akhir,
   delx,genap,ganjil,total,total1,xx,xi,prob,ft,
   ftt,sft,sftt,min,mak,minl,makl,chi,chi2,t,ts,
   ct,ct1,ct2,zd,td,cd,tl,pelp,pelm,pel1,pel2,pnol              : real;
   segmen                                       : extended;
	prop,i,j,ii,jj,Nbes,nkec,bagian,
   datum,pilih,dk,xndp,yndp,ndp,cnt                       : integer;
   nama,namaf                                   : string[10];
   dopsi                                        : string[1];
   opsi,opsi2,opsi3,opsi4,opsi5,lagi,pmenu: char;
   ps,answer,uopsi1,uopsi2,uopsi3,uopsi4,uopsi5           : char;
   pp,pt,py,nu                                  : byte;
   taua,taub,tau,xa,xbx,tperv,pang,pangkat      : extended;
   s1,s2,minx,miny,makx,maky                          : real;
   stype : screentype;

Label 10,20,30,40,50;

procedure Hapus_layar;
begin
	  clrscr;
	  textbackground(black);
	  textcolor(white);
end;


procedure printing;
begin
     clrscr;
	  textbackground(7);
     textcolor(white);
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
	  for i := 1 to 78 do write(' ');
	  gotoxy(1,1);
	  write(st);
	  gotoxy(45,1); write('<<<<< Basic Statistics 1.1 >>>>>');
	  textbackground(black);
	  textcolor(white);
	  gotoxy(1,2);
	  writeln('==============================================================================');
	  textbackground(black);
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
	readln;
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
	opsi := readkey;
end;

procedure min_mak(datum : integer; var min,mak : real);
var i : integer;
begin
	  datum := ndp;
	  min := x[1];
	  mak := x[1];
	  for i := 2 to datum do
     begin
          if x[i] < min then min := x[i];
          if x[i] > mak then mak := x[i];
     end;
     minx := min;
     makx := mak;
     min := y[1];
     mak := y[1];
     for i := 2 to datum do
     begin
          if y[i] < min then min := y[i];
          if y[i] > mak then mak := y[i];
     end;
     miny := min;
     maky := mak;
end;

    procedure input(var ndp : integer);
    type
		  kata   = string[10];
        freal  = file of real;
        fint   = file of integer;
        fkata  = file of kata;
    var nama    : kata;
        fk      : fkata;
        fi      : fint;
        frx,fry : freal;

    begin
         clrscr;
         Cbesar;
         textbackground(black);
	 textcolor(white);
	 tampilan('STATISTIKA KOMPARATIF');
	 gotoxy(15,3); write('NAMA FILE : '); readln(nama);
	 namaf := nama;
	 writeln;
	 assign(fk,nama);
	 assign(fi,nama+'.dat');
	 assign(frx,nama+'xi.dat');
         assign(fry,nama+'yi.dat');
         rewrite(fk);
         rewrite(fi);
         rewrite(frx);
         rewrite(fry);
         write(fk,nama);
	 gotoxy(15,4); write('Ukuran sampel = '); readln(ndp);
	 write(fi,ndp);
	 writeln;
	 for cnt := 1 to ndp do
	 begin
	      write('Sampel 1 (':16,cnt,') = '); readln(x[cnt]); write(frx,x[cnt]);
	      write('Sampel 2 (':16,cnt,') = '); readln(y[cnt]); write(fry,y[cnt]);
	      writeln;
	 end;
	 min_mak(ndp,min,mak);
	 close(fk);
	 close(fi);
	 close(frx);
	 close(fry);
    end;

	 procedure load(var ndp : integer);
	 type
		  kata   = string[10];
        freal  = file of real;
        fint   = file of integer;
        fkata  = file of kata;
	 var nama    : kata;
		  fk      : fkata;
		  fi      : fint;
		  frx,fry : freal;
		  ada     : boolean;
		  metu : char;
	 label 01;

	 begin
			01 :
			clrscr;
			cbesar;
			tampilan('STATISTIKA KOMPARATIF');
			gotoxy(25,3); write('NAMA FILE : '); readln(nama);
			namaf := nama;
			{$I-}
			assign(fk,nama);
			assign(fi,nama+'.dat');
			assign(frx,nama+'xi.dat');
			assign(fry,nama+'yi.dat');
			reset(fk);
			reset(fi);
			reset(frx);
			reset(fry);
			{I+}
			ada := (IOResult = 0);
			if ada then
			begin
				  read(fk,nama);
				  read(fi,ndp);
				  for cnt := 1 to ndp do
				  begin
						 read(frx,x[cnt]);
						 read(fry,y[cnt]);
				  end;
				  min_mak(ndp,min,mak);
			end;
			if not ada then
			begin
				  clrscr;
					 cmati;
					 textcolor(red);
					 gotoxy(5,25); clreol;
					 write(#7);
					 gotoxy(5,24); write('FILE TIDAK ADA ! ');
					 gotoxy(5,25); write('Tekan <Esc> Keluar  Tekan <Enter> Ulang... ');
					 textcolor(yellow);
					 metu := readkey;
					 if metu = #27 then halt else goto 01;
			end;
         close(fk);
         close(fi);
         close(frx);
         close(fry);
    end;

procedure menu1;
begin
     clrscr;
     repeat
     clrscr;
     cbesar;
	  textbackground(brown);
     textcolor(Yellow);
     gotoxy(20,1);   write('           STATISTIKA KOMPARATIF          ');
     textbackground(blue);
     textcolor(white);
     gotoxy(20,3);   write('                                          ');

	  gotoxy(20,4);   write(' A. Simpangan baku sampel                 ');
	  gotoxy(20,5);   write(' B. Estimasi selisih rata-rata dengan Z   ');
	  gotoxy(20,6);   write(' C. Estimasi selisih rata-rata dengan t   ');
	  gotoxy(20,7);   write(' D. Estimasi selisih proporsi dengan Z    ');
	  gotoxy(20,8);   write(' E. Uji kesamaan variansi dengan F (1)    ');
	  gotoxy(20,9);   write(' F. Uji kesamaan variansi dengan F (2)    ');
	  gotoxy(20,10);  write(' G. Uji rata-rata dengan statistika Z     ');
	  gotoxy(20,11);  write(' H. Uji rata-rata dengan statistika t (1) ');
	  gotoxy(20,12);  write(' I. Uji rata-rata dengan statistika t (2) ');
	  gotoxy(20,13);  write(' J. Uji proporsi statistika Z             ');
	  gotoxy(20,14);  write(' K. Display data                          ');
	  gotoxy(20,15);  write(' L. Daftar file                           ');
	  gotoxy(20,16);  write(' X. [MENU UTAMA]                          ');
     gotoxy(20,17);  write('                                          ');
     textcolor(yellow);

	  gotoxy(20,4);   write(' A');
	  gotoxy(20,5);   write(' B');
	  gotoxy(20,6);   write(' C');
	  gotoxy(20,7);   write(' D');
	  gotoxy(20,8);   write(' E');
	  gotoxy(20,9);   write(' F');
	  gotoxy(20,10);  write(' G');
	  gotoxy(20,11);  write(' H');
	  gotoxy(20,12);  write(' I');
	  gotoxy(20,13);  write(' J');
	  gotoxy(20,14);  write(' K');
	  gotoxy(20,15);  write(' L');
	  gotoxy(20,16);  write(' X');
	  textbackground(cyan);
	  textcolor(Yellow);
	  gotoxy(20,20);  write('                Pilihanku :               ');
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
			  gotoxy(48,20); write('-');
			  delay(300);
			  inc(i,1);
			  textbackground(black);
	  until keypressed;
	  cbesar;
	  opsi := readkey;
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
	  end;
	  until opsi in ['x','a','b','c','d','e','f','g','h','i','j','k','l',
			  'X','A','B','C','D','E','F','G','H','I','J','K','L'];
	  clrscr;
	  textbackground(black);
end;

procedure menu2(var datum : integer);
begin
	clrscr;
	tampilan('STATISTIKA KOMPARATIF');
	textbackground(blue);
	textcolor(white);
	gotoxy(27,3); write('                             ');
	gotoxy(27,4); write(' 0. Kembali ke menu          ');
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
	  textcolor(white);
end;

procedure Uji_hipotesis;
begin
	  clrscr;
	  tampilan('STATISTIKA KOMPARATIF');
	  textbackground(blue);
	  textcolor(white);
	  gotoxy(27,3); write('                               ');
	  gotoxy(27,4); write(' 0. [Menu]                     ');
	  gotoxy(27,5); write(' 1. Uji satu pihak ujung kiri  ');
	  gotoxy(27,6); write(' 2. Uji satu pihak ujung kanan ');
	  gotoxy(27,7); write(' 3. Uji dua pihak              ');
	  gotoxy(27,8); write('                               ');
	  textcolor(yellow);
	  gotoxy(27,4); write(' 0');
	  gotoxy(27,5); write(' 1');
	  gotoxy(27,6); write(' 2');
	  gotoxy(27,7); write(' 3');
	  textbackground(brown);
	  textcolor(yellow);
	  gotoxy(27,10); write('        Pilihanku :            ');
	  gotoxy(47,10);
	  uopsi1 := readkey;
	  textbackground(black);
	  textcolor(white);
end;

procedure display_data(nama : string; var datum : Integer);
begin
	  textbackground(black);
	  textcolor(white);
	  gotoxy(5,4); write('Data pilihan ',upcase(opsi));
	  gotoxy(20,4); write(' file : ',namaf);
	  if datum < 39 then
	  begin
          for i := 1 to datum do
          begin
               if i < 20 then
               begin
                    gotoxy(5,i+4); clreol;
                    gotoxy(5,i+4); writeln(i,'. ');
                    gotoxy(10,i+4); writeln(x[i]:3:2);
                    gotoxy(20,i+4); writeln(y[i]:3:2);
               end else
               begin
                    gotoxy(35,i-15); clreol;
                    gotoxy(35,i-15); writeln(i,'. ');
                    gotoxy(40,i-15); writeln(x[i]:3:2);
                    gotoxy(50,i-15); writeln(y[i]:3:2);
               end;
          end;
     end else
     begin
          for i := 1 to datum do
			 begin
               if i < 20 then
               begin
                    gotoxy(5,i+4); clreol;
                    gotoxy(5,i+4); writeln(i,'. ');
                    gotoxy(10,i+4); writeln(x[i]:3:2);
                    gotoxy(20,i+4); writeln(y[i]:3:2);
               end else
               begin
                    if (i >= 20) and (i < 38) then
                    begin
                         readln;
                         gotoxy(35,i-15); clreol;
                         gotoxy(35,i-15); writeln(i,'. ');
                         gotoxy(40,i-15); writeln(x[i]:3:2);
                         gotoxy(50,i-15); writeln(y[i]:3:2);
						  end else
                    begin
                         if i = 38 then
                         begin
										gotoxy(60,23);
                              writeln('Dan seterusnya ...');
                         end;
                         if i > 38 then
                         begin
                         end;
                    end;
               end;
          end;
     end;
     {for i := 2 to 24 do
     begin
			 gotoxy(40,i); writeln('³');
	  end;}
end;

procedure SEPop(x : datar);
begin
	  mu := 0;
	  for i := 1 to ndp do
	  begin
			 mu := mu + x[i];
     end;
     mu := mu/ndp;
     sigmaximu := 0;
     for i := 1 to ndp do
     begin
          sigmaximu := sigmaximu + sqr((x[i]-mu));
     end;
     sigma := sqrt(sigmaximu/ndp);
end;

procedure SESamp(x : datar);
begin
     xbar := 0;
     for i := 1 to ndp do
     begin
          xbar := xbar + x[i];
     end;
     xbar := xbar/ndp;
	  sigmaxixbar := 0;
     for i := 1 to ndp do
     begin
          sigmaxixbar := sigmaxixbar + sqr((x[i]-xbar))
     end;
     sbs := sqrt(sigmaxixbar/(ndp-1))
end;

procedure SEProp(x : datar);
begin
     SESamp(x);
     SESamp(y);
     jprop := 1;
     for i := 1 to ndp do
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
     proppop := jprop/ndp;
end;

procedure Simpsonz(atas,bawah : real; var total : extended);

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
	  bagian := 2;
     j      := 1;
     delx   := (atas-bawah)/bagian;
     ganjil := fx(bawah+delx);
     genap  := 0;
     akhir  := Fx(bawah)+Fx(atas);
     total  := (akhir+4*ganjil)*delx/3;
     repeat
           bagian := bagian*2;
           total1 := total;
           delx   := (atas-bawah)/bagian;
           genap  := genap + ganjil;
           ganjil := 0;
           for i := 1 to (bagian div 2) do
           begin
                xi      := bawah + delx*(2.0*i-1.0);
                ganjil  := ganjil + Fx(xi);
           end;
           total := (akhir + 4*ganjil+2*genap)* delx/3;
           j := j + 1;
	  until abs(total - total1) <= abs(toleransi*total);
end;

procedure Simpson(atas,bawah : extended; var total : extended);

function pow(a,b : extended): extended;
     begin
          pow := exp(b*ln(a));
     end;

     function Fx(t : extended) : extended;
     begin
          xx := (nu+1)/2;
          taua := gam(xx);
          xx := nu/2;
          taub := gam(xx);
          tau  := taua/(taub*sqrt(pi*nu));
          tperv:= 1+(sqr(t)/nu);
          pang := -0.5*(nu+1);
          pangkat := pow(tperv,pang);
			 fx := tau * pangkat;
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

procedure integrasi(py : byte);
begin
     itatas := 0;
     repeat
           simpsonz(itatas,0,segmen);
           prob := (segmen);
           gotoXY(27,py); write(itatas:1:4);
           gotoXY(10,py); write(prob:6:4);
           itatas := itatas + 0.0001
     until abs(prob-pelp) <= 1e-5;
end;

procedure integrasi2(pp,pt : byte);
begin
          t := 0;
			 repeat
                simpson(t,0,segmen);
					 prob := segmen;
                gotoXY(1,pp);  write('Peluang                 = ',(prob+0.5):6:4);
                gotoXY(1,pt);  write('Harga t tabel           = ',t:6:4);
                t := t + 0.0001;
          until abs((prob+0.5)-pelp) <= tol;
end;

Procedure peluang1;
begin
     itatas := t;
     integrasi2(13,14);
     prob := prob + 0.5;
end;

Procedure peluang2;
begin
	  itatas := t;
     integrasi2(13,14);
	  prob := prob + 0.5;
	  if pelm < 0.5 then prob := 1 - prob;
end;

procedure estimasiselrataz;
var myumin,myumak : real;
begin
     myumin := (xxbar-yxbar) - (prob*sqrt((sqr(s1)/ndp)+(sqr(s2)/ndp)));
     myumak := (xxbar-yxbar) + (prob*sqrt((sqr(s1)/ndp)+(sqr(s2)/ndp)));
	  gotoxy(1,16); writeln('ESTIMASI SELISIH RATA-RATA POPULASI ');
	  gotoxy(1,17); writeln('DENGAN STATISTIKA Z');
	  gotoxy(1,19); writeln(myumin:6:4,' σ ζ σ ',myumak:6:4);
end;

procedure estimasiselratat;
var myumin,myumak : real;
begin
     gotoXY(1,10);  write('Taraf signifikansi      = ');read(ts);
     gotoXY(1,10);  write('Taraf signifikansi      = ',ts:1:4);
     nu := (2*ndp)-2;
	  gotoXY(1,11);  write('Harga dk                = ',nu:1);
     pelp   := 1-(ts/2);
     cmati;
     peluang1;
     gotoXY(1,11);  write('Harga dk                = ',nu:1);
     gotoXY(1,12);  write('Peluang                 = ',pelp:6:4);
     gotoXY(1,13);  write('Harga t                 = ',t:6:4);
     myumin := (xxbar-yxbar) - (prob*sqrt((sqr(xsbs)/ndp)+(sqr(ysbs)/ndp)));
     myumak := (xxbar-yxbar) + (prob*sqrt((sqr(xsbs)/ndp)+(sqr(ysbs)/ndp)));
	  gotoxy(1,16); write('ESTIMASI SELISIH RATA-RATA POPULASI ');
	  gotoxy(1,17); write('DENGAN STATISTIKA t');
	  gotoxy(1,19); write(myumin:6:4,' σ ζ σ ',myumak:6:4);
end;

Procedure estimasisimbak;
var varmin,varmak : real;
begin
     varmin := ((ndp-1)*sqr(sbs))/chi;
     varmak := ((ndp-1)*sqr(sbs))/chi2;
	  gotoxy(1,16); write('ESTIMASI VARIANSI POPULASI DENGAN');
	  gotoxy(1,17); write('STATISTIKA  Chiύ');
     gotoxy(1,19); write(varmin:6:4,' σ  εύ σ ',varmak:6:4);
end;

Procedure estimasiselprop;
var propmin,propmak : real;
begin
	  propmin := (proppop1-proppop2)-prob*sqrt((proppop1*(1-proppop1)/ndp)+(proppop2*(1-proppop2)/ndp));
	  propmak := (proppop1-proppop2)+prob*sqrt((proppop1*(1-proppop1)/ndp)+(proppop2*(1-proppop2)/ndp));
	  gotoxy(1,16); write('ESTIMASI SELISIH PROPORSI DATA POPULASI ');
	  gotoxy(1,17); write('DENGAN STATISTIK Z');
	  gotoxy(1,19); write(propmin:6:4,' σ  γ  σ ',propmak:6:4);
end;

Procedure uji_rata_z;
begin
	  zd := (xxbar-yxbar)/(sqrt((sqr(s1)/ndp)+(sqr(s2)/ndp)));
	  gotoxy(1,14); write('Harga Z data            = ',zd:3:4);
	  gotoxy(1,16); write('Kesimpulan :');
	  if uopsi1 = '1' then
	  begin
			 if zd >= -itatas then
			 begin
					gotoxy(1,17); write('Karena Z data ς -Z tabel maka');
					gotoxy(1,18); write('hipotesis diterima, rata-rata kelompok 1 > rata-rata kelompok 2');
			 end else
			 begin
					gotoxy(1,17); write('Karena Z data σ -Z tabel maka');
					gotoxy(1,18); write('hipotesis ditolak, rata-rata kelompok 1 < rata-rata kelompok 2');
			 end;
	  end;
	  if uopsi1 = '2' then
	  begin
			 if zd <= itatas then
			 begin
					gotoxy(1,17); write('Karena Z data σ Z tabel maka');
					gotoxy(1,18); write('hipotesis diterima, rata-rata kelompok 1 < rata-rata kelompok 2');
			 end else
			 begin
					gotoxy(1,17); write('Karena Z data ς Z tabel maka');
					gotoxy(1,18); write('hipotesis ditolak, rata-rata kelompok 1 > rata-rata kelompok 2');
			 end;
	  end;
	  if uopsi1 = '3' then
	  begin
			 if (zd >= -itatas) and (zd <= itatas) then
			 begin
					gotoxy(1,17); write('Karena -Z tabel σ Z data σ Z tabel');
					gotoxy(1,18); write('maka hipotesis diterima, rata-ratanya tidak berbeda signifikan.');
			 end else
			 begin
					if zd < -itatas then
					begin
						  gotoxy(1,17); write('Karena Z data < -Z tabel maka');
						  gotoxy(1,18); write('hipotesis ditolak, rata-ratanya berbeda signifikan.');
					end;
					if zd > itatas then
					begin
						  gotoxy(1,17); write('Karena Z data > -Z tabel maka');
						  gotoxy(1,18); write('hipotesis ditolak, rata-ratanya berbeda signifikan.');
					end;
          end;
     end;
end;

Procedure uji_proporsi_z;
begin
     zd := (proppop1-proppop2)/sqrt((proppop1*(1-proppop1)/ndp)+(proppop2*(1-proppop2)/ndp));
     gotoxy(1,14); write('Harga Z data            = ',zd:3:4);
     gotoxy(1,16); write('Kesimpulan :');
     if uopsi1 = '1' then
     begin
          if zd >= -itatas then
          begin
               gotoxy(1,17); write('Karena Z data ς -Z tabel maka');
					gotoxy(1,18); write('hipotesis diterima, γ1 ς γ2');
          end else
          begin
               gotoxy(1,17); write('Karena Z data σ -Z tabel maka');
               gotoxy(1,18); write('hipotesis ditolak, γ1 < γ2');
			 end;
     end;
     if uopsi1 = '2' then
     begin
          if zd <= itatas then
          begin
               gotoxy(1,17); write('Karena Z data σ Z tabel maka');
               gotoxy(1,18); write('hipotesis diterima, γ1 σ γ2');
          end else
          begin
               gotoxy(1,17); write('Karena Z data ς Z tabel maka');
               gotoxy(1,18); write('hipotesis ditolak, γ1 > γ2');
          end;
     end;
	  if uopsi1 = '3' then
     begin
          if (zd >= -itatas) and (zd <= itatas) then
          begin
               gotoxy(1,17); write('Karena -Z tabel σ Z data σ Z tabel');
               gotoxy(1,18); write('maka hipotesis diterima, γ1 = γ2');
			 end else
          begin
               if zd < -itatas then
               begin
                    gotoxy(1,17); write('Karena Z data < -Z tabel maka');
						  gotoxy(1,18); write('hipotesis ditolak, γ1 Ψ γ2');
					end;
					if zd > itatas then
					begin
						  gotoxy(1,17); write('Karena Z data > -Z tabel maka');
						  gotoxy(1,18); write('hipotesis ditolak, γ1 Ψ γ2');
               end;
          end;
	  end;
end;

procedure uji_rata_t;
var myumin,myumak,w1,w2,t2,sgab : real;
begin
	  if (uopsi1 = '1') or (uopsi1 = '2') then pelp := 1-ts;
	  if  uopsi1 = '3' then pelp := 1-(ts/2);
	  pelm := pelp;
	  if pelp < 0.5 then
	  begin
			 pelp := 1 - pelp;
	  end;
	  repeat
			  cbesar;
			  gotoxy(17,15); clreol;
			  gotoxy(1,15); write('Apakah ε1 = ε2 (y/t) ? ');
			  answer := readkey;
			  gotoxy(1,15); clreol;
			  cmati;
	  until (upcase(answer) = 'T') or (upcase(answer) = 'Y');
	  if upcase(answer) = 'T' then
	  begin
			 td := (xxbar-yxbar)/(sqrt((sqr(xsbs)/ndp)+(sqr(ysbs)/ndp)));
			 gotoxy(1,15); write('Harga t data            = ',td:3:4,' ----> ε1 Ψ ε2');
			 nu := (ndp)-1;
			 gotoXY(1,12);  write('Harga dk                = ',nu:1);
			 peluang1;
			 gotoXY(1,12);  write('Harga dk                = ',nu:1);
			 gotoXY(1,13);  write('Peluang                 = ',pelm:6:4);
			 if pelm < 0.5 then t := -t;
			 w1 := sqr(xsbs)/ndp;
			 w2 := sqr(ysbs)/ndp;
			 t2 := ((w1*t) + (w2*t))/(w1+w2);
			 t := t2;
			 gotoXY(1,14);  write('Harga t`',' tabel          = ',t:6:4);
	  end;
	  if upcase(answer) = 'Y' then
	  begin
			 sgab := sqrt((ndp-1)*(sqr(xsbs)+sqr(ysbs))/((2*ndp)-2));
			 td := (xxbar-yxbar)/(sgab*(sqrt((1/ndp)+(1/ndp))));
			 gotoxy(1,15); write('Harga t data            = ',td:3:4,' ----> ε1 = ε2');
			 nu := (2*ndp)-2;
			 gotoXY(1,12);  write('Harga dk                = ',nu:1);
			 peluang1;
			 gotoXY(1,12);  write('Harga dk                = ',nu:1);
			 gotoXY(1,13);  write('Peluang                 = ',pelm:6:4);
			 if pelm < 0.5 then t := -t;
			 {w1 := sqr(xsbs)/ndp;
			 w2 := sqr(ysbs)/ndp;
			 t2 := ((w1*t) + (w2*t))/(w1+w2);
			 t := t2;}
			 gotoXY(1,14);  write('Harga t tabel           = ',t:6:4);
	  end;

	  gotoxy(1,17); write('Kesimpulan :');
	  if uopsi1 = '1' then
	  begin
			 if td >= -t then
			 begin
					if upcase(answer) = 'T' then
					begin
						  gotoxy(1,18); write('Karena t data ς t`',' tabel maka');
					end else
					begin
						  gotoxy(1,18); write('Karena t data ς t',' tabel maka');
					end;
					gotoxy(1,19); write('hipotesis diterima, rata-rata kelompok 1 > rata-rata kelompok 2');
			 end else
			 begin
					if upcase(answer) = 'T' then
					begin
						  gotoxy(1,18); write('Karena t data σ -t`',' tabel maka')
					end else
					begin
						  gotoxy(1,18); write('Karena t data σ -t',' tabel maka');
					end;
					gotoxy(1,19); write('hipotesis ditolak, rata-rata kelompok 1 < rata-rata kelompok 2');
			 end;
	  end;
	  if uopsi1 = '2' then
	  begin
			 if td <= t then
			 begin
					if upcase(answer) = 'T' then
					begin
						  gotoxy(1,18); write('Karena t data σ t`',' tabel maka')
					end else
					begin
						  gotoxy(1,18); write('Karena t data σ t',' tabel maka');
					end;
					gotoxy(1,19); write('hipotesis diterima, rata-rata kelompok 1 < rata-rata kelompok 2');
			 end else
			 begin
					if upcase(answer) = 'T' then
					begin
						  gotoxy(1,18); write('Karena t data ς t`',' tabel maka')
					end else
					begin
						  gotoxy(1,18); write('Karena t data ς t',' tabel maka');
					end;
					gotoxy(1,19); write('hipotesis ditolak, rata-rata kelompok 1 > rata-rata kelompok 2');
			 end;
	  end;
	  if uopsi1 = '3' then
	  begin
			 if (td >= -t) and (td <= t) then
			 begin
					if upcase(answer) = 'T' then
					begin
						  gotoxy(1,18); write('Karena -t`',' tabel σ t data σ t`',' tabel')
					end else
					begin
						  gotoxy(1,18); write('Karena -t',' tabel σ t data σ t',' tabel');
					end;
					gotoxy(1,19); write('maka hipotesis diterima, rata-ratanya tidak berbeda signifikan.');
			 end else
			 begin
					if td < -t then
					begin
                    if upcase(answer) = 'T' then
                    begin
                         gotoxy(1,18); write('Karena t data < -t`',' tabel maka');
                    end else
                    begin
								 gotoxy(1,18); write('Karena t data < -t',' tabel maka');
                    end;
						  gotoxy(1,19); write('hipotesis ditolak, rata-ratanya berbeda signifikan.');
					end;
					if td > t then
					begin
						  if upcase(answer) = 'T' then
						  begin
								 gotoxy(1,18); write('Karena t data > t`',' tabel maka');
						  end else
						  begin
								 gotoxy(1,18); write('Karena t data > t',' tabel maka');
						  end;
						  gotoxy(1,19); write('hipotesis ditolak, rata-ratanya berbeda signifikan.');
					end;
          end;
     end;
end;

procedure uji_rata_t_beda;
var myumin,myumak,w1,w2,t,t1,t2,sgab : real;
	 r1,r2,r3,r4 : real;
	 rt1,rt2,rt3 : real;
begin
	  if (uopsi1 = '1') or (uopsi1 = '2') then pelp := 1-ts;
	  if  uopsi1 = '3' then pelp := 1-(ts/2);
	  pelm := pelp;
	  if pelp < 0.5 then
	  begin
			 pelp := 1 - pelp;
	  end;
	  repeat
			  cbesar;
			  gotoxy(17,15); clreol;
			  gotoxy(1,15); write('Apakah ε1 = ε2 (y/t) ? ');
			  answer := readkey;
			  gotoxy(1,15); clreol;
			  cmati;
	  until (upcase(answer) = 'T') or (upcase(answer) = 'Y');
	  if upcase(answer) = 'T' then
	  begin
			 rt1 := (xxbar-yxbar);
			 rt2 := (sqr(xsbs)/xndp) + (sqr(ysbs)/yndp);
			 rt3 := sqrt(rt2);
			 td  := rt1/rt3;

			 gotoXY(1,11);  write('Peluang                 = ',pelm:6:4);
			 gotoxy(1,17);  write('Harga t data            = ',td:3:4,' ----> ε1 Ψ ε2');

			 nu := (xndp+yndp)-2;
			 gotoXY(1,13);  write('Harga dk1               = ',xndp-1:1);
			 cursor(6,7);
			 gotoXY(1,14);  write('Harga t tabel (dk1)     = '); readln(t1);
			 gotoXY(41,13);  write('Harga dk2               = ',yndp-1:1);
			 gotoXY(41,14);  write('Harga t tabel (dk2)     = '); readln(t2);
			 cmati;

			 w1 := sqr(xsbs)/xndp;
			 w2 := sqr(ysbs)/yndp;
			 t := ((w1*t1) + (w2*t2))/(w1+w2);
			 gotoXY(1,16);  write('Harga t`',' tabel          = ',t:6:4);
	  end;
	  if upcase(answer) = 'Y' then
	  begin
			 r1 := (xndp-1)*sqr(xsbs);
			 r2 := (yndp-1)*sqr(ysbs);
			 r3 := (xndp+yndp)-2;
			 r4 := (r1 + r2)/r3;
			 sgab := sqrt(r4);
			 rt1 := (xxbar-yxbar);
			 rt2 := (1/xndp) + (1/yndp);
			 rt3 := sqrt(rt2);
			 td  := rt1/(sgab*rt3);

			 gotoXY(1,8);  write('Standar error gabungan  = ',sgab:6:4);
			 gotoXY(1,13); write('Peluang                 = ',pelm:6:4);
			 gotoxy(1,15); write('Harga t data            = ',td:3:4,' ----> ε1 = ε2');

			 nu := (xndp+yndp)-2;
			 gotoXY(1,11);  write('Harga dk1               = ',xndp-1:1);
			 gotoXY(41,11); write('Harga dk2               = ',yndp-1:1);
			 gotoXY(1,12);  write('Harga dk                = ',nu:1);
			 peluang1;
			 gotoXY(1,13);  write('Peluang                 = ',pelm:6:4);
			 if pelm < 0.5 then t := -t;
			 cmati;

			 {w1 := sqr(xsbs)/xndp;
			 w2 := sqr(ysbs)/yndp;
			 t := ((w1*t1) + (w2*t2))/(w1+w2);}
			 {gotoXY(1,14);  write('Harga t',' tabel           = ',t:6:4);}
	  end;

	  gotoxy(1,19); write('Kesimpulan :');
	  if uopsi1 = '1' then
	  begin
			 if td >= -t then
			 begin
					gotoxy(1,20); write('Karena t data ς -t',' tabel maka');
					gotoxy(1,21); write('hipotesis diterima, rata-rata kelompok 1 > rata-rata kelompok 2');
			 end else
			 begin
					gotoxy(1,20); write('Karena t data σ -t',' tabel maka');
					gotoxy(1,21); write('hipotesis ditolak, rata-rata kelompok 1 < rata-rata kelompok 2');
			 end;
	  end;
	  if uopsi1 = '2' then
	  begin
			 if td <= t then
			 begin
					gotoxy(1,20); write('Karena t data σ t',' tabel maka');
					gotoxy(1,21); write('hipotesis diterima, rata-rata kelompok 1 < rata-rata kelompok 2');
			 end else
			 begin
					gotoxy(1,20); write('Karena t data ς t',' tabel maka');
					gotoxy(1,21); write('hipotesis ditolak, rata-rata kelompok 1 > rata-rata kelompok 2');
			 end;
	  end;
	  if uopsi1 = '3' then
	  begin
			 if (td >= -t) and (td <= t) then
			 begin
					gotoxy(1,20); write('Karena -t',' tabel σ t data σ t',' tabel');
					gotoxy(1,21); write('maka hipotesis diterima, rata-ratanya tidak berbeda signifikan.');
			 end else
			 begin
					if td < -t then
					begin
						  gotoxy(1,20); write('Karena t data < -t',' tabel maka');
						  gotoxy(1,21); write('hipotesis ditolak, rata-ratanya berbeda signifikan.');
					end;
					if zd > t then
					begin
						  gotoxy(1,20); write('Karena t data > -t',' tabel maka');
						  gotoxy(1,21); write('hipotesis ditolak, rata-ratanya berbeda signifikan.');
					end;
			 end;
	  end;
end;

procedure uji_sama_variansi;
var fd,fd1,fd2 : real;
begin
     if xsbs > ysbs then fd := sqr(xsbs)/sqr(ysbs)
     else fd := sqr(ysbs)/sqr(xsbs);

	  gotoxy(1,12);
	  write('F (',ts/2:5:3,';dk1= ',ndp-1,',','dk2= ',ndp-1,') = ');
	  read(fd1);
	  gotoxy(1,12);
	  write('F (',ts/2:5:3,';dk1= ',ndp-1,',','dk2= ',ndp-1,') = ',fd1:6:3);
          gotoxy(1,13);
          write('F (',1-(ts/2):5:3,';dk1= ',ndp-1,',','dk2= ',ndp-1,') = ');
	  read(fd2);
          gotoxy(1,13);
          write('F (',1-(ts/2):5:3,';dk1= ',ndp-1,',','dk2= ',ndp-1,') = ',fd2:6:3);
	  gotoxy(1,14);
	  write('F data                  = ',fd:6:4);
	  gotoxy(1,16); write('Kesimpulan : ');
     if (fd < fd1) or (fd > fd2) then
     begin
          if fd < fd1 then
			 begin
               gotoxy(1,18);
               write('Karena F data < F tabel maka');
					gotoxy(1,19);
					write('Hipotesis ditolak, variansinya tidak homogen/tidak sama');
			 end else
			 begin
					gotoxy(1,18);
					write('Karena F data > F tabel maka');
					gotoxy(1,19);
					write('Hipotesis ditolak, variansinya tidak homogen/tidak sama');
			 end
	  end;
	  if ((fd >= fd1) and (fd <= fd2)) or ((fd <= fd1) and (fd >= fd2)) then
	  begin
			 gotoxy(1,18);
			 write('Karena F tabel σ F data σ F tabel maka');
			 gotoxy(1,19);
			 write('Hipotesis diterima, variansinya homogen/sama');
	  end;
end;

procedure uji_sama_variansi_beda;
var fd,fd1,fd2 : real;
begin
	  if xsbs > ysbs then fd := sqr(xsbs)/sqr(ysbs)
	  else fd := sqr(ysbs)/sqr(xsbs);

	  gotoxy(1,12);
	  write('F (',ts/2:5:3,';dk1= ',xndp-1,',','dk2= ',yndp-1,') = ');
	  read(fd1);
	  gotoxy(1,12);
     write('F (',ts/2:5:3,';dk1= ',xndp-1,',','dk2= ',yndp-1,') = ',fd1:6:3);
     gotoxy(1,13);
	  write('F (',1-(ts/2):5:3,';dk1= ',xndp-1,',','dk2= ',yndp-1,') = ');
     read(fd2);
	  gotoxy(1,13);
     write('F (',1-(ts/2):5:3,';dk1= ',xndp-1,',','dk2= ',yndp-1,') = ',fd2:6:3);
     gotoxy(1,14);
     write('F data                  = ',fd:6:4);
	  gotoxy(1,16); write('Kesimpulan : ');
     if (fd < fd1) or (fd > fd2) then
     begin
			 if fd < fd1 then
          begin
               gotoxy(1,18);
					write('Karena F data < F tabel maka');
               gotoxy(1,19);
					write('Hipotesis ditolak, variansinya tidak homogen/tidak sama');
			 end else
			 begin
					gotoxy(1,18);
					write('Karena F data > F tabel maka');
					gotoxy(1,19);
					write('Hipotesis ditolak, variansinya tidak homogen/tidak sama');
			 end;
	  end;
	  if ((fd >= fd1) and (fd <= fd2)) or ((fd <= fd1) and (fd >= fd2)) then
	  begin
			 gotoxy(1,18);
			 write('Karena F tabel σ F data σ F tabel maka');
			 gotoxy(1,19);
			 write('Hipotesis diterima, variansinya homogen/sama');
	  end;
end;


procedure data_sampelx;
begin
	  textcolor(yellow);
	  gotoxy(1,4); write('Sampel 1 :');
	  textcolor(white);
	  gotoxy(1,5); write('Ukuran sampel           = ',ndp);
	  gotoxy(1,6); write('Rata-rata sampel        = ',xbar:3:4);
	  gotoxy(1,7); write('Standar error sampel    = ',sbs:3:4);
	  gotoxy(1,8); write('Data minimal            = ',minx:3:4);
	  gotoxy(1,9); write('Data maksimal           = ',makx:3:4);
end;

procedure data_sampely;
begin
     textcolor(yellow);
     gotoxy(41,4); write('Sampel 2 :');
	  textcolor(white);
	  gotoxy(41,5); write('Ukuran sampel           = ',ndp);
	  gotoxy(41,6); write('Rata-rata sampel        = ',xbar:3:4);
	  gotoxy(41,7); write('Standar error sampel    = ',sbs:3:4);
	  gotoxy(41,8); write('Data minimal            = ',miny:3:4);
	  gotoxy(41,9); write('Data maksimal           = ',maky:3:4);
end;

procedure data_sampel_1;
begin
	  textcolor(yellow);
	  gotoxy(1,4); write('Sampel 1 :');
	  textcolor(white);
	  gotoxy(1,5); write('Ukuran sampel           = ');readln(xndp);
	  gotoxy(1,6); write('Rata-rata sampel        = ');readln(xxbar);
	  gotoxy(1,7); write('Standar error sampel    = ');readln(xsbs);
	  gotoxy(1,5); write('Ukuran sampel           = ',xndp);
	  gotoxy(1,6); write('Rata-rata sampel        = ',xxbar:3:4);
	  gotoxy(1,7); write('Standar error sampel    = ',xsbs:3:4);
end;

procedure data_sampel_2;
begin
	  textcolor(yellow);
	  gotoxy(41,4); write('Sampel 2 :');
	  textcolor(white);
	  gotoxy(41,5); write('Ukuran sampel           = ');readln(yndp);
	  gotoxy(41,6); write('Rata-rata sampel        = ');readln(yxbar);
	  gotoxy(41,7); write('Standar error sampel    = ');readln(ysbs);
	  gotoxy(41,5); write('Ukuran sampel           = ',yndp);
	  gotoxy(41,6); write('Rata-rata sampel        = ',yxbar:3:4);
	  gotoxy(41,7); write('Standar error sampel    = ',ysbs:3:4);
end;

procedure input_s;
begin
	  gotoxy(41,10); write('SE populasi 1           = '); readln(s1);
	  gotoxy(41,11); write('SE populasi 2           = '); readln(s2);
end;

procedure input_su;
begin
	  gotoxy(1,10);  write('SE populasi 1           = '); readln(s1);
	  gotoxy(41,10); write('SE populasi 2           = '); readln(s2);
end;

Procedure data_sampel;
begin
			 SESamp(x);
			 xxbar := xbar;
			 xsbs  := sbs;
			 Data_sampelx;
			 SESamp(y);
			 yxbar := xbar;
			 ysbs  := sbs;
			 Data_sampely;
end;

Procedure data_sampel_12;
begin
			 textcolor(white);
			 Data_sampel_1;
			 Data_sampel_2;
end;

procedure pilopsi;
begin
	  if uopsi1 = '1' then
	  begin
			 textcolor(yellow);
			 gotoxy(1,23); write('UJI SATU PIHAK UJUNG KIRI / UJI PERBEDAAN');
			 textcolor(white);
	  end;
	  if uopsi1 = '2' then
	  begin
			 textcolor(yellow);
			 gotoxy(1,23); write('UJI SATU PIHAK UJUNG KANAN / UJI PERBEDAAN');
			 textcolor(white);
	  end;
	  if uopsi1 = '3' then
	  begin
			 textcolor(yellow);
			 gotoxy(1,23); write('UJI DUA PIHAK / UJI KESAMAAN');
			 textcolor(white);
	  end;
end;

begin
	  10:
	  clrscr;
	  repeat
          Hapus_layar;
	  warna(0,0,80,25,black);
	  menu1;
	  if pilih = 0 then halt;
	  if pilih = 1 then
	  begin
			 menu2(ndp);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': input(ndp);
			 '2': load(ndp);
			 end;
			 tampilan('Simpangan baku sampel');
			 display_data(namaf,ndp);
			 terus;
			 tampilan('Simpangan baku sampel');
			 textbackground(black);
			 SESamp(x);
			 gotoxy(1,5);  writeln('Ukuran sampel 1           = ',ndp);
			 gotoxy(1,6);  writeln('Rata-rata sampel   1      = ',xbar:3:4);
			 gotoxy(1,7);  writeln('Standar error sampel 1    = ',sbs:3:4);
			 gotoxy(1,8);  writeln('Data minimal x            = ',minx:3:4);
			 gotoxy(1,9);  writeln('Data maksimal x           = ',makx:3:4);
			 SESamp(y);
			 gotoxy(41,5); writeln('Ukuran sampel 2           = ',ndp);
			 gotoxy(41,6); writeln('Rata-rata sampel 2        = ',xbar:3:4);
			 gotoxy(41,7); writeln('Standar error sampel 2    = ',sbs:3:4);
			 gotoxy(41,8); writeln('Data minimal y            = ',miny:3:4);
			 gotoxy(41,9); writeln('Data maksimal y           = ',maky:3:4);

	  end;
	  if pilih = 2 then
	  begin
			 menu2(ndp);
			 pmenu := readkey;
			 case pmenu of
          '0': goto 10;
          '1': input(ndp);
			 '2': load(ndp);
          end;
          tampilan('Estimasi selisih rata-rata');
          data_sampel;
			 input_s;
			 gotoxy(1,10);write('Taraf signifikansi      = '); read(ts);
          gotoxy(1,10);write('Taraf signifikansi      = ',ts:3:4);
          gotoxy(1,11);write('Harga Z (      )        = ');
          pelp := 0.5-(ts/2);
          sigma   := 1;        mu      := 0;
          cmati;
          py := 11;
			 integrasi(py);
          cbesar;
          estimasiselrataz;
	  end;
     if pilih = 3 then
	  begin
          menu2(ndp);
          pmenu := readkey;
			 case pmenu of
          '0': goto 10;
          '1': input(ndp);
          '2': load(ndp);
			 end;
			 tampilan('Estimasi selisih rata-rata');
          data_sampel;
          estimasiselratat;
     end;
     if pilih = 4 then
     begin
          menu2(ndp);
			 pmenu := readkey;
          case pmenu of
          '0': goto 10;
			 '1': input(ndp);
          '2': load(ndp);
			 end;
          tampilan('Estimasi selisih proporsi');
          data_sampel;
			 repeat
                gotoxy(1,10);  write('Proporsi data 1         = ');
                read(proppop1);
          until (proppop1 < 1) and (proppop1 > 0);
			 gotoxy(1,10); write('Proporsi data 1         = ',proppop1:3:4);
			 repeat
                gotoxy(41,10);  write('Proporsi data 2         = ');
                read(proppop2);
          until (proppop2 < 1) and (proppop2 > 0);
          gotoxy(41,10); write('Proporsi data 2         = ',proppop2:3:4);
          gotoxy(1,11); write('Taraf signifikansi      = ');
          read(ts);
			 gotoxy(1,11); write('Taraf signifikansi      = ',ts:3:4);
          gotoxy(1,12); write('Harga Z (      )        = ');
          pelp    := 0.5-(ts/2);
			 sigma   := 1;
          mu      := 0;
			 cmati;
          py := 12;
          integrasi(py);
			 cbesar;
          estimasiselprop;
     end;
     if pilih = 5 then
	  begin
	        menu2(ndp);
                pmenu := readkey;
                case pmenu of
                '0': goto 10;
                '1': input(ndp);
                '2': load(ndp);
                end;
		clrscr;
                printing;
                if ps = '0' then goto 10;
		clrscr;
                tampilan('Uji kesamaan variansi');
		data_sampel;
                gotoxy(1,11); write('Taraf signifikansi      = ');
                read(ts);
		gotoxy(1,11); write('Taraf signifikansi      = ',ts:3:4);
                uji_sama_variansi;
                if ps = '2' then intr(5,reg);
     end;
	  if pilih = 6 then
	  begin
                clrscr;
                printing;
                if ps = '0' then goto 10;
                clrscr;
                tampilan('Uji kesamaan variansi');
                data_sampel_12;
					 gotoxy(1,11); write('Taraf signifikansi      = ');
                read(ts);
                gotoxy(1,11); write('Taraf signifikansi      = ',ts:3:4);
					 uji_sama_variansi_beda;
                if ps = '2' then intr(5,reg);
	  end;
     if pilih = 7 then
     begin
			 uji_hipotesis;
			 if uopsi1 = '0' then goto 10;
			 menu2(ndp);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': input(ndp);
			 '2': load(ndp);
			 end;
			 clrscr;
			 printing;
			 if ps = '0' then goto 10;
			 clrscr;
			 tampilan('Uji rata-rata');
			 data_sampel;
			 pilopsi;
			 input_su;
			 gotoxy(1,12); write('Taraf signifikansi      = '); read(ts);
			 gotoxy(1,12); write('Taraf signifikansi      = ',ts:3:4);
			 gotoxy(1,13); write('Harga Z (      )        = ');
			 if (uopsi1 = '1') or (uopsi1 = '2') then pelp := 0.5-ts;
			 if  uopsi1 = '3' then pelp := 0.5-(ts/2);
			 sigma   := 1;
			 mu      := 0;
			 cmati;
			 py := 13;
			 integrasi(py);
			 cbesar;
			 uji_rata_z;
			 if ps = '2' then intr(5,reg);
			 {if opsi3 = #27 then goto 20;}
	  end;
	  if pilih = 8 then
	  begin
			 uji_hipotesis;
			 if uopsi1 = '0' then goto 10;
			 menu2(ndp);
			 pmenu := readkey;
          case pmenu of
          '0': goto 10;
			 '1': input(ndp);
          '2': load(ndp);
          end;
          clrscr;
			 printing;
			 if ps = '0' then goto 10;
          clrscr;
          tampilan('Uji rata-rata');
          data_sampel;
          pilopsi;
          gotoxy(1,11); write('Taraf signifikansi      = '); read(ts);
          gotoxy(1,11); write('Taraf signifikansi      = ',ts:3:4);
	  uji_rata_t;
	  if ps = '2' then intr(5,reg);
			 {if opsi3 = #27 then goto 30;}
	  end;
	  if pilih = 9 then
	  begin
			 uji_hipotesis;
			 if uopsi1 = '0' then goto 10;
			 clrscr;
			 printing;
			 if ps = '0' then goto 10;
			 clrscr;
			 tampilan('Uji rata-rata');
			 data_sampel_12;
			 pilopsi;
			 gotoxy(1,10); write('Taraf signifikansi      = '); read(ts);
			 gotoxy(1,10); write('Taraf signifikansi      = ',ts:3:4);
			 uji_rata_t_beda;
			 if ps = '2' then intr(5,reg);
			 {if opsi3 = #27 then goto 40;}
	  end;
	  if pilih = 10 then
	  begin
			 uji_hipotesis;
			 if uopsi1 = '0' then goto 10;
			 menu2(ndp);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': input(ndp);
			 '2': load(ndp);
			 end;
			 tampilan('Uji proporsi');
			 data_sampel;
			 pilopsi;
			 repeat
					 gotoxy(1,10);  write('Proporsi data 1         = ');
					 read(proppop1);
			 until (proppop1 < 1) and (proppop1 > 0);
			 gotoxy(1,10); write('Proporsi data 1         = ',proppop1:3:4);
			 repeat
					 gotoxy(41,10);  write('Proporsi data 2         = ');
					 read(proppop2);
			 until (proppop2 < 1) and (proppop2 > 0);
			 gotoxy(41,10); write('Proporsi data 2         = ',proppop2:3:4);
			 gotoxy(1,12); write('Taraf signifikansi      = '); read(ts);
			 gotoxy(1,12); write('Taraf signifikansi      = ',ts:3:4);
			 gotoxy(1,13); write('Harga Z (      )        = ');
			 if (uopsi1 = '1') or (uopsi1 = '2') then pelp := 0.5-ts;
			 if  uopsi1 = '3' then pelp := 0.5-(ts/2);
			 sigma   := 1;
			 mu      := 0;
			 cmati;
			 py := 13;
			 integrasi(py);
			 cbesar;
			 uji_proporsi_z;
			 {if opsi3 = #27 then goto 50;}
	  end;
	  if pilih = 11 then
	  begin
					 menu2(ndp);
					 pmenu := readkey;
					 case pmenu of
					 '0': goto 10;
					 '1': input(ndp);
					 '2': load(ndp);
					 end;
					 tampilan('Display data');
					 display_data(namaf,ndp);
					 terus;
					 tampilan('Deskripsi data');
					 data_sampel;
	  end;
	  if pilih = 12 then
	  begin
					 cmati;
					 tampilan('Daftar file');
					 textbackground(black);
					 textcolor(white);
					 exec('STAT_22.exe','');
	  end;
	  ulang;
          Hapus_layar;
	  until (upcase(opsi) = 'x') or (upcase(opsi) = 'X') or (upcase(opsi) = 't') or (upcase(opsi) = 'T');
end.