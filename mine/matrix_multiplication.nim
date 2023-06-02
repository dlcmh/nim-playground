import std/[sequtils]

type
  MatrixAsSeqOfSeqs = seq[seq[float]]

proc transpose(mA: MatrixAsSeqOfSeqs): MatrixAsSeqOfSeqs =
  let dim = mA[0].len
  result = newSeqWith(dim, newSeq[float](dim))
  for i, row in mA:
    for j, v in row:
      result[j][i] = v

proc multiplyAfterTranspose(mA: MatrixAsSeqOfSeqs,
    mB: MatrixAsSeqOfSeqs): MatrixAsSeqOfSeqs =
  let dim = mA[0].len
  result = newSeqWith(dim, newSeq[float](dim))
  let mB = mB.transpose
  for i in 0 .. mA.high:
    for j in 0 .. mB.high:
      var sum: float
      for k in 0 .. dim - 1:
        sum += mA[i][k] * mB[j][k]
      result[i][j] = sum

proc multiply(mA: MatrixAsSeqOfSeqs, mB: MatrixAsSeqOfSeqs): MatrixAsSeqOfSeqs =
  let dim = mA[0].len
  result = newSeqWith(dim, newSeq[float](dim))
  for i in 0 .. mA.high:
    for j in 0 .. mB.high:
      var sum: float
      for k in 0 .. dim - 1:
        sum += mA[i][k] * mB[k][j]
      result[i][j] = sum

when isMainModule:
  import std/[monotimes, random, times]

  randomize()

  var mA, mB: MatrixAsSeqOfSeqs
  var dim, max: int

  # @[@[84.0, 90.0, 96.0], @[201.0, 216.0, 231.0], @[318.0, 342.0, 366.0]]
  # mA = @[@[1.0, 2.0, 3.0], @[4.0, 5.0, 6.0], @[7.0, 8.0, 9.0]]
  # mB = @[@[10.0, 11.0, 12.0], @[13.0, 14.0, 15.0], @[16.0, 17.0, 18.0]]

  # nim c -d:release matrix_multiplication.nim
  # Elapsed: 134
  # Last value: 51515.21475280783
  # /tmp/nim/matrix_multiplication  133.84s user 0.44s system 99% cpu 2:15.35 total

  # nim c -d:release --mm:arc matrix_multiplication.nim
  # Elapsed: 71
  # Last value: 50411.08046986225
  # /tmp/nim/matrix_multiplication  69.88s user 0.51s system 97% cpu 1:12.37 total

  # with multiplyAfterTranspose
  # Elapsed: 11
  # Last value: 51354.62950695271
  # /tmp/nim/matrix_multiplication  11.75s user 0.06s system 96% cpu 12.259 total
  dim = 2048
  max = 10
  mA = newSeqWith(dim, newSeqWith(dim, rand(max.float)))
  mB = newSeqWith(dim, newSeqWith(dim, rand(max.float)))

  # echo mA
  # echo mB

  # echo mA.transpose

  let start = getMonoTime()
  # let mC = multiply(mA, mB)
  let mC = multiplyAfterTranspose(mA, mB)
  echo "Elapsed: ", (getMonoTime() - start).inSeconds
  # echo mC
  echo "Last value: ", mC[^1][^1]
