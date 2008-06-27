package HTML::MobileJp::Filter::EntityReference;
use strict;
use warnings;
use base 'HTML::MobileJp::Filter::Base';

use HTML::Entities::ConvertPictogramMobileJp;

sub filter {
    my ($self, $html) = @_;
    
    convert_pictogram_entities(
        mobile_agent => $self->mobile_agent,
        html         => $html,
    );
}

1;
__END__

=encoding utf-8

=head1 NAME

HTML::MobileJp::Filter::EntityReference - i絵文字のコピペの代わりに実体参照で書いておける

=head1 SYNOPSIS

  - module: EntityReference

=head1 CONFIG AND DEFAULT VALUES

=head1 SEE ALSO

L<HTML::Entities::ConvertPictogramMobileJp>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
