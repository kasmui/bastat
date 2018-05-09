{$N+}{$M 8000,0,0}
Program Statistika;
uses crt,printer,dos,graph,stat_m;
type vector  = array[1..100] of real;
	matrika = array[1..50,1..50] of real;
	datak   = array[1..100] of byte;
	datar   = vector;{array[1..50] of real;}
	screentype   = (mono,color);
var x,y,ytopi,yaksen,residu,sqresidu                  : vector;
    sl,ic,a,b,ss,dsl,dic,dev,ftab,ttab                  : real;
    cnt,ndp,i,pilih                                     : integer;
    sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10,
    JKtot,JKa,RJKa,sum11,sum12,sum13,sum14,sum15,sum16,
    sum17,sum18,sum19,sum20,sum21,x5,x6,x2y,x3y,sstotal,
    ssresidu,ssregresi,MSregresi,Msresidu,fdata,tdata,
    JKresidu,rsquared,r,sgsqb,sigmab,sgsqa,sigmaa,dif1,
    dif2,den,meanx,meany,xpery,xlnpery,pery,lnpery,
    yin,xvalue,s2ep,s2t,fdlin,jker,jktc,jkba,msba                  : real;
    nu1,nu2,jd,j,jj,kj                                     : byte;
	 k                                                   : datak;
	 sumy,sum2y,sumy2,jk                                 : datar;
    ps,metu,lagi,answer,opsi,opsiu,opsi2,opsi3,opsi4,opsi5      : char;
    stype                                               : screentype;
    flag                                                : boolean;
    reg : registers;
Label 10,20,30,40,50,60,70,80,90,100,110,120,130,140;

procedure printing;
begin
     clrscr;
	  textbackground(7);
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

Procedure tuptext;
const tulis2 = '<Esc>-Menu';
	 tulis1 = '<Enter>-Ulang';
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
	opsi2:= readkey;
	textbackground(black);
end;

