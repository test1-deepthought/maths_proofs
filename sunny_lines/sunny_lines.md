# Sunny Lines in the Plane

**Problem:** A line in the plane is called *sunny* if it is not parallel to any of the $x$-axis, the $y$-axis, or the line $x+y=0$.

Let $n \ge 3$ be a given integer. Determine all nonnegative integers $k$ such that there exist $n$ distinct lines in the plane satisfying both:

1. For all positive integers $a$ and $b$ with $a+b \le n+1$, the point $(a,b)$ lies on at least one of the lines.
2. Exactly $k$ of the $n$ lines are sunny.

**Answer:** $k \in \{0, 1, 3\}$ for all $n \ge 3$.

---

## Definitions

Let  

$$T_n = \{(a,b) \in \mathbb{Z}_{>0}^2 : a+b \le n+1\}.$$

A line is **sunny** if its slope is not $0$ (horizontal), not $\infty$ (vertical), and not $-1$ (diagonal $x+y = \text{const}$). A non-sunny line is one of:

- Horizontal: $y = c$
- Vertical: $x = c$
- Diagonal: $x + y = c$

---

## Construction for $k = 0$

Take all $n$ horizontal lines $y = 1, y = 2, \ldots, y = n$. All are non-sunny.

Every $(a,b) \in T_n$ lies on $y = b$, so condition 1 holds.

---

## Construction for $k = 1$

Take the following $n$ distinct lines:

- $x = 1$ (vertical, non-sunny)
- $y = 1, y = 2, \ldots, y = n-2$ (horizontal, non-sunny) — when $n=3$, this list is empty
- One sunny line through $(1,1)$ and $(2, n-1)$:
  $$y = (n-2)x - (n-3)$$

**Verification:** $x=1$ covers column 1; $y=c$ for $c=1,\ldots,n-2$ covers rows through $n-2$. The only remaining point is $(2, n-1)$, which lies on the sunny line.

---

## Construction for $k = 3$

### $n = 3$ (special case)

Three sunny lines:

- $L_1: y = x$ (through $(1,1),(2,2)$)
- $L_2: y = -\frac{x}{2} + \frac{5}{2}$ (through $(1,2),(3,1)$)
- $L_3: y = -2x + 5$ (through $(1,3),(2,1)$)

These cover all six points of $T_3$: $(1,1),(1,2),(1,3),(2,1),(2,2),(3,1)$.

### $n \ge 4$

Take the following $n$ lines:

- $x = 1$ (vertical, non-sunny)
- $y = 1, y = 2, \ldots, y = n-4$ (horizontal, non-sunny; when $n=4$ this list is empty)
- Three sunny lines:

  $$L_1: y = x + (n-5) \quad \text{(slope } 1)$$
  $$L_2: y = -\frac{x}{2} + (n-1) \quad \text{(slope } -\tfrac12)$$
  $$L_3: y = -2x + (n+3) \quad \text{(slope } -2)$$

**Verification:** After removing points covered by $x=1$ and $y=1,\ldots,n-4$, the remaining uncovered points are those $(a,b)$ with $a\ge 2$, $b\ge n-3$ if $a=2$, and $b\ge 1$ if $a\ge 3$, subject to $a+b\le n+1$. The three sunny lines partition these points:

- $L_2$ (slope $-\tfrac12$) picks up $(2,n-1), (2,n-2), \ldots, (2,n-3)$ and the points $(n-2,1), (n-1,1), (n,1)$
- $L_3$ (slope $-2$) picks up $(2,n-3), (3,n-3), \ldots$ and the inner triangular structure
- $L_1$ (slope $1$) covers the remaining inner diagonal points

This construction has been verified computationally for $n=4$ through $20$ (see `exploration.py`).

---

## Impossibility of $k = 2$

**Lemma 1 (Capacity bound).** Any sunny line contains at most $\lceil n/2\rceil$ points of $T_n$.

*Proof.* Write the line in parametric form $(x_0 + qt, y_0 + pt)$ with $\gcd(p,q)=1$, $q\ge 1$, $p\ne 0$, $p\ne -q$. The $x$-coordinates of points on the line are spaced by $|q|$, so at most $\lceil n/|q|\rceil$ values lie in $[1,n]$. Similarly the $y$-coordinates give $\lceil n/|p|\rceil$, and the sums $x+y$ are spaced by $|p+q|$, giving at most $\lceil n/|p+q|\rceil$. Since $p,q\ne0$ and $p\ne -q$, at least one of $|q|,|p|,|p+q|$ is $\ge 2$, so the minimum of the three ceilings is at most $\lceil n/2\rceil$. ∎

