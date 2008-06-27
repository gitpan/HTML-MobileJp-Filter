package HTML::MobileJp::Filter::FallbackImage;
use strict;
use warnings;
use base 'HTML::MobileJp::Filter::Base';

use Encode;
use Encode::JP::Mobile ':props';
use Encode::JP::Mobile::Charnames;

sub config_default {
    template => '', # sprintf format
    params   => [], # Encode::JP::Mobile::Charnames method names
};

sub filter {
    my ($self, $html) = @_;
    
    unless ($self->mobile_agent->is_non_mobile) {
        return;
    }
    
    $html =~ s{(\p{InMobileJPPictograms})}{
        my $char = Encode::JP::Mobile::Character->from_unicode(ord $1);
        
        sprintf $self->config->{template},
            map { $char->$_() } @{ $self->config->{params} };
    
    }ge;
    
    $html;
}

1;
__END__

=encoding utf-8

=head1 NAME

HTML::MobileJp::Filter::FallbackImage - PC の場合絵文字を代替画像に

=head1 SYNOPSIS

  - module: FallbackImage
    config:
      template: <img src="/img/pictogram/%s.gif" />
      params:
        - unicode_hex

=head1 CONFIG AND DEFAULT VALUES

  template => '', # sprintf format
  params   => [], # Encode::JP::Mobile::Charnames method names

=head1 SEE ALSO

L<Encode::JP::Mobile>, L<Encode::JP::Mobile::Charnames>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
