# nums must be declared using `var`, not `let`
var nums = [1,2]

# before mutation
echo nums
# [1, 2]

for n in nums.mitems:
  n = n * 10 # mutate here

# after mutation
echo nums
# [10, 20]
