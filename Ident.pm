# $Id: Ident.pm,v 1.2 2000/02/27 12:50:52 mxp Exp $
# Copyright © 2000 Michael Piotrowski.  All Rights Reserved.

=head1 NAME

Lingua::Ident -- Statistical language identification

=head1 SYNOPSIS

 use Lingua::Ident;
 $i    = new Lingua::Ident("filename 1" ... "filename n");
 $lang = $i->identify("text to classify"), "\n";

=head1 DESCRIPTION

This module implements a statistical language identifier.

The filename attributes to the constructor must refer to files
containing tables of n-gram probabilites for languages. These tables
can be generated using the trainlid(1) utility program.

=head1 RETURN VALUE

The identify() method returns the value specified in the B<_LANG>
field of the probabilities table of the language to which the text
most likely belongs (see L<"WARNINGS">).

It is recommended to be a POSIX locale name constructed from an ISO
639 2-letter language code, possibly extended by an ISO 3166 2-letter
country code and a character set identifier. Example:
B<de_DE.iso88591>.

=cut

###############################################################################

package Lingua::Ident;

$VERSION = "1.0";

use Carp;
use locale;
use strict;

sub new
{
    my $class = shift;
    my @files = @_;
    my $self  = {};

    my ($filename, $matrix, @matrices, @languages) ;

    foreach $filename (@files)
    {
	open MATRIX, "<$filename" or croak "$!";

	$matrix = {};
	
	while(<MATRIX>)
	{
	    chomp;
	    (my $key, my $val) = split(/: /);
	    
	    $matrix->{$key} = $val;
	}
	push @matrices,  $matrix;
	push @languages, $matrix->{'_LANG'};

	close MATRIX;
    }
    
    $self->{MATRICES}  = \@matrices;
    $self->{LANGUAGES} = \@languages;
    
    return bless $self, $class;
}

sub identify
{
    my $self = shift;
    my $text = shift;

    my @matrices = @{$self->{MATRICES}};
    my @prob = (0) x @matrices;
    my ($c, $i, @chars, $trigram);

    foreach $c (split //, $text)
    {
	push @chars, $c;
	if(@chars == 3)
	{
	    $trigram = lc(join("", @chars));
	    $trigram =~ s/[\d\W]/ /og;

	    for($i = 0; $i <= $#matrices; $i++)
	    {
		if(exists $matrices[$i]->{$trigram})
		{
		    $prob[$i] += log $matrices[$i]->{$trigram};
		}
		else
		{
		    $prob[$i] += log $matrices[$i]->{'_NULL'};
		}
	    }
	    shift @chars;
	}
    }

    return $self->{'LANGUAGES'}->[find_max(@prob)];
}

sub find_max
{
    my @list = @_;
    my $i;
    my $max = 0;

    for($i = 0; $i <= $#list; $i++)
    {
	if($list[$i] > $list[$max])
	{
	    $max = $i;
	}
    }
    return $max;
}

=head1 WARNINGS

Since Lingua::Ident is based on statistics it cannot be 100 %
accurate. More precisely, Dunning (see below) reports his
implementation to achieve 92 % accuracy with 50K of training text for
20 character strings discriminating bewteen English and Spanish. This
implementation should be as accurate as Dunning's. However, not only
the size but also the quality of the training text play a role.

The current implementation doesn't use a threshold to determine if the 
most probable language has a high enough probability; if you're trying 
to classify a text in a language for which there is no probability
table, this results in getting an incorrect language.

=head1 AUTHOR

Lingua::Ident was developed by Michael Piotrowski <mxp@dynalabs.de>.

=head1 SEE ALSO

Dunning, Ted (1994). I<Statistical Identification of Language.>
Technical report CRL MCCS-94-273. Computing Research Lab, New Mexico
State University.

=cut

1;
