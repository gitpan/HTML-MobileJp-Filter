#line 1
package HTTP::MobileAgent;

use strict;
use vars qw($VERSION);
$VERSION = '0.27';

use HTTP::MobileAgent::Request;

require HTTP::MobileAgent::DoCoMo;
require HTTP::MobileAgent::JPhone;
require HTTP::MobileAgent::EZweb;
require HTTP::MobileAgent::AirHPhone;
require HTTP::MobileAgent::NonMobile;
require HTTP::MobileAgent::Display;

use vars qw($MobileAgentRE);
# this matching should be robust enough
# detailed analysis is done in subclass's parse()
my $DoCoMoRE = '^DoCoMo/\d\.\d[ /]';
my $JPhoneRE = '^(?i:J-PHONE/\d\.\d)';
my $VodafoneRE = '^Vodafone/\d\.\d';
my $VodafoneMotRE = '^MOT-';
my $SoftBankRE = '^SoftBank/\d\.\d';
my $SoftBankCrawlerRE = '^Nokia[^/]+/\d\.\d';
my $EZwebRE  = '^(?:KDDI-[A-Z]+\d+[A-Z]? )?UP\.Browser\/';
my $AirHRE = '^Mozilla/3\.0\((?:WILLCOM|DDIPOCKET)\;';
$MobileAgentRE = qr/(?:($DoCoMoRE)|($JPhoneRE|$VodafoneRE|$VodafoneMotRE|$SoftBankRE|$SoftBankCrawlerRE)|($EZwebRE)|($AirHRE))/;

sub new {
    my($class, $stuff) = @_;
    my $request = HTTP::MobileAgent::Request->new($stuff);

    # parse UA string
    my $ua = $request->get('User-Agent');
    my $sub = 'NonMobile';
    if ($ua =~ /$MobileAgentRE/) {
        $sub = $1 ? 'DoCoMo' : $2 ? 'JPhone' : $3 ? 'EZweb' :  'AirHPhone';
    }

    my $self = bless { _request => $request }, "$class\::$sub";
    $self->parse;
    return $self;
}


sub user_agent {
    my $self = shift;
    $self->get_header('User-Agent');
}

sub get_header {
    my($self, $header) = @_;
    $self->{_request}->get($header);
}

# should be implemented in subclasses
sub parse { die }
sub _make_display { die }

sub name  { shift->{name} }

sub display {
    my $self = shift;
    unless ($self->{display}) {
	$self->{display} = $self->_make_display;
    }
    return $self->{display};
}

# utility for subclasses
sub make_accessors {
    my($class, @attr) = @_;
    for my $attr (@attr) {
	no strict 'refs';
	*{"$class\::$attr"} = sub { shift->{$attr} };
    }
}

sub no_match {
    my $self = shift;
    require Carp;
    Carp::carp($self->user_agent, ": no match. Might be new variants. ",
	       "please contact the author of HTTP::MobileAgent!") if $^W;
}

sub is_docomo  { 0 }
sub is_j_phone { 0 }
sub is_vodafone { 0 }
sub is_softbank { 0 }
sub is_ezweb   { 0 }
sub is_airh_phone { 0 }
sub is_non_mobile { 0 }
sub is_tuka { 0 }

sub is_wap1 {
    my $self = shift;
    $self->is_ezweb && ! $self->is_wap2;
}

sub is_wap2 {
    my $self = shift;
    $self->is_ezweb && $self->xhtml_compliant;
}

sub carrier { undef }
sub carrier_longname { undef }

1;
__END__

#line 267
