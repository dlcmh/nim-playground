## Zero-indexed counting has two shortcuts ..< and .. ^1 (backward index operator) to simplify counting to one less than the higher index

echo "Full string is 'abcdef' - iterate up until the third-to-last character."
var s = "abcdef"
for i in s[0 .. ^3]:
  echo i

#[
  Full string is 'abcdef' - iterate up until the third-to-last character.
  a
  b
  c
  d
]#
