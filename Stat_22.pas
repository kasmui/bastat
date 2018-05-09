Program cari_file;
uses crt,dos,stat_m;
var lname,i : byte;
    DirInfo1,DirInfo2 : SearchRec;

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

Procedure tampil_file(x : byte; s : string);
begin
	  textcolor(white);
	  i := 3;
     FindFirst(s, Archive, DirInfo1);
	  while (DosError = 0) and( i < 25) do
	  begin
			 if i < 25 then
			 begin
					gotoxy(x,i);
			 end;
			 Write(DirInfo1.Name);
			 lname := length(dirInfo1.name);
			 lname := lname-6;
			 if i < 25 then
			 begin
					gotoxy(x+lname,i); write('        ');
			 end;
			 i := i + 1;
			 FindNext(DirInfo1);
	  end;
end;

Begin
	clrscr;
	cmati;
	tampilan('Daftar file data');
	tampil_file(1, '?xi.dat');
	tampil_file(4, '??xi.dat');
	tampil_file(8, '???xi.dat');
	tampil_file(13,'????xi.dat');
	tampil_file(20,'?????xi.dat');
	tampil_file(28,'??????xi.dat');
	tampil_file(38,'???????xi.dat');
end.