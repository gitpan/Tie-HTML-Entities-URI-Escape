package Tie::HTML::Entities;

use 5.00500;
use strict;

use HTML::Entities qw( encode_entities );

use vars qw($VERSION @ISA);
@ISA = qw( );

$VERSION = '0.04';

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
    return encode_entities( $self->fetch_raw );
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

Tie::HTML::Entities - Scalars tied to HTML encoding

=head1 REQUIREMENTS

C<Tie::HTML::Entities> should work on Perl 5.005 but it was written
and tested on v5.6.1.

It uses the C<HTML::Entities> module;

=head2 Installation

Installation is pretty standard:

  perl Makefile.PL
  make
  make test
  make install

=head1 SYNOPSIS

  use Tie::HTML::Entities;

  my  $text;
  tie $text, 'Tie::HTML::Entities', param("text");

  print "Content-Type: text/html\n\n",
     "<body>", $text, "</body>";

=head1 DESCRIPTION

This module is a mere experiment for examining the usefulness of using
tied scalars with HTML entities. Raw text can be assigned to a tied variable
but output as HTML (entity) encoded text.

=head2 METHODS

An object-oriented interface is provided. For example,

  my $obj = tied( $text );

You can use the following methods on the object:

=over

=item new

  $obj = new Tie::HTML::Entities SCALAR;

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
HTML::Entities

=head1 AUTHOR

Robert Rothenberg <rrwo@cpan.org>

=head1 LICENSE

Copyright (c) 2002 Robert Rothenberg. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