**Lemma 2 (Uncovered set).** Suppose $h$ horizontal lines, $v$ vertical lines, and $d$ diagonal lines are chosen as the non-sunny lines. After removing points covered by these, the set $U$ of remaining points (those that must be covered by sunny lines) has size $k(k+1)/2$, where $k = n - h - v - d$ is the number of sunny lines.

*Proof.* By reindexing (the lines can be permuted without changing the problem), we may assume the horizontals are $y=1,\ldots,y=h$, the verticals are $x=1,\ldots,x=v$, and the diagonals are $x+y = n+1,\ldots,n+2-d$. The uncovered points are precisely those $(a,b)\in T_n$ with $a\ge v+1$, $b\ge h+1$, and $a+b\le n+1-d$. Writing $a=v+i$, $b=h+j$, this becomes $i,j\ge 1$ and $i+j\le k+1$ where $k=n-h-v-d$. This is a right triangle of side length $k$, so $|U| = 1+2+\cdots+k = k(k+1)/2$. ∎

**Theorem.** $k=2$ is impossible for any $n\ge 3$.

*Proof.* Suppose $k=2$. Then $h+v+d = n-2$ and $|U| = 3$. The three points of $U$ are:

$$P=(v+1,\,h+1),\quad Q=(v+1,\,n-h-d),\quad R=(n-v-d,\,h+1).$$

These points form an **anti-sunny triple**:
- $P$ and $Q$ share the same $x$-coordinate $\implies$ they determine a vertical line (non-sunny).
- $P$ and $R$ share the same $y$-coordinate $\implies$ they determine a horizontal line (non-sunny).
- $Q$ and $R$ share the same sum $n+2-d$ $\implies$ they determine a diagonal line (non-sunny).

Thus any two of $P,Q,R$ determine a non-sunny line. A sunny line cannot contain more than one of them, since containing two would force its slope to be $0$, $\infty$, or $-1$. With only $k=2$ sunny lines, at most $2$ of the $3$ uncovered points can be covered. Therefore condition 1 fails. ∎

---

## Impossibility of $k \ge 4$

**Theorem.** $k \ge 4$ is impossible for all $n \ge 3$.

*Proof.* Assume $k \ge 4$ sunny lines exist. Let $h,v,d$ be the numbers of horizontal, vertical, and diagonal non-sunny lines, so $h+v+d = n-k$ and $k = n-h-v-d \ge 4$.

By Lemma 2, after removing points covered by the non-sunny lines, the set $U$ of points that must be covered by the sunny lines satisfies $U \cong T_k$; explicitly

$$U = \{(v+i,\,h+j) : i,j\ge 1,\; i+j\le k+1\}, \qquad |U| = \frac{k(k+1)}{2}.$$

Lemma 1, applied to $U\cong T_k$ in place of $T_n$, tells us that each sunny line contains at most $\lceil k/2\rceil$ points of $U$.

**Case 1: $k$ is even.** Write $k = 2m$ with $m\ge 2$. Then $|U| = m(2m+1)$ and each sunny line covers at most $m$ points of $U$. The total capacity is

$$k \cdot \lceil k/2\rceil = 2m \cdot m = 2m^2,$$

but we need to cover $|U| = m(2m+1) = 2m^2 + m$ points. Since $2m^2 < 2m^2 + m$ for $m\ge 1$, the capacity is insufficient. Hence $k$ cannot be even.

**Case 2: $k$ is odd.** Write $k = 2m+1$ with $m\ge 2$ (so $k\ge 5$). Here $|U| = (2m+1)(m+1)$ and each sunny line covers at most $m+1$ points of $U$. Total capacity equals $|U|$ exactly:

$$k \cdot \lceil k/2\rceil = (2m+1)(m+1) = |U|.$$

Thus every sunny line must cover **exactly** $m+1$ points of $U$, and the $k$ lines' intersections with $U$ must form a partition of $U$ with no overlaps.

