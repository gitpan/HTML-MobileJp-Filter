use strict;
use Test::More tests => 1;

package MyFilter;
use Moose;
with 'HTML::MobileJp::Filter::Role';
sub filter { $_[1].':my_filter1' }

package HTML::MobileJp::Filter::MyFilter;
use Moose;
with 'HTML::MobileJp::Filter::Role';
sub filter { $_[1].':my_filter2' }

package main;
use HTML::MobileJp::Filter;
use HTTP::MobileAgent;

my $filters = [
    { module => '+MyFilter' },
    { module => 'MyFilter' }
];

my $filter = HTML::MobileJp::Filter->new( filters => $filters );
my $html   = $filter->filter(
    mobile_agent => HTTP::MobileAgent->new,
    html         => "test",
);

is($html, "test:my_filter1:my_filter2");
