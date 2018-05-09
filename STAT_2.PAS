{$N+}{$M 4000,0,0}
Program statistika_eksloratif;
uses printer,crt,dos,stat_gam,stat_m;
type
	  datar = array[1..100] of real;
     screentype   = (mono,color);
const
     toleransi  = 1.0e-5;
     tol        = 1e-5;

var
   x                                            : datar;
   sigma,sbs,xbar,mu,sigmaxbar,sigmaximu,
   sigmaxixbar,sigmas,batas,proppop,jprop,atas,
   bawah,itatas,itbawah,ttatas,ttbawah,akhir,
   delx,genap,ganjil,total,total1,xx,xi,prob,ft,
   ftt,sft,sftt,min,mak,minl,makl,chi,chi2,t,ts,
   ct,ct1,ct2,zd,td,cd,tl,pelp,pelm,pel1,pel2,pnol              : real;
   segmen                                       : extended;
	prop,i,j,ii,jj,Nbes,nkec,bagian,
   ndp,pilih,dk                               : integer;
   nama,namaf                                   : string[10];
   dopsi                                        : string[1];
   opsi,opsi2,opsi3,opsi4,opsi5,lagi,pmenu: char;
   ps,uopsi1,uopsi2,uopsi3,uopsi4,uopsi5           : char;
   pp,pt,py,nu,ng                              : byte;
   taua,taub,tau,xa,xbx,tperv,pang,pangkat      : extended;
   stype : screentype;

Label 10,20,30,40,50;

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
	nama : kata;
   fk    : filekata;
   fi    : fileint;
   frx    : filereal;

begin
	  clrscr;
	  tampilan('STATISTIKA EKSPLORATIF');
     textbackground(black);
     textcolor(white);
	  gotoxy(20,3); write('Nama File : '); readln(nama);
	  namaf := nama;
	  assign(fk,nama);
	  assign(fi,nama+'.dat');
	  assign(frx,nama+'xi.dat');
	  rewrite(fk);
	  rewrite(fi);
	  rewrite(frx);
	  gotoxy(20,4); write('                      ');
	  gotoxy(20,4); write('Ukuran sampel    = '); readln(ndp);
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
	ada  : boolean;
	metu : char;
label 01;

begin
     01:
	  clrscr;
	  tampilan('STATISTIKA EKSPLORATIF');
     textbackground(black);
	  textcolor(white);
	  cbesar;
     gotoxy(20,3); write('Nama File                : ');
     gotoxy(47,3); read(nama);
     readln;
     gotoxy(20,5); write('Pilihan variabel (x/y/w) : '); read(dopsi);
     readln;
     namaf := nama;
     {$I-}
     assign(fk,nama);
     assign(fi,nama+'.dat');
     assign(frx,nama+dopsi+'i.dat');
     reset(fk);
     reset(fi);
     reset(frx);
     {$I+}
     ada := (IOResult = 0);
	  if ada then
     begin
          read(fk,nama);
          read(fi,ndp);
          for i := 1 to ndp do
          begin
               read(frx,x[i]);
          end;
          min_mak(ndp,min,mak);
     end;
     if not ada then
     begin
          clrscr;
			 textcolor(red);
			 cmati;
			 gotoxy(5,22); write('FILE TIDAK ADA ! ');
			 gotoxy(5,23); write('Tekan <Esc> Keluar   Tekan <Enter> Ulang');
			 metu := readkey;
			 if metu = #27 then halt else goto 01;
	  end;
	  textcolor(yellow);
     close(fk);
     close(fi);
     close(frx);
end;

