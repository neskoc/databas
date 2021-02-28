
## Kursmoment 02

### SQL

Det här kursmomentet tog betydligt mer tid än jag hade räknat med.
Precis när jag var klar med uppgifterna och funderade över hur jag skulle fixa extrauppgiften läste jag en fråga på discord där jag försökt hjälpa en student men snart insåg jag att jag missade en mening:

> Se till att din rapport ser exakt likadan ut som min. Ta det som en utmaning.  

Detta startade en diskussion vilket ledde till att jag lade ytterligare ca. 10 timmar på att jobba med det samt en hel del nya inlägg i discord.

Jag avvaktar fortfarande på svar/kommentar från lärarna på följande:

> Som jag skrev ovan tycker jag att följande är märkligt:  
I och med att nukomp = diffkomp + 1 borde:  
> ```sql
ORDER BY diffkomp DESC  
ORDER BY nukomp DESC  
ORDER BY nukomp DESC, diffkomp DESC -- och  
ORDER BY diffkomp DESC, nukomp DESC  
```  
> ge identiska resultat fast det gör de inte.  
Att uppgiften anger detta (sortering efter två variabler i samma kommando fast den ena är bara förskjutning av den andra är tårta på tårta) tycker jag känns åt skogen.  
Även om någon underliggande speciell mysql-egenskap ger den effekten borde vi inte lära oss att förlita oss på detta för det bryter mot matematisk logik och sunda programmeringsprinciper.  
Det kommer från https://dbwebb.se/guide/kom-igang-med-sql-i-mysql/joina-tabell

men tänker inte vänta med inlämningen.
Med andra ord lyckades jag först inte lösa uppgiften som jag tolkat det men sedan under tiden jag experimenterade upptäckte jag det ovan och upplevde att något inte riktigt stämde.

Jag har till och från jobbat med SQL och även för över 20 år sedan tog en kurs i databasteknik. Därför är det inget nytt men det jag beskriver ovan har fått mig att känna mig osäker med min kunskap om SQL.

### Node.js / javascript

Jag hade ytterligare en fråga om extrauppgiften och hur man skulle tolka specifikationen men i och med att jag inte fick ett snabbt svar (fredag eftermiddag/kväll) fortsatte jag med min egen tolkning.
Så jag skrev en `teacher2.js` där jag använde en någorlunda generell funktion för utskrift av resultatet.
Den funktionen förväntar sig två variabler:  

1. en av typ key/value Objekt som innehåller header (samtliga kolumnnamn samt typ av padding: start/end)  
2. en med maxbredd (dessa räknas ut via en separat select-function) för varje kolumn

Vad det gäller JavaScript på serversidan samt node.js har jag hört talats om det men aldrig jobbat med det. Det känns ovant men jag upplever det inte som så annorlunda mot javascript på klientsidan. Det jag är lite besviken över är rätt så bristfällig felsökningsfunktionalitet i alla fall så här långt.

Javascript-delen av uppgiften kändes väldigt enkel i och med att till 80-90% fått gå igenom det i övningarna. Det behövdes ytterst lite förändringar för att få till lösningarna.
Det enda som blev då lite utmanande var extrauppgiften.
Kopplingen till databasen var också enkel och konceptet skiljer sig inte särskilt mycket från hur det fungerade med php eller python.  
Jag tycker är lite irriterande att vi använder olika namnkonventioner för javascript och python.

Jag har under åren arbetat med olika realtidsOS samt läste några kurser om realtidssystem, concurrent engineering och VHDL så jag tycker inte async/await och asynkron programmering är besvärliga att förstå eller arbeta med.

### TIL

Hur mycket man än kan (tror sig kunna) något finns alltid mer att lära sig. En annan sak jag lärt mig är att majoritet av lärare tar sin fritid på allvar och hänger inte på kvällarna och helgerna och diskuterar med studenter (i motsatt till vad en av lärarna gör :) ) så vill man ha svar och hjälp får det vara vanlig arbetstid.

-----------------------------------------
