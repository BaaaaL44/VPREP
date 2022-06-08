# VPREP
A VPREP (1.4) (Vásárhelyi Pál Report) rendszer bemutatása

A VPREP (Vásárhelyi Pál Report) rendszer egy egységes, platformfüggetlen (tehát minden, böngészőt futtatni képes számítógépen azonosan megjelenő), statisztikai összegzések létrehozására készült script. Minden intézményben problémát jelent év végén az érettségi eredmények összesítésénél, hogy a pedagógusok informatikai/statisztikai szakértelme, ráfordítható ideje illetve igényei között hatalmas különbségek vannak, így az eltérő munkaközösségekből, eltérő tanárok keze alól kikerülő eredményösszesítő táblázatok hullámzó minőségűek, sok esetben az eltérő számítási módok, eltérő adatfeldolgozás és vizualizáció miatt az adatok összevethetetlenek mind iskolán belüli, mint évek közti vonatkozásban, ami rendkívüli mértékben megnehezíti, hogy az érettségi vizsgák eredményei alapján esetleg levonható tanulságokból gyakorlati módszertani újítások szülessenek. 
Ez közvetlenül, hátrányosan befolyásolja az intézmény belső minőségbiztosítását, és a tanulók teljesítményének értékelését, illetve nyomon követését, mivel heterogén, eltérő minőségű adatok alapján nem nyerhető teljes kép a tanulói teljesítmény minden aspektusáról. 
A VPREP erre a problémára kínál megoldást az által, hogy bármely tantárgy (közismereti, vagy szakmai) érettségi eredményeiből egy Excel-táblázat alapján képes minden részletre kiterjedő, tudományos igényű statisztikai összegzést generálni, mely számos leíró statisztikai adaton (gyakorisági eloszlások, illetve középértékek) kívül az adott tárgy értékelési sémájához illeszkedő, interaktív grafikonokat (3-dimenziós pontdiagram, dobozdiagramok, sűrűségfüggvények, stb.) és szükség esetén az osztályok/részfeladatok/tanárok eredményeinek összehasonlítására statisztikai hipotézisvizsgálatokat (független mintás, illetve páros t-próba, varianciaanalízis post-hoc vizsgálatokkal, korrelációvizsgálat) is automatikusan belefoglal a dokumentumba. A rendszer az előzetes adatfeldolgozást (százalékértékek kiszámolása, megfelelő formátumba rendezés) szintén elvégzi a háttérben.
Ennek segítségével az egymást követő évek eredményei közvetlenül, minimális erőbefektetéssel összehasonlíthatóvá válnak, gyerekjátékká téve az intézményen belüli kimeneti minőségbiztosítási, mérési-értékelési feladatokat.
Technikai háttér, implementáció

A VPREP rendszer alapja az R programnyelv. Ez egy elsősorban statisztikai számításokhoz, modellépítéshez, adatanalitikai feladatokhoz létrehozott, Turing-teljes, hibrid imperatív/funkcionális programnyelv, melyhez számos, magas szintű feladat ellátását lehetővé tévő „csomag” érhető el online ingyenesen. 
Az implementáció gerincét az R-Markdown leírónyelv adja, mely lehetővé teszi egy megadott bemeneti adathalmazon egy előre megírt programkód (script) futtatását oly módon, hogy a program a futás során létrejött objektumokat (táblázatok, grafikonok, számadatok) a megadott paraméterek szerint egy HTML fájlba exportálja, szükség esetén oldalszámozással, tartalomjegyzékkel együtt. A HTML formátum rendkívül előnyös, mivel a Word (.docx) és PDF formátumokkal ellentétben képes interaktív grafikákat, illetve adatvizualizációs eszközöket (dashboardok, webalkalmazások) is megjeleníteni, látványosabbá és informatívabbá téve a reportot, mint ha szöveges dokumentumba illesztenénk be a képeket.
A programkód futására a végfelhasználónak nincs ráhatása, és nem is szükséges ismernie annak működését. A végső report létrehozásához csupán egy, a függelékben megadott formátum szerint elkészített Excel-fájl szükséges, amely tartalmazza a tanulók nevét, nemét, a javító tanár monogramját, illetve az írásbeli vizsgán elért rész- és összpontszámát. 
A rendszer használata lépésről lépésre

