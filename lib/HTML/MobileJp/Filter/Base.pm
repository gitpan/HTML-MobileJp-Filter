package HTML::MobileJp::Filter::Base;
use strict;
use warnings;

use base 'Class::Accessor::Fast';
__PACKAGE__->mk_accessors(qw( mobile_agent config ));

sub new {
    my ($class, $c, $option) = @_;
    my $self = $class->SUPER::new;
    
    $self->config({
        $self->config_default,
        %{ $option->{config} || {} },
    });
      
    $c->add_trigger(filter_process => sub {
        my $c = shift;
        
        $self->mobile_agent($c->{mobile_agent});
        
        my $ret = $self->filter($c->{html});
        
        $c->{html} = $ret if defined $ret;
    });
    
    $self;
}

sub config_default { }

sub filter { }

1;
