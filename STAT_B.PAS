{$M 4000,0,0}
Program Cover;
uses stat_m,CRT,DOS;
type
    piksel = record
                   kar : char;
                   atr : byte;
             end;
    screenbuffer = array [1..25,1..80] of piksel;
    screentype   = (mono,color);
var
    Screen        : screenbuffer absolute $b800:$0000;
    x,y,xb,xe,yb,ye,xh,yh,i,j,A,B : word;
    xw,yw         : byte;
    Savescreen    : screenbuffer;
    stype         : screentype;
    st            : string;

Procedure Cbesar;
var regs:registers;
begin
        FillChar(regs,sizeof(regs),0);
        regs.AH := 1;
        regs.CH := 0;
        case stype of
        mono :regs.CL:= 13;
        color:regs.CL:= 7;
        end;
        intr($10,regs);
end;

Procedure Cmati;
var regs:registers;
begin
        fillChar(regs,sizeof(regs),0);
        with regs do
        begin
             AH:= $01;
             CH:= $20;
             CL:= $20;
        end;
        intr($10,regs);
end;

Procedure hurufxy(xh,yh,A,B : word; st : string);
begin
     TextColor(A);
     TextBackGround(B);
     GotoXY(xh,yh); write(st);
end;

Procedure LBK(xb,yb,xe,ye : word; B : word);
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

Procedure tampil;
var
   xw,yw : byte;
begin
     move(screen,savescreen,4000);
     xw := whereX;
     yw := whereY;
{     LBK(2,2,78,24,white);}
     LBK(3,3,77,23,blue);
	  hurufxy(25,4, red,7,' PROGRAM KOMPUTER BASIC STATISTICS  ');
	  hurufxy(25,6, red,7,'            Versi 1.2               ');
	  hurufxy(25,19,red,7,' JURUSAN KIMIA FMIPA UNNES SEMARANG ');
          hurufxy(25,21,red,7,'           Edisi 2002               ');
	  hurufxy(25,12,red,7,'              DOSEN:                ');
	  hurufxy(25,14,red,7,'        DRS. KASMUI, M.Si           ');
          hurufxy(25,23,blink+yellow,blue,'           Press Enter              ');
     repeat until readkey = #13;
     move(savescreen,screen,4000);
     gotoxy(xw,yw);
end;

Begin
     Clrscr;
     gelap;
     cmati;
     tampil;
     cbesar;
end.
