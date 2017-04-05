---
title: HW 0 (140 points)
headerImg: angles.jpg
---

## Due by Friday 4/14 23:59:59

Get this assignment by running:

```
git clone https://github.com/ucsd-cse130/00-lambda.git
```


## Overview : Lambda Calculus

The objective of this assignment is for you to understand
the **lambda-calculus**, and the notion of computation-by-substitution
i.e. substituting equals for equals.

The assignment is in the files:

1. `tests/01_bool.lc`
2. `tests/02_plus.lc`
3. `tests/03_minus.lc`

You can edit these files and then run them,

* either on the [online site](http://goto.ucsd.edu:8095/index.html), OR
* by running `$ elsa path/to/file.lc` on `ieng6.ucsd.edu`, OR
* by locally installing `elsa` following [these instructions](https://github.com/ucsd-progsys/elsa#install)

If you run it online, be sure to **copy back the result**
into the corresponding local file before submitting.

## Assignment Testing and Evaluation

Your functions/programs **must** compile and run on `ieng6.ucsd.edu`.

All the points will be awarded automatically, by
**evaluating your functions against a given test suite**.

When you run

```shell
$ make 
```

or 

```shell
$ stack test
```

Your last lines should have

```
All N tests passed (...)
OVERALL SCORE = ... / ...
```

**or**

```
K out of N tests failed
OVERALL SCORE = ... / ...
```

**If your output does not have one of the above your code will receive a zero**

The other lines will give you a readout for each test.
You are encouraged to try to understand the testing code,
but you will not be graded on this.

## Submission Instructions

To submit your code, just do:

```bash
$ make turnin
```

`turnin` will provide you with a confirmation of the
submission process; make sure that the size of the file
indicated by `turnin` matches the size of your file.
See the ACS Web page on [turnin](http://acs.ucsd.edu/info/turnin.php)
for more information on the operation of the program.

**REMARK**: For problems 1 and 2, when using `=d>`, you don't need to unfold
every definition. It is often easier to keep some definitions folded until
their code is needed.

## Problem 1: `01_bool.lc`  

**NOTE: DO NOT** use the `=*>` or `=~>` operators
anywhere in your solution for this problem, or you
will get 0 points for the assignment.

**NOTE: YOU MAY** replace `=d>` with `=b>` in the
last line.


### Part (a) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `NOT TRUE` to `FALSE`.


### Part (b) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `AND TRUE FALSE` to `FALSE`.


### Part (c) (5 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `OR FALSE TRUE` to `TRUE`.


## Problem 2: `02_plus.lc`  

**NOTE: DO NOT** use the `=*>` or `=~>` operators
anywhere in your solution for this problem, or you
will get 0 points for the assignment.

**NOTE: YOU MAY** replace `=d>` with `=b>` in the
last line.


### Part (a) (10 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `SUC ONE` to `TWO`.

### Part (b) (10 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `ADD ZERO ZERO` to `ZERO`.

### Part (c) (10 points)

Complete the sequence of `=a>`, `=b>` and `=d>`
steps needed to reduce `ADD TWO TWO` to `FOUR`.

## Problem 3: `03_minus.lc`

**NOTE:** You only need to write lambda-calculus
definitions for `SKIP1`, `DECR`, `SUB`, `ISZ` and `EQL`.
If you modify **any other** other part of the file
you will get 0 points for the assignment.

### Part (a) (30 points)

Replace the definition of `SKIP1` with a suitable
lambda-term (i.e. replace `undefined` with a suitable
term) so that the following reductions are valid:

```haskell
eval skip1_false :
  SKIP1 INCR (PAIR FALSE ZERO)
  =~> (\b -> b TRUE ZERO)         --  PAIR TRUE ZERO

eval skip1_true_zero :
  SKIP1 INCR (PAIR TRUE ZERO)
  =~> (\b -> b TRUE ONE)          -- PAIR TRUE ONE

eval skip1_true_one :
  SKIP1 INCR (PAIR TRUE ONE)
  =~> (\b -> b TRUE TWO)          -- PAIR TRUE TWO
```

### Part (b) (15 points)

Replace the definition of `DECR` (decrement-by-one)
with a suitable lambda-term (i.e. replace `undefined`
with a suitable term) so that the following reductions
are valid:

```haskell
eval decr_zero :
  DECR ZERO
  =~> ZERO

eval decr_one :
  DECR ONE
  =~> ZERO

eval decr_two :
  DECR TWO
  =~> ONE
```

### Part (c) (20 points)

Replace the definition of `SUB` (subtract) with a
suitable lambda-term (i.e. replace `undefined`
with a suitable term) so that the following
reductions are valid:

```haskell
eval sub_two_zero :
  SUB TWO ZERO
  =~> TWO

eval sub_two_one :
  SUB TWO ONE
  =~> ONE

eval sub_two_two :
  SUB TWO TWO
  =~> ZERO

eval sub_two_three :
  SUB ONE TWO
  =~> ZERO
```

### Part (d) (10 points)

Replace the definition of `ISZ` (is-equal-to-zero)
with a suitable lambda-term (i.e. replace `undefined`
with a suitable term) so that the following
reductions are valid:

```haskell
eval isz_zero :
  ISZ ZERO
  =~> TRUE

eval isz_one :
  ISZ ONE
  =~> FALSE
```

### Part (e) (20 points)

Replace the definition of `EQL` (is-equal)
with a suitable lambda-term (i.e. replace
`undefined` with a suitable term) so that
the following reductions are valid:

```haskell
eval eq_zero_zero :
  EQL ZERO ZERO
  =~> TRUE

eval eq_zero_one :
  EQL ZERO ONE
  =~> FALSE

eval eq_one_two :
  EQL ONE TWO
  =~> FALSE

eval eq_two_two :
  EQL TWO TWO
  =~> TRUE
```
