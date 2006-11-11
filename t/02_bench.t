BEGIN { $| = 1; print "1..60\n"; }
use Lingua::Ident;

$classifier = new Lingua::Ident("data/data.de",
				"data/data.en",
                                "data/data.fr",
				"data/data.it",
                                "data/data.ko",
                                "data/data.zh",);

@samples = (['de.iso-8859-1', q{In den drei Pflanzenkübeln entdeckt die Polizei je vier Abschußrohre,}],
            ['de.iso-8859-1', q{sieht, fordert Gysi eine lebenslange Haftstrafe - und zusätzlich}],
            ['de.iso-8859-1', q{Eine nun in der Konrad-Adenauer-Stiftung gelagerte Aktensammlung von}],
            ['de.iso-8859-1', q{Hause zu lassen, nicht mehr frei? ,,Durcheinander. Alkohol. }],
            ['de.iso-8859-1', q{rechnen, auf Bewährung frei zu kommen.}],
            ['de.iso-8859-1', q{kaltblütig getötet, um nicht verraten zu werden. ,,Das Kind war für}],
            ['de.iso-8859-1', q{Beamte zur Verfügung stellen, teilte Hamburgs Innensenator Ronald}],
            ['de.iso-8859-1', q{,,Notlage". Die Vereinbarung beinhalte aber auch, dass in einigen}],
            ['de.iso-8859-1', q{Kohls Kanzleramtsminister Friedrich Bohl sei ,,offenkundig inzwischen}],
            ['de.iso-8859-1', q{Akteneinsicht und Befragung von Mitarbeitern beruhenden ,,Persönlichen}],
            ['de.iso-8859-1', q{Mark. Die Differenz ist nach Feststellungen der Staatsanwaltschaft als}],

            ['en.iso-8859-1', q{some members of his organization have blasted him for}],
            ['en.iso-8859-1', q{Powell said Palestinian President Yasser Arafat must do his part to}],
            ['en.iso-8859-1', q{infringement of freedoms may be necessary to combat terrorism}],
            ['en.iso-8859-1', q{introduced, Norquist said. ``The government's power is a very, very}],
            ['en.iso-8859-1', q{`Whatever it takes, let's just do it' '' . . . That's how tyranny is}],
            ['en.iso-8859-1', q{Sen. Gordon Smith, R-Ore., sounded a similar theme: ``The Constitution}],
            ['en.iso-8859-1', q{Force. They fear the crackdown could subject innocent people to a host}],
            ['en.iso-8859-1', q{courts to weigh in.}],
            ['en.iso-8859-1', q{almost 900 people have been killed, the majority of them Palestinians.}],
            ['en.iso-8859-1', q{Many on both sides figured the association between left and right}],
            ['en.iso-8859-1', q{because it is essentially legislating action by presidential edict.''}],
            ['en.iso-8859-1', q{share information via e-mail message groups or phone trees.}],

            ['fr.iso-8859-1', q{licenciement négociée par leurs représentants syndicaux à Paris? C'est}],
            ['fr.iso-8859-1', q{social, et des assemblées générales seront organisées sur les sites de}],
            ['fr.iso-8859-1', q{représentants des employeurs. Réponse de l'AGS: «Nous consacrerons}],
            ['fr.iso-8859-1', q{gendarmerie de Pau, qui affirme vouloir encore confirmer ce point en}],
            ['fr.iso-8859-1', q{question de sous.»}],
            ['fr.iso-8859-1', q{Joaquin Masanet, le secrétaire général de l'Unsa-police. Cible de toutes}],
            ['fr.iso-8859-1', q{Les salariés normands de Moulinex accepteront-ils la prime de}],
            ['fr.iso-8859-1', q{fruit de leurs efforts ruiné par des décisions de justice qui développent}],
            ['fr.iso-8859-1', q{on nous dit de payer, nous payerons, explique l'AGS, ce n'est pas une}],
            ['fr.iso-8859-1', q{grièvement blessé par balles samedi par un conducteur qui a refusé de}],
            ['fr.iso-8859-1', q{jours, l'Etat et l'Association de garantie des salaires (AGS),}],
            ['fr.iso-8859-1', q{des pères de famille qui tombent sous les balles, comme dans l'affaire}],
            ['fr.iso-8859-1', q{l'Intérieur, Daniel Vaillant, pour tenter d'apaiser la grogne des}],
            ['fr.iso-8859-1', q{disponibles dans les prisons? Les policiers sont-ils condamnés à voir le}],

            ['it.iso-8859-1', q{al 39% del bilancio. Con la nuova dotazione organica e con le}],
            ['it.iso-8859-1', q{Traffico, Scapagnini commissario straordinario tra 10 giorni }],
            ['it.iso-8859-1', q{per prendere definitivamente in pugno il problema della}],
            ['it.iso-8859-1', q{sicurezza». Capuana anticipa di avere concordato l'iniziativa con}],
            ['it.iso-8859-1', q{come limite massimo sui 5418 dipendenti, dirigenti compresi. La}],
            ['it.iso-8859-1', q{La delibera, proposta dal vicesindaco Raffaele Lombardo in qualità}],
            ['it.iso-8859-1', q{disponibilità finanziaria prevista dal POR 2000-2006, i nuovi posti}],
            ['it.iso-8859-1', q{Montagno Bozzone dopo l'agguato è fuggito senza denunciare}],
            ['it.iso-8859-1', q{misto al consiglio comunale, Daniele Capuana, che sollecita}],
            ['it.iso-8859-1', q{ricevuto una risposta positiva dall'assessore ai Vigili urbani,}],
            ['it.iso-8859-1', q{comune di Catania comporta una spesa di 220 miliardi all'anno, pari}],
            ['it.iso-8859-1', q{della Sicilia che prevede la realizzazione di 6900 nuovi posti barca}],
            ['it.iso-8859-1', q{Palermo; Porto turistico di Catania, 15 milioni di euro, 1.100 posti}],

            ['ko.eucKR', q{´«µ¢ÀÌÃ³·³ ºÒ¾î³ª°í ÀÖ´Ù¡±¸ç ¡°ºó ¶óµ§Àº ¡®¼öÀÏ ¾È¿¡¡¯ »ýÆ÷µÇ°Å³ª}],
            ['ko.eucKR', q{ºÒ½Å°ú ºÐ³ë´Â ¾ÕÀ¸·Î ÀÌµé ±â°üÀÌ °ú¿¬ Á¤»óÀûÀ¸·Î ±â´ÉÇÒ ¼ö ÀÖÀ»}],
            ['ko.eucKR', q{±³À°ºÎ´Â ÃÖ±Ù Àü±³Á¶·ÎºÎÅÍ ¼Ò¼Ó ±³»çµéÀÌ ±Ù¹«½Ã°£ ³»¿¡ ³ëÁ¶È°µ¿À» ÇÏ´Â}],
            ['ko.eucKR', q{´ë¸¸ Á¤ºÎ´Â ÀÌ¿¡ µû¶ó 4ºÐ±â °æÁ¦¼ºÀå·ü ¿¹»óÄ¡¸¦ Á¾Àü 2.38%¿¡¼­}],
            ['ko.eucKR', q{ÇöÀå¿¡ ±ä±Þ Ãâµ¿½ÃÄ×À¸¸ç, ºÏÇÑ °æºñÁ¤Àº ¿ì¸® ÇÔÁ¤µéÀÌ Á¢±ÙÇÏÀÚ º°´Ù¸¥}],
            ['ko.eucKR', q{¹Ý¸é °¡Àå ¸¹Àº Çàº¹À» ÁØ »ç¶÷Àº ¡ãÀÚ³à(16.4%) ¡ã°¡Á·(13.5%)}],
            ['ko.eucKR', q{ÇØ±ºÀº °æºñÁ¤ÀÇ NLLÄ§¹üÀ» È®ÀÎÇÑ ÈÄ 1800t±Þ È£À§ÇÔ 1Ã´°ú °í¼ÓÁ¤ 2Ã´À»}],
            ['ko.eucKR', q{Âü¼®Àº Çã¿ëÇÏµÇ, ÇÐ±³³» Á¶ÇÕ¿ø È¸ÀÇ³ª ±³À°¿¡ ´ëÇØ¼­´Â ±³´Ü È¥¶õ µîÀ»}],
            ['ko.eucKR', q{¼ºÀå ÀÌÈÄ ´ë¸¸°ú ¸¶Âù°¡Áö·Î 2ºÐ±â ¿¬¼Ó ¸¶ÀÌ³Ê½º ¼ºÀåÀ» ±â·Ï ÁßÀÌ´Ù.}],
            ['ko.eucKR', q{ÀÌ ÀâÁö ÆíÁýÀåÀº ¸Þ½ÃÁö¿¡¼­ ¡°³í¹® Ç¥ÀýÀº ´Ù¸¥ »ç¶÷ÀÇ ¾ÆÀÌµð¾î¸¦}],
           );

my $index = 0;

print "           actual lang.    identified as\n", '-' x 40, "\n";

foreach $sample (@samples)
{
   $index++;
   my ($l, $p) = $classifier->identify($sample->[1]);

   if ($l eq $sample->[0])
   {
      print "ok $index\n";
   }
   else
   {
      print "not ok $index\n";
   }
}
