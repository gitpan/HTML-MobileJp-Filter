use strict;
use Test::More tests => 1;

use HTML::MobileJp::Filter;
use HTTP::MobileAgent;

my $filter = HTML::MobileJp::Filter->new( filters => [{ module => 'Dummy' }] );
my $html   = $filter->filter(
    mobile_agent => HTTP::MobileAgent->new,
    html         => "test",
);

is($html, "dummy:{test}");
