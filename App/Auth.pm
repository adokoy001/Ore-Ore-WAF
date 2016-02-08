package App::Auth;
use strict;
use warnings;
use utf8;

sub auth_check{
    my $self = shift;
    # you can write something authentication logic.
    # If auth ok, return 1. or not, return 0.
    my $password = $self->{req}->param('password') // '';
    if($password eq 'yoursecretpass'){
	return(1);
    }else{
	return(0);
    }
}

1;
