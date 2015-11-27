#!/usr/bin/env perl

# vim: ai si sw=4 sts=4 et fdc=4 fmr=AAA,ZZZ fdm=marker

use warnings;
use strict;
use v5.18;
use Path::Tiny;

BEGIN {
    unshift @INC, path("~/helpers/lib")->stringify unless grep {/helpers/} @INC;
}
use Personal;

my @choice = Personal::Menu_pick({max=>-1},@ARGV);
say for @ARGV[@choice];
