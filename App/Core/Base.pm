package App::Core::Base;
use strict;
use warnings;
use utf8;
use Mouse;
use Text::Xslate;
use JSON;
use FindBin;

has template_dir => (
    is => 'ro',
    isa => 'Str',
    default => "./App/View/",
    required => 0,
   );

has template_engine => (
    is => 'ro',
    default => sub {
	Text::Xslate->new(
	    cache_dir => "$FindBin::Bin/.xslate_cache"
	   );
    },
    required => 0,
);
has json_engine => (
    is => 'ro',
    default => sub { JSON->new->allow_nonref; },
    required => 0,
   );

sub render_text{
    my $self = shift;
    my $data = shift;
    return [
	200,
	['Content-Type' => 'text/plain'],
	[$data]
       ];
}

sub render_html{
    my $self = shift;
    my $opts = shift;
    my $template_path = $opts->{'template_path'} // 'top';
    my $template_full_path = $self->template_dir . $template_path;
    return [
	200,
	['Content-Type' => 'text/html'],
	[$self->template_engine->render($template_full_path,$opts)]
       ];
}

sub render_json{
    my $self = shift;
    my $data = shift;
    return [
	200,
	['Content-Type' => 'application/json'],
	[$self->json_engine->encode($data)]
       ];
}

1;

