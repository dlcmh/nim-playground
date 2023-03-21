var i = 5

# no mutations
echo i # 5
echo succ i # 6
echo pred i # 4
echo i # 5

# mutations
inc i, 10
echo i # 15
inc i
echo i # 16

dec i
echo i # 15