procedure menu1;
begin
     clrscr;
     repeat
     clrscr;
     cbesar;
     textbackground(black);
     textbackground(brown);
	  textcolor(Yellow);
	  gotoxy(20,1);   write('           STATISTIKA EKSPLORATIF         ');
	  textbackground(blue);
	  textcolor(white);
	  gotoxy(20,3);   write('                                          ');
	  gotoxy(20,4);   write(' A. Simpangan baku sampel                 ');
	  gotoxy(20,5);   write(' B. Estimasi rata-rata dengan statistik Z ');
	  gotoxy(20,6);   write(' C. Estimasi rata-rata dengan statistik t ');
	  gotoxy(20,7);   write(' D. Estimasi variansi populasi            ');
	  gotoxy(20,8);   write(' E. Estimasi proporsi populasi            ');
	  gotoxy(20,9);   write(' F. Uji rata-rata statistika Z            ');
	  gotoxy(20,10);  write(' G. Uji rata-rata statistika t            ');
	  gotoxy(20,11);  write(' H. Uji proporsi statistika  Z            ');
	  gotoxy(20,12);  write(' I. Uji variansi statistika  Chiý         ');
	  gotoxy(20,13);  write(' X. [MENU UTAMA]                          ');
	  gotoxy(20,14);  write('                                          ');
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
	  gotoxy(20,13);   write(' X');
	  textbackground(cyan);
	  textcolor(Yellow);
     gotoxy(20,16);  write('                Pilihanku :               ');
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
			  gotoxy(48,16); write('-');
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
     end;
	  until opsi in ['x','a','b','c','d','e','f','g','h','i',
           'X','A','B','C','D','E','F','G','H','I'];
     clrscr;
     textbackground(black);
     textcolor(white);
end;

procedure menu2(var ndp : integer);
begin
	clrscr;
	tampilan('STATISTIKA EKSPLORATIF');
	textbackground(blue);
	textcolor(white);
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
	  textcolor(white);
end;

procedure Uji_hipotesis;
begin
	  clrscr;
	  tampilan('STATISTIKA EKSPLORATIF');
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
	  gotoxy(27,10); write('       Pilihanku :             ');
	  gotoxy(48,10);
	  uopsi1 := readkey;
	  textbackground(black);
	  textcolor(white);
end;

procedure display_data(nama : string; var ndp : Integer);
begin
	  textbackground(black);
	  textcolor(white);
     gotoxy(45,4); write('Data pilihan ',upcase(opsi));
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
	  for i := 3 to 24 do
	  begin
			 gotoxy(40,i); writeln('+');
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

procedure SESamp;
begin
     xbar := 0;
     for i := 1 to nkec do
     begin
          xbar := xbar + x[i];
     end;
     xbar := xbar/nkec;
     sigmaxixbar := 0;
     for i := 1 to nkec do
     begin
          sigmaxixbar := sigmaxixbar + sqr((x[i]-xbar))
     end;
     sbs := sqrt(sigmaxixbar/(nkec-1))
end;

procedure SEProp;
begin
     SESamp;
     jprop := 1;
     for i := 1 to nkec do
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
     proppop := jprop/nkec;
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

procedure Simpsont(atas,bawah : real; var total : extended);

     function pow(a,b : real): extended;
     begin
          pow := exp(b*ln(a));
     end;

     function Fx(t : real) : real;
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
                simpsont(t,0,segmen);
                prob := segmen;
                gotoXY(1,pp);  write('Peluang                 = ',(prob+0.5):6:4);
                gotoXY(1,pt);  write('Harga t tabel           = ',t:6:4);
                t := t + 0.0001;
          until abs((prob+0.5)-pelp) <= tol;
end;

Procedure peluang1;
begin
     nu     := nkec-1;
     itatas := t;
     integrasi2(12,13);
     prob := prob + 0.5;
end;

Procedure peluang2;
begin
     nu     := nkec-1;
     itatas := t;
     integrasi2(13,14);
     prob := prob + 0.5;
     if pelm < 0.5 then prob := 1 - prob;
end;

