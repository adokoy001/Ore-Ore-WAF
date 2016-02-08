package App::Core::Server;
use strict;
use warnings;
use utf8;
use Exporter 'import';
our @EXPORT = qw/start_server/;
our @EXPORT_OK = qw/start_server/;

use Plack::MIME;
use Plack::Request;
use Plack::Session;
use File::Slurp;
use lib '../../';
use App::Routes;
use App::Core::Base;
use App::Auth;

sub start_server{
    my $env = shift;
    my $public_dir = './public';
    my $index_files = ['index.html','index.htm'];
    my $req = Plack::Request->new($env);
    my $session = Plack::Session->new($env);
    my $base = App::Core::Base->new();
    my $c = {
	req => $req,
	session => $session,
	base => $base
       };
    my $responses_array = App::Routes::app_routes($c);

    my $responses;

    # responses without any authentication
    my $responses_free = $responses_array->[0];
    foreach my $key (sort keys %$responses_free){
	$responses->{$key} = $responses_free->{$key};
    }

    # responses only for pass authentication App::Auth::auth_check
    my $responses_auth = $responses_array->[1];
    if(App::Auth::auth_check($c)){
	foreach my $key (sort keys %$responses_auth){
	    $responses->{$key} = $responses_auth->{$key};
	}
    }

    # 404 Not Found
    my $not_found = [
	404,
	['Content-Type' => 'text/plain'],
	['404 Not found']
       ];
    my $mime = 'application/octet-stream'; # default for unknown mime
    if($req->path_info =~ /(\.[^\.]+?)$/i){
	my $extension = $1;
	$mime = Plack::MIME->mime_type($extension);
    }
    # go process by PATH_INFO
    if(defined($responses->{$req->path_info})){
	# Do sub routine in $responses
	return $responses->{$req->path_info}->();
    }elsif(-f $public_dir.$req->path_info){
	# render static file
	return [
	    200,
	    ['Content-Type' => $mime],
	    [read_file($public_dir.$req->path_info)],
	   ];
    }else{
	# directory index search
	foreach my $index_file (@$index_files){
	    if(-f $public_dir.$req->path_info.$index_file){
		if($index_file =~ /(\.[^\.]+?)$/i){
		    my $extension = $1;
		    $mime = Plack::MIME->mime_type($extension);
		}
		return [
		    200,
		    ['Content-Type' => $mime],
		    [read_file($public_dir.$req->path_info.$index_file)],
		   ];
	    }
	}
	# 404 Not Found
	return $not_found;
    }
}


1;

