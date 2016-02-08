package App::Controller::Example;
use strict;
use warnings;
use utf8;

sub welcome {
    my $self = shift;
    $self->{base}->render_text('Welcome!');
}

sub html_example {
    my $self = shift;
    $self->{base}->render_html(
	{
	    template_path => 'example/top.tmpl.html',
	    message => 'template test!!'
       }
       );
}

sub json_example {
    my $self = shift;
    $self->{base}->render_json(
	{
	    title => 'json_object',
	    data => {
		path => 'json_example',
		resp => 200,
		type => 'application/json'
	       }
       }
       );
}

sub auth_example {
    my $self = shift;
    $self->{base}->render_text('Auth OK!');
}

1;