Amennyiben saját számítógépünkön szeretnénk használni a rendszert, az alábbi lépéseket szükséges végrehajtani:
(1) Olvassuk tüzetesen végig ezt a dokumentációt
Mielőtt bárminek nekikezdünk, olvassuk el alaposan ezt a dokumentációt, és győződjünk meg róla, hogy az Excel-fájlunk a megadott formátumban van, az oszlopnevek pedig megfelelőek. 
(2) Töltsük le a megadott linkről a VPREP nevű fájlt, és helyezzük abba a mappába, ahol az Excel-fájlokat tároljuk
(3) Telepítsük az R-Studio szoftvert
Telepítsük fel az R-Studio szoftvert az alábbi linkről:
https://www.rstudio.com/products/rstudio/download/#download
Az R-Studio egy IDE (Integrált Fejlesztői Környezet) az R programnyelvhez, melynek funkciója a programozók munkájának megkönnyítése, illetve előre mentett scriptek, programkódok futtatásának lehetővé tétele. Nekünk semmit nem kell tudnunk a program működéséről, kizárólag azért van szükség a telepítésére, hogy a VPREP futásához szükséges környezet rendelkezésre álljon a számítógépünkön. 

(4) Telepítsük a VPREP futásához szükséges csomagokat

Jelöljük ki, és másoljuk az alábbi kódsort a bal oldali, console feliratú dobozba, és nyomjuk meg az ENTER billentyűt:
install.packages(c(„readxl”, „ggplot”, „car”, „huxtable”, „dplyr”, „knitr”, „ape”, „kableExtra”, „plotly”,”broom”, „rstatix”, „corrplot”, „matrixcalc”, „shiny”, „tidyverse”, fmsb”, „ggradar”, „ggiraphExtra”, „psych”) )
Ez szükséges ahhoz, hogy a reportot létrehozó programkód hozzáférjen a számára szükséges funkciókhoz, függvényekhez. Ezt csupán az első használatkor szükséges elvégezni, a későbbiekben már nem, mert az R-Studio elmenti a telepített csomagokat. 
(5) Töltsük be a VPREP fájlt: 
Kattintsunk az R-Studio felső sávjában a Session, Select Working Directory, majd a Choose Directory menüpontokra, és válasszuk ki azt a mappát, ahol a report alapjául szolgáló Excel-file, és a VPREP.rmd fájl található.
Kattintsunk az R-Studio bal felső sarkában a File, majd az open file menüpontra, és válasszuk ki a VPREP.rmd fájlt a számítógépen. Ha minden jól ment, az alábbit kell látnunk a bal oldalon:
 
(6) Adjuk meg a paramétereket
A bal oldalon az author címke után, idézőjelek közé írjuk be a nevünket, majd legalul a subj címke után a tárgy nevét nagy betűvel kezdve, amihez reportot akarunk generálni (Angol, Német, Magyar, Matematika, Kereskedelem, Logisztika, Turisztika, Történelem opciók közül választva). Ezt nem szükséges idézőjelek közé tenni.
(7) Futtassuk a programot
Ha mindennel megvagyunk, kattintsunk a képernyő tetején, a nagyító ikon melletti knit (összefűzés) gombra. Ezzel elindítjuk a program futását. A futás befejeztével a mappában, amit a (2)-es lépésben kijelöltünk, meg fog jelenni egy VPREP.html nevű fájl, ez tartalmazza a reportot. Bármilyen böngészővel megnyitható, Chrome vagy Firefox javasolt hozzá. Amennyiben a fájl megnyitása után az interaktív grafikonok nem látszanak, nem működnek, vagy más probléma merül fel, próbáljuk meg frissíteni a böngészőnket, vagy másik böngészőt használni a megnyitáshoz (Internet Explorer vagy Safari helyett Chrome, Firefox, vagy Opera)



