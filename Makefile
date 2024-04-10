#####################################################################################################
COURSE=CSE 116
ASGN=00
COMPILER=lambda
#####################################################################################################

.PHONY: all test bin clean distclean prepare submit

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

submit:
	python3 -m autograder.cli.submission.submit INTEGRITY.md tests/*
