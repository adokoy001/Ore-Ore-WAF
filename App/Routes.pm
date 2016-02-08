package App::Routes;
use strict;
use warnings;
use utf8;
use lib '../';
use App::Controller::Example;

sub app_routes{
    my $c = shift;

    # add routes without any authentication in $responses_free
    my $responses_free = {
        '/' => sub {
	    App::Controller::Example::welcome($c);
        },
	'/html_example' => sub {
	    App::Controller::Example::html_example($c);
	},
	'/json_example' => sub {
	    App::Controller::Example::json_example($c);
	},
    };

    # add routes with authentication in $responses_auth
    my $responses_auth = {
	'/auth_example' => sub {
	    App::Controller::Example::auth_example($c);
	},
    };


    # don't change below
    my $responses_arrayref = [
	$responses_free,
	$responses_auth
       ];
    return $responses_arrayref;
}

1;
