# Metadatakatalog

**Meldingstype**

Er ikke en egen meldingstype. Importert og brukt i de fleste skjema for meldingstypene i denne protokollen.

**Skjema**

[metadatakatalog.xsd](https://github.com/ks-no/fiks-arkiv-specification/blob/main/Schema/V1/metadatakatalog.xsd)

**Definisjon**

Inneholder datatyper brukt i de fleste meldingstypene og xsd-skjema for protokollen. 
Kopiert fra Noark-5 Metadatakatalog og utvidet med flere datatyper. 

## Innhold

Dokumentasjonen her inneholder både tekst og innhold hentet fra Noark-5 dokumentasjonen samt ny tekst og dokumentasjon for nye felter

## metadatakatalog

### Felter

---
### `ID` - M001-a
#### Definisjon
Base for ID'er som skal være på formatet for UID. 

#### Arkivenhet
Brukes som base flere steder hvor det er en ID og som skal følge UID formatet. F.eks. `systemID` og `feilId`

#### Kilde


#### Arv
Nei

#### Betingelser
Skal ikke kunne endres

#### Kommentarer
Dette er en base for ID'er som skal være på formatet for UID.

---
### `systemID` - M001
#### Definisjon
Globalt unik identifikasjon av arkivenheten (UID).

#### Arkivenhet
_arkiv, arkivdel, klassifikasjonssystem, klasse, mappe, registrering, dokumentbeskrivelse, dokumentobjekt_

#### Kilde
Registreres automatisk av systemet

#### Arv
Nei

#### Betingelser
Skal ikke kunne endres

#### Kommentarer
Alle referanser fra en arkivenhet til en annen skal peke til arkivenhetens systemidentifikasjon. Dette gjelder også referanser fra en arkivdel til en annen, f.eks. mellom to arkivperioder som avleveres på forskjellig tidspunkt.

---
### `klasseID` - M002
#### Definisjon
Entydig identifikasjon av klassen innenfor klassifikasjonssystemet.

#### Arkivenhet
_klasse_

#### Kilde
Alle klasser i et klassifikasjonssystem opprettes vanligvis når et arkivsystem tas i bruk. Men enkelte løsninger kan tillate at det opprettes nye klasser ved behov (mest aktuelt ved objektbasert klassifikasjon).

#### Arv
I hierarkiske klassifikasjonssystemer (f.eks. statens arkivnøkkel) skal en underordnet klasse arve og aggregere (slå sammen) identifikasjonen fra alle overordnede klasser, se kommentar nedenfor.

#### Betingelser
Skal ikke kunne endres

#### Kommentarer
Ulike klassifikasjonssystemer innenfor samme arkivsystem kan inneholde en eller flere av de samme identifikasjonene. Identifikasjonen kan være rent nummerisk, men kan også være alfanumerisk og ha et logisk meningsinnhold. Merk at klasseID er identisk med begrepene ordningsverdi og arkivkode i Noark 4.

---
### `mappeID` - M003
#### Definisjon
Entydig identifikasjon av klassen innenfor klassifikasjonssystemet.

#### Arkivenhet
_klasse_

#### Kilde
Alle klasser i et klassifikasjonssystem opprettes vanligvis når et arkivsystem tas i bruk. Men enkelte løsninger kan tillate at det opprettes nye klasser ved behov (mest aktuelt ved objektbasert klassifikasjon).

#### Arv
I hierarkiske klassifikasjonssystemer (f.eks. statens arkivnøkkel) skal en underordnet klasse arve og aggregere (slå sammen) identifikasjonen fra alle overordnede klasser, se kommentar nedenfor.

#### Betingelser
Skal ikke kunne endres

#### Kommentarer
Ulike klassifikasjonssystemer innenfor samme arkivsystem kan inneholde en eller flere av de samme identifikasjonene. Identifikasjonen kan være rent nummerisk, men kan også være alfanumerisk og ha et logisk meningsinnhold. Merk at klasseID er identisk med begrepene ordningsverdi og arkivkode i Noark 4.

---
### `arkivdelstatus` - M051
#### Definisjon
Status til den arkivperioden som arkivdelen omfatter

#### Arkivenhet
_arkivdel_

#### Kilde
Registreres manuelt når arkivet opprettes eller ved skifte av status.

#### Arv
[_kode_](#kode---fiks-arkiv-001)

#### Betingelser
Obligatoriske verdier:
- "Aktiv periode"
- "Overlappingsperiode"
- "Avsluttet periode"
- "Uaktuelle mapper"
Skifte av status kan bare utføres av autoriserte personer.

Kodeliste eksempel:

| kode | beskrivelse         |
|------|---------------------|
| A    | Aktiv periode       |
| O    | Overlappingsperiode |
| P    | Avsluttet periode   |
| U    | Uaktuelle mapper    |

#### Kommentarer
Arkivdeler som avleveres skal ha status "Avsluttet periode".
Se gjerne kodelister fra GI-standarden [her](./../../kodelister/gi-kodelister.png).
Noe avvik vil det være fra GI-standarden til Fiks-Arkiv standarden

---
### `saksstatus` - M052
#### Definisjon
Status til saksmappen, dvs. hvor langt saksbehandlingen har kommet.

#### Arkivenhet
_saksmappe_

#### Kilde
Registreres automatisk gjennom forskjellig saksbehandlings- funksjonalitet, eller overstyres manuelt.

#### Arv
[_kode_](#kode---fiks-arkiv-001)

#### Betingelser
Obligatoriske verdier:
- "Under behandling"
- "Avsluttet"
- "Utgår"
  Skifte av status kan bare utføres av autoriserte personer.

Kodeliste eksempel:

| kode | beskrivelse                |
|------|----------------------------|
| B    | Under behandling           |
| A    | Avsluttet                  |
| U    | Utgår                      |
| R    | Opprettet av saksbehandler |
| S    | Avsluttet av saksbehandler |
| P    | Unntatt prosesstyring      |
| F    | Ferdig fra saksbehandler   |

#### Kommentarer
Saksmapper som avleveres skal ha status "Avsluttet" eller "Utgår".
Se gjerne kodelister fra GI-standarden [her](./../../kodelister/gi-kodelister.png).
Noe avvik vil det være fra GI-standarden til Fiks-Arkiv standarden


---
### `dokumenttype` - M083
#### Definisjon
Navn på type dokument

#### Arkivenhet
_dokumentbeskrivelse_

#### Kilde
Registreres automatisk av systemet eller manuelt

#### Arv
[_kode_](#kode---fiks-arkiv-001)

#### Betingelser
Ingen obligatoriske typer. Aktuelle kode/beskrivelser kan f.eks. være:

| kode         | beskrivelse        |
|--------------|--------------------|
| SØKNAD       | Søknad             |
| MELDING      | Melding            |
| KORR         | Korrespondanse     |
| KART         | Kart               |
| FOTO         | Foto               |
| TEGNING      | Tegning            |
| ANSVKONTO    | Ansvar og kontroll |
| TILSYN       | Tilsyn             |
| AVTALE       | Avtale             |
| VEDTAK       | Vedtak             |
| FERDIGATTEST | Ferdigattest       |


#### Kommentarer
Se gjerne kodelister fra GI-standarden [her](./../../kodelister/gi-kodelister.png).
Noe avvik vil det være fra GI-standarden til Fiks-Arkiv standarden

---
### `kode` - FIKS-ARKIV-001
#### Definisjon
Kode er basen for felter som f.eks. dokumenttype som er av typen kode. Disse har da verdier fra kodelister.
Kode består av **kode** og **beskrivelse**.
Elementet **kode** er en kort identifkator mens **beskrivelse** kan være en lengre tekst som beskriver koden. F.eks. kode="R" og beskrivelse="Opprettet av saksbehandler"

#### Arkivenhet

#### Kilde

#### Arv

#### Betingelser

#### Kommentarer
Elementet **kode** er den som er påkrevd og er typisk en forkortelse for hva den representerer. 
