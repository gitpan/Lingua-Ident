use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Lingua::Ident',
    'VERSION_FROM' => 'Ident.pm',             # finds $VERSION
    'EXE_FILES'    => ['trainlid'],
    'depend'       => {'test :' => 'DATA'},
    'clean'        => {FILES    => 'data/data.*'},
    'dist'         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
);

sub MY::postamble {
   '
    DATA: data/sample.de data/sample.en data/sample.fr data/sample.it data/sample.ko
	perl trainlid de_DE.iso88591 < data/sample.de > data/data.de
	perl trainlid en_US.iso88591 < data/sample.en > data/data.en
	perl trainlid fr_FR.iso88591 < data/sample.fr > data/data.fr
	perl trainlid it_IT.iso88591 < data/sample.it > data/data.it
	perl trainlid ko_KR.eucKR    < data/sample.ko > data/data.ko
    ';
}
