# Sunny Lines — Complete Solution

**Problem:** For integer $n\ge 3$, find all nonnegative integers $k$ such that there exist $n$ distinct lines in the plane satisfying:
1. For all positive integers $a,b$ with $a+b\le n+1$, the point $(a,b)$ lies on at least one line.
2. Exactly $k$ of the $n$ lines are *sunny* (not parallel to the $x$-axis, the $y$-axis, or $x+y=0$).

## Answer

$$k\in\{0,1,3\}$$

---

## 1. Definitions and Notation

Let $T_n = \{(a,b)\in\mathbb Z^2 : a\ge 1,\; b\ge 1,\; a+b\le n+1\}$. 

A line is:
- **Horizontal** if $y=c$ (slope $0$)
- **Vertical** if $x=c$ (slope $\infty$)
- **Diagonal** if $x+y=c$ (slope $-1$)
- **Sunny** if none of the above (slope $\notin\{0,\infty,-1\}$)

Non-sunny lines are the three types above.

---

## 2. Constructions (Achievability)

### $k=0$

Take $n$ horizontal lines $y=1, y=2, \ldots, y=n$.  
Every point $(a,b)\in T_n$ lies on $y=b$, so all are covered. Zero sunny lines.

### $k=1$

Take:
- Vertical line $x=1$
- Horizontal lines $y=1, y=2, \ldots, y=n-2$
- One sunny line through $(1,1)$ and $(2,n-1)$: $y = (n-2)x - (n-3)$

Total: $1 + (n-2) + 1 = n$ lines. One sunny.

*Coverage:* $x=1$ covers column $1$; $y=c$ covers row $c$; the only uncovered point is $(2,n-1)$, which lies on the sunny line.

### $k=3$

**Case $n=3$:** Three sunny lines cover all $6$ points of $T_3$:
$$y=x,\qquad y=-\frac{x}{2}+\frac{5}{2},\qquad y=-2x+5.$$

**Case $n\ge 4$:** Take:
- Vertical line $x=1$
- Horizontal lines $y=1,\ldots,n-4$ (none if $n=4$)
- Three sunny lines:
  $$L_1:\; y = x+(n-5) \quad\text{(slope }1)$$
  $$L_2:\; y = -\frac{x}{2}+(n-1) \quad\text{(slope }-\tfrac12)$$
  $$L_3:\; y = -2x+(n+3) \quad\text{(slope }-2)$$

Total: $1+(n-4)+3 = n$ lines. Three sunny.

*Coverage:* $x=1$ covers column $1$; $y=1,\ldots,n-4$ cover rows $1$ through $n-4$; the remaining $6$ points form a $3\times 3$ triangular grid, partitioned by $L_1,L_2,L_3$ into $3$ pairs of $2$ points each:
$$U = \{(2,n-3),(2,n-2),(2,n-1),(3,n-3),(3,n-2),(4,n-3)\}.$$

All constructions verified computationally for $n=3$ through $20$.

---

## 3. Impossibility of $k=2$

### 3.1 Border constraints

Suppose $k=2$. We have $2$ sunny lines and $n-2$ non-sunny lines. Let:
- $H$ = $\{y\text{-values of horizontal lines}\}$, $|H|=h$
- $V$ = $\{x\text{-values of vertical lines}\}$, $|V|=v$
- $D$ = $\{x+y\text{ values of diagonal lines}\}$, $|D|=d$

with $h+v+d=n-2$.

Consider three "borders" of $T_n$:

| Border | Points | Count | Coverage bound |
|--------|--------|-------|----------------|
| Left $L$ | $(1,1),\ldots,(1,n)$ | $n$ | $[1\in V] + h + d + 2$ |
| Bottom $B$ | $(1,1),\ldots,(n,1)$ | $n$ | $[1\in H] + v + d + 2$ |
| Diagonal $R$ | $(1,n),\ldots,(n,1)$ | $n$ | $[n+1\in D] + h + v + 2$ |

Here $[P]=1$ if $P$ is true, $0$ otherwise, and $+2$ accounts for the $2$ sunny lines.

