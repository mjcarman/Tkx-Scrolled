BEGIN {require 5.006}
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/lib";
use lib "$FindBin::Bin/../Tkx-ROText/lib";
use lib "$FindBin::Bin/../Tkx-FindBar/lib";

use Tkx;
use Tkx::FindBar;
use Tkx::ROText;
use Tkx::Scrolled;

my $mw = Tkx::widget->new('.');
$mw->g_wm_title('Scrolled Test');

#my $text    = $mw->new_tkx_Scrolled('text', -wrap => 'word');
my $text    = $mw->new_tkx_Scrolled('tkx_ROText', -wrap => 'word');
my $findbar = $mw->new_tkx_FindBar(-textwidget => $text);

$findbar->add_bindings($mw,
	'<Control-f>'  => 'show',
	'<Escape>'     => 'hide',
	'<F3>'         => 'next',
	'<Control-F3>' => 'previous',
);

$text->g_pack(-fill => 'both', -expand => 1);

$findbar->g_pack(
	-after => $text,
	-side  => 'bottom',
	-fill  => 'x',
);

$findbar->hide();

$mw->g_bind('<Control-w>', \&quit);

my $content = <<EOT;
House training has changed too. You no longer whack the puppy with a rolled up newspaper when it relieves itself in the house. Now you do something more humane, called cage training. You put the puppy in a cage so small it can barely turn around. Dogs instinctively won\'t poop where they have to stand, so it learns to hold it until it poops on your terms.

I ask myself if I would prefer to be whacked with a rolled up newspaper when I pooped on the carpet or be forced to stay in a coffin-sized cage for several hours while desperately squeezing my butt cheeks together to keep the turtle in the shell. Which is more humane? I'm thinking it doesn't make any difference because my parents used both of those methods on me, and I turned out okay. 

EOT

$text->insert('end', $content) for 1 .. 10;

$mw->g_focus();
Tkx::MainLoop();

sub quit { exit }
