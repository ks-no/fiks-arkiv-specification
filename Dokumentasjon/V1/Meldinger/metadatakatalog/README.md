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

