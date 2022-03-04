# Produserer nuget som inneholder XSD skjema og genererte modeller

## Skript for å genere modeller

`GenerateModels.sh` kopierer XSD skjema og generere C# modeller i prosjektet `KS.Fiks.Arkiv.Models` som blir pakket til nuget.

## Bruk av `KS.Fiks.Arkiv.Models`

### Genererte modeller

Etter at nuget er inkludert i prosjekt er modellen tilgjengelig:

```csharp
using KS.Fiks.IO.Arkiv.Models.Arkivstruktur;

var arkiv = new Arkiv();
```

### XSD skjema

Skjema er inkludert in nuget-pakken og kan refereres med refleksjon:

```csharp
using System.Reflection;

var referencesAssemblies = Assembly
    .GetExecutingAssembly()
    .GetReferencedAssemblies();

var modelsAssemblyName = referencesAssemblies
    .Single(x
        => "KS.Fiks.Arkiv.Models".Equals(x.Name));

using var arkivStream = Assembly.Load(modelsAssemblyName)
    .GetManifestResourceStream("KS.Fiks.Arkiv.Models.Schema.arkivmelding.xsd");

using var reader = new StreamReader(arkivStream);

var arkivXsd = reader.ReadToEnd();

Console.WriteLine(arkivXsd);
```