
#####################################################################################################
COURSE=CMPS 122
ASGN=00
COMPILER=lambda
#####################################################################################################

test:
	stack test

bin:
	stack build

clean:
	stack clean

prepare: clean
	tar -zcvf ../$(ASGN)-$(COMPILER).tgz --exclude .git --exclude .stack-work ../$(ASGN)-$(COMPILER)
	mv ../$(ASGN)-$(COMPILER).tgz .
