using XmlSchemaClassGenerator;

var fileList = new List<string>
{
    "metadatakatalog.xsd",
    "arkivmelding.xsd",
    "arkivmeldingKvittering.xsd",
    "sok.xsd",
    "sokeresultatUtvidet.xsd",
    "sokeresultatMinimum.xsd",
    "sokeresultatNoekler.xsd",
    "arkivstrukturMinimum.xsd",
    "arkivstrukturNoekler.xsd",
    "arkivstruktur.xsd",
    "dokumentfilHent.xsd",
    "journalpostHent.xsd",
    "journalpostHentResultat.xsd",
    "mappeHent.xsd",
    "mappeHentResultat.xsd"
};

const string commonNamespace = "KS.Fiks.IO.Arkiv.Models";
var baseDirectory = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory);
var dotnetFolder = baseDirectory.Parent!.Parent!.Parent!.Parent!.FullName;

var outputPath = Path.Combine(dotnetFolder, "KS.Fiks.Arkiv.Models");
var generator = new Generator
{
    OutputFolder = outputPath,
    Log = s => Console.Out.WriteLine(s),
    GenerateNullables = false,
    SeparateClasses = true,
    NamespaceProvider = new NamespaceProvider
    {
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/metadatakatalog/v2"),
            commonNamespace + ".Metadatakatalog"
        },
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/arkivmelding/v2"),
            commonNamespace + ".Arkivering.Arkivmelding"
        },
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/arkivmeldingkvittering/v2"),
            commonNamespace + ".Arkivering.Arkivmeldingkvittering"
        },
        {new NamespaceKey("http://www.ks.no/standarder/fiks/arkiv/sok/v1"), commonNamespace + ".Innsyn.Sok"},
        {new NamespaceKey("http://www.ks.no/standarder/fiks/arkiv/sokeresultat/v1"), commonNamespace + ".Innsyn.Sok"},
        {
            new NamespaceKey("http://www.ks.no/standarder/fiks/arkiv/arkivstruktur/minimum/v1"),
            commonNamespace + ".Arkivstruktur"
        },
        {
            new NamespaceKey("http://www.ks.no/standarder/fiks/arkiv/arkivstruktur/noekler/v1"),
            commonNamespace + ".Arkivstruktur"
        },
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/arkivstruktur"),
            commonNamespace + ".Arkivstruktur"
        },
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/dokumentfil/hent/v2"),
            commonNamespace + ".Innsyn.Hent"
        },
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/journalpost/hent/v2"),
            commonNamespace + ".Innsyn.Hent"
        },
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/journalpost/hent/resultat/v2"),
            commonNamespace + ".Innsyn.Hent"
        },
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/mappe/hent/v2"),
            commonNamespace + ".Innsyn.Hent"
        },
        {
            new NamespaceKey("http://www.arkivverket.no/standarder/noark5/mappe/hent/resultat/v2"),
            commonNamespace + ".Innsyn.Hent"
        }
    }
};
var schemasToGenerate = fileList.Select(file => Path.Combine("Schema", file));
generator.Generate(schemasToGenerate);