
use strict;

use Test;
BEGIN { plan tests => 46, todo => [9, 20, 31, 42] };

use Tie::HTML::Entities 0.05;
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

  $s .= $char;
  ok($s eq ($ENTITIES{$char} x 2));

  $o->store( $char );
  ok(1);
  $o->append( $char );
  ok($o->fetch_encoded() eq ($ENTITIES{$char} x 2));

  undef $o;

  undef $s;
  ok(1);

  untie $s;
  ok(1);
}



