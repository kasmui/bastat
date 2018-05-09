program plotting;
Uses crt,graph,stat_g,stat_m;
const delx = 0.001;
var xa,a,b,c,xmin,xmax,ymin,ymax : real;
	x,y,x1,y1,y2,yg : array[1..100] of real;
	i,j,jdat,cnt : byte;
	 str1,str2,str3 : string[5];
Var
	 fr                                  : file of real;
	 fi                                  : file of word;
	 xw,yw,jd2,w1,w2,w3                  : byte;
	 pilih1,pilih2,pilih3,pilih4,
	 pildat,pilihan                      : char;
	 peny_1,peny_2,pembilang,koef_korelasi,
	 penyebut,slope,intercept,jum_x,jum_y,
	 jum_xy,awalx,maxdata,step,xkalmin,
	 xkalmak,ykalmin,ykalmak,ygmak,ygmin,
	 jum_x2,jum_y2,rata_x,rata_y,rata_xy,
	 x3,x4,deltaT,koefr1,koefr2,y3,swal  : real;
	 dtx,st,nama,edisi,kunci,nama1,
	 dtx1,dtx2,dtx3,dtx4                 : string[20];

Label 01;

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

	 procedure load;
	 type
		kata   = string[10];
		freal  = file of real;
		fint   = file of byte;
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
			closegraph;
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
			reset(fk);
			reset(fi);
			reset(frx);
			reset(fry);
			{$I+}
			ada := (IOResult = 0);
			if ada then
			begin
				  read(fk,nama);
				  read(fi,jdat);
				  for cnt := 1 to jdat do
				  begin
						 read(frx,x[cnt]);
						 if x[1] = 0 then x[1] := 0.0000001;
				  end;
				  for cnt := 1 to jdat do
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
	 end;

Procedure Xmak_min;
var I:integer;
begin
	  Xkalmin := X[1];
	  Xkalmak := X[1];
	  for I:= 2 to jdat do
	  begin
			 if X[I] < Xkalmin then
		  Xkalmin  := X[I];
			 if X[I] > Xkalmak then
		  Xkalmak  := X[I];
	  end;
end;

Procedure Ymak_min;
var I:integer;
begin
	  Ykalmin := Y[1];
	  Ykalmak := Y[1];
	  for I:= 2 to jdat  do
	  begin
			 if Y[I] < Ykalmin then
		  Ykalmin  := Y[I];
			 if Y[I] > Ykalmak then
		  Ykalmak  := Y[I];
	  end;
end;

Procedure Ygmak_min;
var I:integer;
begin
	  Ygmin := Yg[1];
	  Ygmak := Yg[1];
	  for I:= 2 to jdat  do
	  begin
			 if Yg[I] < Ygmin then
		  Ygmin  := Yg[I];
			 if Yg[I] > Ygmak then
		  Ygmak  := Yg[I];
	  end;
end;

Procedure Regresi;
begin
     jum_x  := 0;
     jum_y  := 0;
     jum_xy := 0;
     jum_x2 := 0;
     jum_y2 := 0;
	  for J := 1 to Jdat do
	  begin
		jum_x    := jum_x  + x[j];
		jum_y    := jum_y  + y[j];
		jum_xy   := jum_xy + x[j]*y[j];
		jum_x2   := jum_x2 + x[j]*x[j];
		jum_y2   := jum_y2 + y[j]*y[j];
	  end;
	  rata_x        := jum_x/Jdat;
	  rata_y        := jum_y/Jdat;
	  rata_xy       := rata_x * rata_y;
	  pembilang     := jum_xy/Jdat - rata_xy;
	  peny_1        := sqrt(jum_x2/Jdat - rata_x*rata_x);
	  peny_2        := sqrt(jum_y2/Jdat - rata_y*rata_y);
	  koef_korelasi := pembilang/(peny_1*peny_2);
	  penyebut      := jum_x*jum_x - Jdat*jum_x2;
	  slope         := (jum_x*jum_y - Jdat*jum_xy)/penyebut;
	  intercept     := (jum_x*jum_xy- jum_y*jum_x2)/penyebut;
end;


begin
	closegraph;
	01:
	clrscr;
	{write(' Ukuran data = '); readln(jdat);
	for i := 1 to jdat do
	begin
		write(' X (',i,') = '); readln(x[i]);
		write(' Y (',i,') = '); readln(y[i]);
		writeln;
	end;}
	load;
	regresi;
	xmak_min;
	ymak_min;

	xmin := 0;
	xmax := xkalmak;

	for j := 1 to jdat do
	begin
		yg[j] := slope*j+intercept;
	end;

	ygmak_min;

	if (intercept > 0) and (ygmin > 0) then ymin := 0 else
	if intercept < ygmin then ymin := intercept else ymin := ygmin;

	if (intercept < ykalmak) and (ygmak < ykalmak) then ymax := ykalmak else
	if intercept > ygmak then ymax := intercept else ymax := ygmak;

	buka;
	kerangka(1,2,3,'Y','X');
	sumbu_koordinat(xmin,ymin,xmax,ymax);
	skala(xmin,ymin,xmax,ymax,5,5);
	outtextxy(17*getmaxx div 20,2*getmaxy div 20,'DATA :');
	str(Jdat:5,str1);
	outtextxy(17*getmaxx div 20,4*getmaxy div 20,' J data    = '+str1);
	str(slope:10:4,str1);
	outtextxy(17*getmaxx div 20,5*getmaxy div 20,' Slope     = '+str1);
	str(intercept:10:4,str1);
	outtextxy(17*getmaxx div 20,6*getmaxy div 20,' Intercept = '+str1);
	Header(0,0,470,25,blue,yellow,'GARIS REGRESI LINIER');

	for j := 1 to jdat do
	begin
		if (y[j] <= ymax) and (y[j] >= ymin) then
		begin
			transformasi(xmin,ymin,xmax,ymax,x[j],y[j],x1[j],y1[j]);
			setcolor(yellow);
			outtextxy(trunc(x1[j]),trunc(y1[j]),'*');
		end;
	end;

	for i := 1 to  jdat do
	  begin
			 if i = 1 then
			 begin
					j := trunc(xmin)
					{j := 0          }
			 end else
			 begin
					j := trunc(x[i]);
			 end;
			 if (Yg[i] <= ymax) and (Yg[i] >= ymin) and
			 (j <= xmax) and (j >= xmin) then
			 begin
					yg[i] := slope*j+intercept;
					transformasi(xmin,ymin,xmax,ymax,j,yg[i],x1[i],y2[i]);

					if i = 1 then
					begin
						  MoveTo(round(x1[i]),round(y2[i]));
					end;
					if i = Jdat then
					begin
						  setcolor(white);
						  LineTo(round(x1[i]),round(y2[i]));
               end;
          end;
     end;


	tutup('<Esc> Exit','','<Enter> Ulang');
	if readkey = #27 then
	begin
		closegraph;
	end else
	begin
		closegraph;
		goto 01;
	end;
end.
