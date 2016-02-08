use strict;
use warnings;
use utf8;
use Plack::Request;
use App::Core::Server;
use App::Core::Base;

# starting psgi application.
my $app = sub {
    my $env = shift; # plack env
    start_server($env);
};
return $app;

