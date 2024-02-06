echo "Generating PlantUML files from xsd with xsdata python library"
xsdata Schema/V1/no.ks.fiks.arkiv.v1.arkivering.arkivmelding.oppdater.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.arkivering.arkivmelding.opprett.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.arkivering.arkivmelding.opprett.kvittering.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.arkivering.avskrivning.opprett.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.arkivering.avskrivning.slett.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.arkivering.dokumentobjekt.opprett.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.arkivering.dokumentobjekt.opprett.kvittering.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.feilmelding.ikkefunnet.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.feilmelding.serverfeil.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.feilmelding.ugyldigforespoersel.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.dokumentfil.hent.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.mappe.hent.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.mappe.hent.resultat.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.registrering.hent.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.registrering.hent.resultat.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.sok.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.sok.resultat.minimum.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.sok.resultat.noekler.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 
xsdata Schema/V1/no.ks.fiks.arkiv.v1.innsyn.sok.resultat.utvidet.xsd --output plantuml --package Dokumentasjon/V1/SchemaModels 

echo "Using python3 to prettify generated plantuml file(s)"
python3 ./prettify-plantuml.py

echo "Generating png files from puml and pu files"
plantuml "Dokumentasjon/**/*.puml"
plantuml "Dokumentasjon/**/*.pu"

echo "Generating svg files from puml and pu files"
plantuml "Dokumentasjon/**/*.puml" -tsvg
plantuml "Dokumentasjon/**/*.pu" -tsvg
plantuml "Schema/**/*.puml" -tsvg

