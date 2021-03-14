
## Kursmoment 06

Pust, nu är jag klar. Det var verkligen omfattande och jag höll nästan på att spy av all sql. Trots att det gör nytta känns det ganska enformigt och begränsande att hålla på med det i en så stor omfattning. Definitivt skulle jag nog inte kunna jobba som dedikerad db-utvecklare.

Under tiden med ditt arbete med kmom06 spenderade jag mest tid på plocklistan, ja uppskattningsvis 15 timmar sammanlagt. Här gjorde jag alla möjliga fel och ställde till för mig själv samtidigt som jag den hårda vägen lärde mig konsekvenserna att bara ytligt kunna vissa saker och ironiskt nog är det relaterat till "shallow copy". Vet inte hur många timmar jag höll på med att felsöka, experimentera, göra om delar av dict to array osv. men det ville inte fungera tills jag kunde hitta källan och till slut få en förklaring till vad det var. Hoppas bara att det sitter långt.

Sedan försökte jag kanske en tredje del av tiden anpassa koden till console.table för att mest på grund av det ovan beskrivna problemet bytte spår efter att jag kom på att vi fick göra en egen funktion för utskrift av tabeller. Så jag gjorde om koden en gång till, anpassade funktionen och fick äntligen utskriften jag var nöjd med men med fel funktionalitet (shallow copy fanns fortfarande och spökade). Hur som helst löste jag detta och förhoppningsvis lärde jag mig en hel del. Det har i alla fall underlättat för implementering av ship-funktionen. Nu tror jag att jag också gjort klart kmom10 men jag har inte testat så noga allt så i morgon räknar jag med att vara klar med det också.

### Index

Jag hade lite svårt att hitta någon lämplig användning av index och till slut föll valet på fulltext index av händelsekolumnen i logg-tabellen samt status-fältet (jag använder en textkolumn som heter status utöver tidsstämplar). Vi behöver söka igenom händelserna och jag använder status rätt så mycket medan det finns inte så många andra kandidater där index skulle kunna göra mer nytta.

Ja, vad är index då? Ett index är en metod att mappa sekventiellt data till en datastruktur där man kan snabbt slå upp det man söker efter (i teorin tar det lika lång/kort tid att slå upp vilket värde som hälst).  
Fördelen är att snabbar kunna få ut resultat medan nackdelen är att man måste hålla index uppdaterad (varje ändring av data kräver uppdatering av index) samt att själva index tar extra plats.

### Funktioner i db

De inbyggda funktionerna underlättar massa olika saker samt avlastar för utvecklaren så att han/hon inte behöver själv implementera det i sin kod.
Man kan även underlätta vissa saker med egendefinierade funktioner och återanvända koden.  

I fallet med eshop upplevde jag inte något större behov av egna funktioner men jag gjorde ändå en både för att testa men också för att det kändes naturligt där: jag kollar om det angivna fakturaid är giltigt.

### Avslutande ord och TIL

Jag skrev en hel del i inledningen så jag skall inte upprepa mig här.  
Igen tyckte jag att specifikationerna var otydliga och jag fick en hel del hjälp av Niklas i discord med tolkningarna. Däremot kunde han inte svara på allt och hänvisade till Mikael. Trots påminnelsen fick jag aldrig något svar från honom.

Därför har jag gjort egna (rimliga) tolkningar i vissa fall och utgår ifrån att dessa skall accepteras (gäller även kmom10) för jag har inga planer att gå tillbaka och göra om det.

Uppgifter i denna kurs kändes rätt så stora jämfört med andra kurser och det växte hela tiden för att kulminera i kmom05 och kmom06. Nu när jag har även i princip gjort klart även kmom10 tycker jag att uppgifterna där känns nästan triviala och dessutom är det upprepning av samma krav som hittas i kmom05/06.

Hur som helst nu när allt är klart är jag väldigt nöjd hur det föll ut. Kan skulle kunna putsa till här och där men jag skulle inte vilja önska göra några större ändringar i funktionaliteten. Även användargränssnittet blev hyfsat bra tycker jag.
