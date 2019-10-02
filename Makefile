#####################################################################################################
COURSE=CSE 116
ASGN=00
COMPILER=lambda
#####################################################################################################

test:
	stack test

bin:
	stack build

clean:
	stack clean

distclean: clean
	rm -drf .stack-work/

prepare: distclean
	tar -zcvf ../$(ASGN)-$(COMPILER).tgz --exclude .git --exclude .stack-work ../$(ASGN)-$(COMPILER)
	mv ../$(ASGN)-$(COMPILER).tgz .
