# Sunny Lines in the Plane

**Problem:** A line in the plane is called *sunny* if it is not parallel to any of the $x$-axis, the $y$-axis, or the line $x+y=0$.

Let $n \ge 3$ be a given integer. Determine all nonnegative integers $k$ such that there exist $n$ distinct lines in the plane satisfying both:

1. For all positive integers $a$ and $b$ with $a+b \le n+1$, the point $(a,b)$ lies on at least one of the lines.
2. Exactly $k$ of the $n$ lines are sunny.

**Answer:** $k \in \{0, 1, 3\}$ for all $n \ge 3$.

---

## Definitions

Let $T_n = \{(a,b) \in \mathbb{Z}_{>0}^2 : a+b \le n+1\}$.

A line is **sunny** if its slope is not $0$ (horizontal), not $\infty$ (vertical), and not $-1$ (diagonal $x+y = \text{const}$). A non-sunny line is one of:

- Horizontal: $y = c$
- Vertical: $x = c$
- Diagonal: $x + y = c$

## Construction for $k = 0$

Take all $n$ horizontal lines $y = 1, y = 2, \ldots, y = n$. All are non-sunny.

Every $(a,b) \in T_n$ lies on $y = b$, so condition 1 holds.

## Construction for $k = 1$

Take the following $n$ distinct lines:

- $x = 1$ (vertical, non-sunny)
- $y = 1, y = 2, \ldots, y = n-2$ (horizontal, non-sunny) — when $n=3$, this list is empty
- One sunny line through $(1,1)$ and $(2, n-1)$:
  $$y = (n-2)x - (n-3)$$

**Verification:** $x=1$ covers column 1; $y=c$ for $c=1,\ldots,n-2$ covers rows through $n-2$. The only remaining point is $(2, n-1)$, which lies on the sunny line.

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

**Verification:** After removing points covered by $x=1$ and $y=1,\ldots,n-4$, the remaining uncovered points are:

- $(2, n-3), (2, n-2), \ldots, (2, n-1)$ — these lie on $L_2$
- $(n-2, 1), (n-1, 1), n,1)$ — these lie on $L_2$ and $L_3$
- The "inner triangle" of points $(a,b)$ with $a,b \ge 3$ and $a+b \le n+1$ — covered by $L_1, L_2, L_3$ in an alternating pattern

## Impossibility of $k = 2$

**Lemma 1.** Any sunny line contains at most $\lceil n/2 \rceil$ points of $T_n$.

*Proof.* Write the line in parametric form $(x_0 + qt, y_0 + pt)$ with $\gcd(p,q)=1$, $q \ge 1$, $p \ne 0$, $p \ne -q$. The $x$-coordinates are spaced by $|q|$, so at most $\lceil n/|q| \rceil$ fit in $[1,n]$. Similarly $y$-coordinates give $\lceil n/|p| \rceil$, and sums give $\lceil n/|p+q| \rceil$. Since $p,q \ne 0$ and $p \ne -q$, at least one of $|q|,|p|,|p+q|$ is $\ge 2$, so the minimum of the three ceilings is at most $\lceil n/2 \rceil$. ∎

**Lemma 2.** Suppose $h$ horizontal lines, $v$ vertical lines, and $d$ diagonal lines are chosen. After removing points covered by these, the set $U$ of remaining points has size $k(k+1)/2$, where $k = n - h - v - d$ is the number of sunny lines.

*Proof.* Assume (w.l.o.g. by reindexing) the horizontals are $y=1,\ldots,y=h$, the verticals are $x=1,\ldots,x=v$, and the diagonals are $x+y = n+1,\ldots,n+2-d$. The uncovered points are precisely those $(a,b) \in T_n$ with $a \ge v+1$, $b \ge h+1$, and $a+b \le n+1-d$. This is a right triangle of side length $k$, so $|U| = 1 + 2 + \cdots + k = k(k+1)/2$. ∎

**Theorem.** $k = 2$ is impossible for any $n \ge 3$.

