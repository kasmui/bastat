{$N+}
Unit stat_gam;
Interface
var x    : extended;

function gam(x : extended) : extended;
implementation

function gam(x : extended) : extended;
var y,f : extended;

    function sgam(y: extended): extended;
    var tmp,f : extended;
    begin
         f := y;
         tmp := f;
         f := f * y;
         tmp := tmp + f * 0.5772156649015329;
         f := f * y;
         tmp := tmp + f * -0.6558780715202538;
         f := f * y;
         tmp := tmp + f * -0.0420026350340952;
         f := f * y;
         tmp := tmp + f * 0.1665386113822915;
         f := f * y;
         tmp := tmp + f * -0.0421977345555443;
         f := f * y;
         tmp := tmp + f * -0.0096219715278770;
         f := f * y;
         tmp := tmp + f * 0.0072189432466630;
         f := f * y;
         tmp := tmp + f * -0.0011651675918591;
         f := f * y;
         tmp := tmp + f * -0.0002152416741149;
         f := f * y;
         tmp := tmp + f * 0.0001280502823882;
         f := f * y;
         tmp := tmp + f * -0.00002013485478070;
         f := f * y;
         tmp := tmp + f * -0.00000125049348210;
         f := f * y;
         tmp := tmp + f * 0.00000113302723200;
         f := f * y;
         tmp := tmp + f * -0.00000020563384170;
         f := f * y;
         tmp := tmp + f * 0.0000000061160950;
         f := f * y;
         tmp := tmp + f * 0.00000000500200750;
         f := f * y;
         tmp := tmp + f * -0.00000000118127460;
         f := f * y;
         tmp := tmp + f * 0.00000000010434270;
         f := f * y;
         tmp := tmp + f * 0.00000000000778230;
         f := f * y;
         tmp := tmp + f * -0.0000000000036968;
         f := f * y;
         tmp := tmp + f * 0.00000000000005100;
         sgam := 1/tmp;
    end;

    begin
         if x = 1 then
         begin
              gam := 1;
         end else
         begin
              if x < 0 then
              begin
                   gam := -(pi/(x*sin(pi*x)*gam(-x)));
              end else
              begin
                   y := x;
                   f := 1;
                   while y > 1 do
                   begin
                        y := y - 1;
                        f := f * y;
                   end;
                   if y = 1 then
                   begin
                        gam := f;
                   end else
                   begin
                        if y > 1/2 then
                        begin
                             gam := f * pi/(sin(pi*y)* gam(1-y));
                        end else
                        begin
                             gam := f * sgam(y);
                        end;
                   end;
              end;
         end;
    end;
end.
