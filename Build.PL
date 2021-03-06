#!perl

#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic-Compatibility/Build.PL $
#     $Date: 2008-06-17 14:27:21 -0500 (Tue, 17 Jun 2008) $
#   $Author: clonezone $
# $Revision: 2450 $

use 5.006001;

use strict;
use warnings;

use English qw< -no_match_vars >;

use Module::Build;


my $class = Module::Build->subclass( code => <<'END_SUBCLASS' );

    sub ACTION_test {
        my ($self) = @_;

        $self->depends_on('manifest');

        return $self->SUPER::ACTION_test();
    }

    sub ACTION_authortest {
        my ($self) = @_;

        $self->depends_on('build');
        $self->depends_on('manifest');
        $self->depends_on('distmeta');

        $self->test_files( qw< t xt/author > );
        $self->recursive_test_files(1);

        $self->depends_on('test');

        return;
    } # end ACTION_authortest()

    sub ACTION_distdir {
        my ($self) = @_;

        $self->depends_on('authortest');

        return $self->SUPER::ACTION_distdir();
    } # end ACTION_distdir

END_SUBCLASS

my $builder = $class->new(
    module_name         => 'Perl::Critic::Compatibility',
    dist_author         => 'Elliot Shank <perl@galumph.com>',
    license             => 'perl',
    dynamic_config      => 0,
    create_readme       => 0,
    create_packlist     => 1,
    sign                => 0,

    requires            => {
        'Perl::Critic'  => '1.083_001',
        'version'       => 0,
    },

    build_requires      => {
        'Test::More'    => 0,
    },

    recommends          => {
    },

    create_makefile_pl  => 'traditional',

    meta_merge          => {
        resources   => {
            homepage    => 'http://perlcritic.com',
            license     => 'http://dev.perl.org/licenses/',
            Repository  => 'http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic-Compatibility/',
            MailingList => 'http://perlcritic.tigris.org/servlets/SummarizeList?listName=users',
        }
    },

    add_to_cleanup      => [
        qw<
            MANIFEST
            MANIFEST.bak
            META.yml
            Makefile
            Makefile.old
            Makefile.PL
            pod2htm?.tmp
            pm_to_blib
            Perl-Critic-Compatibility-*
        >,
    ],
);


$builder->create_build_script();

##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# setup vim: set filetype=perl tabstop=4 softtabstop=4 expandtab :
# setup vim: set shiftwidth=4 shiftround textwidth=78 nowrap autoindent :
# setup vim: set foldmethod=indent foldlevel=0 :