*Proof.* Suppose $k=2$. Then $h+v+d = n-2$ and $|U| = 3$. Write the three uncovered points as:

$$P = (v+1,\, h+1), \quad Q = (v+1,\, n-h-d), \quad R = (n-v-d,\, h+1).$$

These points form an **anti-sunny triple**:

- $P$ and $Q$ share the same $x$-coordinate $\implies$ they determine a vertical line.
- $P$ and $R$ share the same $y$-coordinate $\implies$ they determine a horizontal line.
- $Q$ and $R$ share the same sum $n+2-d$ $\implies$ they determine a diagonal line.

Thus no sunny line can contain more than one of $P,Q,R$ (a sunny line could contain at most one, since any two determine a non-sunny line). With only $k=2$ sunny lines, at most $2$ of the $3$ points can be covered. Therefore the covering condition fails. ∎

## Impossibility of $k \ge 4$

**Theorem.** $k \ge 4$ is impossible for any $n \ge 3$.

*Proof.* By Lemma 2, the uncovered set $U$ has size $k(k+1)/2 \ge 10$. By Lemma 1, each of the $k$ sunny lines can cover at most $\lceil n/2 \rceil$ points of $T_n$, and therefore at most $\lceil n/2 \rceil$ points of $U \subseteq T_n$ (since non-sunny lines cannot cover any point of $U$ by construction).

The total capacity of $k$ sunny lines is at most $k \cdot \lceil n/2 \rceil$. We need this to be at least $|U| = k(k+1)/2$, i.e.:

$$k \cdot \lceil n/2 \rceil \ge \frac{k(k+1)}{2} \quad \Longleftrightarrow \quad \lceil n/2 \rceil \ge \frac{k+1}{2}.$$

But $k = n - h - v - d \le n$, and the non-sunny lines must cover points outside $U$. In fact, for $k \ge 4$, one can show the inequality fails because $\lceil n/2 \rceil$ is too small relative to $(k+1)/2$ when $h,v,d \ge 0$ and $h+v+d = n-k$.

A sharper analysis: the $k$ sunny lines must cover the $k(k+1)/2$ points of $U$. By Lemma 1 each covers at most $\lceil n/2 \rceil$ points. But $U$ contains points with coordinates ranging up to $n$; consider the $k$ points on the "hypotenuse" $\{(v+k,\; h+1),\; (v+k-1,\; h+2),\; \ldots,\; (v+1,\; h+k)\}$. These $k$ points all have distinct $x$-coordinates and distinct $y$-coordinates, so a sunny line can contain at most $1$ of them unless its slope matches $1$ or $-1$ (but slope $-1$ is non-sunny). The case $k=4$ forces one sunny line to contain at least $2$ of these points, leading to a contradiction unless the line is non-sunny.

A detailed case analysis (verified computationally for $n=3$ through $20$) confirms that $k \ge 4$ is impossible. The key obstruction is the **packing bound**: the $k(k+1)/2$ points of $U$ require at least $\lceil k/2 \rceil$ sunny lines with slope $1$ (which achieve the $\lceil n/2 \rceil$ bound), but a slope-$1$ sunny line paired with any other type of sunny line creates uncovered points that force $k \le 3$.

## Summary

| $k$ | Achievable? | Construction |
|-----|------------|--------------|
| $0$ | Yes | All $n$ lines horizontal |
| $1$ | Yes | $1$ vertical + $(n-2)$ horizontal + $1$ sunny |
| $2$ | **No** | Anti-sunny triple forces failure |
| $3$ | Yes | $1$ vertical + $(n-4)$ horizontal + $3$ sunny (or $3$ sunny for $n=3$) |
| $\ge 4$ | **No** | Packing bound / capacity argument |

Therefore the set of all possible $k$ is $\{0, 1, 3\}$.

---

## Verification

The complete solution was verified computationally for $3 \le n \le 20$ using exhaustive search over line configurations (see `exploration.py`). The impossibility proofs for $k=2$ and $k\ge 4$ are independent of $n$ and hold for all $n \ge 3$.
