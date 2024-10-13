# ![](KSDigital25.png) Kontrakter og dokumentasjon for Fiks Arkiv - V1

> Fiks Arkiv er en modernisering av GI Arkiv 1.1 og det nye grensesnittet som anbefales brukt når kommunen skal sette opp kommunikasjonen mellom et fagsystem og en arkivløsning.

I dette github repositoriet finner man json schemas og dokumentasjon for Fiks Arkiv protokollen.

### Andre steder å finne informasjon om Fiks Arkiv:

- ### [KS.no - Fiks Arkiv](https://www.ks.no/fagomrader/digitalisering/felleslosninger/verktoykasse-plan--og-byggesak/verktoy/sammenhengende-tjenester---integrasjoner/fiks-arkiv/)
- ### [KS Digital - developer dokumentasjon](https://developers.fiks.ks.no/tjenester/fiksprotokoll/arkiv/)


## [Wiki for Fiks Arkiv spesifikasjonen](https://github.com/ks-no/fiks-arkiv-specification/wiki)
Gå til [wiki](https://github.com/ks-no/fiks-arkiv-specification/wiki) for å lese mer om protokollen.

## Schemas, meldingstyper, eksempler og pakker

### Schemas

Skjemaene er i xsd-format og ligger under `Schema/V1`.
Det er et skjema for hver meldingstype som har en payload og som har samme navn som meldingstype, samt delte skjema med fellest datatyper.


### Meldingstyper

Se filen [`meldingstyper.json`](Schema/V1/meldingstyper/meldingstyper.json) for hvilke meldingstyper som er i denne protokollen og hvordan de henger sammen. Man kan også se på den genererte [UML-modellen](https://github.com/ks-no/fiks-arkiv-specification/blob/main/Schema/V1/meldingstyper/meldingstyper.svg) som viser hvordan meldingstypene henger sammen.
Hver meldingstype som har en payload har et tilhørende xsd-skjema med samme navn.

### Kodelister

Under mappen kodelister ligger eksempler på kodelister i json-format samt diagram som gir oversikt over innhold.

### Pakker og github prosjekt

Eksempler, schemas samt genererte models basert på schemas er tilgjengelig for .NET og java.
Dette skal forenkle det å hente schemas og bygge meldinger i protokollen.

#### Github prosjektene:
Disse github prosjektene pakker sammen schemas, genererte modeller og hjelpeklasser for .NET og Java.
- [.NET](https://github.com/ks-no/fiks-arkiv-models-dotnet)
- [Java](https://github.com/ks-no/fiks-arkiv-models-dotnet)

#### Pakker:
Nuget og Maven pakker som er resultat av github prosjektene.
- [Nuget (.NET)](https://www.nuget.org/packages/KS.Fiks.Arkiv.Models.V1)
- [Maven (Java)]()


## Diagrammer og dokumentasjon i dette github repository

For hver versjon av protokollen vil det følge en egen dokumentasjon som baserer seg på Markdown og PlantUML.
Modeller ligger i dette repositoriet mens dokumentasjonen ligger i [wiki](https://github.com/ks-no/fiks-arkiv-specification/wiki).

Når man gjør endringer i PlantUML koden kan man kjøre `generate-png-from-puml.sh` scriptet for å generere png filer ut av PlantUML koden. Dette forutsetter at man har installert PlantUML og graphviz.

##### Avhengighet mellom skjemaer

![Avhengigheter mellom schemas](Dokumentasjon/V1/SchemaModels/xsd-schemas-overview.png)

### [Diagrammer for brukstilfeller, meldinger og tilhørende skjema](Dokumentasjon/V1/README.md)

I mappen [Dokumentasjon](Dokumentasjon/V1/README.md) i dette repoet finner man **diagrammer** for denne versjonen av protokollen. Disse diagrammene brukes gjerne i Wiki og dokumentasjonen der. Diagrammene er stort sett utarbeidet vha PlantUML.
Kildekoden i PlantUML for diagrammene ligger da der også hvis man ønsker å bruke de som utgangspunkt i videre arbeid eller ønsker å forbedre de.


#### Generering av diagrammer
Vi bruker [PlantUML](https://plantuml.com/) for å tegne diagrammer som så blir eksportert til png og svg filer. For eksempel bruker vi PlantUML til å generere oversikten over sammenhengen mellom meldingstyper ut i fra `meldingstyper.json` filen.
Vi genererer også PlantUML kode fra xsd filene for å vise datamodellen vha PHP biblioteket **[xsdata](https://pypi.org/project/xsdata-plantuml/)**

For å generere nye modeller i prosjektet kan man kjøre `generate-uml.sh` scriptet.




