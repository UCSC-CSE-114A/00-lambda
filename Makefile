
#####################################################################################################
COURSE=cs130s
ASGN=00
COMPILER=lambda
#####################################################################################################

test:
	stack test

bin:
	stack build

clean:
	stack clean

turnin: clean
	tar -zcvf ../$(ASGN)-$(COMPILER).tgz --exclude .git --exclude .stack-work ../$(ASGN)-$(COMPILER)
	mv ../$(ASGN)-$(COMPILER).tgz .
	turnin -c $(COURSE) -p $(ASGN) ./$(ASGN)-$(COMPILER).tgz
