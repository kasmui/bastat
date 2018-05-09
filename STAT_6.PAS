{$N+}{$M 8000,0,0}
Program Statistika_korelasi;
uses dos,stat_m,CRT;
const toleransi  = 1.0e-5;
type vector  = array[1..100] of real;
	  datak   = array[1..100] of integer;
	  rext    = array[1..100] of extended;
	  datav	 = array[1..100,1..100] of integer;
	  screentype   = (mono,color);
var x,y,ytopi,yaksen,residu,sqresidu                  : vector;
	 rb,yu,ru,propa,propb,paksen,zd,xse,yse,dev,ftab,ttab,sgab                  : real;
	 butir,cnt,ndp,jndp,xndp,yndp,i,pilih             : integer;
	 sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,
	 JKtot,JKa,RJKa,sum11,sum12,sum13,sum14,sum15,sum16,
	 sum17,sum18,sum19,sum20,sum21,x5,x6,x2y,x3y,sstotal,xpery,pery,
	 jkx,jky,sbx,sby,rtab,tdata,rsquared,r,dif1,dif2,meanx,meany,pqt   : real;
	 bs,bi,jts,jti,yv,nu1,nu2,jd,j,jj,kj               : byte;
	 rxy,rxy2,rpq,rpq2,sumy,sum2y,sumy2,jk             : vector;
	 ps,metu,lagi,answer,opsi,opsiu,opsi2,opsi3,opsi4,opsi5      : char;
	 stype                                             : screentype;
	 flag                                              : boolean;
	 tz,pel,O,E,OE,pai,qbi,pqi : array[1..50] of real;
	 total2,total12,kelas,prob2 : rext;
	 sigma,sbs,sigmaximu,sigmaxixbar,xbar,mu,sigmafx,sigmaxbar,
	 rkecBes,sigmas,batas,fak,atas,bawah,itatas,itbawah,ttatas,
	 ttbawah,akhir,delx,mid,ganjil,genap,total,total1,xi,prob,
	 ft,ftt,sft,sftt,chi,chitab,pelm,pelz : real;
	 segmen,segmen2,bidang      : extended;
	 bagian,probii,probi    : integer;
	 si,xpq							: datav;
	 js,ji,ypq 						: datak;
         reg : registers;
Label 10;

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