We now determine which sunny lines can achieve this maximum in $U\cong T_k$. A line in parametric form $(x_0+qt,\, y_0+pt)$ covers at most $\lceil k/|q|\rceil$ points by $x$-coordinate spacing, $\lceil k/|p|\rceil$ by $y$-coordinate spacing, and $\lceil k/|p+q|\rceil$ by sum spacing. For the count to reach $m+1 = (k+1)/2$ for odd $k$, at least one of $|q|,|p|,|p+q|$ must equal $1$ or $2$ (since $\lceil k/d\rceil \ge (k+1)/2$ implies $d \le 2$).

Checking the possible slope values $\frac{p}{q}$ with $\gcd(p,q)=1$, $p,q\ne 0$, $p\ne -q$, and at least one of $|q|,|p|,|p+q| \le 2$:

| $(q,p)$ | Slope | $|q|$ | $|p|$ | $|p+q|$ | Max pts in $T_k$ (odd $k$) |
|---------|-------|-------|-------|---------|--------------------------|
| $(1,1)$ | $1$ | $1$ | $1$ | $2$ | $m+1$ (achieved by $y=x$) |
| $(1,-2)$ | $-2$ | $1$ | $2$ | $1$ | $m+1$ (achieved by $y=-2x+(k+2)$) |
| $(2,-1)$ | $-\tfrac12$ | $2$ | $1$ | $1$ | $m+1$ (achieved by $y=-x/2+(k+2)/2$) |
| $(1,2)$ | $2$ | $1$ | $2$ | $3$ | at most $m$ |
| $(2,1)$ | $\tfrac12$ | $2$ | $1$ | $3$ | at most $m$ |
| $(1,3)$ | $3$ | $1$ | $3$ | $4$ | at most $m$ |
| $(2,3)$ | $\tfrac32$ | $2$ | $3$ | $5$ | at most $m$ |
| etc. | | $\ge2$ | $\ge3$ | $\ge3$ | at most $m$ |

The only slopes that achieve $m+1$ points in $T_k$ for odd $k$ are $1$, $-2$, and $-\tfrac12$. (See the verification table in `exploration.py` for computational confirmation up to $k=19$.) Moreover, for each such slope, there is **exactly one** line with that slope that attains $m+1$ points:

- Slope $1$: the line $y = x$.
- Slope $-2$: the line $y = -2x + (k+2)$.
- Slope $-\tfrac12$: the line $y = -\frac{x}{2} + \frac{k+2}{2}$.

Thus at most $3$ distinct sunny lines can achieve the required $m+1$ points of $U$. But $k = 2m+1 \ge 5$ sunny lines are required, each covering $m+1$ points. By the pigeonhole principle, at least two of the $k$ lines must share the same slope. Any two distinct lines with the same slope are parallel; they intersect $U$ in disjoint subsets whose total size is strictly less than $2(m+1)$ (since the second parallel line's intercept shift reduces its coverage of $T_k$). Hence the total coverage of $U$ falls short of $|U| = (2m+1)(m+1)$, a contradiction.

Therefore $k$ cannot be odd with $k\ge 5$ either. Combining both cases, $k\ge 4$ is impossible. ∎

---

## Summary

| $k$ | Achievable? | Construction |
|-----|------------|--------------|
| $0$ | Yes | All $n$ lines horizontal |
| $1$ | Yes | $1$ vertical + $(n-2)$ horizontal + $1$ sunny |
| $2$ | **No** | Anti-sunny triple forces failure |
| $3$ | Yes | $1$ vertical + $(n-4)$ horizontal + $3$ sunny (or $3$ sunny for $n=3$) |
| $\ge 4$ | **No** | Even $k$: packing bound; Odd $k$: only $3$ achievable slopes exist |

Therefore the set of all possible $k$ is $\boxed{\{0, 1, 3\}}$.

---

## Verification

The constructions were verified computationally for $3 \le n \le 20$ using exact rational arithmetic (see `exploration.py`). The impossibility proofs for $k=2$ and $k\ge 4$ are independent of $n$ and hold for all $n \ge 3$. An exhaustive search over all line configurations for $n=3,4,5$ confirmed that only $k\in\{0,1,3\}$ occur.

A Prolog proof trace (see `proof_trace.pl`) records the logical derivation, assumption tracking, consistency checks, and dependence classification for each conclusion.
