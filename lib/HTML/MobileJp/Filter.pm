package HTML::MobileJp::Filter;
use strict;
use warnings;
our $VERSION = '0.01';

use Carp;
use Class::Trigger;
use UNIVERSAL::require;

sub new {
    my $class  = shift;
    my $config = ref $_[0] eq 'HASH' ? shift : { @_ };
    my $self   = bless {}, $class;
    
    for my $filter (@{ $config->{filters} || [] }) {
        my $module = __PACKAGE__ .'::'. $filter->{module};
        $module->require or croak $@;
        $module->new($self, $filter);
    }
    
    $self;
}

sub filter {
    my ($self, %option) = @_;
    
    $self->{$_} = $option{$_} for keys %option;
    
    $self->call_trigger('filter_process');
    
    $self->{html};
}

1;
__END__

=encoding utf-8

=head1 NAME

HTML::MobileJp::Filter - Glue modules for fighting Japanese mobile web

=head1 SYNOPSIS

  use HTML::MobileJp::Filter;
  use HTTP::MobileAgent;
  use YAML;

  my $filter = HTML::MobileJp::Filter->new(YAML::Load <<'...'
  ---
  filters:
    - module: DoCoMoCSS
      config:
        base_dir: /path/to/htdocs
    - module: DoCoMoGUID
    - module: FallbackImage
      config:
        template: '<img src="%s.gif" />'
        params:
          - unicode_hex
  ...
  );

  $html = $filter->filter(
      mobile_agent => HTTP::MobileAgent->new,
      html         => $html,
  );

=head1 DESCRIPTION

HTML::MobileJp::Filter is 偉大な先人たちがつくってくれた携帯サイトに役立つ
CPAN モジュールたちをつなげる薄いフレームワークです。

B<CAUTION:> This module is still alpha, its possible the API will change.

=head1 METHODS

=over 4

=item new( filters => [ ] )

=item filter( mobile_agent => $ua, html => $html )

=back

=head1 AUTHOR

Naoki Tomita E<lt>tomita@cpan.orgE<gt>

=head1 DEVELOPMENT

L<http://coderepos.org/share/browser/lang/perl/HTML-MobileJp-Filter>

#mobilejp on irc.freenode.net (I've joined as "tomi-ru")

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO


=cut