procedure estimasirataz;
var myumin,myumak : real;
begin
     gotoxy(1,12);
     write('Simpangan baku populasi = ');
     readln(sigma);
     myumin := xbar - (prob*(sigma/sqrt(nkec)));
     myumak := xbar + (prob*(sigma/sqrt(nkec)));
     gotoxy(1,14); writeln('ESTIMASI RATA-RATA POPULASI DENGAN');
     gotoxy(1,15); writeln('STATISTIKA Z');
     gotoxy(1,18); writeln(myumin:6:4,' ó æ ó ',myumak:6:4);
end;

procedure estimasiratat;
var myumin,myumak : real;
begin
     gotoXY(1,10);  write('Taraf signifikansi      = ');read(ts);
     gotoXY(1,10);  write('Taraf signifikansi      = ',ts:1:4);
     nu := nkec-1;
     gotoXY(1,11);  write('Harga dk                = ',nu:1);
     pelp   := 1-(ts/2);
     cmati;
     peluang1;
     gotoXY(1,11);  write('Harga dk                = ',nu:1);
     gotoXY(1,12);  write('Peluang                 = ',pelp:6:4);
     gotoXY(1,13);  write('Harga t                 = ',t:6:4);
     myumin := xbar - (prob*sbs/sqrt(nkec));
     myumak := xbar + (prob*sbs/sqrt(nkec));
     gotoxy(1,15); write('ESTIMASI RATA-RATA POPULASI DENGAN');
     gotoxy(1,16); write('STATISTIKA t');
     gotoxy(1,17); write(myumin:6:4,' ó æ ó ',myumak:6:4);
end;

Procedure estimasisimbak;
var varmin,varmak : real;
begin
     varmin := ((nkec-1)*sqr(sbs))/chi;
     varmak := ((nkec-1)*sqr(sbs))/chi2;
     gotoxy(1,16); write('ESTIMASI VARIANSI POPULASI DENGAN');
     gotoxy(1,17); write('STATISTIKA  Chiý');
     gotoxy(1,19); write(varmin:6:4,' ó  åý ó ',varmak:6:4);
end;

Procedure estimasiprop;
var propmin,propmak : real;
begin
     propmin := proppop-(prob*sqrt((proppop*(1-proppop))/nkec));
     propmak := proppop+(prob*sqrt((proppop*(1-proppop))/nkec));
     gotoxy(1,15); write('ESTIMASI PROPORSI DATA POPULASI DENGAN');
     gotoxy(1,16); write('STATISTIK Z');
     gotoxy(1,18); write(propmin:6:4,' ó  ã  ó ',propmak:6:4);
end;

Procedure uji_rata_z;
begin
     zd := (xbar-pnol)/(sigma/sqrt(nkec));
     gotoxy(1,14); write('Harga Z data            = ',zd:3:4);
     gotoxy(1,16); write('Kesimpulan :');
     if uopsi1 = '1' then
     begin
          if zd >= -itatas then
          begin
               gotoxy(1,17); write('Karena Z data ò -Z tabel maka');
               gotoxy(1,18); write('hipotesis diterima, æ ò æo');
          end else
          begin
               gotoxy(1,17); write('Karena Z data ó -Z tabel maka');
               gotoxy(1,18); write('hipotesis ditolak, æ < æo');
          end;
     end;
     if uopsi1 = '2' then
     begin
          if zd <= itatas then
          begin
               gotoxy(1,17); write('Karena Z data ó Z tabel maka');
               gotoxy(1,18); write('hipotesis diterima, æ ó æo');
          end else
          begin
               gotoxy(1,17); write('Karena Z data ò Z tabel maka');
               gotoxy(1,18); write('hipotesis ditolak, æ > æo');
          end;
     end;
     if uopsi1 = '3' then
     begin
          if (zd >= -itatas) and (zd <= itatas) then
          begin
               gotoxy(1,17); write('Karena -Z tabel ó Z data ó Z tabel');
               gotoxy(1,18); write('maka hipotesis diterima, æ = æo');
          end else
          begin
               if zd < -itatas then
               begin
                    gotoxy(1,17); write('Karena Z data < -Z tabel maka');
                    gotoxy(1,18); write('hipotesis ditolak, æ Ø æo');
               end;
               if zd > itatas then
               begin
                    gotoxy(1,17); write('Karena Z data > -Z tabel maka');
                    gotoxy(1,18); write('hipotesis ditolak, æ Ø æo');
               end;
          end;
     end;
