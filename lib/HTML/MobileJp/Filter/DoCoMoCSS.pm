package HTML::MobileJp::Filter::DoCoMoCSS;
use strict;
use warnings;
use base 'HTML::MobileJp::Filter::Base';

use Encode;
use HTML::DoCoMoCSS;

sub config_default {
    base_dir                => '',
    xml_declaration_replace => 1,
    xml_declaration         => <<'END'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//i-mode group (ja)//DTD XHTML i-XHTML(Locale/Ver.=ja/1.0) 1.0//EN" "i-xhtml_4ja_10.dtd">
END
    ,
}

sub filter {
    my ($self, $html) = @_;
    
    unless ($self->mobile_agent->is_docomo) {
        return;
    }

    if ($self->config->{xml_declaration_replace}) {
        # instead of $doc->setEncoding etc..
        $html =~ s/.*(<html)/$self->config->{xml_declaration} . "\n$1"/msei;
    }
     
    my $inliner = HTML::DoCoMoCSS->new(base_dir => $self->config->{base_dir});
    $html = $inliner->apply($html);
    $html = Encode::decode_utf8($html);
}

1;
__END__

=encoding utf-8

=head1 NAME

HTML::MobileJp::Filter::DoCoMoCSS - DoCoMo の場合 <link> の CSS をインライン展開

=head1 SYNOPSIS

  - module: EntityReference
    config:
      base_dir: /path/to/documentroot

=head1 CONFIG AND DEFAULT VALUES

  base_dir                => '',
  xml_declaration_replace => 1,
  xml_declaration         => <<'END'
  <?xml version="1.0" encoding="UTF-8"?>
  <!DOCTYPE html PUBLIC "-//i-mode group (ja)//DTD XHTML i-XHTML(Locale/Ver.=ja/1.0) 1.0//EN" "i-xhtml_4ja_10.dtd">
  END

XML 宣言や DTD がないと文字が全部実体参照になったりうまく parse できないので。

=head1 SEE ALSO

L<HTML::DoCoMoCSS>

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=cut
