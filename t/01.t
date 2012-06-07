#!/usr/bin/perl -w

use strict;
use lib qw(.);

use Test::More;
use Data::Dumper;
use Net::Domain::ExpireDate;

use POSIX;
setlocale( &POSIX::LC_TIME, "en_US.UTF-8" );

BEGIN { plan tests => 67 };

ok(1); # If we made it this far, we're ok.

#print join ';', domain_dates("alefclub.com", '%Y-%m-%d'), "\n";
#print join ';', domain_dates("skyriver.ru", '%Y-%m-%d'), "\n";
#print join ';', domain_dates("infocentr.ru", '%Y-%m-%d'), "\n";
#exit;

print " .com .net .org tests\n";
is( expdate_fmt("\nRecord expires on 27-Apr-2011.\n"), '2011-04-27' );
is( expdate_fmt("\nDomain expires: 24 Oct 2010\n"), '2010-10-24' );
is( expdate_fmt("\nRecord expires on........: 03-Jun-2005 EST.\n"), '2005-06-03' );
is( expdate_fmt("\nExpires on..............: 24-JAN-2003\n"), '2003-01-24' );
is( expdate_fmt("\nExpiration Date: 02-Aug-2003 22:07:21\n"), '2003-08-02' );
is( expdate_fmt("\nExpiration Date:03-Mar-2004 05:00:00 UTC\n"), '2004-03-03' );
is( expdate_fmt("\nRecord expires on 2003-09-08\n"), '2003-09-08' );
is( expdate_fmt("\nRecord expires:       2003-07-29 10:45:05 UTC\n"), '2003-07-29' );
is( expdate_fmt("\nexpires:        2003-05-21 10:09:56\n"), '2003-05-21' );
is( expdate_fmt("\nRecord expires on:       2010-04-07 00:00:00.0 ET\n"), '2010-04-07' );
is( expdate_fmt("\nRecord expires on 2012-07-15 10:23:10.000\n"), '2012-07-15' );
is( expdate_fmt("\nRecord expired on 2008/8/26\n"), '2008-08-26' );
is( expdate_fmt("\nRecord expires:           2003-03-12 12:16:45\n"), '2003-03-12' );
is( expdate_fmt("\nRecord expires on 2010-04-24 16:03:20+10\n"), '2010-04-24' );
is( expdate_fmt("\nExpires on: 2003-11-05\n"), '2003-11-05' );
is( expdate_fmt("\nDomain expires: 2007-01-20.\n"), '2007-01-20' );
is( expdate_fmt("\nExpiry Date.......... 2009-06-16\n"), '2009-06-16' );
is( expdate_fmt("\nExpire on................ 2002-11-05 16:42:41.000\n"), '2002-11-05' );
is( expdate_fmt("\nValid Date     2010-11-02 05:21:35 EST\n"), '2010-11-02' );
is( expdate_fmt("\nExpiration Date     : 2002-11-19 04:18:25-05\n"), '2002-11-19' );
is( expdate_fmt("\nDate of expiration  : 2003-05-28 11:50:58\n"), '2003-05-28' );
is( expdate_fmt("\nExpires on..............: 2006-07-24\n"), '2006-07-24' );
is( expdate_fmt("\nexpires:        20030803\n"), '2003-08-03' );
is( expdate_fmt("\nExpires on: 12-DEC-05\n"), '2005-12-12' );
is( expdate_fmt("\nExpires on..............: Tue, Aug 04, 2009\n"), '2009-08-04' );
is( expdate_fmt("\nExpires on..............: Oct  5 2002 12:00AM\n"), '2002-10-05' );

is( expdate_fmt("\nRecord expires on December 05, 2004\n"), '2004-12-05' );

