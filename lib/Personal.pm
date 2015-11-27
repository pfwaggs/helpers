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
    #	clear screen: (1)/0
    #	max: -1/(1)/n/n+
    #	header: undef
    #	prompt: pick lines:
    #
    # input menu :
    # input array < \@ or @

# defaults #AAA
    my %opts = (clear=>1, max=>1, header=>undef, prompt=>'pick lines: ',);
    %opts = (%opts, %{shift @_}) if ref $_[0] eq 'HASH';
    my @data = ref $_[0] eq 'ARRAY' ? @{shift @_} : @_;
    my $max = $opts{max} == -1 ? @data : $opts{max};
#ZZZ

    my $picked = '*';
    my $select = $picked^' ';
    my @choices = (' ') x @data;

    my @_menu = map {{str=>$data[$_], s=>' ', x=>1+$_}} keys @data;
    my $picks;
    while (1) {
	system('clear') if $opts{clear};
	say $opts{header} if defined $opts{header};
	say join(' : ',@{$_}{qw{s x str}}) for @_menu;
	print $opts{prompt};
	chomp ($picks = <STDIN>);
	last if $picks =~ /^(?i)q/;
	map {$_menu[$_-1]{s}^=$select} $picks =~ /^(?i)a/ ? (1..$max) : split(/\D/,$picks);
    } continue {
	last if ($max == grep {$_->{s} eq $picked} @_menu) and ($picks !~ /^(?i)a/);
    }
    my @found = map {$_->{x}-1} grep {$_->{s} eq $picked} @_menu;
    my @rtn = @found <= $max ? @found : @found[0..$max-1];
    return wantarray ? @rtn : \@rtn;
}

1;

