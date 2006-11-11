BEGIN { $| = 1; print "1..1\n"; }
use Lingua::Ident;

$ident = new Lingua::Ident('data/data.de', 'data/data.en', 'data/data.it',
			   'data/data.fr', 'data/data.ko', 'data/data.zh');

$lang = $ident->identify("Ein Beamter geht zu den drei Männern.");
if($lang eq "de.iso-8859-1")
{
   print "ok 1\n";
}
else
{
   print "not ok 1\n";
}
