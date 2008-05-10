use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

warn q{
---------------------------------------------------------------------------
  NOTE: Please ignore any warnings during installation about the use of
  "=encoding utf8" in the pod documentation.

  Continuing in 3 seconds...
---------------------------------------------------------------------------
};
sleep 3;

use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME' => 'Muldis::D',
    'VERSION' => '0.28.1',
    'ABSTRACT' => 'Formal spec of Muldis D relational DBMS lang',
    'AUTHOR' => 'Darren Duncan <perl@DarrenDuncan.net>',
    'LICENSE' => 'gpl',
    'PREREQ_PM' => {
        # These are bundled with Perls 5.10.x but not Perls 5.8.x.
        'version' => 0.74,
    },
);

1; # Magic true value required at end of a reusable file's code.
