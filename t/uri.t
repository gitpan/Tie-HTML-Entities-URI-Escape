
use strict;

use Test;
BEGIN { plan tests => 16 };

use Tie::URI::Escape;
ok(1);

my $s;

tie $s, 'Tie::URI::Escape';
ok(1);

# rudimentary testing, for now...
my %ESCAPES = (
 'this that'          => 'this%20that',
 '<mail@nowhere.net>' => '%3Cmail@nowhere.net%3E',
);

foreach my $char (keys %ESCAPES) {

  tie $s, 'Tie::URI::Escape', $char;
  ok(1);

  ok($s eq $ESCAPES{$char});

  my $o = tied($s);
  ok(1);
  ok($o->fetch_raw, $char);
  ok($o->fetch_encoded, $s);
  ok($o->fetch_encoded, $ESCAPES{$char});

  undef $s;
  ok(1);
}



