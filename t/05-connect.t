use strict;
use warnings;
use Test::More tests => 2;
use Win32::ODBC;

# A failed Connect must not leave its connection behind. The driver manager
# rejects this option value before it looks up the DSN.

my @connect = Win32::ODBC::ODBCConnect('NoSuchDSN590',
    Win32::ODBC::SQL_ODBC_CURSORS(), 99);
is($connect[0], 1, 'Connect with an invalid option value fails');

my @conns = (1, Win32::ODBC::ODBCGetConnections());
is_deeply(\@conns, [1, 0], 'GetConnections after a failed Connect');
