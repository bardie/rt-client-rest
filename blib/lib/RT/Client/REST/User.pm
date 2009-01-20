# $Id: User.pm 2 2007-12-23 02:16:25Z dtikhonov $
#
# RT::Client::REST::User -- user object representation.

package RT::Client::REST::User;

use strict;
use warnings;

use vars qw($VERSION);
$VERSION = '0.02';

use Params::Validate qw(:types);
use RT::Client::REST 0.14;
use RT::Client::REST::Object 0.01;
use RT::Client::REST::Object::Exception 0.01;
use RT::Client::REST::SearchResult 0.02;
use base 'RT::Client::REST::Object';

=head1 NAME

RT::Client::REST::User -- user object representation.

=head1 SYNOPSIS

  my $rt = RT::Client::REST->new(server => $ENV{RTSERVER});

  my $user = RT::Client::REST::User->new(
    rt  => $rt,
    id  => $id,
  )->retrieve;

=head1 DESCRIPTION

B<RT::Client::REST::User> is based on L<RT::Client::REST::Object>.
The representation allows to retrieve, edit, comment on, and create
users in RT.

Note: RT currently does not allow REST client to search users.

=cut

sub _attributes {{
    id  => {
        validation  => {
            type    => SCALAR,
        },
        form2value  => sub {
            shift =~ m~^user/(\d+)$~i;
            return $1;
        },
        value2form  => sub {
            return 'user/' . shift;
        },
    },

    name   => {
        validation  => {
            type    => SCALAR,
        },
    },

    password   => {
        validation  => {
            type    => SCALAR,
        },
    },

    email_address => {
        validation  => {
            type    => SCALAR,
        },
        rest_name => 'EmailAddress',
    },

    real_name => {
        validation  => {
            type    => SCALAR,
        },
        rest_name => 'RealName',
    },

    gecos => {
        validation  => {
            type    => SCALAR,
        },
    },

    comments => {
        validation  => {
            type    => SCALAR,
        },
    },
}}

=head1 ATTRIBUTES

=over 2

=item B<id>

For retrieval, you can specify either the numeric ID of the user or his
username.  After the retrieval, however, this attribute will be set
to the numeric id.

=item B<name>

This is the username of the user.

=item B<password>

User's password.  Reading it will only give you a bunch of stars (what
else would you expect?).

=item B<email_address>

E-mail address of the user.

=item B<real_name>

Real name of the user.

=item B<gecos>

Gecos.

=item B<comments>

Comments about this user.

=back

=head1 DB METHODS

For full explanation of these, please see B<"DB METHODS"> in
L<RT::Client::REST::Object> documentation.

=over 2

=item B<retrieve>

Retrieve RT user from database.

=item B<store>

Create or update the user.

=item B<search>

Currently RT does not allow REST clients to search users.

=back

=head1 INTERNAL METHODS

=over 2

=item B<rt_type>

Returns 'user'.

=cut

sub rt_type { 'user' }

=back

=head1 SEE ALSO

L<RT::Client::REST>, L<RT::Client::REST::Object>,
L<RT::Client::REST::SearchResult>.

=head1 AUTHOR

Dmitri Tikhonov <dtikhonov@yahoo.com>

=head1 LICENSE

Perl license with the exception of L<RT::Client::REST>, which is GPLed.

=cut

__PACKAGE__->_generate_methods;

1;