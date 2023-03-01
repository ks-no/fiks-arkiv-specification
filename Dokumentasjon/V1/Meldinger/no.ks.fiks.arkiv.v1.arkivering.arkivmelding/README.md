# Arkivmelding

**Meldingstype**

`no.ks.fiks.arkiv.v1.arkivering.arkivmelding`

**Skjema**

[no.ks.fiks.arkiv.v1.arkivering.arkivmelding.xsd](https://github.com/ks-no/fiks-arkiv-specification/blob/main/Schema/V1/no.ks.fiks.arkiv.v1.arkivering.arkivmelding.xsd)

**Definisjon**

Brukes for arkivering når man skal opprette mappe, saksmappe, journalpost, dokument osv i et arkiv.
Oppdatering eller endring på et arkivert objekt gjøres ved egen meldingstype.

## Innhold

Dokumentasjonen her er gruppert på objekter (complexType) i arkivmeldingen som f.eks. arkivmelding, mappe, saksmappe, journalpost, osv.

## arkivmelding 
Her er feltene for objektet arkivmelding. 

**Arv:** Nei

### `system`
#### Definisjon
Identifiserer avsender system. Vil kunne styre hvilke standardverdier som skal kunne kjøres sammen med feltet `regel`.

### `regel`
#### Definisjon
Hvis det er lagt til en verdi i feltet regel vil det bestemme hvilket regelsett som skal benyttes for å sette standardverdier. Feltet `system` bestemmer hvilke regelset som er tilgjengelig i arkivsystemet.
Regel er referanse til regelsettet med standardverdier ref gammelt skjemamottak.

### `tidspunkt`
#### Definisjon
Tidspunkt for opprettelsen av arkivmeldingen hos avsender system.

### `antallFiler`
#### Definisjon
Totalt antall filer som følger med i arkivmeldingen.
Dette feltet skal vise totalt antall vedlagte filer, ikke inklusiv arkivmelding.xml. Sender man bare en arkivmelding.xml uten hoveddoument eller vedlegg skal `antallFiler` være 0. 

### `mappe`
#### Definisjon
Liste med `mappe` objekter. Kan inneholde 0 til mange. Se mer om `mappe` lenger nede.

### `registrering`
#### Definisjon
Liste med `registrering` objekter. Kan inneholde 0 til mange. Se mer om `registrering` lenger nede.


## mappe
Her er feltene for objektet mappe. 

**Arv:** Nei

*felter kommer*

## saksmappe
Her er feltene for objektet saksmappe. Se også forelder typen `mappe` for arvet felter.

**Arv:** `mappe`

*felter kommer*

## registrering
Her er feltene for objektet registrering. 

**Arv:** Nei

*felter kommer*

## journalpost
Her er feltene for objektet journalpost. Se også forelder typen `registrering` for arvet felter.

**Arv:** `registrering`

*felter kommer*