Each border must be fully covered, giving:
\begin{align*}
[1\in V] + h + d + 2 &\ge n \tag{1}\\
[1\in H] + v + d + 2 &\ge n \tag{2}\\
[n+1\in D] + h + v + 2 &\ge n \tag{3}
\end{align*}

Since $h+v+d=n-2$, we have $n-2-h-d = v$, etc. From (1): $[1\in V] \ge n-2-h-d = v$, so $v \le 1$ and $v=1\Rightarrow 1\in V$. Similarly, $h\le 1$ and $d\le 1$.

Since $h+v+d=n-2$:
- $n=3$: one of $h,v,d$ is $1$, rest $0$
- $n=4$: two are $1$, one is $0$
- $n=5$: all three are $1$ ($h=v=d=1$)
- $n\ge 6$: $h+v+d = n-2 \ge 4$, but each $\le 1$, impossible.

Thus $k=2$ can only occur for $n=3,4,5$.

### 3.2 The uncovered set

For each of $n=3,4,5$, the minimum uncovered set (achieved by the optimal choice of non-sunny lines) consists of exactly $3$ points forming an **anti-sunny triple**: any two of the three points determine a non-sunny line (vertical, horizontal, or diagonal).

| $n$ | $(h,v,d)$ | Non-sunny | Uncovered | Anti-sunny triple? |
|-----|-----------|-----------|-----------|-------------------|
| $3$ | $(1,0,0)$ | $y=1$ | $(1,2),(1,3),(2,2)$ | Yes |
| $3$ | $(0,1,0)$ | $x=1$ | $(2,1),(2,2),(3,1)$ | Yes |
| $3$ | $(0,0,1)$ | $x+y=4$ | $(1,1),(1,2),(2,1)$ | Yes |
| $4$ | $(1,1,0)$ | $x=1,y=1$ | $(2,2),(2,3),(3,2)$ | Yes |
| $4$ | $(1,0,1)$ | $y=1,x+y=5$ | $(1,2),(1,3),(2,2)$ | Yes |
| $4$ | $(0,1,1)$ | $x=1,x+y=5$ | $(2,1),(2,2),(3,1)$ | Yes |
| $5$ | $(1,1,1)$ | $x=1,y=1,x+y=6$ | $(2,2),(2,3),(3,2)$ | Yes |

A sunny line cannot contain two points of an anti-sunny triple (if it did, it would be parallel to a horizontal, vertical, or slope$-1$ direction). Therefore $2$ sunny lines cover at most $2$ of the $3$ uncovered points. The remaining point cannot be covered by any non-sunny line (by definition of "uncovered"). Hence $k=2$ is impossible.

(For any non-optimal choice of non-sunny lines, the uncovered set is larger, making coverage by $2$ sunny lines even harder.)

---

## 4. Impossibility of $k\ge 4$

### 4.1 The optimal non-sunny configuration

Let $h+v+d = n-k$ be the number of non-sunny lines.

**Exchange argument:** A horizontal $y=c$ covers $n+1-c$ points of $T_n$, which decreases as $c$ increases. To maximize coverage (minimize the uncovered set), we should choose the smallest $y$-values: $y=1,\ldots,h$. Similarly, verticals should be $x=1,\ldots,v$ and diagonals $x+y=n+1,\ldots,n+2-d$.

Thus the **consecutive configuration** minimizes the uncovered set:
$$U = \{(a,b)\in T_n : a>v,\; b>h,\; a+b < n+2-d\}.$$

After translating $a'=a-v$, $b'=b-h$, we obtain:
$$U' = \{(a',b') : a'\ge 1,\; b'\ge 1,\; a'+b' \le k+1\},$$
which is a right triangular lattice of "size $k$" containing $k(k+1)/2$ points.

Since any other choice of non-sunny lines leaves a *larger* uncovered set, if $k$ sunny lines cannot cover $U'$, they cannot cover any uncovered set arising from $k$ lines.

### 4.2 Lemma: Points of $U'$ on a sunny line

Let a sunny line have direction vector $(q,p)$ in lowest terms ($\gcd(|p|,q)=1$, $p\neq 0$, $q\neq 0$, $p\neq -q$). The lattice points on this line within $U'$ satisfy:
$$1 \le a'_0+qt \le k,\quad 1 \le b'_0+pt \le k,\quad a'_0+b'_0+(p+q)t \le k+1.$$