end;

Procedure uji_proporsi_z;
begin
     zd := (proppop-pnol)/(sqrt(proppop*(1-proppop)/nkec));
     gotoxy(1,14); write('Harga Z data            = ',zd:3:4);
     gotoxy(1,16); write('Kesimpulan :');
     if uopsi1 = '1' then
     begin
          if zd >= -itatas then
          begin
               gotoxy(1,17); write('Karena Z data ò -Z tabel maka');
               gotoxy(1,18); write('hipotesis diterima, ã ò ão');
          end else
          begin
               gotoxy(1,17); write('Karena Z data ó -Z tabel maka');
               gotoxy(1,18); write('hipotesis ditolak, ã < ão');
          end;
     end;
     if uopsi1 = '2' then
     begin
          if zd <= itatas then
          begin
               gotoxy(1,17); write('Karena Z data ó Z tabel maka');
               gotoxy(1,18); write('hipotesis diterima, ã ó ão');
          end else
          begin
               gotoxy(1,17); write('Karena Z data ò Z tabel maka');
               gotoxy(1,18); write('hipotesis ditolak, ã > ão');
          end;
     end;
     if uopsi1 = '3' then
     begin
          if (zd >= -itatas) and (zd <= itatas) then
          begin
               gotoxy(1,17); write('Karena -Z tabel ó Z data ó Z tabel');
               gotoxy(1,18); write('maka hipotesis diterima, ã = ão');
          end else
          begin
               if zd < -itatas then
               begin
                    gotoxy(1,17); write('Karena Z data < -Z tabel maka');
                    gotoxy(1,18); write('hipotesis ditolak, ã Ø ão');
               end;
               if zd > itatas then
               begin
                    gotoxy(1,17); write('Karena Z data > -Z tabel maka');
                    gotoxy(1,18); write('hipotesis ditolak, ã Ø ão');
               end;
          end;
     end;
end;

procedure uji_rata_t;
var myumin,myumak : real;
begin
     if (uopsi1 = '1') or (uopsi1 = '2') then pelp := 1-ts;
     if  uopsi1 = '3' then pelp := 1-(ts/2);
     pelm := pelp;
     if pelp < 0.5 then
     begin
          pelp := 1 - pelp;
     end;
     cmati;
     nu := nkec-1;
     gotoXY(1,12);  write('Harga dk                = ',nu:1);
     peluang2;
     gotoXY(1,12);  write('Harga dk                = ',nu:1);
     gotoXY(1,13);  write('Peluang                 = ',pelm:6:4);
     if pelm < 0.5 then t := -t;
     gotoXY(1,14);  write('Harga t tabel           = ',t:6:4);
     td := (xbar-pnol)/(sbs/sqrt(nkec));
     gotoxy(1,15); write('Harga t data            = ',td:3:4);
     gotoxy(1,17); write('Kesimpulan :');
     if uopsi1 = '1' then
     begin
          if td >= -t then
          begin
               gotoxy(1,18); write('Karena t data ò -t tabel maka');
               gotoxy(1,19); write('hipotesis diterima, æ ò æo');
          end else
          begin
               gotoxy(1,18); write('Karena t data ó -t tabel maka');
               gotoxy(1,19); write('hipotesis ditolak, æ < æo');
          end;
     end;
     if uopsi1 = '2' then
     begin
          if td <= t then
          begin
               gotoxy(1,18); write('Karena t data ó t tabel maka');
               gotoxy(1,19); write('hipotesis diterima, æ ó æo');
          end else
          begin
               gotoxy(1,18); write('Karena t data ò t tabel maka');
               gotoxy(1,19); write('hipotesis ditolak, æ > æo');
          end;
     end;
     if uopsi1 = '3' then
     begin
          if (td >= -t) and (td <= t) then
          begin
               gotoxy(1,18); write('Karena -t tabel ó t data ó t tabel');
               gotoxy(1,19); write('maka hipotesis diterima, æ = æo');
          end else
          begin
               if td < -t then
               begin
                    gotoxy(1,18); write('Karena t data < -t tabel maka');
                    gotoxy(1,19); write('hipotesis ditolak, æ Ø æo');
               end;
               if zd > t then
               begin
                    gotoxy(1,18); write('Karena t data > -t tabel maka');
                    gotoxy(1,19); write('hipotesis ditolak, æ Ø æo');
               end;
          end;
     end;
