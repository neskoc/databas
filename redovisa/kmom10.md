flitigt
## Kursmoment 10

Jag har inte gjort tentan än så det blir inget specifikt om den.  
Har snabbkollat de senaste två tentorna och de verkade vara ganska enkla så jag tror inte det kommer bli något problem att få allt gjort och tiden borde räcka gott och väl.

### Om projektet

Projektet var nästan trivialt lätt jämfört med resterande kursmoment.
Har man gjort allt från kmom05 och kmom06 finns det nästan inget extra.
Min tid gick åt att kopiera eshop2 till eshop3, gå igenom samtliga självtest och bekräfta att det fungerar som det skall, fixa några upptäckta stavfel, lägga order och kund id i webbgränssnittet för plocklistan (det hade jag redan i cli), ordna db-backup och nu skriver jag denna text.

Om jag tänker efter kanske var det något som var extra i kmom10 som jag redan fixade i föregående kmoms för att det var mindre utökning mot en befintlig funktion så det blev inget kvar för kmom10.

#### Krav 1

Vad det gäller log-funktioner och about fixade jag det redan i kmom05 så det var inget nytt att göra. Specifikationen för hur filter och 20 senaste händelserna skall fungera ihop och jag frågade i discord men fick ingen återkoppling från Mikael. Därför valde jag att implementera Niklas tolkning om att kombinera filter och antal dvs. båda två skall vara uppfyllda samtidigt (det visas högst 20 med eller utan filter).

I webbgränssnittet valde jag att ha klickbart kategorinamn som leder till detaljerna om den valda kategorin. I backand är det implementerat som /:kategori_id länk till sig själv (get). Från början planerade jag, utan att sätta mig i kravspecifikationerna, att implementera redigera/radera funktioner som det finns för produkter (ikonerna visas i menyn) men dessa blev adrig implementerade.

I listan över produkter kan man klicka på penn-ikonen som leder till redigeringssidan. I botten finns checkboxar där man kan välja vilka kategorier produkten skall tillhöra.

#### Krav 2

I webbklienten under Beställningar (/order) ser man samtliga ordrar och klickar man på order id kommer man till detaljerna om ordern. Sedan finns ett antal funktioner som nås via små utf8 symboler:

- penna för att redigera order
- papperskorg för att radera den
- hacka (pick på engelska) för att skapa plocklistan (picklist)
- bock för att beställa en order
- dokument för att gå till fakturan

Dessa symboler visas enbart då de är aktuella:
- penna och papperskorg när den ordern är skapad
- ordern kan inte ändras efter att den har skickats så pennan då försvinner men papperskorgen blir kvar
- bocken bytes ut av hacka efter att ordern är beställd
- hackan ersätts av dokument när fakturan har skapats
- raderar man ordern försvinner samtliga symboler och det visas enbart en som tillåter att en raderad order återskapas
- ändring av status till skickad kan göras enbart från cli
- status för fakturan visas enbart om man går till dess detaljer och den kan ändras enbart från cli

Plocklistan visar samma information i webbklienten som cli. Det går inte att skicka en order (ändra dess status) om samtliga varor inte finns på lager. Dessutom har jag valt att inte tillåta att ha minus på lager (invdel kommer vägra och klaga) och beställningen kommer inte skickas heller.

#### Krav 3

Jag har valt att ha en extra kolumn (status) för "bestallning" tabellen utöver obligatoriska tidsstämplar. Så trots att jag ändrar tidsstämplar är det status-kolumnen som flytigt används där man behov av att känna till orderstatus.
Det är ett reserverat ord vilket jag inte insett i god tid så jag fick använda 'status' överallt för att undvika eventuella problem. Jag upptäckte också att jag svalt en bokstav på ett ställa i mysql men det var så pass sent att jag valde att inte rätta till det och riskera att jag inte skulle hitta samtliga ställen där den används.

Ursprungligen hade jag ett antal extra tabeller för restorder och några andra saker vilket jag rensat i kmom06. Jag trodde från början att jag skulle behöva spara totalpris i databasen (så kunde man tolka texten i specifikationen) men jag valde att bara räkna ut det och visa i webbklienten.

### Tankar om kursen

Jag har redan skrivit en hel del i kmom06 samt tidigare kmoms ovan så jag skall ta upp bara några saker.

Kursen var rätt så tidskrävande för en person tycker jag. Samtidigt tvingade det oss att genom "brute force" dvs. upprepande av saker få någorlunda bestående kunskaper. Så gillar det även om jag ibland kände att det var för mycket.

Det är förvånansvärt hur många nya saker vi har lyckats tas oss igenom. Det tycker jag absolut var lyckat. Jag var lite orolig från början att det skulle bli väldigt ytlig men jag blev positivt överraskad.  
Jag tyckte också om en extra vecka för kmom03(?) var inte för att jag behövde den så mycket men man kunde koncentrera sig på olika saker vid olika tillfällen.
Nu när jag nästan klar med databaskursen kan jag lägga det bakom mig och koppa över till oopython och koncentrera mig 100% på den.

Både föreläsningarna och genomgångarna var roliga och nyttiga.

Vad skulle kunna förbättrats?  
Jag skulle ha uppskattat om specifikationerna var lite tydligare utan tolkningsmöjligheter. Trots allt är det en distanskurs och det blir lite störande att behöva vänta på ett förtydligande i synnerhet om det är en sen fredag kväll. Även om man själv kan göra rimliga antaganden blir man ändå lite orolig om den egna tolkningen kommer accepteras.
En annan sak som jag tycker borde förbättrats är rättningstempot och det gäller även oopython.

Avslutningsvis är jag väldigt nöjd med hur kursen föll ut och vad vi fick lära oss. Betyget den får är en stark nia.
