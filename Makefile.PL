use strict;
use warnings;

use Config qw(%Config);
use ExtUtils::MakeMaker;

unless ($^O eq "MSWin32" || $^O eq "cygwin") {
    die "OS unsupported\n";
}

my %param = (
    NAME          => 'Win32::ODBC',
    VERSION_FROM  => 'ODBC.pm',
    OBJECT        => 'CMom$(OBJ_EXT) Constant$(OBJ_EXT) CResults$(OBJ_EXT) ODBC$(OBJ_EXT)',
    XS            => { 'ODBC.xs' => 'ODBC.cpp' },
);
$param{INC} = '-GX'                     if $Config{'cc'} =~ /^cl/i;
$param{INC} = '-I$Config{incpath}\\mfc' if $Config{'cc'} =~ /^bcc32/i;
# All sources are C++, and g++ warns about the C-only -std=c99 that some
# perls put in ccflags.
$param{CCFLAGS} = join ' ', grep { $_ ne '-std=c99' } split ' ', $Config{ccflags};
$param{NO_META} = 1 if eval "$ExtUtils::MakeMaker::VERSION" >= 6.10_03;
WriteMakefile(%param);

package MY;
use Config qw(%Config);

sub const_loadlibs {
    my ($self) = @_;
    if ($^O eq "MSWin32" && $Config{cc} =~ /^gcc/i) {
	$self->{LDLOADLIBS} .= " -lodbccp32";

    }
    # odbccp32.lib is not a plain import library. Its functions load
    # odbccp32.dll at run time, and the code that loads it calls
    # _vsnwprintf_s. With a UCRT perl, ucrt.lib doesn't export that
    # function, so it has to come from legacy_stdio_definitions.lib.
    # That library in turn needs legacy_stdio_wide_specifiers.lib and
    # adds it as a default library. But perl links extensions with
    # -nodefaultlib, which ignores default libraries, so the link fails
    # unless both are listed here.
    if ($Config{cc} =~ /^cl/i && $Config{libc} =~ /^ucrt/i) {
	$self->{LDLOADLIBS} .= " legacy_stdio_definitions.lib legacy_stdio_wide_specifiers.lib";
    }
    return $self->SUPER::const_loadlibs;
}

sub xs_c {
    '
.xs.cpp:
	$(PERL) -I$(PERL_ARCHLIB) -I$(PERL_LIB) $(XSUBPP) $(XSPROTOARG) $(XSUBPPARGS) $*.xs >xstmp.c && $(MV) xstmp.c $*.cpp
';
};
