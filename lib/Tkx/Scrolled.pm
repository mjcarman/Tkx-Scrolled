#===============================================================================
# Tkx/Scrolled.pm
# Copyright 2009 Michael J. Carman. All rights reserved.
#===============================================================================
package Tkx::Scrolled;
BEGIN {require 5.006}
use strict;
use warnings;

use Tkx;
use base qw(Tkx::widget Tkx::MegaConfig);

our $VERSION = '0.01';

__PACKAGE__->_Mega('tkx_Scrolled');

__PACKAGE__->_Config(
	DEFAULT => ['.scrolled'],
);

my $initialized;
my $tile_available;


#-------------------------------------------------------------------------------
# Subroutine : _ClassInit
# Purpose    : Perform class initialization.
# Notes      : 
#-------------------------------------------------------------------------------
sub _ClassInit {
	# determine availability of themed widgets
	$tile_available = eval { Tkx::package_require('tile') };
}


#-------------------------------------------------------------------------------
# Method  : _Populate
# Purpose : Create a new Tkx::ROText widget
# Notes   : 
#-------------------------------------------------------------------------------
sub _Populate {
	my $class  = shift;
	my $widget = shift;
	my $path   = shift;
	my $type   = shift;
	my %opt    = (
		-tile => 1,
		@_,
	);

	# This doesn't get called automatically. Don't know who's to blame.
	_ClassInit() unless $initialized;

	# Create the megawidget
	my $self = ($tile_available && $opt{-tile})
		? $class->new($path)->_parent->new_ttk__frame(-name => $path)
		: $class->new($path)->_parent->new_frame(-name => $path);
	$self->_class($class);

	# Delete megawidget options so that we can safely pass the remaining
	# ones through to the scrolled subwidget.
	$self->_data->{-tile} = delete $opt{-tile};

	my $new_thing = "new_$type";
	my $w = $self->$new_thing(-name => 'scrolled',   %opt);
	my $x = $self->_scrollbar(-name => 'xscrollbar', -orient => 'horizontal');
	my $y = $self->_scrollbar(-name => 'yscrollbar', -orient => 'vertical');

	$x->configure(-command        => [$w, 'xview']);
	$y->configure(-command        => [$w, 'yview']);
	$w->configure(-xscrollcommand => [$x, 'set'  ]);
	$w->configure(-yscrollcommand => [$y, 'set'  ]);

	# Use grid to pack widget and scrollbars leaving cell 1,1 empty.
	# This keeps the ends of the scrollbars from overlapping.
	$w->g_grid(-row => 0, -column => 0, -sticky => 'nsew');
	$y->g_grid(-row => 0, -column => 1, -sticky => 'ns'  );
	$x->g_grid(-row => 1, -column => 0, -sticky => 'ew'  );

	Tkx::grid('columnconfigure', $self, 0, '-weight', 1);
	Tkx::grid('rowconfigure',    $self, 0, '-weight', 1);

	return $self;
}


#-------------------------------------------------------------------------------
# Method  : _mpath
# Purpose : Delegate all method calls to the scrolled subwidget.
# Notes   : 
#-------------------------------------------------------------------------------
sub _mpath { $_[0] . '.scrolled' }


#-------------------------------------------------------------------------------
# Method  : _scrollbar
# Purpose : Create a scrollbar widget using the tile setting.
# Notes   : 
#-------------------------------------------------------------------------------
sub _scrollbar {
	my $self = shift;

	return $self->_data->{-tile}
		? $self->new_ttk__scrollbar(@_)
		: $self->new_scrollbar(@_);
}


1;

__END__

=pod

=head1 NAME

Tkx::Scrolled - The great new Tkx::Scrolled!

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Tkx::Scrolled;

    my $foo = Tkx::Scrolled->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 FUNCTIONS

(use this section for functional modules)

=head2 function1

=head2 function2

=head1 METHODS

(use this section for object-oriented modules)

=head2 method1

=head2 method2

=head1 AUTHOR

Michael J. Carman, C<< <mjcarman at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-tkx-scrolled at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Tkx-Scrolled>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Tkx::Scrolled


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Tkx-Scrolled>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Tkx-Scrolled>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Tkx-Scrolled>

=item * Search CPAN

L<http://search.cpan.org/dist/Tkx-Scrolled>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Michael J. Carman, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut
