use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Lingua::Ident',
# $Format: "    'VERSION' => '$ProjectVersion$',"$
    'VERSION' => '1.4',
    'EXE_FILES'    => ['trainlid'],
    'depend'       => {'test :' => 'DATA'},
    'clean'        => {FILES    => 'data/data.*'},
    'dist'         => {COMPRESS => 'gzip', SUFFIX => 'gz'},
);

sub MY::postamble {
   '
    DATA: data/sample.de data/sample.en data/sample.fr data/sample.it data/sample.ko data/sample.zh
	perl trainlid de.iso88591 < data/sample.de > data/data.de
	perl trainlid en.iso88591 < data/sample.en > data/data.en
	perl trainlid fr.iso88591 < data/sample.fr > data/data.fr
	perl trainlid it.iso88591 < data/sample.it > data/data.it
	perl trainlid ko.eucKR    < data/sample.ko > data/data.ko
	perl trainlid zh.big5     < data/sample.zh > data/data.zh
    ';
}