A program futásának követelményei

Bár a program bizonyos adathibáknak és anomáliáknak ellenáll, nagyon fontos, hogy a forrásul szolgáló Excel-fájl az alábbi kritériumoknak megfelelően legyen formázva, ezeken kívül más adatokat (kézzel számolt oszlopátlagok, sorátlagok, diagramok, stb.) NEM tartalmazhat.
•	A fájl neve legyen ’tárgy.xlsx’, ahol a ’tárgy’ a fentebb felsorolt tárgyak valamelyike lehet, kisbetűvel.
•	A fájl egy sor - egy diák formátumban legyen kódolva, ahol minden oszlop egy változót jelöl. A következő oszlopokra lesz szükség, ezek megléte nélkül a program nem fog működni:
•	Név, Nem (L illetve F), Osztály (XX.Y formátumban, pl. 12.A, 11.C), javító tanár monogramja nagybetűvel (TB, CSM, BE, TJ) ezen kívül pedig az adott tárgyra specifikus részegységek eredményei, a következőképp elnevezve:
Angol/Német: Olvasott, Nyelv, Hallott, Írás, Szóbeli, Írásbeli (ez az első 4 összege), Össz (ami a teljes összpontszám, a szóbelivel együtt)
Történelem / Logisztika: Teszt, Hosszú, Írásbeli, Szóbeli, Össz (itt minden egyértelmű)
Magyar: Szövegértés, Érvelés_Gyak, Műértelmezés, Szóbeli, Írásbeli, Össz 
Kereskedelem: Pénztár, Szöveges, Számítás, Szóbeli, Írásbeli, Össz
Turisztika: Turizmusföldrajz, Kultúrtörténet, Vendégfogadás, Protokoll, Turizmus_rendszere, Marketing, Szóbeli, Írásbeli, Össz
Matematika: Rövid, Hosszú_A, Hosszú_B, Szóbeli, Írásbeli, Össz
•	Ügyeljünk az oszlopok nevének helyes tagolására (kis és nagybetűk, alsóvonalak)
•	Ne számoljunk százalékot előre, mindenhol használjuk a nyers vizsgapontokat, kivéve az Írásbeli (ami az írásbeli komponensek összege) és az Össz (ami az összes komponens összege) változóknál.

Teljes funkciólista:

A VPREP mindig az aktuális tárgy és a bemeneti adathalmaz sajátosságait, komponenseinek számát, azok jellegét veszi alapul a report elkészítésekor, így az alábbiak közül nem mindegyik fog minden tárgy esetén megjelenni. (Például ha csak egy javító tanár szerepel a fájlban, a tanárok összehasonlítása nem fog belekerülni a reportba)

