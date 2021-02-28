-----------------------------------------

## Kursmoment 01

### Utvecklingsmiljö

Jag använder omväxlande en gammal mac och 2 linux-datorer som synkas via Dropbox.
Som dbms använder jag 10.5.8-MariaDB på mac och nog ganska lik version på linux.
Jag kör för det mesta MySQLWorkbench 8.0.x fast även en del cli.
Nu i början kör jag Atom för redigering av filer (i terminal brukar det vara nvim) som jag importerar i MySQLWorkbench.
Får se om jag kommer växla till/kombinera med VSC framöver. Om det blir mer omfattande js kommer det blir mer av VSC. För ren sql och redovisning är jag nöjd med Atom.

### Att komma igång med DB/sql

I htmlphp-kursen använde vi en del sqlite och jag använde det i en annan kurs också så jag har fått damma av sql. Däremot var det ett bra tag sedan (flera år) jag jobbade senaste lite mer med MySql (läs MariaDB) så det är en viss inkörningsperiod.
Sedan hade jag planer att eventuellt hoppa över den här kursen (läser ändå 3 andra ML extra kurser parallellt) för jag har redan en db-kurs sedan ca. 20 år tillbaka.
Men och med att det annonserats att det blir javascript som "host" blev det mer intressant.
Sedan blir jag alltid förvånad av omfattningen av arbetsuppgifterna.
Det är tidskrävande även om man kan en hel del.

Ovan har jag väl svarat även på nästa punkt. Kan komplettera det med att jag även under vissa perioder arbetade med MS SQL server för ett antal år sedan. Vid något tillfället stötte jag också på PostgreSQL men det var 5-6 år sedan senast.

### Hur gick det att jobba med SQL i guiden?

Som jag nämnt ovan är det tidskrävande även om jag kan en hel del. Är man dessutom trött blir det lätt att man gör fel. Jag var även på väg att skriva inlägg på discord där jag skulle ha hävdat att jag hittat fel i lösningen men sedan när jag började beskriva varför jag tycket det var fel insåg jag att det var faktiskt jag som gjorde fel (av ren lathet utgick jag ifrån att alla "namn" var efternamn så jag missade en person). Sedan var det otydligt hur begreppet "mellan x och y" skall tolkas och som vanligt tolkade jag det annorlunda mot vad facit visade.

### Jämför SQL med andra sätt att programmera

Skall man utgå ifrån vad vi har gått igenom i kmom01 skulle man dra lite felaktiga slutsatser för sql omfattar betydligt mer än vad vi har hittills gått igenom.
Generellt känns sql både friare och knepigare att programmera mot "klassiska" programmeringsspråk.

Syntaxen är enkel men inte särskilt förlåtande. Turen är att utvecklingsmiljöerna har blivit betydligt bättre än för 20 eller 30 år sedan så man får en hel del hjälp på travet. Även MySQLWorkbench visar direkt gör syntax fel

Samtidigt saknar men variabler, procedurer ... och även om dessa tillkommer är de inte lika enkla att använda som i "riktiga" programmeringsspråk.

### TIL

Det var inte mycket nytt under kmom01 men att vi tvingades hela tiden använda massa separata sql-filer, köra dessa om och om, samt till slut lägga allt i ett shell-skript känns så här i efterhand som en nyttig sak som i längden sparar/kan spara en hel del tid. Så trots en viss frustration av att behöva skapa så många filer tycker jag nu att det var befogat.
Sedan var det en positiv överraskning att MySQLWorkbench-editor har blivit så pass användarvänligt förutom att den föreslår versaler för reserverade ord vilket faktist är irriterande (det har sedan "urminnes tid" varit standard att använda versaler).
Det är också lite förvånande att Atom är så pass dålig på att känna igen vissa reserverade ord som exempelvis flush mm.

-----------------------------------------
