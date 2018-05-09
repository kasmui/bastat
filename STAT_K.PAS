Program kunci_mati;
uses crt,graph,stat_m;
var x,y : byte;
    kunci : string[10];
	 tombol : char;
	 ai,bi : byte;
Procedure bunyi;
begin
     sound(10000);delay(10);nosound;
end;

Procedure hurufxy(xh,yh,A,B : word; st : string);
begin
     TextColor(A);
     TextBackGround(B);
     GotoXY(xh,yh); write(st);
end;

Procedure garis_datar2(x1,x2,y : integer);
begin
     for i:= x1 to x2 do
     begin
          gotoxy(i,y); write('Í');
     end;
end;

Procedure garis_tegak2(y1,y2,x : integer);
begin
     for i:= y1 to y2 do
     begin
          gotoxy(x,i);  write('º');
     end;
end;

Procedure jendela(xb,yb,xe,ye : word; B : word);
begin
     for y := yb to ye do
     begin
          for x := xb to xe do
          begin
               TextBackGround(B);
               GotoXY(x,y);
               write(char(255));
               TextBackGround(B-1);
               GotoXY(x,yb-1);
               write(char(196));
               GotoXY(x,ye+1);
               write(char(196));
          end;
          TextBackGround(B-1);
          GotoXY(xb-1,y);
          write(char(179));
          GotoXY(xe+1,y);
          write(char(179));
     end;
     TextBackGround(B-1);
     GotoXY(xb-1,yb-1);
     write(char(218));
     GotoXY(xe+1,yb-1);
     write(char(191));
     GotoXY(xb-1,ye+1);
     write(char(192));
     GotoXY(xe+1,ye+1);
     write(char(217));
end;

Procedure bingkai2(tulis,layar : word);
begin
     clrscr;
     textcolor(tulis); textbackground(layar);
     clrscr;
     gotoxy(1,1);write('É');
     gotoxy(1,25);write('È');
	  garis_tegak2(2,24,1);
	  garis_tegak2(2,24,79);

	  garis_datar2(2,78,1);
	  garis_datar2(2,78,25);
	  gotoxy(79,1);write('»');
	  gotoxy(79,25);write('¼');
end;

Procedure Password;
begin
	  bingkai2(white,white);
	  Checkbreak := false;
	  REPEAT
                          CBesar;
			  textcolor(lightgreen);
			  gotoxy(26,5);  write('S E L A M A T  D A T A N G');
			  gotoxy(23,7);  write('PROGRAM KOMPUTER BASIC STATISTICS');
                          gotoxy(25,20); write('Programer : Drs. Kasmui, M.Si');

			  jendela(19,10,59,10,white);
			  hurufxy(21,10,lightblue,white,'SILAHKAN TEKAN PASSWORD ANDA : ______ ');
			  {gotoxy(54,10);
			  textcolor(Yellow);
			  gotoxy(15,23);write('KALAU NGGAK DONG TEKAN <Esc> 6 X LALU TEKAN <Enter>');}
			  gotoxy(52,10);
			  textcolor(lightgreen);
			  kunci:='';
			  for i:= 1 to 6 do
			  begin
			       tombol :=readkey;
			       textcolor(white);
			       gotoxy(51+i,10);write('*');
			       kunci:=kunci+upcase(tombol);
			  end;
			  cmati;
			  if (kunci<>'ALKEMI') and (kunci <> #27#27#27#27#27#27) and
	                     (kunci <>'KASMUI') and (kunci <>'ANISAH') THEN
			  repeat
			         jendela(19,10,59,10,7);
				 hurufxy(21,10,red+blink,7,'PASSWORD ANDA SALAH ............... !');
                                 textcolor(Yellow);
				 gotoxy(26,24);write('** SILAHKAN TEKAN ENTER **');
                                 bunyi;
                                 gotoxy(10,23); ClrEol;
                                 textcolor(white);
                                 gotoxy(79,23);write('º');
				 tombol:=readkey;
				 ai := random(65);
				 if ai < 3 then ai := 3;
				 bi := random(23);
				 if bi < 3 then bi := 3;
				 gotoxy(ai,bi); write('Astaghfirullah');
			  until tombol=#13;
			  gotoxy(25,24); write('                            ');
			  gotoxy(10,23); ClrEol;
			  textcolor(white);
			  gotoxy(79,23);write('º');
	  until (kunci ='ALKEMI') or (kunci = #27#27#27#27#27#27) or
	        (kunci ='KASMUI') or(kunci ='ANISAH');
	  if (kunci = #27#27#27#27#27#27) or (kunci ='KASMUI')
			or(kunci ='ANISAH') then halt(1);
end;

begin
     clrscr;
     password
end.
