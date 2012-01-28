#!/usr/bin/perl -Tw

# Simple liferea (and possibly for other things) conversion filter to download
# content for offline viewing during feed updates.
#
# Pigeon <pigeon at pigeond dot net>
#
# http://pigeond.net/
#
# Latest version of this script can be found at:
# git://pigeond.net/offline_filter/
#
# GPLv2
#
#
# What it currently does:
# - Look for matching pattern (e.g. img src url).
# - Download it using wget if it is not already downloaded.
# - Replace original src in the feed with the local downloaded one.
#
# Limitations:
# - Will download all matched elements (img), one by one.
# - Will not redownload a file if it has been changed remotely.
#
# TODO:
# - Doesn't handle things spanned across multiple lines
#

use strict;
use Digest::SHA1 qw(sha1_hex);
use HTML::Entities;

delete @ENV{qw(IFS CDPATH ENV BASH_ENV PATH)};

my ($HOME) = ($ENV{'HOME'} =~ /([a-zA-Z0-9\/\.\_]+)/);

my $SAVE_PATH = "${HOME}/.liferea_1.4/cache/saves";
my $WGET = '/usr/bin/wget';
my $WGET_TIMEOUT = 5;

my @BLACKLIST_RE = (
);

my $debug = 0;


sub url_fetch {

    my ($url) = @_;

    my ($ok) = undef;

    my $outfile = $SAVE_PATH.'/'.sha1_hex($url);

    if ($url =~ m/(\.[a-zA-Z]{3,4})$/) {
	$outfile .= lc($1);
    }

    if (-f $outfile) {

	if ($debug) {
	    print(STDERR "Skipping [${url}], already in [${outfile}]\n");
	}

    } else {

	$url = decode_entities($url);

	# use one upper level as referer
	my $referer = $url;
	$referer =~ s![^/]*?$!!;

	my @args = ($WGET, '-O', $outfile, '-T', $WGET_TIMEOUT);
	if (!$debug) {
	    push(@args, '-q');
	}

	push(@args, "--referer=${referer}");

	push(@args, $url);

	if ($debug) {
	    print(STDERR "Running [".join(' ', @args)."]\n");
	}

	if (system(@args) != 0) {
	    if ($debug) {
		print(STDERR "Fetch failed for [${url}]\n");
	    }
	    unlink(${outfile});
	    $outfile = undef;
	}
    }

    return $outfile;
}


sub img_func {
    my ($matched, $src) = @_;
    my ($ok) = undef;

    if ($src ne '') {

	foreach my $u (@BLACKLIST_RE) {
	    return ${matched} if (${src} =~ ${u});
	}

	my $outfile = url_fetch($src);

	if ($outfile) {
	    $matched =~ s!\Q${src}\E!file://${outfile}!g;
	}
    }
    return $matched;
}


my %handler = (

    # save <img> images for offline viewing
    qr{(?:<|&lt;)img .*?src=(?:"|'|&quot;)?(http://.*?)(?:>|&gt;|"|'|&quot;|\s)}i =>
	'img_func($&, $1)',

);




my @lines = <>;

system("mkdir -p ${SAVE_PATH}");

foreach my $l (@lines) {
    foreach my $regex (keys(%handler)) {
	$l =~ s/$regex/$handler{$regex}/gee;
    }
    print($l);
}

exit(0);

