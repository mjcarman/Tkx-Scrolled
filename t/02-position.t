#!perl -T
use strict;
use warnings;
use Test::More tests => 22;
use Tkx;
use Tkx::Scrolled;

my $mw = Tkx::widget->new('.');
$mw->g_wm_withdraw();  # hide the mainwindow

my @positions = (
	[n    => 1],
	[s    => 1],
	[e    => 1],
	[w    => 1],
	[ne   => 1],
	[nw   => 1],
	[se   => 1],
	[sw   => 1],
	[nn   => 0],
	[ns   => 0],
	[ew   => 0],
	[ee   => 0],
	[en   => 1],
	[ws   => 1],
	[nne  => 0],
	[swen => 0],
	[on   => 1],
	[ow   => 1],
	[one  => 1],
	[now  => 1],
	[osoe => 1],
	[oos  => 0],
);

foreach my $p (@positions) {
	eval { $mw->new_tkx_Scrolled('text', -scrollbars => $p->[0]) };
	my $r = $@ ? 0 : 1;
	is($r, $p->[1], "'-scrollbars => '" . $p->[0] . "'");
}
