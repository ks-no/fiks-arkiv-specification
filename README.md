# Kontrakter og meldingstyper for Fiks Arkiv

> Fiks Arkiv er en modernisering av GI Arkiv 1.1 og det nye grensesnittet som anbefales brukt når kommunen skal sette opp kommunikasjonen mellom et fagsystem og en arkivløsning.

## Protokollen

### Fiks Arkiv versjon 1 (V1)
#### Meldingstyper
Se filen [`meldingstyper.json`](Schema/V1/meldingstyper/meldingstyper.json) for hvilke meldingstyper som finnes og hvordan de henger sammen eller den genererte [UML-modellen](https://github.com/ks-no/fiks-arkiv-specification/blob/main/Schema/V1/meldingstyper/meldingstyper.svg) som viser hvordan meldingstypene henger sammen.

#### Skjema

Skjemafilene ligger under `Schema/V1`  

##### Avhengighet mellom skjemaer
![Avhengigheter mellom schemas](Dokumentasjon/V1/SchemaModels/xsd-schemas-overview.png)

## Dokumentasjon


* ### [wiki](https://github.com/ks-no/fiks-arkiv-specification/wiki)

* ### [developers.fiks.ks.no](https://developers.fiks.ks.no/fiks-plattform/tjenester/fiksprotokoll/arkiv/)

* ### [diagrammer](Dokumentasjon/V1)

For mer utfyllende dokumentasjon om protokollen kan man lese mer i [wiki](https://github.com/ks-no/fiks-arkiv-specification/wiki), på [ks.no](https://www.ks.no/fagomrader/digitalisering/felleslosninger/verktoykasse-plan--og-byggesak/verktoy/sammenhengende-tjenester---integrasjoner/fiks-arkiv/) og på [developers.fiks.ks.no](https://developers.fiks.ks.no/fiks-plattform/tjenester/fiksprotokoll/arkiv/) i tillegg til det som er her.

I mappen [Dokumentasjon](Dokumentasjon) i dette repet ligger modeller og **diagrammer** for hver versjon av protokollen. Modeller er stort sett utarbeidet vha PlantUML.
Kildekoden i PlantUML for modellene ligger da der også hvis man ønsker å bruke de som utgangspunkt i videre arbeid eller ønsker å forbedre de.



### Generering av diagrammer
Vi bruker [PlantUML](https://plantuml.com/) for å tegne diagrammer som så blir eksportert til png og svg filer. For eksempel bruker vi PlantUML til å generere oversikten over sammenhengen mellom meldingstyper ut i fra `meldingstyper.json` filen.
Vi genererer også PlantUML kode fra xsd filene for å vise datamodellen vha PHP biblioteket **[xsdata](https://pypi.org/project/xsdata-plantuml/)**

For å generere nye modeller i prosjektet kan man kjøre `generate-uml.sh` scriptet.




