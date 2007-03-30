use 5.008001;
use utf8;
use strict;
use warnings FATAL => 'all';

use QDRDBMS::Validator;

QDRDBMS::Validator::main({
    'engine_name' => 'QDRDBMS::Engine::Example' });

1; # Magic true value required at end of a reuseable file's code.