procedure printing;
begin
	  clrscr;
	  textbackground(blue);
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

	 procedure input;
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
			tampilan('Input data');
			Cbesar;
			textbackground(black);
			textcolor(white);
			gotoxy(15,3); write('NAMA FILE : '); readln(nama);
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
				  write('x(':16,cnt,') = '); readln(x[cnt]); write(frx,x[cnt]);
				  write('y(':16,cnt,') = '); readln(y[cnt]); write(fry,y[cnt]);
				  writeln;
			end;
			close(fk);
			close(fi);
			close(frx);
			close(fry);
	 end;

    procedure load;
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
	 label 01;

	 begin
			01:
			clrscr;
			tampilan('Ambil data');
			cbesar;
			textbackground(black);
			textcolor(white);
			gotoxy(25,3); write('NAMA FILE : '); readln(nama);
			{$I-}
			assign(fk,nama);
			assign(fi,nama+'.dat');
			assign(frx,nama+'xi.dat');
			assign(fry,nama+'yi.dat');
			reset(fk);
			reset(fi);
			reset(frx);
			reset(fry);
			{$I+}
			ada := (IOResult = 0);
			if ada then
			begin
				  read(fk,nama);
				  read(fi,ndp);
				  for cnt := 1 to ndp do
				  begin
						 read(frx,x[cnt]);
				  end;
				  for cnt := 1 to ndp do
				  begin
						 read(fry,y[cnt]);
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
			close(fk);
			close(fi);
			close(frx);
			close(fry);
			{close(frw);}
	 end;


	 procedure inputxy;
	 type
		  kata   = string[10];
		  fvec  = file of datav;
		  fmat = file of datak;
		  fint   = file of integer;
		  fkata  = file of kata;
	 var nama    : kata;
		  fk      : fkata;
		  fi      : fint;
		  frx		 : fvec;
		  fry 	: fmat;
			ada     : boolean;

		  begin
			clrscr;
			tampilan('Input data');
			Cbesar;
			textbackground(black);
			textcolor(white);
			gotoxy(15,3); write('NAMA FILE : '); readln(nama);
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
			gotoxy(15,4); write('Jumlah butir = '); readln(butir);
			write(fi,butir);
			gotoxy(15,5); write('Jumlah kasus = '); readln(ndp);
			write(fi,ndp);
			writeln;
			ClrScr;

			for i := 1 to butir do
			begin
				for cnt := 1 to ndp do
				begin
				  gotoxy(5+(2*i),3    ); 	write(i);
				  gotoxy(2,  3+cnt); 		write(cnt);
				  gotoxy(5+(2*i),3+cnt); 	readln(xpq[i,cnt]); write(frx,xpq);
				end;
			end;
			for cnt := 1 to ndp do
			begin
				  gotoxy(75,3+cnt); readln(ypq[cnt]); write(fry,ypq);
			end;
			close(fk);
			close(fi);
			close(frx);
			close(fry);
	 end;

	 procedure loadxy;
	 type
		  kata   = string[10];
		  fvec  = file of datav;
		  fmat = file of datak;
		  fint   = file of integer;
		  fkata  = file of kata;
	 var nama    : kata;
		  fk      : fkata;
		  fi      : fint;
		  frx		 : fvec;
		  fry 	: fmat;
			ada     : boolean;

	 label 01;

	 begin
			01:
			clrscr;
			tampilan('Ambil data');
			cbesar;
			textbackground(black);
			textcolor(white);
			gotoxy(15,3); write('NAMA FILE : '); readln(nama);

			{$I-}
			assign(fk,nama);
			assign(fi,nama+'.dat');
			assign(frx,nama+'xi.dat');
			assign(fry,nama+'yi.dat');
			reset(fk);
			reset(fi);
			reset(frx);
			reset(fry);
			{$I+}
			ada := (IOResult = 0);

			if ada then
			begin
				  read(fk,nama);
				  read(fi,butir);
				  read(fi,ndp);
				  for i := 1 to butir do
				  begin
						for cnt := 1 to ndp do
						begin
							read(frx,xpq);
						end;
				  end;
				  for cnt := 1 to ndp do
				  begin
						 read(fry,ypq);
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
			close(fk);
			close(fi);
			close(frx);
			close(fry);
	 end;


Procedure tuptext;
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
	opsi2 := readkey;
