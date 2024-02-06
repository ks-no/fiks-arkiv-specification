# This script adds the "left to right direction" setting to grunnlag.pu file. Changes from landscape to better readable uml
with open("./Dokumentasjon/V1/SchemaModels/no/ks/fiks/arkiv/v1/arkivering/arkivmelding/opprett.pu", "r") as f:
    contents = f.readlines()

contents.insert(1, "left to right direction")

with open("./Dokumentasjon/V1/SchemaModels/no/ks/fiks/arkiv/v1/arkivering/arkivmelding/opprett.pu", "w") as f:
    contents = "".join(contents)
    f.write(contents)