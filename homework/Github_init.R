---
title: "Homework 5"
subtitle: "BSTA 550"
author: "Your name here"
date-modified: "today"
format:
  html:
    toc: true
    embed-resources: true
    link-external-newwindow: true
  typst:
    toc: true
    papersize: us-letter
    margin:
      x: 1in
      y: 1in
editor_options:
  chunk_output_type: console
---

<!--
HOW TO USE THIS FILE
- Put your name in the "author" line at the very top.
- Type your answers after each "Answer:" line.
- Put R code inside the gray code chunks (between ```{r} and ```).
- You don't need to change anything between the --- lines at the top (YAML)
  or any line starting with :::
- Click the arrow next to "Render" and choose "Render HTML" or
  "Render Typst" (Typst makes a PDF). Submit that file.
-->

```{r}
#| label: "setup"
#| include: false

knitr::opts_chunk$set(echo = TRUE)

# Uses the course date file when it's available;
# otherwise falls back to the due date below.
if (requireNamespace("here", quietly = TRUE) &&
    file.exists(here::here("class_dates.R"))) {
  source(here::here("class_dates.R"))
} else {
  hw5 <- as.Date("2026-11-22")
}
```

::: {.callout-tip appearance="minimal"}
**Due `r format(hw5, "%m/%d")` at 11pm**
:::

## Assignment information

### Lessons covered

-   Lesson 11: Variance
-   Lesson 12: Important discrete RVs
-   Lesson 13: Important continuous RVs

### Directions

**Please turn in this homework on Brightspace.** Please submit your homework as a pdf or html file. You can type your work in this file and render it, or submit a single file with photos of your written work or any other method that can be turned into a pdf. Please let me know if you prefer to submit a physical copy, we can arrange for a physical "turn in" during Monday's class.

