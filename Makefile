clearout:
	rm -rf out

gp:
	git add . && git commit -am 'feature' && gp