Procedure tuptext2;
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
	opsi2:= readkey;
	textbackground(black);
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
		 Cbesar;
		 tampilan('Menyimpan data baru');
		 gotoxy(15,3); write('NAMA FILE : '); readln(nama);
		 writeln;
		 assign(fk,nama);
		 assign(fi,nama+'.dat');
		 assign(frx,nama+'xi.dat');
		 assign(fry,nama+'yi.dat');
		 {assign(frw,nama+'wi.dat');}
		 rewrite(fk);
		 rewrite(fi);
		 rewrite(frx);
		 rewrite(fry);
		 {rewrite(frw);}
		 write(fk,nama);
		 gotoxy(15,4); write('Banyaknya data sampel = '); readln(ndp);
		 write(fi,ndp);
		 {answer := 'n';}
		 writeln;
		 for cnt := 1 to ndp do
		 begin
			 write('x(':16,cnt,') = '); readln(x[cnt]);
			 if x[1] = 0 then x[1] := 0.0000001;
			 write(frx,x[cnt]);
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
		  metu    : char;
    label 01;

    begin
         01:
         clrscr;
	 cbesar;
	 tampilan('Ambil data tersimpan');
         textbackground(black);
         textcolor(yellow);
	 gotoxy(25,3); write('NAMA FILE : '); readln(nama);
         {$I-}
	 assign(fk,nama);
         assign(fi,nama+'.dat');
         assign(frx,nama+'xi.dat');
			assign(fry,nama+'yi.dat');
			{assign(frw,nama+'wi.dat');}
			reset(fk);
			reset(fi);
			reset(frx);
			reset(fry);
			{reset(frw);}
			{$I+}
			ada := (IOResult = 0);
			if ada then
			begin
				  read(fk,nama);
				  read(fi,ndp);
				  for cnt := 1 to ndp do
				  begin
						 read(frx,x[cnt]);
						 if x[1] = 0 then x[1] := 0.0000001;
				  end;
				  for cnt := 1 to ndp do
				  begin
						 read(fry,y[cnt]);
				  end;
				  {for cnt := 1 to ndp do
				  begin
				  read(frw,w[cnt]);
				  end;}
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

	 Procedure edit_data;
	 type
	     kata   = string[10];
	     freal  = file of real;
	     fint   = file of integer;
             fkata  = file of kata;
    var nama,namaf    : kata;
        fk,fke      : fkata;
        fi,fie      : fint;
	frx,fry,frxe,frye,frwe  : freal;
	yt : char;
	 Label 01;
    begin
         01 :
         clrscr;
			tampilan('Edit data tersimpan');
			textcolor(yellow);
			cbesar;
			gotoxy(20,3); write('NAMA FILE : '); readln(nama);
			{$I-}
			assign(fk,nama);
			assign(fi,nama+'.dat');
			assign(frx,nama+'xi.dat');
			assign(fry,nama+'yi.dat');
			{assign(frw,nama+'wi.dat');}

			reset(fk);
			reset(fi);
			reset(frx);
			reset(fry);
			{reset(frw);}
			{$I+}
			if IOResult = 0 then
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
				  {for cnt := 1 to ndp do
				  begin
						 read(frw,w[cnt]);
				  end;}
			end else
			begin
				  clrscr;
				  cmati;
				  textcolor(lightred); write(#7);
				  gotoxy(20,5); write('FILE TIDAK ADA ! ');
				  gotoxy(20,7); write('Tekan <Esc> Keluar atau <Enter> Ulang');
				  metu := readkey;
				  if metu = #27 then exit else goto 01;
			end;

			cbesar;
			textcolor(yellow);
			gotoxy(10,4); write('FILE BARU (harus sama dengan nama file asal) : '); readln(namaf);
			gotoxy(10,5); write('BANYAKNYA DATA : '); readln(ndp);

			assign(fke,namaf);
			assign(fie,namaf+'.dat');
			assign(frxe,namaf+'xi.dat');
			assign(frye,namaf+'yi.dat');
			{assign(frwe,namaf+'wi.dat');}

			rewrite(fke);
			rewrite(fie);
			rewrite(frxe);
			rewrite(frye);
			{rewrite(frwe);}

			write(fke,namaf);

			GotoXY(20,7);  write('   OPTION :     ');
			GotoXY(20,8);  write('1. EDIT DATA    ');
			GotoXY(20,9);  write('2. TAMBAH DATA  ');
			GotoXY(20,10);  write('3. EXIT  ');
			GotoXY(20,12);  write('   PILIHAN :    ');
			yt := readkey;
			if yt = '1' then
		 begin
				  write(fie,ndp);
				  repeat
						  GotoXY(37,13);  write('           ');
						  GotoXY(37,14);  write('           ');
						  GotoXY(37,15);  write('           ');
						  GotoXY(37,16);  write('           ');
						  GotoXY(37,17);  write('           ');
						  GotoXY(20,13);  write('NOMOR DATA     ? '); read(cnt);
						  if cnt <> 0 then
						  begin
								 GotoXY(20,14);  write('Harga X semula = ',X[cnt]:6:2);
								 GotoXY(20,15);  write('Harga Y semula = ',y[cnt]:6:4);
								 GotoXY(20,16);  write('Harga X baru   = ');
								 read(X[cnt]);
								 GotoXY(20,17);  write('Harga Y baru   = ');
								 read(y[cnt]);
								 GotoXY(20,19);  write('ISI <0> UNTUK SELESAI EDIT ');
						  end;
				  until cnt = 0 ;
			 for cnt := 1 to ndp do
				  begin
						 write(frxe,x[cnt]);
				  end;
				  for cnt := 1 to ndp do
				  begin
						 write(frye,y[cnt]);
				  end;
				  {for cnt := 1 to ndp do
				  begin
						 w[cnt] := 1;
						 write(frwe,w[cnt]);
				  end;}
			end;
			if yt = '2' then
			begin
				  cnt := ndp;
				  repeat
						  cnt := cnt + 1;
						  GotoXY(20,12);  write('                          ');
						  GotoXY(20,11);  write('Nomor data     = ',cnt);
						  GotoXY(20,12);  write('Harga X baru   = ');
						  read(X[cnt]);
						  GotoXY(20,13);  write('Harga Y baru   = ');
						  read(Y[cnt]);
						  GotoXY(20,15);  write('ISI HARGA Y = 999 UNTUK SELESAI EDIT ');
						  jj := cnt;
				  until (Y[cnt] >= 999) or (X[cnt] >= 999) ;
				  ndp := jj - 1;
				  write(fie,ndp);
				  for cnt := 1 to ndp do
				  begin
						 write(frxe,x[cnt]);
				  end;
				  for cnt := 1 to ndp do
				  begin
						 write(frye,y[cnt]);
				  end;
				  {for cnt := 1 to ndp do
				  begin
				 w[cnt] := 1;
						 write(frwe,w[cnt]);
				  end;}
			end;
			if yt = '3' then exit;

			close(fk);
			close(fi);
			close(frx);
			close(fry);
			{close(frw);}

			close(fke);
			close(fie);
			close(frxe);
			close(frye);
			{close(frwe);}
	 end;

	 procedure calc;
	 begin
			sum1  := ndp;  sum2  := 0;  sum3  := 0;  sum4 := 0;  sum5  := 0;
			sum6  := 0;  sum7  := 0;  sum8  := 0;  sum9 := 0;  sum10 := 0;
			sum11 := 0;  sum12 := 0; sum13  := 0; sum14 := 0;  sum15 := 0;
			sum16 := 0;  sum17 := 0;  sum18 := 0; sum19 := 0;  sum20 := 0;
			sum21 := 0;  x2y   := 0;  x3y   := 0; x5    := 0;  x6    := 0;
			xpery := 0; xlnpery := 0; pery  := 0; lnpery:= 0;
			for cnt := 1 to ndp do
			begin
				  {sum1  := sum1  + 1;} {ndp}
				  sum2  := sum2  + x[cnt]; {sigma x}
				  sum3  := sum3  + y[cnt]; {sigma y}
				  sum4  := sum4  + sqr(x[cnt]); {sigma xý}
				  sum5  := sum5  + x[cnt]*y[cnt]; {sigma xy}
				  sum6  := sum6  + sqr(y[cnt]); {sigma yý}
				  sum7  := sum7  + sqr(y[cnt])*y[cnt]; {sigma y^3}
				  sum8  := sum8  + sqr(x[cnt])*x[cnt]; {sigma x^3}
				  sum9  := sum9  + sqr(y[cnt])*sqr(y[cnt]); {sigma y^4}
				  sum10 := sum10 + sqr(x[cnt])*sqr(x[cnt]); {sigma x^4}
				  sum11 := sum11 + ln(x[cnt]); {sigma lnx}
				  sum12 := sum12 + ln(y[cnt]); {sigma lny}
				  sum13 := sum13 + sqr(ln(x[cnt])); {sigma lnxý}
				  sum14 := sum14 + x[cnt]*ln(y[cnt]); {sigma xlny}
				  sum15 := sum15 + sqr(ln(y[cnt])); {sigma lnyý}
				  sum16 := sum16 + ln(x[cnt])*ln(y[cnt]); {sigma lnxlny}
				  x5    := x5    + sqr(x[cnt])*sqr(x[cnt])*x[cnt]; {sigma x^5}
				  x6    := x6    + sqr(x[cnt])*sqr(x[cnt])*sqr(x[cnt]);
				  x2y   := x2y   + sqr(x[cnt])*y[cnt]; {sigma x2y}
				  x3y   := x3y   + sqr(x[cnt])*x[cnt]*y[cnt]; {sigma x3y}
				  xpery := xpery + x[cnt]*(1/y[cnt]); {sigma xpery}
				  xlnpery := xlnpery + x[cnt]*ln(1/y[cnt]); {sigma xlnpery}
				  pery  := pery  + (1/y[cnt]); {sigma sepery}
				  lnpery:= lnpery+ ln(1/y[cnt]); {sigma lnpery}
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
	 end; {calc}

	 procedure compare;
	 var cnt : integer;
	 begin
			clrscr; cmati;
			tampilan('REGRESI LINIER/NONLINIER');
			textcolor(yellow);
			writeln('     Membandingkan harga input dengan harga regresi :');
			writeln;
			textcolor(white);
			writeln('x':7,'y(input)':19,'y(regresi)':17,
				'y(residual)':15,'y(residual)ý':15,'no':4);
			writeln;
			for cnt := 1 to ndp do
				 writeln(x[cnt]:12:5,y[cnt]:14:5,ytopi[cnt]:15:5,
				 residu[cnt]:15:5,sqresidu[cnt]:15:5,cnt:6);
				 writeln('JK Residual = ':57,sum21:14:5);
	 end; {compare}

	 procedure printcompare;
	 var cnt : integer;
	 begin
		 compare;
		 tampilan('REGRESI LINIER/NONLINIER');
		 writeln(lst,'Membandingkan harga input dengan harga regresi');
			writeln(lst,'x':7,'y(input)':19,'y(regresi)':15,
				'y(residual)':15,'y(sqresidual)':15);
			for cnt := 1 to ndp do
				 writeln(lst,x[cnt]:12:5,y[cnt]:14:5,ytopi[cnt]:15:5,
				 residu[cnt]:15:5,sqresidu[cnt]:15:5,cnt:5);
         writeln(lst,'JK Residual = ':57,sum21:14:5);
         tuptext2;
    end; {pcompare}

    procedure search;
    var xvalue,aksen,b,baksen : real;
    begin
         tampilan('REGRESI LINIER/NONLINIER');
	 writeln('Interpolasi data menggunakan garis regresi  ');
         writeln;
         repeat
	       write('harga x (stop jika x > 99) ? '); readln(xvalue);
               if i = 2 then ytopi[cnt] := ic+sl*xvalue;
               if i = 3 then
               begin
                    b := (sum1*sum14-sum2*sum12)/(sum1*sum4-sqr(sum2));
                    aksen := (sum12-b*sum2)/sum1;
                    yaksen[cnt] := aksen + b * xvalue;
                    ytopi[cnt]  := exp(yaksen[cnt]);
               end;
               if i = 4 then
               begin
                    b := (sum1*sum16-sum11*sum12)/(sum1*sum13-sqr(sum11));
                    aksen := (sum12-b*sum11)/sum1;
                    yaksen[cnt] := aksen + b * ln(xvalue);
                    ytopi[cnt]  := exp(yaksen[cnt]);
               end;
               if i = 5 then
			begin
                    baksen := (sum1*sum14-sum2*sum12)/(sum1*sum4-sqr(sum2));
                    aksen := (sum12-baksen*sum2)/sum1;
                    yaksen[cnt] := aksen + baksen * xvalue;
                    ytopi[cnt]  := exp(yaksen[cnt]);
               end;
               if i = 6 then
					begin
                    baksen := (sum1*sum14-sum2*sum12)/(sum1*sum4-sqr(sum2));
                    aksen := (sum12-baksen*sum2)/sum1;
                    yaksen[cnt] := aksen + baksen * xvalue;
                    ytopi[cnt]  := exp(yaksen[cnt]);
               end;
               if i = 7 then ytopi[cnt] := 1/(ic+sl*xvalue);
               if i = 8 then
               begin
                    writeln('See comparing ! ');
               end;
         until (xvalue > 99);
    end; {search}

    procedure comsearch;
    begin
                 cbesar;
		 tampilan('REGRESI LINIER/NONLINIER');
		 gotoxy(15,3); write('Apakah akan membandingkan harga input ');
		 gotoxy(15,4); write('dengan harga regresi (y/n) ? ');
			readln(answer);
			if (answer in ['j','J','y','Y']) then
			begin
				  gotoxy(15,6); write('1. Display ke monitor');
				  gotoxy(15,7); write('2. Cetak ke printer');
				  gotoxy(15,9); write('   Pilihan : '); readln(pilih);
				  case pilih of
				  1 : begin compare; end;
				  2 : printcompare;
				  end;
			end;
	 end;

	 procedure plotdata;
	 var x1,y1 : vector;
		  xmax,ymax,xmin,ymin : real;
		  xp,yp,cnt,gd,gm : integer;
		  answer : char;

           procedure normalize;
           var dx,dy : real;
           cnt : integer;
           begin
                x1 := x; y1 := y; xmax := 1e-30; xmin := 1e30;
                ymax := xmax; ymin := xmin;
                for cnt := 1 to ndp do
                begin
                     if (x[cnt] >= xmax) then xmax := x[cnt];
                     if (x[cnt] <= xmin) then xmin := x[cnt];
                     if (y[cnt] >= ymax) then ymax := y[cnt];
                     if (y[cnt] <= ymin) then ymin := y[cnt];
                end;
                dx := (xmax-xmin)*0.1; dy := (ymax-ymin)*0.1;
                xmax := xmax+dx; xmin := xmin-dx;
					 ymax := ymax+dy; ymin := ymin-dy;
                for cnt := 1 to ndp do
                begin
                     x1[cnt] := (xmax-x1[cnt])/(xmax-xmin);
                     y1[cnt] := (ymax-y1[cnt])/(ymax-ymin);
                end;
           end;

           procedure cross(i,j: integer);
           begin
                line(i-2,j,i+2,j); line(i,j-1,i,j+1);
           end;

           procedure plot;
           var xs1,xs2,ys1,ys2 : real;
           xa,xe,ya,ye : extended;

           procedure setxy(xm,ym : real; var k : integer);
           begin
                x1[k] := (xmax-xm)/(xmax-xmin);
					 y1[k] := (ymax-ym)/(ymax-ymin);
					 k := k+1;
           end;

           begin
                {ic := a; sl := b;}
                ys1 := ic+sl*xmin; ys2 := ic+sl*xmax;
                if (sl = 0) then
                begin
                     xs1 := 1e30; xs2 := 1e30;
                end else
                begin
                     xs1 := (ymin-ic)/sl; xs2 := (ymax-ic)/sl;
                end;
                cnt := ndp + 1;
                if (ys1 >= ymin) and (ys1 <= ymax) then setxy(xmin,ys1,cnt);
                if (ys2 >= ymin) and (ys2 <= ymax) then setxy(xmax,ys2,cnt);
                if (xs1 >= xmin) and (xs1 <= xmax) then setxy(xs1,ymin,cnt);
                if (xs2 >= xmin) and (xs2 <= xmax) then setxy(xs2,ymax,cnt);
                xa := getmaxx-(getmaxx*x1[ndp+1]);
					 xe := getmaxx-(getmaxx*x1[ndp+2]);
                ya := getmaxy*y1[ndp+1];
                ye := getmaxy*y1[ndp+2];
                line(round(xa),round(ya),round(xe),round(ye));
           end;
    begin
         normalize;
         gd := detect;
         initgraph(gd,gm,'');
         rectangle(0,0,getmaxx,getmaxy);
         for cnt := 1 to ndp do
         begin
              xp := getmaxx-round(getmaxx*x1[cnt]);
              yp := round(getmaxy*y1[cnt]);
              cross(xp,yp);
         end;
         plot;
         repeat answer := readkey until (answer = chr($0d));
         textmode(3);
    end;

    procedure parakuadratik;
    var a   : matrika;
        dim : integer;

        procedure input;
        var row,col : integer;
            dim     : integer;
        begin
             clrscr; writeln;
             dim := 3;
             a[1,1] := sum1; a[1,2] := sum2; a[1,3] := sum4;  a[1,4] := sum3;
             a[2,1] := sum2; a[2,2] := sum4; a[2,3] := sum8;  a[2,4] := sum5;
             a[3,1] := sum4; a[3,2] := sum8; a[3,3] := sum10; a[3,4] := x2y;
        end;

         procedure hit;
         var row,col,i,hlp : integer;

             procedure exchange;
		   var cnt,dim : integer;
                 zw : real;
             begin
                  for cnt := 1 to 3+1 do
                  begin
                       zw := a[row,cnt];
                       a[row,cnt] := a[hlp,cnt];
                       a[hlp,cnt] := zw;
                  end;
             end;

             procedure normalize;
             var cnt,dim : integer;
                 fac : real;
             begin
                  fac := 1/a[row,row];
                  for cnt := 1 to 3+1 do a[row,cnt] := fac*a[row,cnt];
             end;

             procedure subtract;
		   var cnt,dim : integer;
                 fac : real;
             begin
                  fac := -a[col,row];
                  for cnt := 1 to 3+1 do
                      a[col,cnt] := a[col,cnt]+fac*a[row,cnt];
             end;
         begin
              flag := true; i := 1;
              for row := 1 to 3 do
              begin
                   hlp := row;
                   repeat
                         if not(a[hlp,row] = 0) then
                         begin
                              exchange; normalize;
                              for col := 1 to 3 do
                                  if not(col = row) then subtract;
                                  hlp := 3;
                         end else i := hlp;
						 hlp := hlp + 1;
                   until (hlp >= 3);
                   if (i = 3) then
                   begin
                        flag := false; exit;
                   end;
              end;
         end;

         procedure output;
         var row : integer;
         begin
              writeln; clrscr;
              if flag then
                 for row := 1 to 3 do
                     writeln(a[row,3+1]:12:8)
              else writeln('No solution is possible !');
              clrscr;
              writeln;
              writeln('a = ',a[1,4]:12:8); writeln('b = ',a[2,4]:12:8);
				  writeln('c = ',a[3,4]:12:8);
              writeln;
              for cnt := 1 to ndp do
              begin
                   ytopi[cnt]    := a[1,4] + a[2,4] * x[cnt] + a[3,4] * sqr(x[cnt]);
                   residu[cnt]   := y[cnt]-ytopi[cnt];
                   sqresidu[cnt] := sqr(y[cnt]-ytopi[cnt]);
              end;
              for cnt := 1 to ndp do
              begin
                   sum21 := sum21 + sqr(y[cnt]-ytopi[cnt]); {sigma sqry-ytopi}
              end;
				  tampilan('Persamaan regresi parabola kuadrat');
              writeln;
              writeln('Y              = ',a[1,4]:12:8,' + ',a[2,4]:12:8,' * X + ',
                                        a[3,4]:12:8,' * Xý');
              writeln('JK Residual    = ',sum21:10:8);
              tuptext2;
              clrscr;
              comsearch;
	    end;
    begin
        clrscr; input; hit; output; tuptext;
    end;

    procedure parakubik;
    var a   : matrika;
        dim : integer;

        procedure input;
        var row,col : integer;
				dim     : integer;
        begin
             clrscr; writeln;
             dim := 4;
             a[1,1] := sum1;  a[1,2] := sum2;  a[1,3] := sum4;  a[1,4] := sum8;  a[1,5] := sum3;
             a[2,1] := sum2;  a[2,2] := sum4;  a[2,3] := sum8;  a[2,4] := sum10; a[2,5] := sum5;
             a[3,1] := sum4;  a[3,2] := sum8;  a[3,3] := sum10; a[3,4] := x5;    a[3,5] := x2y;
             a[4,1] := sum8;  a[4,2] := sum10; a[4,3] := x5;    a[4,4] := x6;    a[4,5] := x3y;
        end;

         procedure hit;
         var row,col,i,hlp : integer;

             procedure exchange;
             var cnt,dim : integer;
                 zw : real;
             begin
                  for cnt := 1 to 4+1 do
                  begin
							  zw := a[row,cnt];
                       a[row,cnt] := a[hlp,cnt];
                       a[hlp,cnt] := zw;
                  end;
             end;

             procedure normalize;
             var cnt,dim : integer;
                 fac : real;
             begin
			   fac := 1/a[row,row];
                  for cnt := 1 to 4+1 do a[row,cnt] := fac*a[row,cnt];
             end;

             procedure subtract;
             var cnt,dim : integer;
                 fac : real;
             begin
                  fac := -a[col,row];
						for cnt := 1 to 4+1 do
                      a[col,cnt] := a[col,cnt]+fac*a[row,cnt];
             end;
         begin
              flag := true; i := 1;
              for row := 1 to 4 do
              begin
                   hlp := row;
                   repeat
                         if not(a[hlp,row] = 0) then
                         begin
								 exchange; normalize;
                              for col := 1 to 4 do
                                  if not(col = row) then subtract;
                                  hlp := 4;
                         end else i := hlp;
                         hlp := hlp + 1;
                   until (hlp >= 4);
                   if (i = 4) then
						 begin
                        flag := false; exit;
                   end;
              end;
         end;

         procedure output;
         var row : integer;
         begin
              writeln; clrscr;
              if flag then
                 for row := 1 to 4 do
				 writeln(a[row,4+1]:12:8)
              else writeln('No solution is possible !');
              clrscr;
              writeln;
              writeln('a = ',a[1,5]:12:8); writeln('b = ',a[2,5]:12:8);
              writeln('c = ',a[3,5]:12:8); writeln('d = ',a[4,5]:12:8);
              writeln;
				  for cnt := 1 to ndp do
              begin
                   ytopi[cnt]    := a[1,5] + a[2,5] * x[cnt] + a[3,5] * sqr(x[cnt]) +
                                    a[4,5] * sqr(x[cnt])*x[cnt];
                   residu[cnt]   := y[cnt]-ytopi[cnt];
                   sqresidu[cnt] := sqr(y[cnt]-ytopi[cnt]);
              end;
              for cnt := 1 to ndp do
              begin
                   sum21 := sum21 + sqr(y[cnt]-ytopi[cnt]); {sigma sqry-ytopi}
              end;
              tampilan('Regresi parabola kubik ');
              writeln;
		    writeln('Y           = ',a[1,5]:8:4,' + ',a[2,5]:8:4,' * X + ',
                                        a[3,5]:8:4,' * Xý + ',a[4,5]:8:4,' * X^3');
              writeln;
              writeln('JK Residual = ',sum21:10:8);
              tuptext2;
              clrscr;
				  comsearch;
         end;
    begin
        clrscr; input; hit; output; tuptext;
    end;

    procedure pangkat;
    var b,baksen,a,aksen : real;
    begin
         baksen := (sum1*sum14-sum2*sum12)/(sum1*sum4-sqr(sum2));
         b:= exp(baksen);
         sl := b;
         aksen := (sum12-baksen*sum2)/sum1;
         a:= exp(aksen);
	    ic := a;
         for cnt := 1 to ndp do
         begin
              yaksen[cnt] := aksen + baksen * x[cnt];
              ytopi[cnt]  := exp(yaksen[cnt]);
				  residu[cnt] := y[cnt]-ytopi[cnt];
              sqresidu[cnt] := sqr(y[cnt]-ytopi[cnt]);
         end;
         sum21 := 0;
         for cnt := 1 to ndp do
         begin
              sum21 := sum21 + sqr(y[cnt]-ytopi[cnt]);
         end;
         clrscr;
	    tampilan('Regresi eksponensial ');
         writeln;
         writeln('                                            X');
         writeln('Y              = ',a:12:8,' * ',b:12:8); writeln;
         writeln('Slope (b)      = ',b:10:8);
         writeln('Intercept (a)  = ',a:10:8);
	    writeln('JK Residual    = ',sum21:10:8);
         tuptext2;
         clrscr;
         comsearch;
			tuptext;
    end; {pangkat}

    procedure eksponensial;
    var b,a,aksen : real;
    begin
         b := (sum1*sum14-sum2*sum12)/(sum1*sum4-sqr(sum2));
         sl := b;
         aksen := (sum12-b*sum2)/sum1;
         a:= exp(aksen);
         ic := a;
         for cnt := 1 to ndp do
         begin
              yaksen[cnt] := aksen + b * x[cnt];
              ytopi[cnt]  := exp(yaksen[cnt]);
              residu[cnt] := y[cnt]-ytopi[cnt];
		    sqresidu[cnt] := sqr(y[cnt]-ytopi[cnt]);
         end;
         sum21 := 0;
			for cnt := 1 to ndp do
         begin
              sum21 := sum21 + sqr(y[cnt]-ytopi[cnt]);
         end;
         clrscr;
	    tampilan('Regresi eksponensial  ');
         writeln;
         writeln('                               ',b:12:8,' * X');
         writeln('Y              = ',a:12:8,' * e'); writeln;
         writeln('Slope (b)      = ',b:10:8);
         writeln('Intercept (a)  = ',a:10:8);
         writeln('JK Residual    = ',sum21:10:8);
         tuptext2;
         clrscr;
         comsearch;
         tuptext;
    end; {exponential}

    procedure geometrik;
	 var b,a,aksen : real;
    begin
         b := (sum1*sum16-sum11*sum12)/(sum1*sum13-sqr(sum11));
         sl := b;
         aksen := (sum12-b*sum11)/sum1;
         a:= exp(aksen);
         ic := a;
         for cnt := 1 to ndp do
         begin
              yaksen[cnt] := aksen + b * ln(x[cnt]);
              ytopi[cnt]  := exp(yaksen[cnt]);
              residu[cnt] := y[cnt]-ytopi[cnt];
              sqresidu[cnt] := sqr(y[cnt]-ytopi[cnt]);
         end;
         sum21 := 0;
         for cnt := 1 to ndp do
         begin
              sum21 := sum21 + sqr(y[cnt]-ytopi[cnt]);
	    end;
			clrscr;
	    tampilan('Regresi geometri  ');
         writeln;
         writeln('                               ',b:12:8);
         writeln('Y              = ',a:12:8,' * X'); writeln;
         writeln('Slope (b)      = ',b:10:8);
         writeln('Intercept (a)  = ',a:10:8);
         writeln('JK Residual    = ',sum21:10:8);
         tuptext2;
         clrscr;
         comsearch;
         tuptext;
    end; {geometrik}

    procedure logistik;
    var b,baksen,a,aksen : real;
    begin
         baksen := (sum1*xlnpery-sum2*lnpery)/(sum1*sum4-sqr(sum2));
         b:= exp(baksen);
		 sl := b;
         aksen := (lnpery-baksen*sum2)/sum1;
         a:= exp(aksen);
         ic := a;
         for cnt := 1 to ndp do
         begin
              yaksen[cnt] := aksen + baksen * x[cnt];
              ytopi[cnt]  := exp(yaksen[cnt]);
              ytopi[cnt]  := 1/ytopi[cnt];
              residu[cnt] := y[cnt]-ytopi[cnt];
              sqresidu[cnt] := sqr(y[cnt]-ytopi[cnt]);
         end;
         sum21 := 0;
         for cnt := 1 to ndp do
         begin
              sum21 := sum21 + sqr(y[cnt]-ytopi[cnt]);
         end;
         clrscr;
	    tampilan('Regresi logistik ');
			writeln;
	    writeln('                                1');
         writeln('Y              = ---------------------------------');
         writeln('                                             X');
         writeln('                 ',a:12:8,' *  ',b:12:8); writeln;
         writeln('Slope (b)      = ',b:10:8);
         writeln('Intercept (a)  = ',a:10:8);
         writeln('JK Residual    = ',sum21:10:8);
         tuptext2;
         clrscr;
         comsearch;
         tuptext;
    end; {logistik}

    procedure hiperbolik;
    begin
         den  := sum1*sum4-sqr(sum2);
         dif1 := pery*sum4-xpery*sum2;
         dif2 := sum1*xpery-sum2*pery;
			ic   := dif1/den;
			a    := ic;
		 sl   := dif2/den;
			b    := sl;
			for cnt := 1 to ndp do
			begin
				  ytopi[cnt] := 1/(ic+sl*x[cnt]);
				  residu[cnt] := y[cnt]-ytopi[cnt];
				  sqresidu[cnt] := sqr(y[cnt]-ytopi[cnt]);
			end;
			for cnt := 1 to ndp do
			begin
				  sum21 := sum21 + sqr(y[cnt]-ytopi[cnt]); {sigma sqry-ytopi}
			end;
			clrscr;
		 tampilan('Regresi hiperbola ');
			writeln;
			writeln('                               1');
			writeln('Y              = -------------------------------');
			writeln('                 ',ic:12:8,' + ',sl:12:8,' * X'); writeln;
			writeln('Slope (b)      = ',sl:10:8);
			writeln('Intercept (a)  = ',ic:10:8);
		 writeln('JK Residual    = ',sum21:10:8);
			tuptext2;
			clrscr;
			comsearch;
			tuptext;
	 end; {hiperbolik}

	 procedure sum;
	 begin
			clrscr;
			textcolor(white);
			tampilan('Ringkasan hitungan data ');
			gotoxy(20,3);writeln('ä data         = ',sum1:10:8);
			gotoxy(20,4);writeln('ä X            = ',sum2:10:8);
			gotoxy(20,5);writeln('ä Y            = ',sum3:10:8);
			gotoxy(20,6);writeln('ä 1/Y          = ',pery:10:8);
			gotoxy(20,7);writeln('Mean X         = ',meanx:10:8);
			gotoxy(20,8);writeln('Mean Y         = ',meany:10:8);
			gotoxy(20,9);writeln('ä Xý           = ',sum4:10:8);
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
			tuptext2;
			clrscr;
			textcolor(white);
			gotoxy(20,3);writeln('ä ln(1/Y)      = ',lnpery:10:8);
			gotoxy(20,4);writeln('ä X*ln(Y)      = ',sum14:10:8);
			gotoxy(20,5);writeln('ä X*ln(1/Y)    = ',xlnpery:10:8);
			gotoxy(20,6);writeln('ä ln(X)*ln(Y)  = ',sum16:10:8);
	 gotoxy(20,7);writeln('ä (ln(X))ý     = ',sum13:10:8);
			gotoxy(20,8);writeln('ä (ln(Y))ý     = ',sum15:10:8);
			gotoxy(20,9);writeln('ä (X-Xbar)ý    = ',sum18:10:8);
			gotoxy(20,10);writeln('ä (Y-Ybar)ý    = ',sum20:10:8);
			tuptext;
	 end;

	 procedure Oreg;
	 var answer : char;

		  function sqsum : real;
		  var ts : real;
				cnt : integer;
		  begin
				 ts := 0;
				 for cnt := 1 to ndp do
					  ts := ts + sqr(y[cnt] - ic - sl*x[cnt]);
				 sqsum := ts;
		  end; {sqsum}

	 begin
			den  := sum1*sum4-sqr(sum2);
			dif1 := sum3*sum4-sum5*sum2;
			dif2 := sum1*sum5-sum2*sum3;
			ic   := dif1/den;
			a    := ic;
			sl   := dif2/den;
			b    := sl;
			ss   := sqsum;
			dev  := sqrt(ss/(ndp-2));
			dic  := dev*sqrt(sum4/den);
			dsl  := dev*sqrt(sum1/den);
			for cnt := 1 to ndp do
			begin
				  ytopi[cnt] := ic+sl*x[cnt];
				  residu[cnt] := y[cnt]-ytopi[cnt];
				  sqresidu[cnt] := sqr(y[cnt]-ytopi[cnt]);
			end;
			sum21 := 0;
			for cnt := 1 to ndp do
		 begin
				  sum21 := sum21 + sqr(y[cnt]-ytopi[cnt]);
			end;
			JKba := b*(sum5-(sum2*sum3)/ndp);
			sstotal   := sum6;
			ssregresi := sqr(sum3)/ndp;
			ssresidu  := sstotal-jkba-ssregresi;
			JKresidu  := ssresidu;
			rsquared  := (sqr((ndp*sum5)-(sum2*sum3)))/
							 (((ndp*sum4)-sqr(sum2))*((ndp*sum6)-sqr(sum3)));
			r         := sqrt(rsquared);
			MSregresi := ssregresi;
			MSba      := jkba;
			MSresidu  := JKresidu/(ndp-2);
			fdata     := MSba/MSresidu;
			tdata     := r*sqrt(ndp-2)/sqrt(1-sqr(r));
			sgsqb     := MSresidu/sum18;
			sigmab    := sqrt(sgsqb);
			sgsqa     := MSresidu*(1/ndp+(sqr(meanx)/sum18));
			sigmaa    := sqrt(sgsqa);
		 clrscr;
			Cbesar;
			tampilan('REGRESI LINIER/NONLINIER');
			textbackground(brown); textcolor(yellow);
			gotoxy(25,3);   write('             PILIHAN                ');
			textbackground(blue); textcolor(white);
			gotoxy(25,5);   write('                                    ');
			gotoxy(25,6);   write(' 1. Persamaan garis regressi linier ');
			gotoxy(25,7);   write(' 2. Analisis regressi linier        ');
			gotoxy(25,8);   write(' 3. Keluar                          ');
			gotoxy(25,9);   write('                                    ');
			textbackground(cyan); textcolor(brown);
			gotoxy(25,11);  write('           Pilihanku :              ');
			gotoxy(48,11);
			opsi4 := readkey;
			textbackground(black); textcolor(white);
			case opsi4 of
			'1': begin
					  clrscr;
					  printing;
					  clrscr;
					  cmati;
					  tampilan('Persamaan garis regresi linier');
					  gotoxy(15,5); write('Y              = ',ic:12:8,' + ',sl:12:8,' * X'); writeln;
					  gotoxy(15,6); write('Slope (b)      = ',sl:10:8,' +/- ',dsl:10:8);
					  gotoxy(15,7); write('Intercept (a)  = ',ic:10:8,' +/- ',dic:10:8);
					  gotoxy(15,8); write('JK Residual    = ',ssresidu:10:8);
					  if ps = '2' then intr(5,reg);
					  tuptext2;
				  end;
			'2': begin
			          clrscr;
				  Cbesar;
				  tampilan('Analisis regresi linier');
				  textbackground(brown); textcolor(yellow);
				  gotoxy(25,3);   write('             PILIHAN                        ');
				  textbackground(blue); textcolor(white);
				  gotoxy(25,5);   write('                                            ');
				  gotoxy(25,6);   write(' 1. Uji linieritas regresi                  ');
				  gotoxy(25,7);   write(' 2. Uji kebermaknaan koef regresi dengan F  ');
				  gotoxy(25,8);   write(' 3. Uji kebermaknaan koef regresi dengan t  ');
				  gotoxy(25,9);   write(' 4. Menghitung harga JK Residual            ');
                                  gotoxy(25,10);  write(' 5. Interpolasi data                        ');
				  gotoxy(25,11);  write(' 6. Keluar                                  ');
				  gotoxy(25,12);  write('                                            ');
				  textbackground(cyan); textcolor(yellow);
				  gotoxy(25,14);  write('           Pilihanku :                      ');
				  gotoxy(48,14);
				  opsi5 := readkey;
				  Cbesar;
				  textbackground(black); textcolor(white);

				  if opsi5 = '2' then begin
				  clrscr;
				  printing;
					  clrscr;
					  tampilan('Uji kebermaknaan koefisien regresi');
					  textbackground(blue); textcolor(white);
                 gotoxy(5,3);  write('       TABEL ANAVA UJI KEBERMAKNAAN KOEF REGRESI DENGAN F       ');
                 textbackground(black); textcolor(white);
                 gotoxy(5,4);  write('================================================================');
                 gotoxy(5,5);  write('Sumber Variasi','dk':10,'JK':10,'KT':16,'F':10,'    ');
                 gotoxy(5,6);  write('================================================================');
                 gotoxy(5,7);  write('Regresi (a)   ','1':10,JKa:15:4,JKa:15:4,'-':10);
                 gotoxy(5,8);  write('Regresi (b!a) ','1':10,JKba:15:4,MSba:15:4,fdata:10:4);
                 gotoxy(5,9);  write('Residu        ',ndp-2:10,JKresidu:15:4,MSresidu:15:4,'-':10);
                 gotoxy(5,10); write('================================================================');
                 gotoxy(5,11); write('Total         ',ndp:10,sstotal:15:4,'-':15,'-':10);
					  gotoxy(5,12); write('================================================================');
					  gotoxy(5,14); write('Harga F (0,95; 1;',ndp-2,') dari tabel = '); read(ftab);
					  gotoxy(5,14); write('Harga F (0,95; 1;',ndp-2,') dari tabel = ',ftab:5:3);
					  cmati;
					  if (fdata > ftab) then
					  begin
							 gotoxy(5,17); write('Kesimpulan : ');
							 gotoxy(5,18);
							 write('Karena F data > F(0,95;','1':2,';',ndp-2:2,') maka koef regresi bermakna');
					  end else
					  begin
							 gotoxy(5,17);
							 write('Kesimpulan : ');
							 gotoxy(5,18);
							 write('Karena F data < F(0,95;','1':2,';',ndp-2:2,') maka koef regresi tidak bermakna');
					  end;
					  if ps = '2' then intr(5,reg);
					  tuptext2;
					  end;

					  if opsi5 = '1' then begin
					  clrscr;
					  Cbesar;
					  tampilan('Uji linieritas ');
					  textbackground(black); textcolor(white);
					  gotoxy(1,3);
					  write('Banyaknya jenis data X (= k)        = '); readln(jd);
					  writeln;
					  for j := 1 to jd do
					  begin
							 write('Banyaknya data jenis data ',j:2,' (k ',j:2, ') = ');
							 readln(k[j]);
					  end;
					  writeln;
					  jker := 0;  kj := 0;
					  for j := 1 to jd do
					  begin
							 sumy2[j] := 0; sumy[j] := 0;
							 for cnt := (1+kj) to (k[j]+kj) do
							 begin
									sumy2[j] := sumy2[j] + sqr(y[cnt]);
							 end;
							 for cnt := (1+kj) to (k[j]+kj) do
							 begin
									sumy[j]  := sumy[j] + y[cnt];
							 end;
							 kj := kj + k[j];
							 sum2y[j] := sqr(sumy[j]);
							 sum2y[j] := sum2y[j]/k[j];
							 jk[j] := sumy2[j] - sum2y[j];
							 jker  := jker + jk[j];
					  end;
					  if ndp <> jd then
					  begin
							 s2ep := jker/(ndp-jd);
							 jktc := JKResidu - JKEr;
							 s2t  := jktc/(jd-2);
							 fdlin:= s2t/s2ep;
					  end else
					  begin
							 jker := 0;
							 jktc := JKResidu - JKEr;
							 s2t  := jktc/(jd-2);
					  end;
					  clrscr;
					  printing;
					  clrscr;
					  cmati;
					  tampilan('Uji linieritas ');
					  writeln;
					  if jd <= 20 then
					  begin
							 for  j := 1 to jd do
							 begin
									writeln('K',j:2,' = ',k[j]:2,' --> JK ',j:2,' = ',jk[j]:10:8);
							 end;
					  end else
					  begin
							 for  j := 1 to 20 do
							 begin
									writeln('K',j:2,' = ',k[j]:2,' --> JK ',j:2,' = ',jk[j]:10:8);
							 end;
							 tuptext2; clrscr;
							 for  j := 21 to jd do
							 begin
									writeln('K',j:2,' = ',k[j]:2,' --> JK ',j:2,' = ',jk[j]:10:8);
							 end;
					  end;
					  if ps = '2' then intr(5,reg);
					  tuptext2;

					  clrscr;
					  printing;
					  clrscr;
					  Cbesar;
					  textbackground(blue); textcolor(white);
					  gotoxy(5,2);  write('                  TABEL ANAVA UJI LINIERITAS                    ');
					  textbackground(black); textcolor(white);
					  gotoxy(5,4);  write('================================================================');
					  gotoxy(5,5);  write('Sumber Variasi','dk':10,'JK':10,'KT':16,'F':10);
					  gotoxy(5,6);  write('================================================================');
					  gotoxy(5,7);  write('Total         ',ndp:10,sstotal:15:4,'-':15,'-':10);
					  gotoxy(5,8);  write('================================================================');
					  gotoxy(5,9);  write('Regresi (a)   ','1':10,JKa:15:4,JKa:15:4,'-':10);
					  gotoxy(5,10); write('Regresi (b!a) ','1':10,JKba:15:4,MSba:15:4,fdata:10:4);
					  gotoxy(5,11); write('Residu        ',ndp-2:10,JKresidu:15:4,MSresidu:15:4,'-':10);
					  gotoxy(5,12); write('================================================================');
					  gotoxy(5,14); write('Kekeliruan    ',(ndp-jd):10,jker:15:4,s2ep:15:4,fdlin:10:4);
					  gotoxy(5,13); write('Tuna cocok    ',(jd-2):10,  jktc:15:4,s2t:15:4);
					  gotoxy(5,15); write('================================================================');
					  if ndp <> jd then
					  begin
							 gotoxy(5,17); write('F(0,95;',jd-2:2,';',ndp-jd:2,')  = '); read(ftab);
							 gotoxy(5,17); write('F(0,95;',jd-2:2,';',ndp-jd:2,')  = ',ftab:11:8);
							 cmati;
							 if (fdlin < ftab) then
							 begin
									gotoxy(5,19); write('Kesimpulan : ');
									gotoxy(5,20);
									write('Karena F data < F(0,95;',jd-2:2,';',ndp-jd:2,') maka model regresi linier diterima');
							 end else
							 begin
									gotoxy(5,19); write('Kesimpulan : ');
									gotoxy(5,20);
									write('Karena F data > F(0,95;',jd-2:2,';',ndp-jd:2,') maka model regresi linier ditolak');
							 end;
					  end else
					  begin
							 cmati;
							 gotoxy(5,17); write('Kesimpulan : ');
							 gotoxy(5,18); write('Karena JK Error = 0 maka sulit untuk mendefinisikan F data.');
							 gotoxy(5,19); write('Seharusnya dilakukan pengulangan terhadap variabel bebas X.');
							 gotoxy(5,20); write('Dengan adanya pengulangan terhadap X maka jumlah kuadrat   ');
							 gotoxy(5,21); write('residu (JK residu) dapat dipecah menjadi JK error dan JKTC.');
					  end;
					  if ps = '2' then intr(5,reg);
					  tuptext2;
					  end;

					  if opsi5 = '3' then begin
					  clrscr;
					  printing;
					  clrscr;
					  cbesar;
					  textbackground(black); textcolor(white);
					  gotoxy(5,2); write('     UJI KEBERMAKNAAN KOEFISIEN REGRESI DENGAN t :     ');
					  gotoxy(5,4); write('SEýb           = ',sgsqb:10:8);
					  gotoxy(5,5); write('SE b           = ',sigmab:10:8);
					  gotoxy(5,6); write('SEýa           = ',sgsqa:10:8);
					  gotoxy(5,7); write('SE a           = ',sigmaa:10:8);
					  gotoxy(5,8); write('T data         = ',tdata:10:8);
					  gotoxy(5,9); write('T(0,975;',ndp-2:2,')    = '); readln(ttab);
					  gotoxy(5,9); write('T(0,975;',ndp-2:2,')    = ',ttab:10:8);
					  cmati;
					  gotoxy(5,10); write('Std. Deviation = ',dev:10:8);
					  if (tdata > ttab) or (tdata < -ttab) then
					  begin
							 if (tdata > ttab) then
							 begin
									gotoxy(5,12); write('Kesimpulan : ');
									gotoxy(5,13); write('Karena T data > T(0,975;',ndp-2:2,') ');
									gotoxy(5,14); write('maka hipotesis nol ditolak atau á tidak sama dengan nol');
							 end;
							 if (tdata < -ttab) then
							 begin
									gotoxy(5,12); write('Kesimpulan : ');
									gotoxy(5,13); write('Karena T data < -T(0,975;',ndp-2:2,')');
									gotoxy(5,14); write('maka hipotesis nol ditolak atau á tidak sama dengan nol');
							 end;
					  end else
					  begin
							 gotoxy(5,12); write('Kesimpulan : ');
							 gotoxy(5,13); write('Karena T data < T(0,975;',ndp-2:2,')');
							 gotoxy(5,14); write('maka hipotesis nol diterima atau á = 0');
					  end;
					  if ps = '2' then intr(5,reg);
					  tuptext2;
					  end;

					  if opsi5 = '4' then
					  begin
							 clrscr;
							 textbackground(black); textcolor(white);
							 comsearch;
							 tuptext2;
							 {if opsi2 = #27 then exit;}
					  end;

                                          if opsi5 = '5' then
					  begin
							 clrscr;
							 textbackground(black); textcolor(white);
                                                         tampilan('REGRESI LINIER');
                                                         WriteLn;
	                                                 writeln('Interpolasi data menggunakan garis regresi  ');
                                                         writeln;
	                                                 write('Harga x = '); readln(xvalue);
                                                         yin := ic+sl*xvalue;

                                                         clrscr;
					                 cmati;
					                 tampilan('Persamaan garis regresi linier');
					                 gotoxy(15,5);  write('Y              = ',ic:12:8,' + ',sl:12:8,' * X');
                                                         writeln;
                                                         gotoxy(15,7);  write('Harga X        = ',xvalue:10:8);
					                 gotoxy(15,8);  write('Slope (b)      = ',sl:10:8);
					                 gotoxy(15,9);  write('Intercept (a)  = ',ic:10:8);
                                                         gotoxy(15,10); write('Harga Y        = ',yin:10:8);

							 tuptext2;
							 {if opsi2 = #27 then exit;}
					  end;

					  if opsi5 = '6' then exit;
				  end; {oreg}
			'3': exit;
			end;
	 end;

	 procedure menu1;
	 begin
			clrscr;
			tampilan('REGRESI LINIER/NONLINIER');
                        textbackground(brown); textcolor(yellow);
			gotoxy(30,3);   write('   ASAL DATA    ');
			textbackground(blue); textcolor(white);
			gotoxy(30,5);   write('                ');
			gotoxy(30,6);   write(' 1. Data baru   ');
			gotoxy(30,7);   write(' 2. Ambil data  ');
			gotoxy(30,8);   write(' 3. Menu Utama  ');
			gotoxy(30,9);   write('                ');
			textcolor(yellow);
			gotoxy(30,6);   write(' 1');
			gotoxy(30,7);   write(' 2');
			gotoxy(30,8);   write(' 3');
			textbackground(cyan); textcolor(yellow);
			gotoxy(30,11);   write('   Pilihan :    ');
			gotoxy(43,11);
			opsi := readkey;
			textbackground(black);
			case opsi of
			'1' : begin
						  input;
                    calc;
               end;
         '2' : begin
                    load;
                    calc;
               end;
         end;
    end;

    procedure menu2;
    begin
         clrscr;
         textbackground(brown); textcolor(yellow);
         gotoxy(25,2);   writeln('    REGRESI LINIER/NONLINIER     ');
         textbackground(blue); textcolor(white);
         gotoxy(25,4);   writeln('                                 ');
			gotoxy(25,5);   writeln(' A. Deskripsi data               ');
			gotoxy(25,6);   writeln(' B. Regresi linier               ');
			gotoxy(25,7);   writeln(' C. Regresi eksponensial   1     ');
			gotoxy(25,8);   writeln(' D. Regresi eksponensial   2     ');
			gotoxy(25,9);   writeln(' E. Regresi logistik             ');
			gotoxy(25,10);  writeln(' F. Regresi geometrik            ');
			gotoxy(25,11);  writeln(' G. Regresi hiperbola            ');
			gotoxy(25,12);  writeln(' H. Regresi parabola kuadrat     ');
			gotoxy(25,13);  writeln(' I. Regresi parabola kubik       ');
			gotoxy(25,14);  writeln(' J. Plot data regresi            ');
         gotoxy(25,15);  writeln(' K. Display data                 ');
         gotoxy(25,16);  writeln(' L. Daftar file                  ');
         gotoxy(25,17);  writeln(' M. Edit data                    ');
         gotoxy(25,18);  writeln(' X. [MENU UTAMA]                 ');
         gotoxy(25,19);  writeln('                                 ');
         textcolor(yellow);
         gotoxy(25,5);   writeln(' A');
         gotoxy(25,6);   writeln(' B');
         gotoxy(25,7);   writeln(' C');
         gotoxy(25,8);   writeln(' D');
         gotoxy(25,9);   writeln(' E');
         gotoxy(25,10);  writeln(' F');
         gotoxy(25,11);  writeln(' G');
         gotoxy(25,12);  writeln(' H');
         gotoxy(25,13);  writeln(' I');
         gotoxy(25,14);  writeln(' J');
         gotoxy(25,15);  writeln(' K');
         gotoxy(25,16);  writeln(' L');
         gotoxy(25,17);  writeln(' M');
         gotoxy(25,18);  writeln(' X');
         textbackground(cyan); textcolor(brown);
         cbesar;
			gotoxy(25,21);  writeln('           Pilihan :             ');
			textbackground(black);
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
			  gotoxy(46,21); write('-');
			  delay(300);
			  inc(i,1);
			until keypressed;
			cbesar;
			textbackground(black);
			clrscr;
    end;

begin
	  10:
	  textbackground(black);
	  menu2;
	  textbackground(black);
     opsi3 := readkey;
	  case upcase(opsi3) of
           'A' : begin
                      20: menu1;
                      if opsi = '3' then goto 10;
							 sum;
                      if opsi2 = #13 then goto 20 else goto 10;
                 end;
           'B' : begin
							 30:
							 menu1;
                      if opsi = '3' then goto 10;
							 Oreg;
							 if opsi2 = #13 then goto 30;
							 if opsi2 = #27 then exit;
					  end;
			  'C' : begin
                      40: menu1;
                      if opsi = '3' then goto 10;
                      eksponensial;
                      if opsi2 = #13 then goto 40 else goto 10;
                 end;
           'D' : begin
                      50: menu1;
							 if opsi = '3' then goto 10;
                      pangkat;
                      if opsi2 = #13 then goto 50 else goto 10;
                 end;
           'E' : begin
                      60: menu1;
                      if opsi = '3' then goto 10;
                      logistik;
                      if opsi2 = #13 then goto 60 else goto 10;
                 end;
           'F' : begin
							 70: menu1;
							 if opsi = '3' then goto 10;
                      geometrik;
                      if opsi2 = #13 then goto 70 else goto 10;
                 end;
           'G' : begin
                      80: menu1;
                      if opsi = '3' then goto 10;
							 hiperbolik;
                      if opsi2 = #13 then goto 80 else goto 10;
                 end;
           'H' : begin
                      90: menu1;
                      if opsi = '3' then goto 10;
                      parakuadratik;
                      if opsi2 = #13 then goto 90 else goto 10;
                 end;
           'I' : begin
                      100: menu1;
                      if opsi = '3' then goto 10;
							 parakubik;
							 if opsi2 = #13 then goto 100 else goto 10;
                 end;
           'J' : begin
                      110:
							 cbesar;
							 exec('Stat_23.exe','');
							 goto 10;
					  end;
			  'K' : begin
							  120: menu1;
							  if opsi = '3' then goto 10;
							  gotoxy(1,3); clreol;
							  gotoxy(25,3);  write('Data X : ');
							  gotoxy(40,3);  writeln('Data Y : ');
							  cmati;
							  if ndp < 21 then
							  begin
									 for cnt := 1 to ndp do
									 begin
											gotoxy(25,cnt + 4);  write(x[cnt]:5:4);
											gotoxy(40,cnt + 4);  write(y[cnt]:5:4);
									 end;
							  end else
							  begin
									 for cnt := 1 to 20 do
									 begin
											writeln(cnt:15,x[cnt]:15:4,y[cnt]:15:4);
									 end;
									 readln;
									 for cnt := 21 to ndp do
									 begin
											writeln(cnt:15,x[cnt]:15:4,y[cnt]:15:4);
									 end;
									 {writeln;}
							  end;
							  tuptext;
							  if opsi2 = #13 then goto 120 else goto 10;
					  end;
			  'L' : begin
							 130:
							 cmati;
							 clrscr;
							 exec('Stat_22.exe','');
							 tuptext;
							 exit;
							 if opsi2 = #13 then goto 130 else goto 10;
					  end;
			  'M' : Begin
							 140:
							 cbesar;
							 edit_data;
							 tuptext;
							 if opsi2 = #13 then goto 140 else goto 10;
					  end;
			  'X' : halt;
	  end;
end.