end;


	 procedure calc;
	 begin
			sum1  := 0;  sum2  := 0;  sum3  := 0;  sum4 := 0;  sum5  := 0;
         sum6  := 0;  sum7  := 0;  sum8  := 0;  sum9 := 0;  sum10 := 0;
         sum11 := 0;  sum12 := 0; sum13  := 0; sum14 := 0;  sum15 := 0;
         sum16 := 0;  sum17 := 0;  sum18 := 0; sum19 := 0;  sum20 := 0;
			sum21 := 0;  x2y   := 0;  x3y   := 0; x5    := 0;  x6    := 0;
         xpery := 0;  pery  := 0;
			for cnt := 1 to ndp do
         begin
				  sum1  := sum1  + 1; {ndp}
				  sum2  := sum2  + x[cnt] ; {sigma x}
				  sum3  := sum3  + y[cnt] ; {sigma y}
				  sum4  := sum4  + sqr(x[cnt]) ; {sigma xý}
				  sum5  := sum5  + x[cnt]*y[cnt] ; {sigma xy}
				  sum6  := sum6  + sqr(y[cnt]) ; {sigma yý}
				  sum7  := sum7  + sqr(y[cnt])*y[cnt] ; {sigma y^3}
				  sum8  := sum8  + sqr(x[cnt])*x[cnt] ; {sigma x^3}
				  sum9  := sum9  + sqr(y[cnt])*sqr(y[cnt]) ; {sigma y^4}
				  sum10 := sum10 + sqr(x[cnt])*sqr(x[cnt]) ; {sigma x^4}
				  sum11 := sum11 + ln(x[cnt]) ; {sigma lnx}
				  sum12 := sum12 + ln(y[cnt]) ; {sigma lny}
				  sum13 := sum13 + sqr(ln(x[cnt])) ; {sigma lnxý}
				  sum14 := sum14 + x[cnt]*ln(y[cnt]) ; {sigma xlny}
				  sum15 := sum15 + sqr(ln(y[cnt])) ; {sigma lnyý}
				  sum16 := sum16 + ln(x[cnt])*ln(y[cnt]) ; {sigma lnxlny}
				  x5    := x5    + sqr(x[cnt])*sqr(x[cnt])*x[cnt] ; {sigma x^5}
				  x6    := x6    + sqr(x[cnt])*sqr(x[cnt])*sqr(x[cnt]) ;
				  x2y   := x2y   + sqr(x[cnt])*y[cnt] ; {sigma x2y}
				  x3y   := x3y   + sqr(x[cnt])*x[cnt]*y[cnt] ; {sigma x3y}
              xpery := xpery + x[cnt]*(1/y[cnt]); {sigma xpery}
              pery  := pery  + (1/y[cnt]); {sigma sepery}
         end;
         Jktot := sum6;
         JKa   := sqr(sum3)/ndp;
			RJKa  := JKa/1;
         meanx := sum2/ndp;
         meany := sum3/ndp;
         for cnt := 1 to ndp do
         begin
              sum17 := sum17 + (x[cnt]-meanx); {sigma x-xbar}
				  sum18 := sum18 + sqr((x[cnt]-meanx)); {sigma sqrx-xbar}
              sum19 := sum19 + (y[cnt]-meany); {sigma y-ybar}
              sum20 := sum20 + sqr((y[cnt]-meany)); {sigma sqry-ybar}
         end;
	 end;

	 procedure calcxy;
	 begin
			sum1  := 0;  sum2  := 0;  sum3  := 0;
			sum4 := 0;   sum5  := 0;  sum6  := 0;
			for cnt := 1 to ndp do
			begin
				  sum1  := sum1  + 1; {ndp}
				  sum2  := sum2  + xpq[i,cnt] ; {sigma x}
				  sum3  := sum3  + ypq[cnt] ; {sigma y}
				  sum4  := sum4  + sqr(xpq[i,cnt]) ; {sigma xý}
				  sum5  := sum5  + xpq[i,cnt]*ypq[cnt] ; {sigma xy}
				  sum6  := sum6  + sqr(ypq[cnt]) ; {sigma yý}
			end;
			if ndp > 30 then jndp := ndp else jndp := ndp-1;
			JKx := sum4 - (sum2/jndp);
			SBx := sqrt(JKx/(ndp-1));
			JKy := sum6 - (sum3/jndp);
			SBy := sqrt(JKy/(ndp-1));
			meanx := sum2/ndp;
			meany := sum3/ndp;
			rxy[i] := ((ndp*sum5)-(sum2*sum3))/sqrt(((ndp*sum4)-
						 sqr(sum2))*((ndp*sum6)-sqr(sum3)));
			rxy2[i] := sqr(rpq[i]);
			rpq[i] := ((rxy[i]*SBy)-SBx)/
						 sqrt((sqr(SBx)+sqr(SBy))-(2*rxy[i]*SBx*SBy));
			rpq2[i] := sqr(rpq[i]);
	 end;


	 procedure sum;
	 begin
			clrscr;
			printing;
			clrscr;
			textbackground(black);
			textcolor(white);
			tampilan('Ringkasan hitungan data ');
			gotoxy(20,3); writeln('ä data         = ',sum1:10:8);
			gotoxy(20,4); writeln('ä X            = ',sum2:10:8);
			gotoxy(20,5); writeln('ä Y            = ',sum3:10:8);
			gotoxy(20,6); writeln('ä 1/Y          = ',pery:10:8);
			gotoxy(20,7); writeln('Mean X         = ',meanx:10:8);
			gotoxy(20,8); writeln('Mean Y         = ',meany:10:8);
			gotoxy(20,9); writeln('ä Xý           = ',sum4:10:8);
         gotoxy(20,10);writeln('ä Yý           = ',sum6:10:8);
         gotoxy(20,11);writeln('ä XY           = ',sum5:10:8);
         gotoxy(20,12);writeln('ä X/Y          = ',xpery:10:8);
         gotoxy(20,13);writeln('ä XýY          = ',x2y:10:8);
         gotoxy(20,14);writeln('ä X^3          = ',sum8:10:8);
         gotoxy(20,15);writeln('ä X^3Y         = ',x3y:10:8);
         gotoxy(20,16);writeln('ä Y^3          = ',sum7:10:8);
			gotoxy(20,17);writeln('ä X^4          = ',sum10:10:8);
         gotoxy(20,18);writeln('ä X^5          = ',x5:10:8);
         gotoxy(20,19);writeln('ä X^6          = ',x6:10:8);
         gotoxy(20,20);writeln('ä Y^4          = ',sum9:10:8);
         gotoxy(20,21);writeln('ä ln(X)        = ',sum11:10:8);
         gotoxy(20,22);writeln('ä ln(Y)        = ',sum12:10:8);
         if ps = '2' then intr(5,reg);
         tuptext;
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

    procedure integrasi;
    begin
         itbawah := 0;
         itatas  := 0;
			repeat
               simpsonz(itatas,itbawah,segmen);
               prob := (segmen);
               gotoXY(1,13);
               write('Harga Z                   = ',itatas:8:4);
               itatas := itatas + 0.00001
         until abs(prob-pelz) <= 1e-5;
    end;

    procedure tabzet(var itatas : real);
	 begin
         pelz := paksen;
         pelm := pelz;
         if pelm < 0 then pelz := -pelz;
         sigma   := 1;
         mu      := 0;
         integrasi;
         if pelm < 0 then itatas := -itatas;
	 end;

	 procedure r_tabel;
	 begin
	 case (ndp-2) of
	 1 : rtab := 0.997;
	 2 : rtab := 0.950;
	 3 : rtab := 0.878;
	 4 : rtab := 0.811;
	 5 : rtab := 0.754;
	 6 : rtab := 0.707;
	 7 : rtab := 0.666;
	 8 : rtab := 0.632;
	 9 : rtab := 0.602;
	10 : rtab := 0.576;
	11 : rtab := 0.553;
	12 : rtab := 0.532;
	13 : rtab := 0.514;
	14 : rtab := 0.497;
	15 : rtab := 0.482;
	16 : rtab := 0.468;
	17 : rtab := 0.456;
	18 : rtab := 0.444;
	19 : rtab := 0.433;
	20 : rtab := 0.423;
	21 : rtab := 0.413;
	22 : rtab := 0.404;
	23 : rtab := 0.396;
	24 : rtab := 0.388;
	25 : rtab := 0.381;
	26 : rtab := 0.374;
	27 : rtab := 0.367;
	28 : rtab := 0.361;
	29 : rtab := 0.355;
	30..34 : rtab := 0.349;
	35..39 : rtab := 0.325;
	40..44 : rtab := 0.304;
	45..49 : rtab := 0.288;
	50..59 : rtab := 0.273;
	60..69 : rtab := 0.250;
	70..79 : rtab := 0.232;
	80..89 : rtab := 0.217;
	90..99 : rtab := 0.205;
  100..109 : rtab := 0.195;
	end;
	end;

	 procedure product_moment;
	 begin
			clrscr;
			printing;
			clrscr;
			r        := ((ndp*sum5)-(sum2*sum3))/
                      sqrt(((ndp*sum4)-sqr(sum2))*((ndp*sum6)-sqr(sum3)));
         rsquared := sqr(r);
         tdata     := r*sqrt(ndp-2)/sqrt(1-rsquared);
         textbackground(black);
         textcolor(white);
         tampilan('Korelasi Product-Moment');
			gotoxy(5,5); write('Harga koef korelasi    (r)  = ',r:8:4);
         gotoxy(5,6); write('Harga koef determinasi (rý) = ',rsquared:8:4,' (pengaruhnya sebesar ',100*rsquared:8:2,' %)');
         textcolor(yellow);
			gotoxy(5,8); write('Interpretasi harga r : ');
         textcolor(white);
         if r > 0 then
			begin
              if  (r > 0) and (r < 0.2) then
              begin
						 gotoxy(5,9); write('1. Korelasi positif/langsung sangat rendah');
				  end;
				  if  (r >= 0.2) and (r < 0.4) then
				  begin
						 gotoxy(5,9); write('1. Korelasi positif/langsung rendah');
				  end;
				  if  (r >= 0.4) and (r < 0.6) then
				  begin
						 gotoxy(5,9); write('1. Korelasi positif/langsung agak rendah');
				  end;
				  if  (r >= 0.6) and (r < 0.8) then
				  begin
						 gotoxy(5,9); write('1. Korelasi positif/langsung cukup');
				  end;
				  if  (r >= 0.8) and (r <= 1) then
				  begin
						 gotoxy(5,9); write('1. Korelasi positif/langsung tinggi');
				  end;

			end;
			if r = 0 then
			begin
				  gotoxy(5,9); write('1. Tidak terdapat hubungan linier');
			end;
			if r < 0 then
			begin
				  if  (r < 0) and (r > -0.2) then
				  begin
						 gotoxy(5,9); write('1. Korelasi negatif/tak langsung sangat rendah');
				  end;
				  if  (r <= -0.2) and (r > -0.4) then
				  begin
						 gotoxy(5,9); write('1. Korelasi negatif/tak langsung rendah');
				  end;
				  if  (r <= -0.4) and (r > -0.6) then
				  begin
						 gotoxy(5,9); write('1. Korelasi negatif/tak langsung agak rendah');
				  end;
				  if  (r <= -0.6) and (r > -0.8) then
				  begin
						 gotoxy(5,9); write('1. Korelasi negatif/tak langsung cukup');
				  end;
				  if  (r <= -0.8) and (r >= -1) then
				  begin
						 gotoxy(5,9);  write('1. Korelasi negatif/tak langsung tinggi');
				  end;
			end;
			gotoxy(5,11);  write('2. Harga t data                = ',tdata:8:4);
			gotoxy(5,12);  write('                               = ');
			gotoxy(5,12);  write('   Harga t tabel (0,975;',ndp-2,')');
			gotoxy(40,12); read(ttab);
			if (tdata >= -ttab) and (tdata <= ttab) then
			begin
				gotoxy(5,14);  write('   Karena -t tabel < t data < t tabel maka ');
				gotoxy(5,15);  write('   harga r sampel tidak berarti ');
			end else
			begin
				if tdata < -ttab then
				begin
					gotoxy(5,14);  write('   Karena t data < -t tabel maka ');
					gotoxy(5,15);  write('   harga r sampel berarti ');
				end;
				if tdata > ttab then
				begin
					gotoxy(5,14);  write('   Karena t data > t tabel maka ');
					gotoxy(5,15);  write('   harga r sampel berarti ');
				end;
			end;
			r_tabel;
			gotoxy(5,17);  write('3. Harga r data                = ',r:8:4);
			gotoxy(5,18);  write('                               = ');
			gotoxy(5,18);  write('   Harga r tabel               = ',rtab:8:4);
			if (r >= rtab) then
			begin
				gotoxy(5,20);  write('   Karena r data > r tabel maka ');
				gotoxy(5,21);  write('   harga r sampel menunjukkan korelasi yang signifikan');
			end else
			begin
				gotoxy(5,20);  write('   Karena r data < r tabel maka ');
				gotoxy(5,21);  write('   harga r sampel tidak menunjukkan korelasi yang signifikan');
			end;

			if ps = '2' then intr(5,reg);
			tuptext;
	 end;

	 procedure reliabilitas;
	 begin
			clrscr;
			printing;
			clrscr;
			textbackground(black);
			textcolor(white);
			tampilan('Analisis Reliabilitas');
			textcolor(white);
			for i := 1 to butir do
			begin
				calcxy;
			end;
			r_tabel;
			gotoxy(5,3);  		write('r xy':8);
			gotoxy(15,3); 		write('r pq':8);
			gotoxy(25,3); 		write('r tab':8);
			gotoxy(45,3);  	write('status');
			for i := 1 to butir do
			begin
				gotoxy(1,3+i);  write(i:2,'.');
				gotoxy(5,3+i);  write(rxy[i]:8:4);
				gotoxy(15,3+i); write(rpq[i]:8:4);
				gotoxy(25,3+i); write(rtab:8:4);
				if (rpq[i] >= rtab) then
				begin
					gotoxy(45,3+i);  write('o.k.');
				end else
				begin
					gotoxy(45,3+i);  write('gugur');
				end;
			end;

			if ps = '2' then intr(5,reg);
			tuptext;
	 end;


	 procedure data_sampel_1;
	 begin
         textbackground(black);
         textcolor(yellow);
         gotoxy(1,4); write('Kelompok A (atas) :');
			textcolor(white);
         gotoxy(1,5); write('Ukuran kelompok A         = ');readln(xndp);
         gotoxy(1,6); write('Rata-rata kelompok A      = ');readln(meanx);
         gotoxy(1,7); write('Simpangan baku kelompok A = ');readln(xse);
         gotoxy(1,5); write('Ukuran kelompok A         = ',xndp);
         gotoxy(1,6); write('Rata-rata kelompok A      = ',meanx:3:4);
         gotoxy(1,7); write('Simpangan baku kelompok A = ',xse:3:4);
    end;

    procedure data_sampel_2;
    begin
         textbackground(black);
			textcolor(yellow);
         gotoxy(41,4); write('Kelompok B (bawah) :');
         textcolor(white);
         gotoxy(41,5); write('Ukuran kelompok B         = ');readln(yndp);
         gotoxy(41,6); write('Rata-rata kelompok B      = ');readln(meany);
         gotoxy(41,7); write('Simpangan baku kelompok B = ');readln(yse);
         gotoxy(41,5); write('Ukuran kelompok B         = ',yndp);
         gotoxy(41,6); write('Rata-rata kelompok B      = ',meany:3:4);
         gotoxy(41,7); write('Simpangan baku kelompok B = ',yse:3:4);
    end;

    procedure biseri;
    begin
         clrscr;
         printing;
         clrscr;
         tampilan('Korelasi Biserial');
         cbesar;
         data_sampel_1;
         data_sampel_2;
			cmati;
         sgab := sqrt(((xndp-1)*sqr(xse)+(yndp-1)*sqr(yse))/(xndp+yndp-2));
         gotoxy(1,9);  write('Simpangan baku gabungan   = ',sgab:8:4);
         propa := xndp/(xndp+yndp);
         propb := 1 - propa;
         gotoxy(1,10); write('Proporsi kelompok A       = ',propa:8:4);
         gotoxy(1,11); write('Proporsi kelompok B       = ',propb:8:4);
         paksen := abs(propa-propb);
         paksen := paksen/2;
         gotoxy(1,12); write('Luas pada kurva normal    = ',paksen:8:4);
         tabzet(itatas);
         zd := itatas;
         yu := (1/sqrt(2*pi))*exp(-0.5*sqr(zd));
			gotoxy(1,14); write('Tinggi ordinat u          = ',yu:8:4);
			rb := ((meanx-meany)*propa*propb)/(yu*sgab);
			gotoxy(1,15); write('Harga korelasi biserial   = ',rb:8:4);
			r := rb;

			textcolor(yellow);
			gotoxy(1,17); write('Interpretasi harga r : ');
			textcolor(white);
			ru := (sqr(yu)/(propa*propb))*sqr(rb);
			tdata := (ru*(xndp+yndp-2))/(1-ru);
			gotoxy(1,18);  write('Harga t data               = ',tdata:8:4);
			cbesar;
			gotoxy(1,19);  write('                           = ');
			gotoxy(1,19);  write('Harga t tabel (0,975;',(xndp+yndp)-2,')');
			gotoxy(33,19); read(ttab);
			cmati;

			if (tdata >= -ttab) and (tdata <= ttab) then
			begin
				gotoxy(1,21);  write('Karena -t tabel < t data < t tabel maka ');
				gotoxy(1,22);  write('harga r sampel tidak berarti ');
			end else
			begin
				if (tdata > ttab) then
				begin
					gotoxy(1,21);  write('Karena t data > t tabel maka ');
					gotoxy(1,22);  write('harga r sampel berarti ');
				end;
				if (tdata < -ttab) then
				begin
					gotoxy(1,21);  write('Karena t data < -t tabel maka ');
					gotoxy(1,22);  write('harga r sampel berarti ');
				end;
			end;
			if ps = '2' then intr(5,reg);
         tuptext;
	 end;

	 procedure pbiseri;
    begin
         clrscr;
         printing;
         clrscr;
			tampilan('Korelasi Point Biserial');
			cbesar;
			data_sampel_1;
			data_sampel_2;
			cmati;
			sgab := sqrt(((xndp-1)*sqr(xse)+(yndp-1)*sqr(yse))/(xndp+yndp-2));
			gotoxy(1,9);  write('Simpangan baku gabungan   = ',sgab:8:4);
			propa := xndp/(xndp+yndp);
			propb := 1 - propa;
			gotoxy(1,10); write('Proporsi kelompok A       = ',propa:8:4);
			gotoxy(1,11); write('Proporsi kelompok B       = ',propb:8:4);
			{tabzet(itatas);
			zd := itatas;}
			rb := ((meanx-meany)/sgab)*sqrt(propa/propb);
			gotoxy(1,13); write('Koef kor point biserial   = ',rb:8:4);
			r := rb;

			{textcolor(yellow);
			gotoxy(1,17); write('Interpretasi harga r : ');
			textcolor(white);
			ru := (sqr(yu)/(propa*propb))*sqr(rb);
			tdata := (ru*(xndp+yndp-2))/(1-ru);
			gotoxy(1,18);  write('Harga t data               = ',tdata:8:4);
			cbesar;
			gotoxy(1,19);  write('                           = ');
			gotoxy(1,19);  write('Harga t tabel (0,975;',(xndp+yndp)-2,')');
			gotoxy(33,19); read(ttab);
			cmati;

			if (tdata >= -ttab) and (tdata <= ttab) then
			begin
				gotoxy(1,21);  write('Karena -t tabel < t data < t tabel maka ');
				gotoxy(1,22);  write('harga r sampel tidak berarti ');
			end else
			begin
				if (tdata > ttab) then
				begin
					gotoxy(1,21);  write('Karena t data > t tabel maka ');
					gotoxy(1,22);  write('harga r sampel berarti ');
				end;
				if (tdata < -ttab) then
				begin
					gotoxy(1,21);  write('Karena t data < -t tabel maka ');
					gotoxy(1,22);  write('harga r sampel berarti ');
				end;
			end;}
			if ps = '2' then intr(5,reg);
			tuptext;
	 end;


	 procedure menu1;
	 begin
			clrscr;
			textbackground(brown); textcolor(yellow);
			gotoxy(30,2);   write('   ASAL DATA    ');
			textbackground(blue); textcolor(white);
			gotoxy(30,4);   write('                ');
			gotoxy(30,5);   write(' 1. Data baru   ');
			gotoxy(30,6);   write(' 2. Ambil data  ');
			gotoxy(30,7);   write(' 3. Menu Utama  ');
			gotoxy(30,8);   write('                ');
			textcolor(yellow);
			gotoxy(30,5);   write(' 1');
			gotoxy(30,6);   write(' 2');
			gotoxy(30,7);   write(' 3');
			textbackground(cyan); textcolor(yellow);
			gotoxy(30,10);   write('   Pilihan :    ');
			gotoxy(43,10);
			opsi := readkey;
			textbackground(black);
			textcolor(white);
			case opsi of
			'1' : begin
						  input;
						  calc;
					end;
			'2' : begin
						  load; if metu <> #27 then calc else exit;
					end;
			'3' : exit;
			end;
	 end;


	 procedure menuxy;
	 begin
			clrscr;
			textbackground(brown); textcolor(yellow);
			gotoxy(30,2);   write('   ASAL DATA    ');
			textbackground(blue); textcolor(white);
			gotoxy(30,4);   write('                ');
			gotoxy(30,5);   write(' 1. Data baru   ');
			gotoxy(30,6);   write(' 2. Ambil data  ');
			gotoxy(30,7);   write(' 3. Menu Utama  ');
			gotoxy(30,8);   write('                ');
			textcolor(yellow);
			gotoxy(30,5);   write(' 1');
			gotoxy(30,6);   write(' 2');
			gotoxy(30,7);   write(' 3');
			textbackground(cyan); textcolor(yellow);
			gotoxy(30,10);   write('   Pilihan :    ');
			gotoxy(43,10);
			opsi := readkey;
			textbackground(black);
			textcolor(white);
			case opsi of
			'1' : begin
						  inputxy;
					end;
			'2' : begin
						  loadxy;
						  if metu <> #27 then calcxy else exit;
					end;
			'3' : exit;
			end;
	 end;

	 procedure menu2;
	 begin
			repeat
			clrscr;
			textbackground(black);
			textbackground(brown); textcolor(yellow);
			gotoxy(25,2);   writeln('        KORELASI TUNGGAL         ');
			textbackground(blue); textcolor(white);
			gotoxy(25,4);   writeln('                                 ');
			gotoxy(25,5);   writeln(' A. Deskripsi data               ');
			gotoxy(25,6);   writeln(' B. Korelasi Product-Moment      ');
			gotoxy(25,7);   writeln(' C. Korelasi Biserial            ');
			gotoxy(25,8);   writeln(' D. Korelasi Point Biserial      ');
			gotoxy(25,9);   writeln(' E. Analisis Reliabilitas        ');
			gotoxy(25,10);  writeln(' X. [MENU UTAMA]                 ');
			gotoxy(25,11);  writeln('                                 ');
			textcolor(yellow);
			gotoxy(25,5);   writeln(' A');
			gotoxy(25,6);   writeln(' B');
			gotoxy(25,7);   writeln(' C');
			gotoxy(25,8);   writeln(' D');
			gotoxy(25,9);   writeln(' E');
			gotoxy(25,10);  writeln(' X');
			textbackground(blue); textcolor(lightgreen);
			cbesar;
			gotoxy(25,13);  writeln('           Pilihan :             ');
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
			  textbackground(blue);
			  textcolor(i+6);
			  gotoxy(46,13); write('-');
			  delay(300);
			  inc(i,1);
			until keypressed;
			cbesar;
			textbackground(black);
			opsi3 := readkey;
			until upcase(opsi3) in ['A','B','C','D','E','X'];
			textbackground(black);
	 end;

begin
	  10:
	  textbackground(black);
	  menu2;
	  textbackground(black);
	  case upcase(opsi3) of
			  'A' : begin
							 menu1;
							 if opsi = '3' then goto 10;
							 sum;
							 if opsi2 = #13 then goto 10;
					  end;
			  'B' : begin
							  menu1;
							 if opsi = '3' then goto 10;
							 if metu <> #27 then product_moment else exit;
							 if opsi2 = #13 then goto 10;
					  end;
			  'C' : begin
							 clrscr;
							 biseri;
							 if opsi2 = #13 then goto 10;
					  end;
			  'D' : begin
							 clrscr;
							 pbiseri;
							 if opsi2 = #13 then goto 10;
					  end;
			  'E' : begin
							 clrscr;
							 menuxy;
							 reliabilitas;
							 if opsi2 = #13 then goto 10;
					  end;
			  'X' : halt;
			  end;
end.


