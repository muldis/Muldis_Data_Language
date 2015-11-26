use 5;
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
   NAME => 'Muldis::D',
   VERSION => '0.201000_1',  # corresponding to 0.201.0.-9
   ABSTRACT => 'Formal spec of Muldis D relational DBMS lang',
   AUTHOR => 'Darren Duncan <darren@DarrenDuncan.net>',
   PREREQ_PM => {},
   ($ExtUtils::MakeMaker::VERSION ge '6.31' ? (
      LICENSE => 'gpl_3',
   ) : ()),
   ($ExtUtils::MakeMaker::VERSION ge '6.46' ? (
      META_ADD => {
         resources => {
            homepage => 'http://www.muldis.com/',
            license => 'http://www.fsf.org/licensing/licenses/gpl.html',
            MailingList => 'http://mm.darrenduncan.net/mailman/listinfo',
            repository => 'http://github.com/muldis/Muldis-D',
         },
      },
   ) : ()),
);

1;