**Get the .qmd file:** You can download this homework as a `.qmd` file from [GitHub](https://github.com/nwakim/BSTA_550_26F/blob/main/homework/HW_05.qmd). On that page, click the download button ("Download raw file") near the top right of the file.

*You must show all of your work to receive credit.*

Extra problems do not need to be turned in!

::: {.callout-warning collapse="false"}
#### If you are editing this file to turn in

If you are editing this `.qmd` file, then you will see a section right below the YAML called "HOW TO USE THIS FILE." Please follow those instructions to make sure you are not deleting essential parts of this file. When you render, that section will not show up.
:::

::: {.callout-note collapse="false"}
#### AI Use Statement

**Using AI is not required in this class.** If you *did* use an AI tool (ChatGPT, Claude, Copilot, Gemini, an RStudio assistant, etc.) on this homework, add a brief AI Use Statement at the very top of your submission. Include:

-   **Which tool(s)** you used
-   **What for** (a sentence or two, with question numbers)
-   **Where** it contributed to any written interpretations (if at all)
-   *You do NOT need to link your conversation.*

For example:

> *AI Use Statement: Claude was used to explain an error message in Question 3. All statistical reasoning, code review, and conclusions are my own.*

OR

> *AI Use Statement: AI was not used in this assignment.*

Before using AI, check the table of allowed uses in the [Generative AI Policy](https://nwakim.github.io/BSTA_550_26F/syllabus.html#generative-ai-policy). For homework, AI can help you *understand* (explain an error or a concept, check an answer you already worked out, give feedback on your own writing), but it should not do the problem for you. A half-finished answer that shows your thinking is always better than a polished one from AI!
:::

## Questions

**Load packages.** This chunk is done for you. Run it before any of the R code below.

```{r}
#| label: "load-packages"
#| message: false

library(tidyverse)
```

Questions 1–4 practice expected values of functions of RVs and variance (Lesson 11). Questions 1, 2, and 4 revisit setups from Homework 4, so you can reuse your expected values from there. Questions 5–10 practice the named distributions from Lessons 12 and 13.

### 1. Asthma ER visits (revisited)

Suppose that for adults with asthma, the number of emergency room (ER) visits for asthma in a year, $X$, has the following pmf:

| $x$ | 0 | 1 | 2 | 3 |
|:---:|:---:|:---:|:---:|:---:|
| $p_X(x)$ | 0.50 | 0.30 | 0.15 | 0.05 |

and $p_X(x) = 0$ for any other value of $x$. In Homework 4, you found $\mathbb{E}[X]$.

#### Part a

Find $\mathbb{E}[X^2]$. Is $\mathbb{E}[X^2]$ equal to $\left(\mathbb{E}[X]\right)^2$?

***Answer:***

#### Part b

Find $Var(X)$ two ways: with the definition, $Var(X) = \mathbb{E}\left[(X - \mathbb{E}[X])^2\right]$, and with the computation formula, $Var(X) = \mathbb{E}[X^2] - \left(\mathbb{E}[X]\right)^2$. Then find $SD(X)$.

***Answer:***

#### Part c

Suppose each ER visit costs a patient a \$250 copay, plus every patient pays a \$100 yearly fee. So the patient's yearly cost is $C = 250X + 100$. Find $SD(C)$.

-   *Hint:* You can use the result for $Var(aX+b)$ (Lesson 11, Lemma 7). You will prove this result in Question 3!

***Answer:***

#### Part d

Simulate 10,000 adults with asthma to check your answers to Parts a and b.

**Step 1: Set up.** This chunk is done for you. Run it before the others.

```{r}
#| label: "q1d-setup"

set.seed(2222)    # so you get the same "random" adults each time
reps <- 10000     # number of simulated adults

# probability of 0, 1, 2, and 3 ER visits
visit_probs <- c(0.50, 0.30, 0.15, 0.05)
```

**Step 2: Simulate.** Simulate the number of ER visits, $X$, for each of the 10,000 adults.

-   *Hint:* You can reuse your code from Homework 4. Or follow Lesson 10, Example 2 (the not-so-fair die): start with `tibble(sim = 1:reps)`, then use `mutate()` and `sample()` with the possible values `0:3`, `replace = TRUE`, and `prob = visit_probs`.

***Answer:***

```{r}
#| label: "q1d-simulate"

# Your code here

```

**Step 3: Summarize.** Use `summarise()` to approximate $\mathbb{E}[X^2]$, $Var(X)$, and $SD(X)$ from your simulation.

-   *Hint:* Follow the card example in Lesson 11 ("The variance from our simulation"). `mean(X^2)` approximates $\mathbb{E}[X^2]$, `mean((X - mean(X))^2)` approximates $Var(X)$, and `sqrt()` takes the square root.

***Answer:***

```{r}
#| label: "q1d-summarize"

# Your code here

```

Are your simulated answers close to your answers in Parts a and b? (They do not need to match exactly!)

***Answer:***

### 2. Medication absorption (revisited)

Suppose the proportion $X$ of a medication dose that is absorbed in the first hour has pdf $$f_X(x) = \begin{cases} 3x^2 & \text{if } 0 \leq x \leq 1 \\ 0 & \text{otherwise} \end{cases}$$ In Homework 4, you found $\mathbb{E}[X]$.

#### Part a

Find $\mathbb{E}[X^2]$.

***Answer:***

#### Part b

Find $Var(X)$ and $SD(X)$.

***Answer:***

#### Part c

Simulate 10,000 values of $X$ with the inverse CDF method from Lesson 9, and use them to check your answers to Parts a and b.

-   *Hint:* You can reuse your simulation from Homework 4 ($x = u^{1/3}$). Then use `summarise()` to approximate $\mathbb{E}[X^2]$, $Var(X)$, and $SD(X)$, like in Question 1.

***Answer:***

```{r}
#| label: "q2c-simulate"

set.seed(3131)
reps <- 10000

# Your code here

```

Are your simulated answers close to your answers in Parts a and b? (They do not need to match exactly!)

***Answer:***

### 3. Variance of a linear function

Prove that for a random variable $X$ and constants $a$ and $b$, $$Var(aX+b)=a^2Var(X).$$

-   *Hint:* Use the computation formula from Lesson 11 with $aX+b$ in place of $X$: $Var(aX+b) = \mathbb{E}\left[(aX+b)^2\right] - \left(\mathbb{E}[aX+b]\right)^2$. Then expand the squares and use $\mathbb{E}[aX+b] = a\mathbb{E}[X] + b$ from Lesson 10.

***Answer:***

### 4. Waiting for the bus (revisited)

Suppose your waiting time for a bus in the morning is uniformly distributed on \[0, 8\] (minutes), whereas waiting time in the evening is uniformly distributed on \[0, 10\] (minutes) independent of morning waiting time. *Make sure to FIRST set up an equation for the total waiting time in each question before calculating its variance.* *You may use results from class for the expected value and variance of uniform RVs without proving them.*

#### Part a

If you take the bus each morning and evening for a week (7 days), what is the variance of your total waiting time?

***Answer:***

#### Part b

What is the variance of the difference between morning and evening waiting times on a given day?

***Answer:***

#### Part c

What is the variance of the difference between total morning waiting time and total evening waiting time for a particular week?

***Answer:***

#### Part d

Simulate 10,000 weeks of bus rides to check your answers to Parts a and c.

**Step 1: Set up.** This chunk is done for you. Run it before the others.

```{r}
#| label: "q4d-setup"

set.seed(6161)  # so you get the same "random" weeks each time
reps <- 10000   # number of simulated weeks
n_days <- 7     # number of days in a week
```

**Step 2: Simulate and find the weekly totals.** You can reuse your code from Homework 4 to make the `morning` and `evening` waiting times, then find the weekly `total` and `difference`.

-   *Hint:* Start with `expand_grid(sim = 1:reps, day = 1:n_days)`, then use `mutate()` with `runif(n(), min = 0, max = 8)` and `runif(n(), min = 0, max = 10)`. Then `group_by(sim)` and `summarise()` with `total = sum(morning + evening)` and `difference = sum(morning) - sum(evening)`.

***Answer:***

```{r}
#| label: "q4d-simulate"

# Your code here

```

**Step 3: Summarize.** Approximate the variance of the total waiting time and of the difference.

-   *Hint:* Use `summarise()` with `mean((total - mean(total))^2)`, like in Question 1.

***Answer:***

```{r}
#| label: "q4d-summarize"

# Your code here

```

Are your simulated answers close to your answers in Parts a and c? (They do not need to match exactly!)

***Answer:***

### 5. Quitting smoking

Suppose that each time an adult who smokes tries to quit, they have a 0.25 chance of staying smoke-free for a full year. Assume the attempts are independent. Let $X$ be the number of quit attempts up to and including the first successful one.

#### Part a

What is the distribution of $X$? Give its parameter and say what the parameter means in this problem.

***Answer:***

#### Part b

Using the pmf and CDF from Lesson 12, find the probability that the first successful attempt is the $3^{rd}$ attempt, $P(X = 3)$, and the probability that it takes 3 or fewer attempts, $P(X \leq 3)$.

***Answer:***

#### Part c

Find $\mathbb{E}[X]$, $Var(X)$, and $SD(X)$. Explain $\mathbb{E}[X]$ in the context of the problem.

***Answer:***

#### Part d

Use R to check your answers to Part b.

-   *Hint:* Use `dgeom()` and `pgeom()` with `prob = 0.25`, like the bullseye example in Lesson 12. **Careful:** R counts the *failures* before the first success, so for $X = 3$ attempts, use `3 - 1`.

***Answer:***

```{r}
#| label: "q5d-geom"

# Your code here

```

#### Part e

Simulate 10,000 people who are trying to quit to check your answers to Parts b and c.

**Step 1: Set up.** This chunk is done for you. Run it before the others.

```{r}
#| label: "q5e-setup"

set.seed(4747)    # so you get the same "random" people each time
reps <- 10000     # number of simulated people
p <- 0.25         # chance that one quit attempt works
```

**Step 2: Simulate.** Simulate the number of quit attempts, $X$, for each of the 10,000 people.

-   *Hint:* Follow "Let's simulate the bullseye example" in Lesson 12. Start with `tibble(sim = 1:reps)`, then use `mutate()` to make a column `failures` with `rgeom(n(), prob = p)` and a column `X` that adds 1 for the attempt that worked.

***Answer:***

```{r}
#| label: "q5e-simulate"

# Your code here

```

**Step 3: Summarize.** Use `summarise()` to approximate $P(X = 3)$, $P(X \leq 3)$, $\mathbb{E}[X]$, and $Var(X)$.

-   *Hint:* `mean(X == 3)` is the proportion of people whose $3^{rd}$ attempt was their first success (`TRUE` counts as 1 and `FALSE` as 0). Use `mean(X)` and `mean((X - mean(X))^2)` like in Question 1.

***Answer:***

```{r}
#| label: "q5e-summarize"

# Your code here

```

Are your simulated answers close to your answers in Parts b and c? (They do not need to match exactly!)

***Answer:***

### 6. Voters at a polling station

Suppose that voters arrive at a polling station at the rate of 120 per hour. For Parts a–c, [give the name and parameter(s) of the distribution]{.underline} to be used to model the event and [set up the expression]{.underline} to find the specified probability. *You do not need to compute the probability in Parts a–c.*

#### Part a

The probability that the next voter will arrive in less than 30 seconds.

***Answer:***

#### Part b

The probability that exactly 200 voters will arrive in a two-hour period.

***Answer:***

#### Part c

The probability that the $50^{th}$ voter will arrive between 15 and 30 minutes from now.

***Answer:***

#### Part d

Use R to compute the probabilities you set up in Parts a–c.

-   *Hint:* Use `pexp()` (Lesson 13), `dpois()` (Lesson 12), and `pgamma()` (Lesson 13). Make sure the rate is in the same time units as the times in your expression (for example, 120 voters per hour is 2 voters per minute).

***Answer:***

```{r}
#| label: "q6d-probs"

# Your code here

```

### 7. Pizza delivery

Suppose that the times until Hector, Ivan, and Jacob's pizzas arrive are independent exponential RVs $X$, $Y$, and $Z$, each with an average of 20 minutes.

#### Part a

Find the probability that none of the waiting times exceed 20 minutes, i.e., find $P(\max(X, Y,Z) \leq 20)$.

-   *Hint:* The longest wait is 20 minutes or less only if *all three* waits are 20 minutes or less. Then use independence.

***Answer:***

#### Part b

Simulate 10,000 nights of pizza delivery to check your answer to Part a.

**Step 1: Set up.** This chunk is done for you. Run it before the others.

```{r}
#| label: "q7b-setup"

set.seed(8484)    # so you get the same "random" nights each time
reps <- 10000     # number of simulated nights
n_people <- 3     # Hector, Ivan, and Jacob
```

**Step 2: Simulate.** Simulate the waiting time for each person on each night.

-   *Hint:* Follow "Gamma as a sum of exponentials: simulate" in Lesson 13. Start with `expand_grid(sim = 1:reps, person = 1:n_people)`, then use `mutate()` to make a column `wait` with `rexp(n(), rate = 1/20)`. Here `n()` is the number of rows, so each person gets their own wait. Try `reps <- 5` first and print the table to see what it looks like.

***Answer:***

```{r}
#| label: "q7b-simulate"

# Your code here

```

**Step 3: Find the longest wait for each night.** Then approximate $P(\max(X, Y,Z) \leq 20)$.

-   *Hint:* Use `group_by(sim)` and `summarise(longest = max(wait))`. Then use `summarise()` with `mean(longest <= 20)`.

***Answer:***

```{r}
#| label: "q7b-longest"

# Your code here

```

Is your simulated answer close to your answer in Part a? (They do not need to match exactly!)

***Answer:***

### 8. Blood pressure

Suppose that systolic blood pressure (SBP, in mmHg) among adults in a community is $X \sim \text{Normal}(120, 15^2)$.

#### Part a

What is the probability that an adult's SBP is above 140 mmHg?

-   *Hint:* The Normal CDF has no closed form, so use `pnorm()` like the high temperature example in Lesson 13. R uses `sd` $= \sigma = 15$, **not** the variance.

***Answer:***

```{r}
#| label: "q8a-pnorm"

# Your code here

```

#### Part b

Find the SBP value $t$ where 90% of adults have an SBP at $t$ or lower.

-   *Hint:* Use `qnorm()`.

***Answer:***

```{r}
#| label: "q8b-qnorm"

# Your code here

```

#### Part c

What is the probability that an adult's SBP is between 110 and 130 mmHg?

***Answer:***

```{r}
#| label: "q8c-pnorm"

# Your code here

```

#### Part d

Let $Z = \dfrac{X - 120}{15}$. Find $\mathbb{E}[Z]$ and $Var(Z)$.

-   *Hint:* Write $Z = aX + b$ with $a = \frac{1}{15}$ and $b = -\frac{120}{15}$. Then use $\mathbb{E}[aX+b]$ (Lesson 10) and $Var(aX+b)$ (Question 3). This is how we get the standard Normal in Lesson 13.

***Answer:***

#### Part e

Simulate the SBP of 10,000 adults to check your answers to Parts a–c.

-   *Hint:* Follow "High temperature: simulate it" in Lesson 13. Start with `tibble(sim = 1:reps)`, then use `mutate()` with `rnorm(n(), mean = 120, sd = 15)`. Then use `summarise()` with `mean(X > 140)`, `quantile(X, 0.9)`, and `mean(X >= 110 & X <= 130)`.

***Answer:***

```{r}
#| label: "q8e-simulate"

set.seed(9191)
reps <- 10000

# Your code here

```

Are your simulated answers close to your answers in Parts a–c? (They do not need to match exactly!)

***Answer:***

### 9. Reference table of distributions

Let's create a reference table for the important distributions. Fill out the following table and save it for future reference. The first row is done for you.

| RV / Distribution | Type | Parameters | Possible values of $X$ | pmf / pdf | Mean $\mathbb{E}[X]$ | Variance $Var(X)$ |
|:-----------------------|:----------|:----------|:------------|:-------------|:----------|:----------|
| **Bernoulli** | Discrete | $p$ | $x = 0, 1$ | $p^x(1-p)^{1-x}$ | $p$ | $p(1-p)$ |
| **Binomial** |  |  |  |  |  |  |
| **Geometric** |  |  |  |  |  |  |
| **Negative Binomial** |  |  |  |  |  |  |
| **Hypergeometric** |  |  |  |  |  |  |
| **Poisson** |  |  |  |  |  |  |
| **Discrete Uniform** |  |  |  |  |  |  |
| **Continuous Uniform** |  |  |  |  |  |  |
| **Exponential** |  |  |  |  |  |  |
| **Gamma** |  |  |  |  |  |  |
| **Normal** |  |  |  |  |  |  |

***Answer:***

### 10. Relationships between distributions

It is also important to know how different RVs/distributions relate to one another. In the following web, please fill in the relationships between each distribution. You can recreate the web or you can write out the relationships in a numbered list.

```{mermaid}
%%| fig-width: 6.5

graph TD
    
    %% Define Node Styles
    classDef discrete fill:#D6EAF8,stroke:#5DADE2,color:#333
    classDef continuous fill:#D5F5E3,stroke:#58D68D,color:#333

    %% === NODES ===
    
    %% Discrete Distributions
    Bern(Bernoulli)
    Geo(Geometric)
    Bin(Binomial)
    NegBin(Negative Binomial)
    Hyper(Hypergeometric)
    Pois(Poisson)
    
    %% Continuous Distributions
    Exp(Exponential)
    Gam(Gamma)
    Norm(Normal)
    Chi(Chi-Squared)
    
    %% === CONNECTIONS ===
    Bern -- "1" --> Geo
    Bern -- "2" --> Bin
    Pois -- "3" --> Bin
    Bin -- "9" --> Hyper
    Norm -- "4" --> Bin
    Norm -- "5" --> Chi
        
    Geo -- "8" --> NegBin
    Pois -- "7" --> Exp
    Gam -- "6" --> Exp



    %% Apply Styles
    class Bern,Bin,Geo,NegBin,Hyper,DiscUnif,Pois discrete
    class ContUnif,Exp,Gam,Norm,Chi continuous
```

***Answer:***

## Extra problems

**You do NOT need to complete the extra problems!**

### 1. Variance of an exponential RV

Let $f_X(x)=\lambda e^{-\lambda x}$ for $x>0$, where $\lambda>0$.

#### Part a

Show $Var(X)=\dfrac{1}{\lambda^2}$. You may use the result from class for $\mathbb{E}[X]$ without first proving it.

-   *Hint:* Start by finding $\mathbb{E}[X^2]$. You will need integration by parts (Lesson 10, Example 6) twice.

#### Part b

Now let $\lambda = 0.5$. Simulate 10,000 values of $X$ and check that your simulated mean and variance are close to $\mathbb{E}[X] = \dfrac{1}{\lambda}$ and $Var(X) = \dfrac{1}{\lambda^2}$.

-   *Hint:* Use the code from Lesson 10 ("Picking up our exponential simulation from Lesson 9"), but change $\lambda$ from 2 to 0.5. With $\lambda = 0.5$, the inverse CDF is $x = -\ln(1-u)/0.5$. In R, $\ln$ is `log()`. Then use `summarise()` like in Question 1.

Use `set.seed(5151)` and `reps <- 10000` so your answers match the solutions.

### 2. Shipping containers (revisited)

A shipping company handles containers in three different sizes: (1) 27 $ft^3$ (3 x 3 x 3), (2) 125 $ft^3$, and (3) 512 $ft^3$. Let $X_i$ ($i = 1, 2, 3$) denote the number of type $i$ containers shipped during a given week. Suppose that $\mu_1 =200,\sigma_1=10,\mu_2 =250,\sigma_2=12,\mu_3 =100,\sigma_3=8$.

#### Part a

Assuming that $X_1,X_2,X_3$ are independent, calculate the variance of the total volume shipped.

#### Part b

Would your calculation necessarily be correct if the $X_i$'s were not independent? Explain. How is this different from your answer for the expected value in Homework 4?

### 3. The sample mean (revisited)

Let $\overline{X}$ be the random variable for the sample mean, $\overline{X}=\dfrac{\sum_{i=1}^nX_i}{n}$, where the $X_i$ are i.i.d. random variables with common mean $\mu$ and variance $\sigma^2$. In Homework 4, you found $\mathbb{E}[\overline{X}]$. Find $Var(\overline{X})$.

### 4. The sample proportion (revisited)

Let $\hat{p}$ be the random variable for the sample proportion, $\hat{p}=\dfrac{X}{n}$, where $X$ is the number of successes in a random sample of size $n$. Assume the probability of success is $p$. Find $Var(\hat{p})$.

### 5. Sum of binomials

Let $X_i\sim \text{Binomial}(n_i,p)$ be independent RVs for $i=1,\ldots,m$.

#### Part a

What does the RV $X=\sum_{i=1}^mX_i$ count, and what is the distribution of $X$? Make sure to specify the parameters of $X$'s distribution.

#### Part b

Find $\mathbb{E}[X]$. *Make sure to show your work for Parts b and c. However, you may use without proof what you know about the mean and variance of each* $X_i$.

#### Part c

Find $Var(X)$.