•	Gyakorisági oszlopdiagramok osztály, javító tanár és nem szerinti bontásban
•	Gyakorisági táblázatok osztály, javító tanár és nem szerinti bontásban
•	Gyakorisági táblázatok Státusz (érvénytelen, kettesért szóbelizik, átment írásbelivel) szerint
•	Gyakorisági táblázatok Jegy szerint
•	Grafikonok Státusz és Jegy szerint
•	Leíró statisztikai táblázat a komponensek középértékeivel és szóródási mutatóival (átlag és szórás mellett a program medián abszolút eltérést, sztenderd hibát és kvartiliseket is számol, hogy a szélsőértékek ne legyenek hatással a leíró statisztikai adatokra)
•	Táblázat osztályonként a legjobb három eredményt produkáló tanuló nevével, osztályával és eredményével
•	Grafikon osztályonként a három legjobb eredményt produkáló tanuló nevével, ahol az osztályokon belül a legjobb 3 diák közti relatív különbségek is megjelennek vizuálisan
•	A vizsga komponensei közötti ismételt méréses varianciaanalízis post-hoc vizsgálatokkal (Welch t-próba Holm korrektúrával) annak megállapítására, van-e az egyes részegységek eredményei között véletlenszinttől eltérő különbség. Ez minőségbiztosítási szempontból különösen fontos.
•	Dobozdiagram a részegységek mediánjával, valamint interkvartilis féltartományával
•	A tárgy sajátosságaitól függően 2D, 3D vagy 4D (színezett 3D) interaktív pontdiagram a részpontszámok viszonyáról
•	2D pontdiagram lineáris trendvonallal az írásbeli és szóbeli pontszámok közti kapcsolat erősségének vizsgálatára (Könnyen megváltoztatható Loess vagy Generalizált Additív Modell alapú, nemlineáris görbére is)
•	Diákonként radardiagramok, melyek a komponenseken elért százalékokat jelenítik meg intuitív vizuális formában. Az ülésrendek ismeretében potenciálisan csalások utólagos kiszűrésére is használható.
•	Osztályonkénti dobozdiagramok az elért százalékkal
•	Osztály alapján független mintás, egyutas varianciaanalízis, vagy független mintás t-próba annak megállapítására, hogy a megfigyelt különbségek véletlenszinttől eltérőek-e (amennyiben igen, a program automatikusan végez páronkénti Welch-féle t-próbákat Holm korrektúrával)
•	Empirikus sűrűségfüggvény az elért százalékok vonatkozásában, amennyiben 11 és 12. évfolyamos tanulók is vettek részt a vizsgán, évfolyamonkénti, egymásra rétegzett sűrűségfüggvények
•	Dobozdiagram tanárok közti különbségekről
•	Tanár alapján független mintás, egyutas varianciaanalízis, vagy független mintás t-próba annak megállapítására, hogy a megfigyelt különbségek véletlenszinttől eltérőek-e (amennyiben igen, a program automatikusan végez páronkénti Welch-féle t-próbákat Holm korrektúrával)
•	Nemek szerinti dobozdiagram
•	Nemek alapján független mintás t-próba
•	A komponensek korrelációs mátrixa táblázatos formában
•	A komponensek korrelációs mátrixa grafikus formában, korrelációs ellipszissel, és a diagonális egységekben hisztogramokkal komponensenként.
•	Automatikus szövegalkotás, a statisztikai próbák eredményeiről, illetve a gyakorisági adatokról. Ez nem helyettesíti a kézzel, ember által írt szöveget, de segít élőbbé tenni a reportot.
•	A program által készített minden grafikon interaktív, zoomolható, forgatható, egyes elemek kattintással eltűntethetőek, illetve rámutatással megjelennek a leíró statisztikai adatok, valamint a tanuló neve.
•	Bizonyos táblázatok esetében az oszlopok neveire mutatva a kurzorral megjelenik egy szövegdoboz, ami magyarázatot ad az adott oszlopban található értékről. 

Diszklémer, kapcsolat

A program és a hozzá tartozó dokumentáció olyan, amilyen, a szerző semmiféle, a program által okozott adatvesztésért, illetve kárért nem vállal felelősséget. A program Tóth Bálint szellemi tulajdona, használata, terjesztése a szerző engedélyéhez kötött, anyagi haszonszerzés céljára való felhasználása, módosítása pedig tilos. 
Bármilyen programhiba vagy nem várt működés esetén a hibajelenség pontos leírását, az érintett adatfájlt és a hibáról készült képernyőmentést kérem eljuttatni a toth.balint.pte@gmail.com vagy a toth.balint@vasarhelyi.info e-mail címek valamelyikére. Az Excel-fájlokat szintén ezen címek valamelyikére kérem elküldeni, a tárgymezőben VPREP megjelöléssel. Ugyanezen e-mail címek valamelyikére várom a javaslatokat, mi az, ami esetleg az egyes tárgyak megjelenítéséből hiányzik, vagy ami informatív lenne. 

Ismert hibák

•	A p-értékek megjelenítésekor néhány táblázatban a program a nullához konvergáló p-értékeket nullára kerekíti. Ez az értelmezést nem befolyásolja.
•	A második korrelációs táblázat mérete az egyes tárgyak között nem következetes, ez az eltérő számú vizsgakomponensek eredménye. 
•	Bizonyos esetekben a grafikonok, táblázatok egyes elemei belelóghatnak egymásba


