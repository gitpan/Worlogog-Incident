use strict;
use warnings;
use ExtUtils::MakeMaker;

sub merge_key_into {
    my ($href, $target, $source) = @_;
    %{$href->{$target}} = (%{$href->{$target}}, %{delete $href->{$source}});
}

my %opt = (
    NAME                => 'Worlogog::Incident',
    AUTHOR              => q{Lukas Mai <l.mai@web.de>},
    VERSION_FROM        => 'lib/Worlogog/Incident.pm',
    ABSTRACT_FROM       => 'lib/Worlogog/Incident.pm',

    LICENSE => 'perl',
    PL_FILES => {},

    MIN_PERL_VERSION => '5.6.0',
    CONFIGURE_REQUIRES => {
        'strict'              => 0,
        'warnings'            => 0,
        'ExtUtils::MakeMaker' => '6.56',
    },
    TEST_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'strict'              => 0,
        'warnings'            => 0,
        'parent'              => 0,
        'Carp'                => 0,
        'Dispatch::Class'     => 0,
        'Exporter::Tiny'      => 0,
        'Return::MultiLevel'  => 0,
        'Scope::OnExit::Wrap' => 0,
        'Worlogog::Restart'   => 0,
    },

    depend => {
        Makefile => '$(VERSION_FROM)',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Worlogog-Incident-*' },

    META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                url => 'git://github.com/mauke/Worlogog-Incident.git',
                web => 'https://github.com/mauke/Worlogog-Incident',
                type => 'git',
            },
        },
    },
);

(my $mm_version = ExtUtils::MakeMaker->VERSION) =~ tr/_//d;

if ($mm_version < 6.67_04) {
    # Why? For the glory of satan, of course!
    no warnings qw(redefine);
    *ExtUtils::MM_Any::_add_requirements_to_meta_v1_4 = \&ExtUtils::MM_Any::_add_requirements_to_meta_v2;
}

if ($mm_version < 6.63_03) {
    merge_key_into \%opt, 'BUILD_REQUIRES', 'TEST_REQUIRES';
}

if ($mm_version < 6.55_01) {
    merge_key_into \%opt, 'CONFIGURE_REQUIRES', 'BUILD_REQUIRES';
}

if ($mm_version < 6.51_03) {
    merge_key_into \%opt, 'PREREQ_PM', 'CONFIGURE_REQUIRES';
}

WriteMakefile %opt;
