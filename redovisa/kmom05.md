
## Kursmoment 05

Arbetet med lösningen av detta kursmoment började med att gå igenom kmom10, kmom06 och till slut kmom05 och så ett antal iterationer tills jag fått en bild av vad som kommer behöva göras framöver för att skippa göra om eller dubbelarbeta.  

Under denna process dök det upp en hel del frågetecken som jag försökte får svar på i discord.  
Niklas kunde hjälpa mig med tolkningar av en hel del men ändå blev några frågetecken kvar i avvaktan på att Mikael skall förtydliga specifikationerna.

Jag har också valt att lägga upp struktur för samtliga kursmoment även om alla delar inte är lösta. Med andra ord menyerna är kompletta men det saknas funktionalitet för en hel del som tillkommer i kmom06/10.  
Dessutom har jag valt att skjuta upp arbetet med att ändra kategorier för en produkt (extrauppgift) till nästa redovisning för samma uppgift upprepas i kmom10.

Arbetet med detta kursmoment upplevde jag som rätt så tidskrävande för en person på gränsen till att vara för mycket. Nu när jag tänker efter arbetade jag först med procedurerna för det mesta för kmom05, sedan triggers, därefter cli, sedan detaljerad genomgång av samtliga kmom och till slut webbgränssnittet och en del iterationer av det jag nämnt ovan.

Det mesta var utan större problem både vad det gäller procedurer och triggers. Det var någon procedur som jag fastnade lite med men jag minns nu inte vilken.
När jag blev klar med sql gick det mycket fortare med javascript fast det blev ändå rätt så tidskrävande.  
Jag upplevde arbetet på det sättet som något som passar mig för jag kunde för det mesta fokusera mig på olika saker i stället för att behöva hålla koll på allt på en och samma gång.

### Lagrade procedurer i SQL

Ett sätt att separera sql-kod (backend) från presentationslogiken. Procedurerna i SQL liknar mest funktioner i vanliga programmeringsspråk men en gång i tiden gjorde man också skillnad mellan funktioner och procedurer i "klassiska" programmeringsspråk om jag minns rätt är det så i fortran och i synnerhet cobol.
Så man matar in parametrar till en procedur som sedan (oftast) gör olika bearbetningar av databasen och skickar tillbaka resultat. Dessa execueras på db-servern och är den en annan maskin än webbserver avlastas då webbservern.

### Triggers i sql

Ett sett att automatisera vissa processer som startas av att en händelse inträffar. I sql-sammanhang gör man exempelvis trigger som startar andra processer i samband med ändringar i en tabell. Man kan också trigga uppdatering av tabeller som har beroende värden till exempel främmande nycklar som då gör att ändringen propageras genom databasen.

### Något om CRUD

Det var väl inget speciellt förutom att det är tidskrävande att implementera. Inte den roligaste delen av programmeringen kan man påstå.

### Avslutande ord och TIL

Eshopen börjar ta formen och jag räknar med att göra klart alla kvarstående uppgifter inom 3-4 dagar och sedan hoppar jag på oopython.
Generellt känns det att vi gör ett omfattande projekt och sedan kommer vi behöva göra tentan också.

Och TIL: Framöver om det blir aktuellt med yrkesmässig programmering med databaser kommer jag definitivt använda mig mer av lagrade procedurer.

-----------------------------------------