end;

procedure data_sampel;
begin
     gotoxy(1,5); write('Ukuran sampel           = ',nkec);
     gotoxy(1,6); write('Rata-rata sampel        = ',xbar:3:4);
     gotoxy(1,7); write('Standar error sampel    = ',sbs:3:4);
     gotoxy(1,8); write('Data minimal            = ',min:3:4);
     gotoxy(1,9); write('Data maksimal           = ',mak:3:4);
end;

procedure pilopsi;
begin
     if uopsi1 = '1' then
     begin
          gotoxy(1,22); write('UJI SATU PIHAK UJUNG KIRI');
     end;
     if uopsi1 = '2' then
     begin
          gotoxy(1,22); write('UJI SATU PIHAK UJUNG KANAN');
     end;
     if uopsi1 = '3' then
     begin
			 gotoxy(1,22); write('UJI DUA PIHAK');
	  end;
end;

begin
	  10:
	  repeat
     Hapus_layar;
     warna(0,0,80,25,black);
     menu1;
     if pilih = 0 then halt;
     if pilih = 1 then
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
			 gotoxy(1,5); writeln('Ukuran sampel             = ',nkec);
			 gotoxy(1,6); writeln('Rata-rata sampel          = ',xbar:3:4);
			 gotoxy(1,7); writeln('Standar error sampel      = ',sbs:3:4);
			 gotoxy(1,8); writeln('Data minimal              = ',min:3:4);
			 gotoxy(1,9); writeln('Data maksimal             = ',mak:3:4);
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
          tampilan('Estimasi rata-rata dengan Z');
          display_data(namaf,nkec);
          SESamp;
          Data_sampel;
          gotoxy(1,10);write('Taraf signifikansi      = '); read(ts);
			 gotoxy(1,10);write('Taraf signifikansi      = ',ts:3:4);
			 gotoxy(1,11);write('Harga Z (      )        = ');
			 pelp := 0.5-(ts/2);
			 sigma   := 1;        mu      := 0;
			 cmati;
			 py := 11;
			 integrasi(py);
			 cbesar;
			 estimasirataz;
	  end;
	  if pilih = 3 then
	  begin
			 menu2(nkec);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nkec);
			 '2': Load_data1(nkec);
			 end;
			 tampilan('Estimasi rata-rata dengan t');
			 display_data(namaf,nkec);
			 SESamp;
			 Data_sampel;
			 estimasiratat;
	  end;
	  if pilih = 4 then
	  begin
			 menu2(nkec);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nkec);
			 '2': Load_data1(nkec);
			 end;
			 tampilan('Estimasi variansi');
			 display_data(namaf,nkec);
			 SESamp;
			 Data_sampel;
			 gotoxy(1,10); write('Variansi sampel         = ',sqr(sbs):3:4);
			 gotoxy(1,11); write('Taraf signifikansi      = '); read(ts);
			 gotoxy(1,11); write('Taraf signifikansi      = ',ts:3:4);
			 gotoxy(1,12); write('Derajat kebebasan       = ',nkec-1:1);
			 pel1 := 1-(ts/2);
			 pel2 := ts/2;
			 gotoxy(1,13); write('Chiý                    = ');
			 gotoxy(6,13); write('(',pel1:5:3,'; dk = ',nkec-1,')');
			 gotoxy(27,13);
			 read(chi);
			 gotoxy(1,14); write('Chiý                    = ');
			 gotoxy(6,14); write('(',pel2:5:3,'; dk = ',nkec-1,')');
			 gotoxy(27,14);
			 read(chi2);
			 estimasisimbak;
	  end;
	  if pilih = 5 then
	  begin
			 menu2(nkec);
			 pmenu := readkey;
			 case pmenu of
			 '0': goto 10;
			 '1': Enter_data1(nkec);
			 '2': Load_data1(nkec);
			 end;
			 tampilan('Estimasi proporsi');
			 display_data(namaf,nkec);
			 SESamp;
			 Data_sampel;
			 repeat
					 gotoxy(1,10);  write('Proporsi data           = ');
					 read(proppop);
			 until (proppop < 1) and (proppop > 0);
			 gotoxy(1,10); write('Proporsi data           = ',proppop:3:4);
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
			 estimasiprop;
	  end;
	  if pilih = 6 then
	  begin
			 uji_hipotesis;
          if uopsi1 = '0' then goto 10;
          menu2(nkec);
          pmenu := readkey;
          case pmenu of
          '0': goto 10;
          '1': Enter_data1(nkec);
          '2': Load_data1(nkec);
          end;
          tampilan('Uji rata-rata dengan Z');
          display_data(namaf,nkec);
          SESamp;
          Data_sampel;
			 pilopsi;
          gotoxy(1,10); write('Simpangan baku populasi = ');
          read(sigma);
          gotoxy(1,10); write('Simpangan baku populasi = ',sigma:3:4);
          gotoxy(1,11); write('Estimasi rata-rata      = ');
          read(pnol);
          gotoxy(1,11); write('Estimasi rata-rata      = ',pnol:3:4);
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
			 {if opsi3 = #27 then goto 20;}
	  end;
	  if pilih = 7 then
	  begin
			 uji_hipotesis;
			 if uopsi1 = '0' then goto 10;
			 menu2(nkec);
          pmenu := readkey;
          case pmenu of
          '0': goto 10;
          '1': Enter_data1(nkec);
          '2': Load_data1(nkec);
          end;
          tampilan('Uji rata-rata dengan t');
          display_data(namaf,nkec);
          SESamp;
          Data_sampel;
          pilopsi;
          gotoxy(1,10); write('Estimasi rata-rata      = ');
          read(pnol);
          gotoxy(1,10); write('Estimasi rata-rata      = ',pnol:3:4);
          gotoxy(1,11); write('Taraf signifikansi      = '); read(ts);
          gotoxy(1,11); write('Taraf signifikansi      = ',ts:3:4);
			 gotoxy(1,14); write('Harga t (      )        = ');
			 uji_rata_t;
			 {if opsi3 = #27 then goto 30;}
	  end;
	  if pilih = 8 then
	  begin
			 uji_hipotesis;
          if uopsi1 = '0' then goto 10;
          menu2(nkec);
          pmenu := readkey;
          case pmenu of
          '0': goto 10;
          '1': Enter_data1(nkec);
          '2': Load_data1(nkec);
          end;
          tampilan('Uji proporsi dengan Z');
          display_data(namaf,nkec);
          SESamp;
          Data_sampel;
			 pilopsi;
          gotoxy(1,10); write('Estimasi proporsi       = ');
          read(pnol);
          gotoxy(1,10); write('Estimasi proporsi       = ',pnol:3:4);
          gotoxy(1,11); write('Proporsi data           = ');
          read(proppop);
          gotoxy(1,11); write('Proporsi data           = ',proppop:3:4);
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
			 {if opsi3 = #27 then goto 40;}
	  end;
     if pilih = 9 then
     begin
			 uji_hipotesis;
          if uopsi1 = '0' then goto 10;
          menu2(nkec);
          pmenu := readkey;
          case pmenu of
          '0': goto 10;
          '1': Enter_data1(nkec);
          '2': Load_data1(nkec);
          end;
          tampilan('Uji variansi dengan Chiý');
          display_data(namaf,nkec);
          SESamp;
          Data_sampel;
          pilopsi;
          gotoxy(1,10); write('Estimasi variansi       = ');
          read(pnol);
			 gotoxy(1,10); write('Estimasi variansi       = ',pnol:3:4);
          gotoxy(1,11); write('Taraf signifikansi      = '); read(ts);
          gotoxy(1,11); write('Taraf signifikansi      = ',ts:3:4);
			 cd := ((nkec-1)*sqr(sbs))/pnol;
          gotoxy(1,12); write('Derajat kebebasan       = ',nkec-1:1);
          gotoxy(1,13); write('Harga Chiý data         = ',cd:3:4);
          if  uopsi1 = '1' then
          begin
               pelp := ts;
               gotoxy(1,14);  write('Harga Chiý (        )   = ');
               gotoxy(13,14); write(pelp:1:3,';',nkec-1);
               gotoxy(28,14); read(ct);
          end;
          if  uopsi1 = '2' then
          begin
               pelp := 1-ts;
               gotoxy(1,14);  write('Harga Chiý (        )   = ');
               gotoxy(13,14); write(pelp:1:3,';',nkec-1);
               gotoxy(28,14); read(ct);
			 end;
          if  uopsi1 = '3' then
          begin
					pel1 := ts/2;
               pel2 := 1-(ts/2);
               gotoxy(1,14);  write('Harga Chiý (        )   = ');
               gotoxy(13,14); write(pel1:1:3,';',nkec-1);
               gotoxy(28,14); read(ct1);
               gotoxy(1,15);  write('Harga Chiý (        )   = ');
               gotoxy(13,15); write(pel2:1:3,';',nkec-1);
               gotoxy(28,15); read(ct2);
          end;
          gotoxy(1,17);  write('Kesimpulan :');
          if uopsi1 = '1' then
          begin
               if cd >= ct then
               begin
                    gotoxy(1,18);  write('Karena Chiý data ò Chiý tabel maka');
                    gotoxy(1,19);  write('hipotesis diterima, åý ò åýo');
					end else
               begin
                    gotoxy(1,18);  write('Karena Chiý data < Chiý tabel maka');
						  gotoxy(1,19);  write('hipotesis ditolak, åý < åýo');
               end;
          end;
          if uopsi1 = '2' then
          begin
               if cd <= ct then
               begin
                    gotoxy(1,18);  write('Karena Chiý data ó Chiý tabel maka');
                    gotoxy(1,19);  write('hipotesis diterima, åý ó åýo');
               end else
               begin
                    gotoxy(1,18);  write('Karena Chiý data > Chiý tabel maka');
                    gotoxy(1,19);  write('hipotesis ditolak, åý > åýo');
               end;
          end;
          if uopsi1 = '3' then
			 begin
               if (cd <= ct2) and (cd >= ct1) then
               begin
						  gotoxy(1,18);  write('¯¯ Chiý tabel ó Chiý data ó Chiý tabel');
                    gotoxy(1,19);  write('maka hipotesis diterima, åý = åýo');
               end else
               begin
                    if cd > ct2 then
                    begin
                         gotoxy(1,18);  write('Karena Chiý data > Chiý tabel maka');
                         gotoxy(1,19);  write('hipotesis ditolak, åý Ø åýo');
                    end;
                    if cd < ct1 then
                    begin
                         gotoxy(1,18);  write('Karena Chiý data < Chiý tabel maka');
                         gotoxy(1,19);  write('hipotesis ditolak, åý Ø åýo');
                    end;
               end;
          end;
			 {if opsi3 = #27 then goto 50;}
	  end;
	  ulang;
          Hapus_layar;
	  until (upcase(opsi) = 'x') or (upcase(opsi) = 'X') or (upcase(opsi) = 't') or (upcase(opsi) = 'T');
end.