# Revision history for Win32::ODBC

## 0.036 [2020-08-31]

- update pointer variables to work in 64bit as well by Christian Walde ([@wchristian](https://github.com/wchristian)) [#5](https://github.com/perl-libwin32/win32-odbc/pull/5)

## 0.035 [2013-11-28]

- Fix required perl version 5.6 -> 5.006 by Steve Hay ([@steve-m-hay](https://github.com/steve-m-hay)) [#3](https://github.com/perl-libwin32/win32-odbc/pull/3)
- Add Github repo link to `META.yml` by David Steinbrunner ([@dsteinbrunner](https://github.com/dsteinbrunner)) [#1](https://github.com/perl-libwin32/win32-odbc/pull/1)
- Typo fixes by David Steinbrunner ([@dsteinbrunner](https://github.com/dsteinbrunner)) [#2](https://github.com/perl-libwin32/win32-odbc/pull/2)

## 0.034 [2008-06-13]

- moved `sample.pl` to `eg/` subdirectory to avoid the file from
  getting installed.

## 0.033 [2008-04-15]

- new version 0.033 for separate upload to CPAN
- updated email addresses
- simplified `Makefile.PL`
- added `Changes`, `META.yml` and `ppport.h` files
- renamed `Test.pl` to `sample.pl` because it doesn't generate TAP output
- `ODBC/ODBC.xs`: use `iodbcinst.h` with CYGWIN, by Reini Urban
- `ODBC/ODBC.xs` (`_NT_ODBC_Error`): use the correct `SQLINTEGER`, ...
  types in `SQLError` and not the wrong from MSVC, by Reini Urban

Older changes can be found in the `HISTORY.TXT` file.
