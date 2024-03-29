import strutils, parseutils

proc encode*(input: string): string =
    var i = 0
    while i < input.len:
        let c = input[i]
        let count = input.skipWhile({c}, start = i)
        if count > 1:
            result.add($count)
        result.add(c)
        i += count

proc decode*(input: string): string =
    var count = 1
    for (token, isNum) in input.tokenize(Digits):
        if isNum:
            count = token.parseInt
        else:
            result.add(token[0].repeat(count-1))
            result.add(token)
            count = 1

when isMainModule:
    import unittest

    suite "run-length encode a string":
        test "empty string":
            check encode("") == ""

        test "single characters only are encoded without count":
            check encode("XYZ") == "XYZ"

        test "string with no single characters":
            check encode("AABBBCCCC") == "2A3B4C"

        test "single characters mixed with repeated characters":
            let input = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
            let expected = "12WB12W3B24WB"
            check encode(input) == expected

        test "multiple whitespace mixed in string":
            check encode("  hsqq qww  ") == "2 hs2q q2w2 "

        test "lowercase characters":
            check encode("aabbbcccc") == "2a3b4c"


    suite "run-length decode a string":
        test "empty string":
            check decode("") == ""

        test "single characters only":
            check decode("XYZ") == "XYZ"

        test "string with no single characters":
            check decode("2A3B4C") == "AABBBCCCC"

        test "single characters with repeated characters":
            let input = "12WB12W3B24WB"
            let expected = "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"
            check decode(input) == expected

        test "multiple whitespace mixed in string":
            check decode("2 hs2q q2w2 ") == "  hsqq qww  "

        test "lowercase string":
            check decode("2a3b4c") == "aabbbcccc"


    suite "encode and then decode":
        test "encode followed by decode gives original string":
            check "zzz ZZ  zZ".encode.decode == "zzz ZZ  zZ"
