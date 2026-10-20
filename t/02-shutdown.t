use strict;
use warnings;
use Test::More tests => 1;
use Win32::ODBC;

# ODBCShutDown() frees this thread's connections, so it must be the last ODBC
# call in the process.

my @shutdown = (1, Win32::ODBC::ODBCShutDown('extra'));
is_deeply(\@shutdown, [1], 'ODBCShutDown returns nothing');
