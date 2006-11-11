use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Lingua::Ident',
# $Format: "    'VERSION' => '$ProjectVersion$',"$
    'VERSION' => '1.6',
    'EXE_FILES'    => ['trainlid'],
    'clean'        => {FILES    => 'data/data.*'},
    'dist'         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
);

package MY;

sub postamble
{
   '
DATA: data/sample.de data/sample.en data/sample.fr data/sample.it data/sample.ko data/sample.zh
	$(PERL) trainlid de.iso-8859-1 < data/sample.de > data/data.de 2> /dev/null
	$(PERL) trainlid en.iso-8859-1 < data/sample.en > data/data.en 2> /dev/null
	$(PERL) trainlid fr.iso-8859-1 < data/sample.fr > data/data.fr 2> /dev/null
	$(PERL) trainlid it.iso-8859-1 < data/sample.it > data/data.it 2> /dev/null
	$(PERL) trainlid ko.eucKR      < data/sample.ko > data/data.ko 2> /dev/null
	$(PERL) trainlid zh.big5       < data/sample.zh > data/data.zh 2> /dev/null
';
}

sub test
{
   my $self = shift;
   my $make = $self->SUPER::test(@_);

   # add dependencies for test targets
   $make =~ s/(test ::)(.*)/$1 DATA $2/g;

   return $make;
}

