  {v. 1/7, 22:17 2000 Matz Johansson Illusion Graphics}
{$IFDEF CPU87}
  {$N+}
{$ELSE}
  {$N-}
{$ENDIF}

program Othello;
uses    crt,graph,dos;
type    asdf=string;
var     regs:registers;
        gd,gm:integer;
        ch:char;
        backboard,background,nyvem,vem,n,b,w,g,colour,c,d,i,a,x,e,v,ee,ve,que,r,o:integer;{ee ve „r e v fast f”r replay}
        y,z,q,k,aa:real;
        replayer,giltigt,ok,on:boolean;
        text,winn:string[25];
        ramc,xdir,ydir:shortint;{y-xdir „r till f”r syntetiska mark”ren -255..255}
        {r„knare f”r ram beh”vs n„r man skall manipulera str„ngen}
        session:byte;{vilken match vill man se i replay?}
        othboard:array[1..9,1..9] of byte;
        moves:array[1..9,1..9] of byte;
        Ram:string[120]; {max antal drag-koordinater (8*8-4)}
        log:asdf;
        f:file of asdf;


                      procedure MLC; {Matz Learning computer}
begin
      {
      ...
      ...
      ...
      ...

      }
end;

                      procedure openlog;
begin
      {time---------------}



      {time---------------}
      {str(time,log);}
      {datum och tid i n†gon kod s† att man inte sparar
      filnamn ”ver varandra}
      {skall l„gga till en rutin som tar bort de filer vars inneh†ll
      „r 'snarlika' eller helt lika f”r att ”ka minnesutrymme}
      assign(f,'c:\othello\'+log+'.dat');
      reset(f);
end;

                      procedure scratch;
begin
   othboard[4,5]:=2;
   othboard[5,4]:=2;
   othboard[4,4]:=1;
   othboard[5,5]:=1;
end;


                      procedure turn;
 begin
     setcolor(black);
     settextstyle(7,horizdir,1);
 for n:=440 to 500 do
     line(n,460,n,440);
     setcolor(white);
    if vem=1 then
     outtextxy(450,445,'Red');
    if vem=2 then
     outtextxy(450,445,'Blue');
end;

                      procedure shell;
   begin
    setcolor(colour);
     circle(63*c-31,55*d-27,20);
     setfillstyle(1,colour);
     floodfill(63*c-31,55*d-27,colour);
     setcolor(yellow);
     ellipse(63*c-32,55*d-25,45,90,20,20);
     ellipse(63*c-33,55*d-25,45,90,20,20);
     setcolor(white);
     ellipse(63*c-31,55*d-25,45,90,20,20);
   end;

   {egentligen inte bra}
                      procedure camp;
begin
  log:='x';
  write(f,log);
for a:=1 to 8 do
  begin
  othboard[random(8)+1,random(8)+1]:=1;
  othboard[random(8)+1,random(8)+1]:=2;
  end;
end;

                function switch(x:integer):integer;
 begin
      vem:=round(-3*(vem*vem)/2+(7*vem)/2);{formel f”r bytet}
 end;

                      procedure clear;
 begin
{rensar moves}
  for c:=1 to 8 do
   moves[c,1]:=0;
  for c:=1 to 8 do
   moves[1,c]:=0;
 end;

                      procedure giltig;
     begin
     if giltigt then
     begin
   {moves[c,d]:=vem;}

{s„tter fast en bricka}
     if vem=1 then
      colour:=red;
     if vem=2 then
      colour:=blue;
     shell;

     othboard[e,v]:=vem;{registrerar att brickan „r p† bordet}
     moves[e,v]:=vem;

{koordinaterna f”r drag till fil}
{f”r att kunna fylla ett tomrum f”r varje data-packe har jag kommit p†
att man faktiskt kan skicka de b†da koordinaterna samtidit s† att de fyller
de tv† platserna som finns lediga (string[1]='  ')}

     {sparar i ram}
     str(e,log);
      ram:=ram+log;
      str(v,log);
      ram:=ram+log;

     {m†ste l„gga till koordinaten f”r c,d ocks†}
     {under f”ruts„ttning att man s„tter dem om man gjort ett 'giltigt' drag}
     nyvem:=vem;{switch}
     switch(vem);
    end;
     giltigt:=false;
     {draget „r gjort}
    end;

                      procedure scan;
begin
    {Horisontellt till h”ger}
     if c<7 then
     begin

     if othboard[c+1,d]=nyvem then
begin
     i:=c;
     repeat
      i:=i+1;
     until (othboard[i,d]=vem) or (othboard[i,d]=0) or (i=8);
     if othboard[i,d]=vem then
 begin
      a:=i;
      for i:=c to a do
      moves[i,d]:=vem;
     giltigt:=true;{om draget „r giltigt eller inte}
 end;
 end;
end;
     {Horisontellt v„nster}
     if c>2 then
 begin
     if othboard[c-1,d]=nyvem then
  begin
     i:=c;
    repeat
     i:=i-1;
    until (othboard[i,d]=vem) or(othboard[i,d]=0) or (i=1);
     if othboard[i,d]=vem then
    begin
       a:=i;
     for i:=a to c-1 do
       moves[i,d]:=vem;
       giltigt:=true;
    end;
  end;
 end;
     if d>2 then{Vertikal upp}
 begin
     if othboard[c,d-1]=nyvem then
  begin
      i:=d;
   repeat
      i:=i-1;
   until (othboard[c,i]=vem) or (othboard[c,i]=0) or (i=1);
      if othboard[c,i]=vem then
    begin
      a:=i;
      {det m†ste vara till d eftersom d motsvarar y-axeln i br„det}
      for i:=a to d do
      moves[c,i]:=vem;
      giltigt:=true;
    end;
  end;
 end;
      if d<7 then {vertikal ned}
    begin
      if othboard[c,d+1]=nyvem then
  begin
      i:=d;
      repeat
      i:=i+1;
      until (othboard[c,i]=vem) or (othboard[c,i]=0) or (i=8);
      if othboard[c,i]=vem then
   begin
      a:=i;
      for i:=d to a do
       moves[c,i]:=vem;
      giltigt:=true;
   end;
  end;
end;
     if (d>2) or (c>2) then {Diagonalt upp v„nster}
begin
     if othboard[c-1,d-1]=nyvem then
 begin
       x:=c;
       i:=d;
   repeat
     i:=i-1;
     x:=x-1;
   until (othboard[x,i]=vem) or (othboard[x,i]=0) or (x=1) or (i=1);
     if othboard[x,i]=vem then
  begin
     a:=i;
     for i:=a to d do
   begin
     moves[x,i]:=vem;
     {m†ste vara efter moves eftersom i=a fr†n b”rjan likas† „r y=c}
     x:=x+1;
   end;
     giltigt:=true;
  end;
 end;
end;
     {diagonalt ned h”ger}
     if (c<7) or (d<7) then {det existerar inga brickor som man kan v„nda efter den 7e platsen}
  begin
     if othboard[c+1,d+1]=nyvem then
begin
       x:=c;
       i:=d;
  repeat
     x:=x+1;
     i:=i+1;
  until (othboard[x,i]=vem) or (othboard[x,i]=0) or (x=8) or (i=8);
     if othboard[x,i]=vem then
 begin
     a:=i;
     x:=c;
     for i:=d to a do
     begin
     moves[x,i]:=vem;
     x:=x+1;
     end;
     giltigt:=true;
  end;
 end;
end;
      {diagonalt upp h”ger}
     if (c<7) or (d>2) then
begin
     if othboard[c+1,d-1]=nyvem then
begin
       x:=c;
       i:=d;
  repeat
     i:=i-1;
     x:=1+x
  until (othboard[x,i]=vem) or (othboard[x,i]=0) or (x=8) or (i=1);
     if othboard[x,i]=vem then
 begin
     a:=i;
     for i:=a to d do{a>d; i-->a}
begin
     moves[x,i]:=vem;
     x:=x-1;
end;
     giltigt:=true;
  end;
 end;
end;
   {diagonalt ner}
     if (c>2) or (d<7) then
  begin
     if othboard[c-1,d+1]=nyvem then
begin
       x:=c;
       i:=d;
  repeat
     i:=i+1;
     x:=x-1;
  until (othboard[x,i]=vem) or (othboard[x,i]=0) or (x=1) or (i=8);
     if othboard[x,i]=vem then
 begin
     a:=i;
     x:=c;
  for i:=d to a do
   begin
     moves[x,i]:=vem;
     x:=x-1;
   end;
    giltigt:=true;
  end;
 end;
end;
{giltig; tar jag bort s† att den blir frist†ende}
end;


                      procedure pass;             {fixar under construction}
begin  {om det inte „r giltigt passar man ”ver till motst†ndaren}
 {skall l„gga in en replay som kr„ver att pass fungerar}
 for c:=1 to 8 do
  for d:=1 to 8 do
 begin
  begin
 scan; {ingen giltig sedan}
  end;
 end;
if not(giltigt) then
begin
setcolor(0);
outtextxy(0,0,'pass');

switch(vem);
turn;
end;
end;

                      procedure othelloboard;{othellobordet ritas ut}
 begin
    setfillstyle(1,backboard);
    floodfill(0,0,1);
    setcolor(black);
    for c:=1 to 8 do
  begin
    rectangle(63*c,0,63,440);
    rectangle(0,55*c,504,0);
 end;
    line(524,460,524,0);
    line(524,460,0,460);
    line(504,440,524,460);{3d-djup}
    setfillstyle(1,0);
    floodfill(519,459,0);
    setfillstyle(10,background);
    floodfill(600,400,0);
  end;

                      procedure turnover;
 begin
  {all grafics}
  setcolor(backboard);
  {v„nder p† brickorna}

  for c:=1 to 8 do
   for d:=1 to 8 do
  begin
   begin

    if moves[c,d]<>othboard[c,d] then {f”r att inte skriva ut n†gon flera ggr}
    if moves[c,d]=nyvem then
begin
{if moves[c,d]=1 then
   colour:=blue;
   if moves[c,d]=2 then
   colour:=red;}
   a:=21;
 repeat
    delay(6);
    if nyvem=1 then
    colour:=red;
    if nyvem=2 then
    colour:=blue;
    setcolor(backboard);
    ellipse(63*c-31,55*d-25,45,90,a,20);
    ellipse(63*c-32,55*d-25,45,90,a,20);
    ellipse(63*c-33,55*d-25,45,90,a,20);
    a:=a-1;
    ellipse(63*c-31,55*d-27,0,360,a,20);

    setcolor(yellow);
    ellipse(63*c-32,55*d-25,45,90,a,20);
    ellipse(63*c-33,55*d-25,45,90,a,20);
    setcolor(white);
    ellipse(63*c-31,55*d-25,45,90,a,20);

 until a=0;
    setcolor(colour);
    line(63*c-31,55*d-46,63*c-31,55*d-7);{ritar ”ver det h†lrummet som bildades i ellipsen}
    {andra sidan av brickan}
    if nyvem=1 then
    colour:=red;
    if nyvem=2 then
    colour:=blue;
    setcolor(backboard);

 repeat
    delay(6);
    setcolor(colour);
 {m†lar ”ver lensflare-ellipsen med brick-f„rgen}
    ellipse(63*c-31,55*d-25,45,90,a,20);
    ellipse(63*c-32,55*d-25,45,90,a,20);
    ellipse(63*c-33,55*d-25,45,90,a,20);
    a:=a+1;
    ellipse(63*c-31,55*d-27,0,360,a,20);{ny bricka vecklas ut}
    setcolor(yellow);
    ellipse(63*c-32,55*d-25,45,90,a,20);
    ellipse(63*c-33,55*d-25,45,90,a,20);
    setcolor(white);{lensflare-effekten}
    ellipse(63*c-31,55*d-25,45,90,a,20);
 until a=20;
  end;
     end;
   end;
end;

                      procedure brickor;
 begin
   for c:=1 to 8 do
   for d:=1 to 8 do
  begin
   begin
   if moves[c,d]<>0 then
   othboard[c,d]:=moves[c,d];
   end;
  end;

  for c:=1 to 8 do
  for d:=1 to 8 do
  begin
   begin

    if othboard[c,d]=1 then
begin
    colour:=red;
    shell;
    {setcolor(red);
    circle(63*c-31,55*d-27,20);
    setfillstyle(1,red);
    floodfill(63*c-31,55*d-27,red);
    setcolor(yellow);
    ellipse(63*c-32,55*d-25,45,90,20,20);
    ellipse(63*c-33,55*d-25,45,90,20,20);
    setcolor(white);
    ellipse(63*c-31,55*d-25,45,90,20,20);}
    {ellips f”r den andra f„rgen}
end;
    if othboard[c,d]=2 then
begin
   colour:=blue;
   shell;
  {setcolor(blue);
    circle(63*c-31,55*d-27,20);
    setfillstyle(1,blue);
    floodfill(63*c-31,55*d-27,blue);
    setcolor(yellow);
    ellipse(63*c-32,55*d-25,45,90,20,20);
    ellipse(63*c-33,55*d-25,45,90,20,20);
    setcolor(white);
    ellipse(63*c-31,55*d-25,45,90,20,20);}
   end;
  end;
 end;
end;

                      procedure winner;
begin
     b:=0;
     i:=0;
    {kontrollerar om n†gon vunnit}

    for a:=1 to 8 do
    for x:=1 to 8 do
 begin
  begin
     if othboard[x,a]=1 then
     i:=i+1;
     if othboard[x,a]=2 then
     b:=b+1;
  end;
 end;

     if b=0 then
     outtextxy(200,200,'Red rules');
     if i=0 then
     outtextxy(200,200,'Way to go Blue');
     if b+i=64 then
begin
     {r„knar upp alla brickor}
     delay(1000);
     cleardevice;
     othelloboard;
     setcolor(red);

     if b>i then
     winn:='Blue  wins';
     if b<i then
     winn:='Red  wins';
     if b=i then
     winn:='Draw, close but no cigar';
   w:=1;{r„knare skall egentligen vara 1 och i=1 osv}
   g:=1;
   d:=1;{positionerna p† br„det}
   c:=1;
   x:=8;
   a:=8;

repeat
{observera att brickornas antal inte synkade med siffrorna som st†r f”rr„n i slutet}
     delay(400);
  {r”da brickor}
     colour:=red;
     shell;
    { setcolor(red);
     circle(63*c-31,55*d-27,20);
     setfillstyle(1,red);
     floodfill(63*c-31,55*d-27,red);
     setcolor(yellow);
     ellipse(63*c-32,55*d-25,45,90,20,20);
     ellipse(63*c-33,55*d-25,45,90,20,20);
     setcolor(white);
     ellipse(63*c-31,55*d-25,45,90,20,20);  }
     {bl†a brickor}
    {det g†r inte att anv„nda shell h„r pga att jag anv„nder andra variabler x och a}
     setcolor(blue);
     circle(63*x-31,55*a-27,20);
     setfillstyle(1,blue);
     floodfill(63*x-31,55*a-27,blue);
     setcolor(yellow);
     ellipse(63*x-32,55*a-25,45,90,20,20);
     ellipse(63*x-33,55*a-25,45,90,20,20);
     setcolor(white);
     ellipse(63*x-31,55*a-25,45,90,20,20);

      if b<>0 then{bl†a brickorna}
begin {n„r b=0 „r brickorna slut}
     w:=w+1;{till texten}
     b:=b-1;{koordinaterna}
     a:=a-1;
     if a=0 then
   begin
     a:=8;{flyttar brickorna en position †t v„nster}
     x:=x-1;
   end;
end;
    setcolor(black);
for n:=529 to 610 do
    line(n,300,n,310);
    setcolor(blue);
    str(w,text);
    outtextxy(530,300,'Blue:'+text);

   if i<>0 then{de r”da brickorna}
begin
     g:=g+1;
     i:=i-1;
     d:=d+1;
     if d>8 then
  begin
     c:=c+1;
     d:=1;
  end;
end;
    setcolor(black);
for n:=529 to 610 do
    line(n,200,n,210);
    setcolor(red);
    str(g,text);
    outtextxy(530,200,'Red:'+text);
    if g+w=64 then
    outtextxy(520,100,'Press enter');

 until keypressed;
      delay(400);
  {vinnaren}
      setcolor(black);
      for n:=190 to 410 do
      line(n,200,n,210);
      setcolor(white);
      outtextxy(200,200,winn);
      delay(3000);
      readln;
      halt;
 end;
end;

                      procedure cursor;
 begin
    rectangle(63*c,55*d,63*(c-1),55*(d-1));
 end;

                      procedure anticursor;
 begin
    setcolor(0);
    cursor;

 end;

                      procedure stamp;
 begin
   if othboard[c,d]=0 then{kollar om platsen „r ledig}
  begin
   scan;
   giltig;{m†ste l„gga till giltig eftersom scan „r frist†ende
    och att jag d„rf”r m†ste anropa giltig f”r att registrera
    att en bricka satts p† othellobordet}
 end; {om man redan st†r p† en bricka som „r tagen. se „ven scan}
  end;

                      procedure droutine;
{kub som snurrar}
Begin
    a:=0;
    que:=100;
    if q>360 then
    q:=0;

{--zip--}

setcolor(magenta);
repeat
aa:=aa+pi/2;
line(round(cos(q+aa+x)*60+200),round(sin(q+x+aa)*60/4+que),round(cos(q+x+aa)*60+200),round(sin(q+pi/2+aa)/4*60+100+que));
until aa>2*pi;

setcolor(magenta);
repeat
aa:=aa+pi/2;
line(round(cos(q+aa+x)*60+400),round(sin(q+x+aa)*60/4+que),round(cos(q+x+aa)*60+400),round(sin(q+pi+aa)/4*60+100+que));
until aa>2*pi;
{rotera delen av pelaren}


 {line(     );
 line(     ); }
{--zip--}
{ line(round(cos(q+pi/2)*60+200),round(sin(q+pi/2)*60/4+150),round(cos(q+pi/2)*60+200),round(sin(q+pi/2)/4*60+100));
 line(round(cos(q+pi)*60+200),round(sin(q+pi)/4*60+150),round(cos(q+pi)*60+200),round(sin(q+pi)/4*60+100));
 line(round(cos(q+3/2*pi)*60+200),round(sin(q+3/2*pi)/4*60+150),round(cos(q+3/2*pi)*60+200),round(sin(q+3/2*pi)/4*60+100));
 line(round(cos(q+2*pi)*60+200),round(sin(q+2*pi)/4*60+150),round(cos(q+2*pi)*60+200),round(sin(q+2*pi)/4*60+100));
{locket och botten}
 {line(round(cos(q+pi/2)*60+200),round(sin(q+pi/2)/4*60+100),round(cos(q+pi)*60+200),round(sin(q+pi)/4*60+100));
 line(round(cos(q+pi)*60+200),round(sin(q+pi)/4*60+100),round(cos(q+3/2*pi)*60+200),round(sin(q+3/2*pi)/4*60+100));
 line(round(cos(q+2*pi)*60+200),round(sin(q+2*pi)/4*60+100),round(cos(q+3/2*pi)*60+200),round(sin(q+3/2*pi)/4*60+100));
 line(round(cos(q+2*pi)*60+200),round(sin(q+2*pi)/4*60+100),round(cos(q+pi/2)*60+200),round(sin(q+pi/2)/4*60+100));
 line(round(cos(q+pi/2)*60+200),round(sin(q+pi/2)/4*60+150),round(cos(q+pi)*60+200),round(sin(q+pi)/4*60+150));
 line(round(cos(q+pi)*60+200),round(sin(q+pi)/4*60+150),round(cos(q+3/2*pi)*60+200),round(sin(q+3/2*pi)/4*60+150));
 line(round(cos(q+2*pi)*60+200),round(sin(q+2*pi)/4*60+150),round(cos(q+3/2*pi)*60+200),round(sin(q+3/2*pi)/4*60+150));
 line(round(cos(q+2*pi)*60+200),round(sin(q+2*pi)/4*60+150),round(cos(q+pi/2)*60+200),round(sin(q+pi/2)/4*60+150));
 }
 end;

                      procedure anticube;
      begin
      setcolor(black);
      droutine;
      end;

                      procedure xe;
  begin
  delay(49);
  end;

                      procedure pix;
begin
      putpixel((round(x)+300),round(-y)+240,1);
      putpixel(round(x+300),round(-y+241),2);
      putpixel(round(x+300),round(-y+242),14);
      putpixel(round(x+300),round(-y+243),15);
      putpixel(round(x+300),round(-y+244),14);
      putpixel(round(x+300),round(-y+245),2);
      putpixel(round(x+300),round(-y+246),1);
end;

                      procedure cursorq;
begin
rectangle(195,round(y+25),400,round(y-15));
end;

                      procedure anticursorq;
begin
setcolor(0);
cursorq;
end;

                      procedure syntheticcursor;
begin
{l†ter mark”ren vila i n†gra millisekunder mellan varje steg}
repeat
{c,d „r nuvarande koordinater e,v „r m†len}
  xdir:=c-e;
  ydir:=d-v;

  if xdir>0 then
   begin
    repeat
     anticursor;
     c:=c-1;
     setcolor(white);
     cursor;
     delay(random(100)+100);
    until c=e;
   end;

  if xdir<0 then
   begin
    repeat
     anticursor;
     c:=c+1;
     setcolor(white);
     cursor;
     delay(random(000)+100);
    until c=e;
   end;

  if ydir>0 then
   begin
    repeat
     anticursor;
     d:=d-1;
     setcolor(white);
     cursor;
     delay(random(000)+100);{kanske random-delay}
    until d=v;
   end;

  if ydir<0 then
   begin
    repeat
     anticursor;{p†verkar olyckligtvis den nuvarande f„rgen}
     d:=d+1;
     setcolor(white);{†terst„ller nuvarande f„rg}
     cursor;
     delay(random(000)+100);
    until d=v;
   end;

until (c=e) and (d=v);
    delay(random(100)+100);{datorn s„tter en bricka}
    cursor;
    delay(100);
    stamp;
end;

                      procedure replay;{komplicerad}
begin
    scratch;
    othelloboard;
    brickor;
    turn;
   outtextxy(530,30,'Replay mode');
   repeat
{utklassning}

   ee:=c;
   ve:=d;
if session=1 then
ram:='564635645343342433422257361174846537231273824738';

{fixa s† att man kan v„lja vilken sesion som helst}

{if (session=1) and (ramc<61) then
ram:='543656533553721672662613674787743352514262611314261878887216';
if (session=1) and (ramc>60) then
ram:='211285868382817886626842716541635167381728188586778778881112';
}
  val(copy(ram,ramc,1),e,e);{1 st†r f”r ett tecken}
  {konverterar log-str„ngen till ett integer-v„rde}
  ramc:=ramc+1;
  val(copy(ram,ramc,1),v,v);
  ramc:=ramc+1;
      turnover;
      turn;
      brickor;{v„nder och vrider p† brickorna}
      {beh”ver inte kolla efter winner innan koden „r slut (replay-koden}
      clear;{rensar}
      setcolor(white);
      c:=ee;
      d:=ve;
      {***********}
{den syntetiska mark”ren kan man anv„nda till datorn (com)}
      {varf”r utser inte datorn en vinnare?}
      {***********}
      syntheticcursor;

      {ramc h†ller reda p† dragen}
      if ramc>length(ram) then {denna strofen „r viktig roundup}
      begin
      turnover;
      turn;
      brickor;
      winner;{winner}
      delay(3000);
      closegraph;
      writeln('Replay mode...done');
      readln;
      readln;
      halt;
      end;
   until ramc>length(ram);

closegraph;
halt;
end;

                      procedure opengraph;
begin
gd:=detect;
    initgraph(gd,gm,'a:');
    if graphresult <> grOK then
 begin
   clrscr;
   textcolor(1);
   sound(120);
   delay(40);
   nosound;
   delay(100);
   sound(120);
   delay(200);
   nosound;
   writeln('                             ...ERROR_CGF:Computer Grafics-failure');
   delay(1500);
   writeln('Make sure that the a:\Bp\Matz\Egavga.bgi and Goth.chr exists');
   writeln('If not, contact Matz JB');
   readln;
   halt(1);
 end;
end;

                      procedure natreg;{musrutin}
 begin
   regs.ax:=$3;
with regs do
  intr($33,regs);
 on:=false;
end;


begin
randomize;
{f”r att vara s„ker p† att allt som slumpas „r olika fr†n g†ng till...}
   {initierar logfil}
{   Assign(f,'c:\othello\Mlog.dat');
   reset(f);
 }
   {intro... brickor faller ner}
  replayer:=false;
  ramc:=1;
  clrscr;
  writeln('Matz Othello Beta-version 2000-30/6');
  writeln('************************************settings**********************************');

  write('2 )background:');
  readln(background);
  write('5 {not 4 or 1})board:');
  readln(backboard);
  opengraph;


 {background:=magenta;}
  x:=-301;
     y:=0;
     k:=7;
delay(2000);
repeat
     {utritning av pixlar}
     x:=15+x;
     y:=-sin(cos(arctan(k*x*x)))*200;
     pix;
     {linjen „r utritad om x har ritats till x-koordinaten 300}
     if x>300 then
begin
     x:=-301;
     delay(25);
if k>0.00001 then{h†ller p† att rita ut linjen tills den har formen k<0.00001}
begin
     repeat
     x:=15+x;
     y:=-sin(cos(arctan(k*x*x)))*200;
     setcolor(0);
     line(round(x)+300,round(-y)+240,round(x)+300,round(-y)+246);
     until x>300;
{Matz 2Droutine for function-based animation}
  x:=-301;
  k:=0.91*k;
end;
end;
     {jag m†ste fixa s† att linjen ligger kvar}
     {„ndrar k-v„rdet g”r att kurvans form „ndras}
     until k<0.00001;
     {signatur Matz}
  b:=1;
  setcolor(green);
  outtextxy(400,300,' Happy Production presents');
  setcolor(white);
  delay(100);
  line(22,306,91,49);
  delay(100);
  line(91,49,59,194);
  delay(50);
  line(59,194,58,234);
 xe;
 xe;
  line(58,234,65,242);
 xe;
  line(65,242,85,218);
 xe;
  line(85,218,145,65);
 xe;
  line(145,65,96,226);
 xe;
  line(96,226,98,282);
 xe;
  line(98,282,107,306);
 xe;
  line(107,306,123,298);
 xe;
  line(123,298,133,274);
 xe;
  line(133,274,133,258);
 xe;
  line(133,258,123,258);
 xe;
  line(123,258,117,315);
 xe;
  line(117,315,133,315);
 xe;
  line(133,315,236,81);
 xe;
  line(236,81,170,306);
 xe;
  line(170,306,165,226);
 xe;
  line(165,226,293,218);
 xe;
  line(293,218,298,226);
 xe;
  line(298,226,245,298);
 xe;
  line(245,298,287,290);
 xe;
  line(287,290,309,306);
 xe;
  line(309,306,309,339);
 xe;
  line(309,339,293,378);
 xe;
  line(293,378,218,492);
 xe;
  line(218,492,213,516);
 xe;
  line(213,516,234,435);
 xe;
  line(234,435,321,285);
 xe;
  line(321,285,352,247);
 xe;
  line(352,247,372,234);

  delay(2000);
  cleardevice;
   {titelsk„rmen}

   settextstyle(4,horizdir,7);
   outtextxy(125,0,'*OTHELLO*');
   settextstyle(4,horizdir,3);
   outtextxy(220,450,'Press [Enter] to play');
   z:=-300;
setcolor(red);

{rectangle(100,100,500,400);
rectangle(99,99,501,399);}
   outtextxy(0,450,'Illusion graphics');

   repeat
{g”ra s† att kuben blir mindre (flimrar inte s† mycket d†)}
{i och med att den blir mindre m†ste jag hitta ett nytt anv„ndningsomr†de f”r
den ist„llet f”r att den skall anv„ndas som en snygg intro-bild s† anv„nder
jag den som en valpekare man v„ljer vad man vill i spelet (|1p vs 2p| enda
valm”jligheten nu, senare skall menyn expanderas s† att man kan 'scrolla' sig
till sitt val}

     delay(25);
     anticube;
     q:=q+0.029;
     setcolor(13);
     droutine;
     setcolor(white);
   until keypressed;
  cleardevice;
{en passande bakgrundsf„rg f”r de svarta och vita brickorna}
{originalinst„llningar}
     vem:=2;
     nyvem:=1;
 for c:=1 to 8 do
     othboard[c,1]:=0;
 for c:=1 to 8 do
     othboard[1,c]:=0;
     {tomt othello-br„de}
scratch;
     {s„tter ut start-brickorna}

     {0=tom ruta 1=vit bricka 2=svart bricka}
     othelloboard;
     {bordet med rutorna ritas ut}
     brickor;{brickorna ritas ut}
     turn;
     cursor;{mark”ren ritas ut}
     c:=8;
     d:=8;

{repeat}
   {startar musmotorn}

   regs.ax:=0;
   with regs do
   intr($33,regs);
   regs.ax:=$1;
   intr($14,regs);{14 ist„llet f”r 33 g”r att musen inte syns}
   {on:=false;  }

repeat

   regs.ax:=$3;
 with regs do
   intr($33,regs);

 if (regs.cx<504) and (regs.cx>0) and (regs.dx<440) and (regs.dx>0) then
 begin
 {„r regs.cx integer eller real eller inget}

  ee:=c;
  ve:=d;
  o:=0;
 repeat
  o:=1+o;
 until o>regs.cx/63;
  c:=o;{0-63==1 ...}
  o:=0;
 repeat
  o:=1+o;
 until o>regs.dx/55;
  d:=o;

 if (ee<>c) or (ve<>d) then
    begin
 {muspekaren †r synkad med mark”ren/cursor}
     setcolor(0);
     rectangle(63*ee,55*ve,63*(ee-1),55*(ve-1));{f”rb„ttrad version f”r mus}
     {anv„nder de gamla v„rdena ee och ve}
     setcolor(white);
     cursor;
     delay(20);
    end;

 {musen}

 if regs.bx=1 then
 begin

       e:=c;{nya variabler f”r att f† mark”ren att stanna d„r den skall vara}
       v:=d;
       stamp;
       {anticursor;}{kvadraten f”rsvinner f”r en stund}
       {brickor;}
       turnover;

       turn;{visar vem som skall s„tta en bricka}

       brickor;

       winner;
       clear;
       setcolor(white);
       c:=e;{mark”ren †terf†r sin position}
       d:=v;

       cursor;

end;
end;
until regs.bx=2;{musrutin och mark”r}

{efter man tryckt p† h”gerknappen}
repeat

 if readkey='r' then
begin
    outtextxy(530,20,'REPLAY');
    outtextxy(0,0,'Do you really want to REPLAY? y/n ');

 repeat
  if readkey='y' then
   begin
     outtextxy(530,30,'session1.');
   {  outtextxy(530,50,'session2. ');  }
     read(session);
     replayer:=true;
     cleardevice;
     setcolor(white);
     replay;{visar alla drag i repris; komplex}
     writeln('replaymode done...');
     readln;
     cleardevice;
     setcolor(white);
   end;


 until readkey='n';
end;


if readkey='p'then
begin
    nyvem:=vem;
    switch(vem);
    turn;
end;




until readkey='q';{man skall kunna komma tillbaka till othello}
halt;


   ch:=readkey;
   case ch of
'p':begin
     nyvem:=vem;
     switch(vem);
     turn;
end;

'6':begin
    if c<>8 then
 begin
    anticursor;
    c:=c+1;
    setcolor(white);
    cursor;
 end;
        end;
'3':begin
    if (c<>8) and (d<>8) then
 begin
    anticursor;
    c:=c+1;
    d:=d+1;
    setcolor(white);
    cursor;
 end;
end;

'2':begin
    if d<>8 then
  begin
    anticursor;
    d:=d+1;
    setcolor(white);
    cursor;
  end;
        end;

'1':begin
    if (c<>1) and (d<>8) then
 begin
      anticursor;
      c:=c-1;
      d:=d+1;
      setcolor(white);
      cursor;
 end;
 end;

'4':begin
    if c<>1 then
 begin
       anticursor;
       c:=c-1;
       setcolor(white);
       cursor;
 end;
        end;

'7':begin
    if (c<>1) and (d<>1) then
 begin
       anticursor;
       c:=c-1;
       d:=d-1;
       setcolor(white);
       cursor;
 end;
end;

'8':begin
    if d<>1 then
  begin
       anticursor;
       d:=d-1;
       setcolor(white);
       cursor;
  end;
        end;

'9':begin
    if (d<>1) and (c<>8) then
  begin
       anticursor;
       d:=d-1;
       c:=c+1;
       setcolor(white);
       cursor;
    end;
  end;

'0':begin
         e:=c;{nya variabler f”r att f† mark”ren att stanna d„r den skall vara}
         v:=d;
         stamp;
         {anticursor;}{kvadraten f”rsvinner f”r en stund}
         {brickor;}
         turnover;
         turn;{visar vem som skall s„tta en bricka}
         brickor;
         winner;
         clear;
         setcolor(white);
         c:=e;{mark”ren †terf†r sin position}
         d:=v;
         cursor;
         end;

 'x':camp;

 'r':begin
 outtextxy(530,20,'REPLAY');
  outtextxy(0,0,'Do you really want to REPLAY? y/n ');
 repeat
 if readkey='y' then
  begin
  outtextxy(530,30,'session1.');
  outtextxy(530,50,'session2. ');
  read(session);
  replayer:=true;
  cleardevice;
  setcolor(white);
  replay;{visar alla drag i repris; komplex}
  cleardevice;
  setcolor(white);

  end;
 until readkey='n';
 end;

 'q':begin
  setcolor(backboard-2);
  outtextxy(0,0,'Do you really want to quit? y/n ');

 repeat
 if readkey='y' then
  begin
   closegraph;
   halt;
  end;

 until readkey='n';

   opengraph;
   cleardevice;
   othelloboard;
   brickor;
    c:=e;{mark”ren †terf†r sin position}
    d:=v;
   cursor;
   turn;
  end;
 end;

end.