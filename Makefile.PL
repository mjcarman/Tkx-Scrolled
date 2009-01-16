use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Tkx::Scrolled',
    AUTHOR              => 'Michael J. Carman <mjcarman@cpan.org>',
    VERSION_FROM        => 'lib/Tkx/Scrolled.pm',
    ABSTRACT_FROM       => 'lib/Tkx/Scrolled.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Tkx-Scrolled-*' },
);
