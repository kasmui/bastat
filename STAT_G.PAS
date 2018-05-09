Unit stat_g;
Interface
Uses crt,graph;
Const x_min = 0; y_min = 0; x_max = 640; y_max = 480;
Var
   GraphDriver : integer;
   GraphMode   : integer;
   MaxX, MaxY  : integer;
   ErrorCode   : integer;
   MaxColor    : word;

Procedure Buka;
Procedure Kerangka(warna1,warna2,warna3 : integer; stringy,stringx : string);
Procedure Header(x1,y1,x2,y2 : integer; warna1,warna2 : word; s : string);
Procedure Data(x1,y1,x2,y2 : integer; warna1,warna2 : word; s : string);
Procedure Kotak_warna(a,b,c,d,e,f : integer; warna1,warna2 : word; s : string);
Procedure Transformasi(x_min,y_min,x_max,y_max,x_gambar,y_gambar : real;
          var x_layar,y_layar : real);
Procedure Sumbu_koordinat(x_min,y_min,x_max,y_max : real);
Procedure Skala(x_min,y_min,x_max,y_max : real; bagix,bagiy : byte);
Procedure gerak(x,y : real);
Procedure draw(x,y : real);
Procedure plot(x,y : real; warna : word);
Procedure panjang(x1,x2 : real; var d : real);
Procedure cir(x,y,r : real);
Procedure Tutup(pesan_kiri,pesan_tengah,pesan_kanan : string);

Implementation
Procedure Buka;
var gd,gm,errorcode : integer;
begin
     gd := detect;
     Initgraph(gd,gm,'');
     errorcode := graphresult;
     if errorcode <> Grok then Halt;
end;

Procedure Kerangka(warna1,warna2,warna3 : integer; stringy,stringx : string);
begin
	  rectangle(0,3*getmaxy div 40,(3*getmaxx div 4-getmaxx div 64),18*getmaxy div 20);
	  rectangle(6*getmaxx div 8,3*getmaxy div 40,getmaxx,18*getmaxy div 20);
	  rectangle(0,19*getmaxy div 20,getmaxx,getmaxy);

	  setfillstyle(1,warna1);
	  floodfill(1,2*getmaxy div 10,white);

	  setfillstyle(1,warna2);
	  floodfill(getmaxx-1,2*getmaxy div 10,white);

	  setfillstyle(1,warna3);
	  floodfill(1,getmaxy-1,white);

	  settextstyle(smallfont,horizdir,5);
	  settextjustify(centertext,centertext);
	  setcolor(white);
	  Outtextxy(getmaxx div 10, 4*getmaxy div 40+5 ,stringy);
	  Outtextxy(getmaxx div 3+50*getmaxx div 640 ,17*getmaxy div 20,stringx);
end;

Procedure Header(x1,y1,x2,y2 : integer; warna1,warna2 : word; s : string);
begin
	  rectangle(x1,y1,x2,y2);
	  rectangle(x1+1,y1+1,x2-1,y2-1);
	  setfillstyle(1,warna1);
	  floodfill(x1+2,y1+2,white);
	  setcolor(warna2);
	  SetUserCharSize(1,2,1,2);
	  settextjustify(centertext,centertext);
	  SetTextStyle(TriplexFont,HorizDir,UserCharSize);
	  OutTextXY(4*getmaxx div 10,getmaxy div 50,s);
end;

Procedure Data(x1,y1,x2,y2 : integer; warna1,warna2 : word; s : string);
begin
	  setcolor(warna2);
	  rectangle(x1,y1,x2,y2);
	  rectangle(x1+1,y1+1,x2-1,y2-1);
	  setfillstyle(1,warna1);
	  floodfill(x1+2,y1+2,warna1);
	  setcolor(warna2);
	  SetUserCharSize(1,2,1,2);
	  settextjustify(centertext,centertext);
	  SetTextStyle(TriplexFont,HorizDir,UserCharSize);
	  OutTextXY(7*getmaxx div 8,getmaxy div 50,s);
	  setbkcolor(black);
end;

Procedure Kotak_warna(a,b,c,d,e,f : integer; warna1,warna2 : word; s : string);
begin
     rectangle(a*getmaxx div 60,b*getmaxy div 48,c*getmaxx div 60,d*getmaxy div 48);
     setfillstyle(1,warna1);
     floodfill((a*getmaxx div 60)+2,(b*getmaxy div 48)+2,white);

	  settextstyle(smallfont,horizdir,5);
     settextjustify(lefttext,centertext);
     setcolor(warna2);
     Outtextxy(e*getmaxx div 60, f*getmaxy div 48,s);
end;

Procedure Transformasi(x_min,y_min,x_max,y_max,
          x_gambar,y_gambar : real;
          var x_layar,y_layar : real);
var xmin,xmax,ymin,ymax : integer;
begin
	  xmin := getmaxx div 10;
     xmax := (3*getmaxx div 4)-(3*getmaxx div 64);
	  ymin := 3*getmaxy div 20;
     ymax := 15*getmaxy div 20;
     x_layar := (xmin*x_max-xmax*x_min)/(x_max-x_min)
                + x_gambar*(xmax-xmin)/(x_max-x_min);
     y_layar := (ymax*y_max-ymin*y_min)/(y_max-y_min)
                - y_gambar*(ymax-ymin)/(y_max-y_min);
end;

Procedure Sumbu_koordinat(x_min,y_min,x_max,y_max : real);
var
	x1,y1,x2,y2 : real;
	del,del_1 : real;
	n                     : integer;
	dtx                   : string[5];

