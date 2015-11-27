package Personal;

use Data::Printer;
use strict;
use warnings;
#use Term::ReadLine;
use v5.18;
#say Term::ReadLine->ReadLine();
#die 'check readline';

sub _build_List {
    my @list = @{shift @_};
    my @picked = @{shift @_};
    my @rtn;
    push @rtn, join(' : ',$picked[$_],1+$_,$list[$_]) for keys @list;
    return wantarray ? @rtn : \@rtn;
}

sub Menu_pick {
    # input options :
    #	clear screen (y)/n
    #	max -1/(1)/n/n+
    #	index (y)/n
    #
    # input menu :
    # input array < \@ or @

# defaults #AAA
    my %opts = (clear => 'yes', ndx => 'yes', max => 1);
    %opts = (%opts, %{shift @_}) if ref $_[0] eq 'HASH';
    my @menu = ref $_[0] eq 'ARRAY' ? @{shift @_} : @_;
    my $max = $opts{max} == -1 ? @menu : $opts{max};
#ZZZ

    my $picked = 'x';
    my $open = ' ';
    my $select = $picked^$open;
    my @choices = ($open) x @menu;

    my $choice_cnt = grep {/$picked/} @choices;
    my $picks;
    while ($choice_cnt <= $max) {
	system('clear') if $opts{clear} eq 'yes';
	my @_menu = _build_List(\@menu, \@choices);
	say for @_menu;
	print "pick lines: ";
	chomp ($picks = <STDIN>);
	last if $picks =~ /^(?i)(q(uit)?)\z/;
	$picks = join(' ', keys @menu) if $picks =~ /^(?i)all\z/;
	my @picks = split /\D/, $picks;
	map {$choices[$_-1]^=$select} @picks;
	say '';
    } continue {
	$choice_cnt = grep {/$picked/} @choices;
    }
    $max =  grep {/$picked/} @choices if $picks =~ /^(?i)(q(uit)?)\z/;
    my @rtn = (grep {$choices[$_] =~ /$picked/} keys @choices)[0..$max-1];
    return wantarray ? @rtn : \@rtn;
}

1;