is( expdate_fmt("\nRecord expires on.......: Oct  28, 2011\n"), '2011-10-28' );
is( expdate_fmt("\nExpires on .............WED NOV 16 09:09:52 2011\n"), '2011-11-16' );
is( expdate_fmt("\nExpires after:   Mon Jun  9 23:59:59 2003\n"), '2003-06-09' );
is( expdate_fmt("\nRecord expires on 10-05-2003 11:21:25 AM\n"), '2003-10-05' );
is( expdate_fmt("\nExpires on 10-09-2011\n"), '2011-10-09' );
is( expdate_fmt("\nRecord Expires on 08-24-2011\n"), '2011-08-24' );
is( expdate_fmt("\nExpiration: 6/3/2004\n"), '2004-06-03' );
is( expdate_fmt("\nExpires on 11/26/2007 23:00:00\n"), '2007-11-26' );
is( expdate_fmt("\nRecord expires on 2010-Apr-03\n"), '2010-04-03' );
is( expdate_fmt("\nRecord expires on 2012-Apr-5.\n"), '2012-04-05' );
is( expdate_fmt("\nExpires on..............: 2006-Jun-12\n"), '2006-06-12' );
is( expdate_fmt("\nExpiration date: 09/21/03 13:45:09\n"), '2003-09-21' );
# whois.bulkregister.com can give expiration date in different formats
is( expdate_fmt("\nRecord expires on 2003-04-25\n"), '2003-04-25' );
is( expdate_fmt("\nRecord will be expiring on date: 2003-04-25\n"), '2003-04-25' );
is( expdate_fmt("\nRecord expiring on -  2003-04-25\n"), '2003-04-25' );
is( expdate_fmt("\nRecord will expire on -  2003-04-25\n"), '2003-04-25' );
is( expdate_fmt("\nRecord will be expiring on date: 2003-04-25\n"), '2003-04-25' );

is( expdate_fmt("\nExpires : January 27 2019.\n"), '2019-01-27' );
is( expdate_fmt("\nDomain Expiration Date:29-Apr-2013 17:53:03 UTC\n"), '2013-04-29' );

print ".ru tests\n";
is( expdate_fmt("\nstate:   Delegated till 2003.10.01\nstate:   RIPN NCC check completed OK\n", 'ru'), '2003-10-01' );
is( expdate_fmt("\ncreated:  2001.09.19\nreg-till: 2003.09.20\n", 'ru'), '2003-09-20' );
is( expdate_fmt("\nstate:    REGISTERED, NOT DELEGATED\nfree-date:2002.10.03\n", 'ru'), '2002-08-31' );

print "creation date tests\n";

is( credate_fmt("\nDomain Registration Date:   Wed Mar 27 00:01:00 GMT 2002\n", 'biz'), '2002-03-27' );
is( credate_fmt("\nRegistered:  Wed Jan 17 2001\n", 'biz'), '2001-01-17' );
is( credate_fmt("\nRecord created on Feb 21 2001.\n", 'biz'), '2001-02-21' );
is( credate_fmt("\nDomain created on 2002-10-29 03:54:36\n", 'biz'), '2002-10-29' );

is( credate_fmt("\nCreated : September 10 1999.\n", 'ac'), '1999-09-10' );
is( credate_fmt('\nDomain Create Date:29-Apr-2008 17:53:03 UTC\n'), '2008-04-29' );

print "domdates tests\n";

is( join( ';', domdates_fmt("\nCreation Date: 06-sep-2000\nExpiration Date: 06-sep-2005\n") ), '2000-09-06;2005-09-06;' );
is( join( ';', domdates_fmt("\ncreated:    2001.09.19\npaid-till:  2005.09.20\n", 'ru') ), '2001-09-19;2005-09-20;' );
is( join( ';', domdates_fmt("\nCreated on..............: Mon, Nov 12, 2007\n      Expires on..............: Tue, Mar 26, 2013\n") ), '2007-11-12;2013-03-26;', 'domdates_fmt' );

# online tests

print "The following tests requires internet connection and may fail if checked domains were renewed...\n";

$Net::Domain::ExpireDate::USE_REGISTRAR_SERVERS = 2;

like( expire_date('microsoft.com', '%Y-%m-%d'), qr(202\d-05-02) );
like( expire_date('usa.biz', '%Y-%m-%d'), qr(20\d\d-03-26) );
like( expire_date('nic.info', '%Y-%m-%d'), qr(201\d-07-27) );
like( expire_date('nic.us', '%Y-%m-%d'), qr(20\d\d-04-17) );
#like( expire_date('orenet.co.uk', '%Y-%m-%d'), /2006-01-23/ );
#like( expire_date('google.jp', '%Y-%m-%d'), /2007-05-31/ );

$Net::Domain::ExpireDate::USE_REGISTRAR_SERVERS = 0;
like( join( ';', domain_dates("godaddy.com", '%Y-%m-%d') ), qr(1999-03-02;202\d-11-01;) );
$Net::Domain::ExpireDate::USE_REGISTRAR_SERVERS = 2;


like( join( ';', domain_dates("reg.ru", '%Y-%m-%d') ), qr(2005-11-01;201\d-11-01;) );

like( join( ';', domain_dates("ibm.com", '%Y-%m-%d') ), qr(1986-03-19;20\d\d-03-21;) );
like( join( ';', domain_dates("intel.com", '%Y-%m-%d') ), qr(1986-03-25;20\d\d-03-26;) );