begin
	  transformasi(x_min,y_min,x_max,y_max,x_min,0,x1,y1);
	  transformasi(x_min,y_min,x_max,y_max,x_max,0,x2,y2);
	  Line(trunc(x1),trunc(y1),trunc(x2),trunc(y2));

	  transformasi(x_min,y_min,x_max,y_max,0,y_min,x1,y1);
	  transformasi(x_min,y_min,x_max,y_max,0,y_max,x2,y2);
	  Line(trunc(x1),trunc(y1),trunc(x2),trunc(y2));
end;

Procedure Skala(x_min,y_min,x_max,y_max : real; bagix,bagiy : byte);
var
	del,del_1,x1,y1,x2,y2 : real;
	n                     : integer;
	dtx                   : string[5];
begin
	  transformasi(x_min,y_min,x_max,y_max,x_min,y_min,x1,y1);
	  transformasi(x_min,y_min,x_max,y_max,x_min,y_max,x2,y2);
	  Line(trunc(x1),trunc(y1),trunc(x2),trunc(y2));

	  settextstyle(smallfont,horizdir,5);
	  settextjustify(centertext,centertext);

	  del := (y_max-y_min)/bagiy;
	  del_1 := (y2-y1)/bagiy;
	  for n := 1 to bagiy+1 do
	  begin
			 if n = bagiy+1 then
			 begin
					setcolor(white);
					str(y_min + del*(n-1):5:2,dtx);
					Outtextxy(getmaxx div 20, trunc(y1 + del_1*(n-1)),dtx);
					Outtextxy(getmaxx div 10, trunc(y1 + del_1*(n-1)),'-');
					SetLineStyle(1, 0, NormWidth);
					Line(getmaxx div 10,trunc(y1 + del_1*(n-1)),19*getmaxy div 20,trunc(y1 + del_1*(n-1)));
			 end else
			 begin
					str(y_min + del*(n-1):5:2,dtx);
					Outtextxy(getmaxx div 20, trunc(y1 + del_1*(n-1)),dtx);
					if n <> 1 then
					begin
						Outtextxy(getmaxx div 10, trunc(y1 + del_1*(n-1)),'-');
						SetLineStyle(1, 0, NormWidth);
						Line(getmaxx div 10,trunc(y1 + del_1*(n-1)),19*getmaxy div 20,trunc(y1 + del_1*(n-1)));
					end;
			 end;
	  end;

	  transformasi(x_min,y_min,x_max,y_max,x_max,y_min,x2,y2);
	  Line(trunc(x1),trunc(y1),trunc(x2),trunc(y2));

	  del := (x_max-x_min)/bagix;
	  del_1 := (x2-x1)/bagix;
	  for n := 1 to bagix+1 do
	  begin
			 if n = bagix+1 then
			 begin
					str(x_min + del*(n-1):1:0,dtx);
					setcolor(white);
					Outtextxy(trunc(x1 + del_1*(n-1)),15*getmaxy div 20,'!');
					Outtextxy(trunc(x1 + del_1*(n-1)),16*getmaxy div 20,dtx);
					SetLineStyle(1, 0, NormWidth);
					Line(trunc(x1 + del_1*(n-1)),15*getmaxy div 20,trunc(x1 + del_1*(n-1)),3*getmaxy div 20);
			 end else
			 begin
					str(x_min + del*(n-1):1:0,dtx);
					Outtextxy(trunc(x1 + del_1*(n-1)),16*getmaxy div 20,dtx);
					if n <> 1 then
					begin
						Outtextxy(trunc(x1 + del_1*(n-1)),15*getmaxy div 20,'!');
						SetLineStyle(1, 0, NormWidth);
						Line(trunc(x1 + del_1*(n-1)),15*getmaxy div 20,trunc(x1 + del_1*(n-1)),3*getmaxy div 20);
					end
			 end;
	  end;
end;

Procedure gerak(x,y : real);
var x1,y1 : real;
begin
	  transformasi(x_min,y_min,x_max,y_max,x,y,x1,y1);
	  MoveTo(trunc(x1),trunc(y1));
end;

Procedure draw(x,y : real);
var x1,y1 : real;
begin
     transformasi(x_min,y_min,x_max,y_max,x,y,x1,y1);
     LineTo(trunc(x1),trunc(y1));
end;

Procedure plot(x,y : real; warna : word);
var x1,y1 : real;
begin
     transformasi(x_min,y_min,x_max,y_max,x,y,x1,y1);
     putpixel(trunc(x1),trunc(y1),warna);
end;

Procedure panjang(x1,x2 : real; var d : real);
var xt1,xt2,yt1,yt2 : real;
begin
     transformasi(x_min,y_min,x_max,y_max,x1,0,xt1,yt1);
     transformasi(x_min,y_min,x_max,y_max,x2,0,xt2,yt2);
     d := trunc(sqrt(sqr(xt2-xt1) + sqr(yt2-yt1)));
end;

Procedure cir(x,y,r : real);
var x1,y1,rr : real;
begin
     transformasi(x_min,y_min,x_max,y_max,x,y,x1,y1);
     panjang(0,r,rr);
     circle(trunc(x1),trunc(y1),trunc(rr));
end;

Procedure Tutup(pesan_kiri,pesan_tengah,pesan_kanan : string);
begin
     setcolor(white);
     settextstyle(smallfont,horizdir,5);
     settextjustify(centertext,righttext);
	  outtextxy(getmaxx div 10, 21*getmaxy div 22,pesan_kiri);
	  outtextxy(getmaxx div 2, 21*getmaxy div 22,pesan_tengah);
	  outtextxy(9*getmaxx div 10, 21*getmaxy div 22,pesan_kanan);
end;
end.


