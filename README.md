# Karatsuba multiplication

This is a simple implementation of the Karatsuba multiplication algorithm in Verilog. 

## Theory

### Principle

Let $N$ be a positive integer. We assume we have a computing device which can perform mutiplications of non-negative integers smaller than $N$.

Let $a$ and $b$ be two non-negative integers smaller than $N^2$, and $c = a \times b$. We can choose four non-negative integers $a_0$ $a_1$, $b_0$, and $b_1$ smaler than $N$ such that $a = a_1 N + a_0$ and $b = b_1 N + b_0$. Then, 

$$
    c = a_1 b_1 N^2 + (a_1 b_0 + a_0 b_1) N + a_0 b_0 .
$$

The product $c$ of $a$ and $b$ can thus be computed using $4$ multiplications and $4$ additions. Using this identity recursively, and neglecting the cost of additions, multiplying the number of bits of $N$ by $2$ thus multiplies the number of mutiplications by $4$. The complexity is thus quadratic in the number $B$ of bits of $N$.

This complexity can be reduced by noting that 

$$
    a_1 b_0 + a_0 b_1 = (a_0 + b_0) (a_1 + b_1) - a_0 b_0 - a_1 b_1 .
$$

The product $c$ can thus be computed using $3$ multiplications (of numbers with at most $B+1$ bits), $5$ additions, and $2$ subtractions. The small drawback of this approach is that it involves a multiplication of two numbers which may be as high as $2 (N - 1)$, which is larger than $N$ if $N > 2$. However, in practice it is usually more efficient.

### Complexity

Let $C_m(B)$, $C_a(B)$, and $C_s(B)$ denote the numbers of operations required to perforn, respectively, a multiplication, an addition, and a subtraction of numbers with $B$ bits. Using the Karatsuba algorithm, we have:

$$
    C_m(2 B) = C_m(B+1) + 2 C_m(B) + 2 C_a(B) + 2 C_a(2B) + 2 C_s(B+1). 
$$

Let us look for asymptotically exponential solutions, such that 

$$
    C_m(B) \mathop{\sim}_{B \to \infty} \beta B^\alpha,
$$
where $\alpha$ and $\beta$ are two positive numbers. The cost of additions and subtractions are linear, and thus negligible for large values of $B$. In the limit $B \to \infty$, the above equation thus becomes:

$$
    \beta 2^\alpha B^\alpha \mathop{\sim}_{B \to \infty} \beta (B+1)^\alpha + 2 \beta B^\alpha . 
$$

Since $\beta$ is not equal to $0$, this may be simplified as: 

$$
    2^\alpha \mathop{\sim}_{B \to \infty} \left( 1 + \frac{1}{B} \right)^\alpha + 2, 
$$

which is true if and only if $2^\alpha = 3$, *i.e.*, $\alpha = \log_2(3)$.

The complexity of the multiplication is thus

$$
    C_m(B) \mathop{\propto}_{B \to \infty} B^{\log_2(3)} \approx B^{1.58496} .
$$

## How to run the tests

### Requirements

* Verilator (tested Verilator 5.003 devel rev v5.002-12-g2a3eabff7).
* A C++ compiler compatible with Verilator (tested with g++ 11.3.0).

### Run a test

If you have `make, you may run the test `TEST` using the command

```
make name=TEST test
```

You may also use diectly
```
verilator --cc --exe --build tests/TEST.cpp tests/TEST.v --top-module TEST
```
to build the test. The executable will be placed in `obj_dir/VTEST`.

The tests currently implemented are: 

* `addition`: a simple test of the addition module
* `subtraction`: a simple test of the subtracttion module
* `mul_2`: multiplication of 2-bit numbers

The command 

```
make all_tests
```

compiles and runs all the tests.
