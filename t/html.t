
use strict;

use Test;
BEGIN { plan tests => 30 };

use Tie::HTML::Entities;
ok(1);

my $s;

tie $s, 'Tie::HTML::Entities';
ok(1);

my %ENTITIES = (
  '&' => '&amp;',
  '"' => '&quot;',
  '<' => '&lt;',
  '>' => '&gt;',
);

foreach my $char (keys %ENTITIES) {

  tie $s, 'Tie::HTML::Entities', $char;
  ok(1);

  ok($s eq $ENTITIES{$char});

  my $o = tied($s);
  ok(1);
  ok($o->fetch_raw, $char);
  ok($o->fetch_encoded, $s);
  ok($o->fetch_encoded, $ENTITIES{$char});

  undef $s;
  ok(1);
}



