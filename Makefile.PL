use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Lingua::Ident',
# $Format: "    'VERSION' => '$ProjectVersion$',"$
    'VERSION' => '1.5',
    'EXE_FILES'    => ['trainlid'],
    'clean'        => {FILES    => 'data/data.*'},
    'dist'         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
);

package MY;

sub postamble {
   '
DATA: data/sample.de data/sample.en data/sample.fr data/sample.it data/sample.ko data/sample.zh
	$(PERL) trainlid de.iso88591 < data/sample.de > data/data.de
	$(PERL) trainlid en.iso88591 < data/sample.en > data/data.en
	$(PERL) trainlid fr.iso88591 < data/sample.fr > data/data.fr
	$(PERL) trainlid it.iso88591 < data/sample.it > data/data.it
	$(PERL) trainlid ko.eucKR    < data/sample.ko > data/data.ko
	$(PERL) trainlid zh.big5     < data/sample.zh > data/data.zh
';
}

sub test {
    my $self = shift;

    my $make = $self->SUPER::test(@_);

    # add dependencies for test targets
    $make =~ s/(test ::)(.*)/$1 DATA $2/g;

    return $make;
}

