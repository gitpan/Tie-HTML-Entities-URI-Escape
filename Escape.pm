package Tie::URI::Escape;

use 5.00500;
use strict;

use URI::Escape qw( uri_escape );

use vars qw($VERSION @ISA);
@ISA = qw( );

$VERSION = '0.01';

sub new
  {
    my $class  = shift;
    my $scalar = shift;
    my $self   = \$scalar;

    bless $self, $class;

    $self->store( $scalar );

    return $self;
  }

sub store
  {
    my $self = shift;
    die "Not a valid object", unless ref $self;
    $$self   = shift;
  }

sub fetch_raw
  {
    my $self = shift;
    die "Not a valid object", unless ref $self;
    return $$self;
  }

sub fetch_encoded
  {
    my $self = shift;
    die "Not a valid object", unless ref $self;
    return uri_escape( $self->fetch_raw );
  }

BEGIN
  {
    *TIESCALAR = \&new;
    *STORE     = \&store;
    *FETCH     = \&fetch_encoded;
  }

1;
__END__

=head1 NAME

Tie::URI::Escape - Scalars tied to URI escaping

=head1 REQUIREMENTS

C<Tie::URI::Escape> should work on Perl 5.005 but it was written
and tested on v5.6.1.

It uses the C<URI::Escape> module;

=head2 Installation

Installation is pretty standard:

  perl Makefile.PL
  make
  make test
  make install

=head1 SYNOPSIS

  use Tie::URI::Escape;

  my  $foo;
  tie $foo, 'Tie::URI::Escape', param("foo");

  print "<a href=\"$foo\">Some Link</a>";


=head1 DESCRIPTION

This module is a mere experiment, the sister module of C<Tie::HTML::Entities>.

=head2 METHODS

An object-oriented interface is provided. For example,

  my $obj = tied( $foo );

You can use the following methods on the object:

=over

=item new

  $obj = new Tie::URI::Escape SCALAR;

Creates a new object. SCALAR is the default ''value'' of that object.

=item store

  $obj->store( SCALAR );

Stores the value of the SCALAR.

=item fetch_raw

  $obj->fetch_raw;

Returns the raw (unencoded) value.

=item fetch_encoded

  $obj->fetch_encoded;

Returns the encoded value.

=back

=head1 SEE ALSO

CGI
Tie::HTML::Entities
URI::Escape

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 LICENSE

Copyright (c) 2002 Robert Rothenberg. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
