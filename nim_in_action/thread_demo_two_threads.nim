type
  ThreadData = tuple
    id: char
    greeting: string

var greeting = "abcdefghijklmnoprstuvwxyz"

proc showData(data: ThreadData) {.thread.} =
  for i, v in data.greeting:
    if i == 0:
      stdout.write "\n", data.id, " started...|"
    stdout.write data.id, v
    stdout.write '|'
  echo data.id, " done."

var threads: array[2, Thread[ThreadData]]
var data1: ThreadData = ('?', greeting)
var data2: ThreadData = ('!', greeting)
createThread[ThreadData](threads[0], showData, data1)
createThread[ThreadData](threads[1], showData, data2)
joinThreads(threads)

echo "\n"

# Result:
# ? started...|?a|?b|?c|
# ! started...|!a|!b|!c|!?d|?e|d|!e|!f|?f|?g|!g|!h|!?h|?i|i|!j|!k|?j|?k|!l|!m|?l|?m|!n|!o|?n|?o|!p|!r|?p|?r|!s|!t|!u|!v|!w|!x|!y|!z|! done.
# ?s|?t|?u|?v|?w|?x|?y|?z|? done.
