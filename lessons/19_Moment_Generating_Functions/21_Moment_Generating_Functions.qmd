# Chapter 43: Moment Generating Functions Part 2 {#chapter-43-moment-generating-functions-part-2 .unnumbered}

**Recap: What is an mgf?**

::: example
**Example 1**. *  Let $X$ be a random variable with mgf
$$M_X(t)= \frac{1}{5}e^t + \frac{3}{10}e^{2t} + \frac{1}{2}e^{3t}.$$
Find the pmf or pdf of $X$.*
:::

::: example
**Example 2**. *  Let $X$ be a normal random variable with mean $\mu$
and variance $\sigma^2$, i.e. $X \sim N(\mu,\sigma^2)$.*

1.  *Find the mgf of $X$.*

2.  *Find $\mathbb{E}[X]$.*

3.  *Find $Var(X)$.*
:::

------------------------------------------------------------------------

::: theorem
**Theorem 3**. *  Let $X$ have mgf $M_X(t)$, and let $Y=aX+b$, where $a$
and $b$ are constants. Then $$M_Y(t)=$$*
:::

::: proof
*Proof.* ◻
:::

**Question:** *Do linear transformations always preserve the
distribution type?*

I.e., if $X$ has a certain probability distribution, does $aX+b$ always
have the same distribution type?

------------------------------------------------------------------------

::: example
**Example 4**. *  Let $X \sim U[0,1]$, and $Y = 2X+3$. Is $Y$ also a
uniform rv? If so, what are its parameters?*
:::

::: example
**Example 5**. *  Let $X \sim Exp(\lambda=5)$, and $Y = 2X+3$. Is $Y$
also an exponential rv? If so, what is its parameter?*
:::

**Mgf's of Sums of Independent rv's**

------------------------------------------------------------------------

::: theorem
**Theorem 6**. *  Let $X_1, X_2, \ldots, X_n$ be independent rv's with
respective mgf's $M_{X_i}(t)$, for $i=1,2,\ldots,n$. Let
$Y=\sum_{i=1}^n a_iX_i$, where $a_i$ are constants. Then
$$M_Y(t)= %\Pi_{i=1}^n M_{X_i}(a_it).$$*
:::

::: proof
*Proof.* ◻
:::

------------------------------------------------------------------------

::: example
**Example 7**. *  Let $X_i \sim N(\mu_i, \sigma_i^2)$ be independent
normal rv's. What is the distribution of  $Y=\sum_{i=1}^n X_i$?*
:::

------------------------------------------------------------------------

::: example
**Example 8**. *  Let $X_i \sim N(\mu, \sigma^2)$ be iid normal rv's,
for $i=1,2,\ldots,n$. What is the distribution
of  $\bar{X}=\frac{\sum_{i=1}^n X_i}{n}$?*
:::

::: example
**Example 9**. *  Let $Z$ be a standard normal random variable, i.e.
$Z \sim N(0,1)$. Show that $Z^2 \sim \chi_1^2$, i.e. is a chi-squared rv
with 1 degree of freedom.*
:::
