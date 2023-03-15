# nums must be declared using `var`, not `let`
var nums = [1,2]

# before mutation
echo nums
# [1, 2]

for idx, n in nums.mpairs:
  echo "mutating ", idx, "..."
  # mutating 0...
  # mutating 1...

  n = n * 10 # mutate here

# after mutation
echo nums
# [10, 20]
