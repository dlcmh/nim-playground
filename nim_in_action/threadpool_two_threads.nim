import std/[threadpool]

var greeting = "abcdefghijklmnoprstuvwxyz"

proc showData(id: char, greeting: string) =
  for i, v in greeting:
    if i == 0:
      stdout.write "\n", id, " started...|"
    stdout.write id, v
    stdout.write '|'
  echo id, " done."

spawn showData('?', greeting)
spawn showData('!', greeting)
sync()

# Result 1:
# ? started...|?a|?b|?c|?d|?e|?f|?g|?h|?i|?j|?k|?l|?m|?n|?o|?p|?r|?s|?t|?u|?v|?w|?x|?y|?z|? done.

# ! started...|!a|!b|!c|!d|!e|!f|!g|!h|!i|!j|!k|!l|!m|!n|!o|!p|!r|!s|!t|!u|!v|!w|!x|!y|!z|! done.

# Result 2:
# ? started...|
# ! started...|!a|!b|!c|!d|!e|!f|!g|!h|!i|?a|?b|?!j|!k|!c|?d|?e|l|!m|?f|?g|!n|!o|?h|?i|!p|!r|?j|?k|!s|!t|?l|?m|!u|!v|?n|!w|!x|!y|!z|! done.
# ?o|?p|?r|?s|?t|?u|?v|?w|?x|?y|?z|? done.

# Result 3:
# ? started...|?a|?b|?c|?d|?
# ! started...|!a|!b|!c|!d|!e|!f|!g|!h|!i|!j|!k|!l|!m|!n|!o|!p|!r|!s|!t|!u|!v|!w|!x|!y|!z|! done.
# e|?f|?g|?h|?i|?j|?k|?l|?m|?n|?o|?p|?r|?s|?t|?u|?v|?w|?x|?y|?z|? done.