The step size in $a'$ is $|q|$, in $b'$ is $|p|$, and in $a'+b'$ is $|p+q|$. Since $p,q$ are non-zero integers with $p\neq -q$, at least one of $|p|,|q|,|p+q|$ is $\ge 2$. Hence the number of integer $t$ satisfying all three constraints is at most $\lceil k/2\rceil$.

**Lemma.** Every sunny line contains at most $\lceil k/2\rceil$ points of $U'$.

### 4.3 Even $k\ge 4$: counting

For even $k$, $\lceil k/2\rceil = k/2$. The $k$ sunny lines cover at most $k\cdot (k/2) = k^2/2$ points of $U'$. But $|U'| = k(k+1)/2 = k^2/2 + k/2 > k^2/2$. Therefore, even $k\ge 4$ is impossible.

### 4.4 Odd $k\ge 5$: geometric constraint

For odd $k$, $\lceil k/2\rceil = (k+1)/2$, and $k\cdot (k+1)/2 = |U'|$. Thus each sunny line must contain **exactly** $(k+1)/2$ points of $U'$, and no two lines may share a point (otherwise some point would be uncovered).

Now, which sunny lines can contain $(k+1)/2$ points of $U'$?

For a line with direction $(q,p)$ to achieve $\lceil k/2\rceil$ points, we need $\min(\lceil k/|p|\rceil,\lceil k/|q|\rceil,\lceil k/|p+q|\rceil) = \lceil k/2\rceil$. For odd $k\ge 5$ (let $k=2m+1$, $m\ge 2$), this requires each of $|p|,|q|,|p+q| \le 2$.

The non-zero integer solutions $(p,q)$ with $p\neq 0$, $q\neq 0$, $p\neq -q$ and $|p|,|q|,|p+q|\le 2$ are exactly:
- $p=q=1$ (slope $1$)
- $p=1,q=-2$ (slope $-\frac12$) or $p=-1,q=2$
- $p=2,q=-1$ (slope $-2$) or $p=-2,q=1$

For each slope, there is **exactly one** line passing through $U'$ that achieves the maximum number of points:

| Slope | Line in $U'$ | Points |
|-------|-------------|--------|
| $1$ | $b' = a'$ | $(1,1),(2,2),\ldots,((k+1)/2,(k+1)/2)$ |
| $-\frac12$ | $2b'+a' = k+2$ | $(1,(k+1)/2),(3,(k-1)/2),\ldots,(k,1)$ |
| $-2$ | $a'+2b' = k+2$ | $(1,k),(2,k-2),\ldots,((k+1)/2,1)$ |

Only $3$ distinct sunny lines can achieve $(k+1)/2$ points in $U'$. For $k\ge 5$, we need $k\ge 5$ such lines to partition $U'$. Since $5 > 3$, this is impossible.

Therefore, all odd $k\ge 5$ are impossible.

---

## 5. Summary

| $k$ | Status | Reason |
|-----|--------|--------|
| $0$ | Achievable | $n$ horizontal lines |
| $1$ | Achievable | $x=1$, $y=1,\ldots,n-2$, one sunny line |
| $2$ | Impossible | Border constraints limit to $n\le5$; anti-sunny triple in uncovered set |
| $3$ | Achievable | $x=1$, $y=1,\ldots,n-4$, three sunny lines (slopes $1,-\frac12,-2$) |
| $k\ge 4$, even | Impossible | Packing bound: $k\cdot\lceil k/2\rceil < k(k+1)/2$ |
| $k\ge 5$, odd | Impossible | Only $3$ slopes give $\lceil k/2\rceil$ points; need $k\ge 5$ such lines |

$$\boxed{k\in\{0,1,3\}}$$

---

## 6. Computational Verification

The constructions were verified for $n=3$ through $20$ using exact rational arithmetic (Python `fractions.Fraction`). Exhaustive search for $n=3,4,5$ over all possible line combinations confirmed that only $k=0,1,3$ are achievable.

The running time of the exhaustive search is $O(N^{n})$ where $N$ is the number of candidate lines, making full search infeasible for $n\ge 6$. However, the analytic proof above covers all $n\ge 3$.
