# Modeller og diagrammer for Fiks Arkiv V1

Her er diagrammer for skjema og brukstilfeller / usecases.

## Brukstilfeller
Her beskrives diverse spesifikke usecase og hvordan de kan løses innenfor protokollen.
Disse diagrammene brukes og vises også i Wiki. Gå der for mer utfyllende dokumentasjon

* ### [Søknadssystem med søknadsfrist](UseCases/Soeknadssystem-med-soeknadsfrist)
* ### [Elevmappe](UseCases/Elevmappe)
* ### [Flere klientsystemer med delt data i arkiv](UseCases/Flere-klientsystemer-med-felles-data)

## Meldingstyper og skjema
Diagrammene brukes og vises også i Wiki. Gå der for mer utfyllende dokumentasjon.
Merk at diagrammene ikke viser detaljer for objekter som kommer fra andre skjema som `metadatakatalog.xsd` og `arkivstruktur.xsd`.
Da må man sjekke disse diagrammene. 

### Arkivering:

#### Opprett Arkivmelding
Skjema: `no.ks.fiks.arkiv.v1.arkivering.arkivmelding.opprett.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/arkivering/arkivmelding/opprett.md)

#### Opprett Arkivmelding - kvittering
Skjema: `no.ks.fiks.arkiv.v1.arkivering.arkivmelding.opprett.kvittering.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/arkivering/arkivmelding/opprett/kvittering.md)

#### Oppdater Arkivmelding
Skjema: `no.ks.fiks.arkiv.v1.arkivering.arkivmelding.oppdater.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/arkivering/arkivmelding/oppdater.md)

#### Opprett Avskrivning
Skjema: `no.ks.fiks.arkiv.v1.arkivering.avskrivning.opprett.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/arkivering/avskrivning/opprett.md)

#### Slett Avskrivning
Skjema: `no.ks.fiks.arkiv.v1.arkivering.avskrivning.slett.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/arkivering/avskrivning/slett.md)

#### Opprett Dokumentobjekt
Skjema: `no.ks.fiks.arkiv.v1.arkivering.dokumentobjekt.opprett.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/arkivering/dokumentobjekt/opprett.md)

#### Opprett Dokumentobjekt - kvittering
Skjema: `no.ks.fiks.arkiv.v1.arkivering.dokumentobjekt.opprett.kvittering.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/arkivering/dokumentobjekt/opprett/kvittering.md)

### Innsyn:
#### Hent Mappe
Skjema: `no.ks.fiks.arkiv.v1.innsyn.mappe.hent.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/innsyn/mappe/hent.md)

#### Hent Mappe - resultat
Skjema: `no.ks.fiks.arkiv.v1.innsyn.mappe.hent.resultat.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/innsyn/mappe/hent/resultat.md)

#### Hent Registrering
Skjema: `no.ks.fiks.arkiv.v1.innsyn.registrering.hent.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/innsyn/registrering/hent.md)

#### Hent Registrering - resultat
Skjema: `no.ks.fiks.arkiv.v1.innsyn.registrering.hent.resultat.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/innsyn/registrering/hent/resultat.md)

#### Hent Dokumentfil
Skjema: `no.ks.fiks.arkiv.v1.innsyn.dokumentfil.hent.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/innsyn/dokumentfil/hent.md)

#### Sok
Skjema: `no.ks.fiks.arkiv.v1.innsyn.sok.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/innsyn/sok.md)

#### Sok - resultat
Skjema: `no.ks.fiks.arkiv.v1.innsyn.sok.resultat.xsd`

[Gå til diagram og forklaring.](SchemaModels/no/ks/fiks/arkiv/v1/innsyn/sok/resultat/resultat.md)

### Felles skjema:

#### Arkivstruktur
Skjema: `no.ks.fiks.arkiv.v1.arkivstruktur.xsd`

[Gå til diagram og forklaring.](SchemaModels/arkivstruktur.md)

#### Arkivstruktur - minimum
Skjema: `no.ks.fiks.arkiv.v1.arkivstruktur.minimum.xsd`

[Gå til diagram og forklaring.](SchemaModels/arkivstrukturMinimum.md)

#### Metadatakatalog
Skjema: `no.ks.fiks.arkiv.v1.metadatakatalog.xsd`

[Gå til diagram og forklaring.](SchemaModels/metadatakatalog.md)
