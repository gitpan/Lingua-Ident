# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..2\n"; }
END {print "not ok 1\n" unless $loaded;}
use Lingua::Ident;
$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

$ident = new Lingua::Ident('data/data.de', 'data/data.en', 'data/data.it',
			 'data/data.fr', 'data/data.ko');

$lang = $ident->identify("Ein Beamter geht zu den drei M�nnern.");
if($lang eq "de_DE.iso88591")
{
   print "ok 2\n";
}
else
{
   print "not ok 2\n";
}
