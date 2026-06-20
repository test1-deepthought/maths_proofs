# AIME 2024 — Complete Problem Set with Solutions

All 30 problems from AIME I and AIME II 2024, sourced from the Hugging Face dataset
[Maxwell-Jia/AIME_2024](https://huggingface.co/datasets/Maxwell-Jia/AIME_2024) (MIT License).

---

## 2024-I-1: Aya's Walk

Every morning Aya goes for a 9-kilometer-long walk and stops at a coffee shop afterwards. When she walks at a constant speed of $s$ kilometers per hour, the walk takes her 4 hours, including $t$ minutes spent in the coffee shop. When she walks $s+2$ kilometers per hour, the walk takes her 2 hours and 24 minutes, including $t$ minutes spent in the coffee shop. Suppose Aya walks at $s+\frac{1}{2}$ kilometers per hour. Find the number of minutes the walk takes her, including the $t$ minutes spent in the coffee shop.

**Solution:** $\frac{9}{s} + t = 4$ in hours and $\frac{9}{s+2} + t = 2.4$ in hours. Subtracting the second from the first: $\frac{9}{s} - \frac{9}{s+2} = 1.6$. Multiplying by $s(s+2)$: $18 = 1.6s^2 + 3.2s$. Multiplying by $\frac52$: $4s^2 + 8s - 45 = 0$. Factoring: $(2s-5)(2s+9)=0$, so $s=2.5$. Then $t=0.4$ hours. With $s+\frac12 = 3$ km/h, $\frac{9}{3} + 0.4 = 3.4$ hours = 204 minutes.

**Answer:** 204

---

## 2024-I-2: Logarithmic System

There exist real numbers $x$ and $y$, both greater than 1, such that $\log_x(y^x)=\log_y(x^{4y})=10$. Find $xy$.

**Solution:** Simplify to $x\log_xy=4y\log_yx=10$. So $x\log_xy=10$ and $4y\log_yx=10$. Multiplying: $4xy(\log_xy\log_yx)=100$. Since $\log_ab\cdot\log_ba=1$, $4xy=100$, so $xy=25$.

**Answer:** 25

---

## 2024-I-3: Alice and Bob Token Game

Alice and Bob play a game with $n$ tokens. Alice goes first. On each turn, the player removes either 1 or 4 tokens. Whoever removes the last token wins. Find the number of $n\le 2024$ for which Bob has a winning strategy.

**Solution:** Bob wins if $n\equiv 0\pmod5$ or $n\equiv 2\pmod5$. In the first case, Bob complements Alice's move to 5. In the second, Bob maintains $n\equiv2\pmod5$ until 2 tokens remain. Count: $\lfloor2024/5\rfloor=404$ numbers $\equiv0$, and $\lfloor(2024-2)/5\rfloor+1=405$ numbers $\equiv2$, total 809.

**Answer:** 809

---

## 2024-I-4: Lottery Probability

Jen picks 4 distinct numbers from $\{1,\dots,10\}$. Four numbers are randomly chosen from the same set. She wins a prize if at least two of her numbers match the chosen ones, and wins the grand prize if all four match. Given she won a prize, the probability she won the grand prize is $m/n$ in lowest terms. Find $m+n$.

**Solution:** Winning a prize: exactly 2 matches $=\binom42\binom62=90$, exactly 3 $=\binom43\binom61=24$, exactly 4 $=1$, total 115. $P(\text{grand}\mid\text{prize}) = \frac{1/\binom{10}{4}}{115/\binom{10}{4}} = \frac1{115}$. So $1+115=116$.

**Answer:** 116

---

## 2024-I-5: Rectangles with Cyclic Quadrilateral

Rectangles $ABCD$ and $EFGH$ are drawn such that $D,E,C,F$ are collinear. Also, $A,D,H,G$ all lie on a circle. If $BC=16$, $AB=107$, $FG=17$, and $EF=184$, what is the length of $CE$?

**Solution:** Let $O$ be the center of the circle through $A,D,H,G$, and let $P$ and $Q$ be midpoints of $HG$ and $AD$ respectively. Since $OA=OH$, we have $OQ^2+QA^2=OP^2+PH^2$. With $QA=8$, $PH=92$, $OP=DQ+HE=8+17=25$, and $OQ=DE+HP=x+92$, we get $(x+92)^2+8^2=25^2+92^2$. Solving: $(x+92)^2=9025$, so $x+92=95$, i.e., $DE=3$. Hence $CE=CD-DE=107-3=\boxed{104}$.

(Also solvable by Power of a Point: $x(x+184)=17\cdot33=561\Rightarrow x=3$; or by similar triangles $\triangle DHE\sim\triangle GAB$: $\frac{x}{17}=\frac{33}{184+x}\Rightarrow x=3$.)

**Answer:** 104

---

## 2024-I-6: Grid Paths

Consider the paths of length 16 that follow the lines from the lower left corner to the upper right corner on an $8\times 8$ grid. Find the number of such paths that change direction exactly four times.

**Solution:** The path has five segments of alternating direction ($RURUR$ or $URURU$). By symmetry, count one case and multiply by 2. For $URURU$: distribute 8 Up moves into 3 positive parts ($\binom{7}{2}=21$ ways) and 8 Right moves into 2 positive parts ($\binom{7}{1}=7$ ways). So $21 \cdot 7 \cdot 2 = 294$.

**Answer:** 294

---

## 2024-I-7: Maximum Real Part

Find the largest possible real part of $(75+117i)z + \frac{96+144i}{z}$ where $z$ is a complex number with $|z|=4$.

**Solution:** Let $z = a + bi$ with $a^2 + b^2 = 16$. The real part simplifies to $81a - 108b = 27(3a - 4b)$. By Cauchy-Schwarz, the maximum of $3a - 4b$ given $a^2 + b^2 = 16$ is $\sqrt{3^2+(-4)^2} \cdot 4 = 20$. So the maximum real part is $27 \cdot 20 = 540$.

**Answer:** 540

---

## 2024-I-8: Tangent Circles in Triangle

Eight circles of radius 34 are sequentially tangent, and two of the circles are tangent to $AB$ and $BC$ of triangle $ABC$, respectively. 2024 circles of radius 1 can be arranged in the same manner. The inradius of triangle $ABC$ can be expressed as $\frac{m}{n}$, where $m$ and $n$ are relatively prime positive integers. Find $m+n$.

**Solution:** Using similar triangles from both configurations, we get $a+b = \frac{1190}{11}$ where $a,b$ are altitude segments. The inradius $r$ satisfies $r(a+b) = BC = 2\cdot 2022 + 2 + a + b = 4046 + a + b$. So $r = \frac{4046 + (a+b)}{a+b} = \frac{4046}{1190/11} + 1 = \frac{4046 \cdot 11}{1190} + 1 = \frac{44506}{1190} + 1 = \frac{192}{5}$. Thus $192+5=197$.

**Answer:** 197

---

## 2024-I-9: Rhombus on Hyperbola

Let $A$, $B$, $C$, and $D$ be points on the hyperbola $\frac{x^2}{20} - \frac{y^2}{24} = 1$ such that $ABCD$ is a rhombus whose diagonals intersect at the origin. Find the greatest real number that is less than $BD^2$ for all such rhombi.

**Solution:** Assume $AC$ is along the asymptote $y = -\sqrt{5/6}\,x$, minimizing $BD$. Substituting into the hyperbola: $x^2 = 720/11$. Then $BD^2 = 4 \cdot \frac{11}{6} x^2 = 480$. This case cannot be achieved, so all $BD^2 > 480$.

**Answer:** 480

---

## 2024-I-10: Triangle with Tangents

Let $ABC$ be a triangle inscribed in circle $\omega$. Let the tangents to $\omega$ at $B$ and $C$ intersect at point $D$, and let $\overline{AD}$ intersect $\omega$ at $P$. If $AB=5$, $BC=9$, and $AC=10$, $AP$ can be written as $\frac{m}{n}$ where $m$ and $n$ are relatively prime positive integers. Find $m+n$.

**Solution:** By Law of Cosines, $\cos A = 11/25$, $\cos B = 1/15$. From tangency, $\angle CBD = \angle A$, so $CD = \frac{BC/2}{\cos A} = \frac{9/2}{11/25} = \frac{225}{22}$. Then $AD^2 = AC^2 + CD^2 - 2\cdot AC\cdot CD\cdot\cos(A+C) = 100 + (225/22)^2 + 2\cdot10\cdot(225/22)\cdot(1/15) = \frac{5^4\cdot13^2}{484}$, so $AD = \frac{25\cdot13}{22}$. By Power of a Point, $DP\cdot AD = CD^2$, giving $DP = \frac{25\cdot81}{13\cdot22}$. Then $AP = AD - DP = \frac{100}{13}$, so $100+13=113$.

**Answer:** 113

---

## 2024-I-11: Octagon Coloring Probability

Each vertex of a regular octagon is independently colored either red or blue with equal probability. The probability that the octagon can then be rotated so that all of the blue vertices end up at positions where there were originally red vertices is $\tfrac{m}{n}$, where $m$ and $n$ are relatively prime positive integers. What is $m+n$?

**Solution:** Valid configurations require $b \le 4$ blue vertices. If $b \le 3$: any configuration works, $\sum_{i=0}^3 \binom{8}{i} = 93$. If $b = 4$: count by adjacent vertices: 0 adjacent (2 ways), 1 adjacent (8 ways), 2 adjacent (4 ways), 3 adjacent (8 ways), total 22. Overall valid = 115. Total configurations = $2^8 = 256$. So probability = $115/256$, and $115+256 = 371$.

**Answer:** 371

---

## 2024-I-12: Graph Intersections

Define $f(x)=||x|-\tfrac12|$ and $g(x)=||x|-\tfrac14|$. Find the number of intersections of the graphs of $y=4g(f(\sin(2\pi x)))$ and $x=4g(f(\cos(3\pi y)))$.

**Solution:** Let $h(x)=4g(f(x))$. Both functions oscillate between 0 and 1. $p(x) = h(\sin(2\pi x))$ has 1 period in $[0,1]$, giving 8 zeros and 9 ones (16 half-waves). $q(y) = h(\cos(3\pi y))$ has 1.5 periods, giving 12 zeros and 13 ones (24 half-waves). The number of intersections in $(0,1)\times(0,1)$ is $16 \cdot 24 = 384$. One extra intersection occurs at $(1,1)$, giving 385 total.

**Answer:** 385

---

## 2024-I-13: Prime Powers

Let $p$ be the least prime number for which there exists a positive integer $n$ such that $n^4+1$ is divisible by $p^2$. Find the least positive integer $m$ such that $m^4+1$ is divisible by $p^2$.

**Solution:** $n^4 \equiv -1 \pmod{p}$ implies $\text{ord}_p(n) = 8$, so $8 \mid p-1$. The smallest such prime is $p=17$, and $2^4+1=17$. Using LTE, $17^2 \mid 2^{4\cdot 17} + 1$, so the possible $n$ are $2^{17}, 2^{51}, 2^{85}, 2^{119}$ modulo $17^2$. Computing, $2^{51} \equiv 110 \pmod{289}$ is the least.

**Answer:** 110

---

## 2024-I-14: Tetrahedron Inradius

Let $ABCD$ be a tetrahedron such that $AB=CD=\sqrt{41}$, $AC=BD=\sqrt{80}$, and $BC=AD=\sqrt{89}$. There exists a point $I$ inside the tetrahedron such that the distances from $I$ to each of the faces are all equal. This distance can be written as $\frac{m\sqrt{n}}{p}$. Find $m+n+p$.

**Solution:** Using the formula for isosceles tetrahedron volume: $V = \sqrt{\frac{(a^2+b^2-c^2)(b^2+c^2-a^2)(a^2+c^2-b^2)}{72}}$. Each face has equal area $A = 6\sqrt{21}$. Since $V = \frac{4AR}{3}$ where $R$ is the inradius, we get $R = \frac{20\sqrt{21}}{63}$. So $20 + 21 + 63 = 104$.

**Answer:** 104

---

## 2024-I-15: Rectangular Boxes in Sphere

Let $\mathcal{B}$ be the set of rectangular boxes with surface area 54 and volume 23. Let $r$ be the radius of the smallest sphere that can contain each of the rectangular boxes that are elements of $\mathcal{B}$. The value of $r^2$ can be written as $\frac{p}{q}$. Find $p+q$.

**Solution:** With dimensions in the form $p/q$, $q/r$, $r$, we get $p=23$. Solving $23(r^2+q)/qr + q = 27$ gives $q=4$, then $23/r + 4 + 23r/4 = 27$ gives $r=2$. The space diagonal squared is $L^2+b^2+h^2 = (23/4)^2 + (4/2)^2 + 2^2 = 529/16 + 4 + 4 = (529+128)/16 = 657/16$, so $r^2 = (657/16)/4 = 657/64$. So $657+64 = 721$.

**Answer:** 721

---

## 2024-II-1: Four-Item Ownership

Among the 900 residents of Aimeville, there are 195 who own a diamond ring, 367 who own a set of golf clubs, and 562 who own a garden spade. In addition, each of the 900 residents owns a bag of candy hearts. There are 437 residents who own exactly two of these things, and 234 residents who own exactly three of these things. Find the number of residents of Aimeville who own all four of these things.

**Solution:** Let $w,x,y,z$ be residents who own 1, 2, 3, 4 items respectively. Then $w+x+y+z=900$ and total items = $w+2x+3y+4z = 195+367+562+900 = 2024$. With $x=437$, $y=234$, we get $w+z=229$ and $w+4z=448$. Solving: $z=73$.

**Answer:** 73

---

## 2024-II-2: List with Mode and Median

A list of positive integers has the following properties: The sum of the items in the list is 30. The unique mode of the list is 9. The median of the list is a positive integer that does not appear in the list itself. Find the sum of the squares of all the items in the list.

**Solution:** The median not appearing implies an even-sized list. For size 4: two 9s and two distinct numbers summing to 12. The median must be an integer not in the list, so the two numbers must be 5 and 7. Sum of squares = $5^2+7^2+9^2+9^2 = 25+49+81+81 = 236$.

**Answer:** 236

---

## 2024-II-3: 2x3 Grid Digit Placement

Find the number of ways to place a digit in each cell of a 2x3 grid so that the sum of the two numbers formed by reading left to right is 999, and the sum of the three numbers formed by reading top to bottom is 99.

**Solution:** With grid $\begin{smallmatrix} a & b & c \\ d & e & f \end{smallmatrix}$, we have $c+f=9$, $b+e=9$, $a+d=9$, and $10(a+b+c)+(9-a+9-b+9-c)=99$, giving $a+b+c=8$. By stars and bars, $\binom{8+3-1}{3-1} = \binom{10}{2} = 45$.

**Answer:** 45

---

## 2024-II-4: Logarithmic System

Let $x,y$ and $z$ be positive real numbers that satisfy: $\log_2(x/yz) = 1/2$, $\log_2(y/xz) = 1/3$, $\log_2(z/xy) = 1/4$. Then the value of $|\log_2(x^4y^3z^2)|$ is $m/n$ where $m,n$ are relatively prime. Find $m+n$.

**Solution:** Let $a=\log_2 x$, $b=\log_2 y$, $c=\log_2 z$. Then $a-b-c=1/2$, $-a+b-c=1/3$, $-a-b+c=1/4$. Solving: $a=-7/24$, $b=-9/24$, $c=-5/12$. Then $|4a+3b+2c| = |4(-7/24)+3(-9/24)+2(-5/12)| = |(-28-27-20)/24| = 75/24 = 25/8$. So $25+8=33$.

**Answer:** 33

---

## 2024-II-5: Equilateral Hexagon

Let ABCDEF be a convex equilateral hexagon in which all pairs of opposite sides are parallel. The triangle whose sides are extensions of segments AB, CD, and EF has side lengths 200, 240, and 300. Find the side length of the hexagon.

**Solution:** By constructing a scaled diagram and using the parallel relationships, the hexagon side length is found to be 80.

**Answer:** 80

---

## 2024-II-6: Bob's Set Count

Alice chooses a set $A$ of positive integers. Then Bob lists all finite nonempty sets $B$ of positive integers with the property that the maximum element of $B$ belongs to $A$. Bob's list has 2024 sets. Find the sum of the elements of A.

**Solution:** If $k \in A$, the number of sets with maximum $k$ is $2^{k-1}$. So 2024 must be a sum of powers of $2$. $2024 = 2^{10} + 2^9 + 2^8 + 2^7 + 2^6 + 2^5 + 2^3$, corresponding to elements $11, 10, 9, 8, 7, 6, 4$, whose sum is 55.

**Answer:** 55

---

## 2024-II-7: Four-Digit Number Divisible by 7

Let $N$ be the greatest four-digit positive integer with the property that whenever one of its digits is changed to 1, the resulting number is divisible by 7. Let $Q$ and $R$ be the quotient and remainder when $N$ is divided by 1000. Find $Q+R$.

**Solution:** For $N=\overline{abcd}$, changing each digit to 1 gives $N \equiv 1000(a-1) \equiv 100(b-1) \equiv 10(c-1) \equiv d-1 \pmod{7}$. Using $1000 \equiv 6$, $100 \equiv 2$, $10 \equiv 3 \pmod{7}$, casework yields $N=5694$. Then $5694 = 5\cdot1000 + 694$, so $Q+R = 5+694 = 699$.

**Answer:** 699

---

## 2024-II-8: Torus and Sphere Tangency

Torus $T$ is the surface produced by revolving a circle with radius 3 around an axis in the plane of the circle that is a distance 6 from the center of the circle. Let $S$ be a sphere with radius 11. When $T$ rests on the inside of $S$, it is internally tangent to $S$ along a circle with radius $r_i$, and when $T$ rests on the outside of $S$, it is externally tangent to $S$ along a circle with radius $r_o$. Find $r_i - r_o$.

**Solution:** Using similar triangles: For internal tangency, $\frac{6}{11-3} = \frac{r_i}{11}$, so $r_i = \frac{33}{4}$. For external tangency, $\frac{6}{11+3} = \frac{r_o}{11}$, so $r_o = \frac{33}{7}$. Then $r_i - r_o = \frac{33}{4} - \frac{33}{7} = \frac{99}{28}$, so $99+28=127$.

**Answer:** 127

---

## 2024-II-9: Grid Chip Placement

There is a collection of 25 indistinguishable white chips and 25 indistinguishable black chips. Find the number of ways to place some of these chips in the 25 unit cells of a $5\times5$ grid such that: each cell contains at most one chip; all chips in the same row and column have the same colour; any additional chip placed would violate the previous conditions.

**Solution:** By casework on the number of black chips in the first column (5,4,3,2,1), each case gives counts: $1 + 75 + 150 + 150 + 75 = 451$. Multiply by 2 for symmetry (reversing colors) gives 902.

**Answer:** 902

---

## 2024-II-10: Triangle with Circumcenter and Incenter

Let $\triangle ABC$ have circumcenter $O$ and incenter $I$ with $\overline{IA} \perp \overline{OI}$, circumradius 13, and inradius 6. Find $AB \cdot AC$.

**Solution:** By Euler's formula $OI^2 = R(R-2r) = 13(13-12) = 13$. By Pythagoras, $AI^2 = 13^2 - 13 = 156$. Let $AI$ meet the circumcircle again at $M$. Then $I$ is the midpoint of $AM$, and $M$ is the midpoint of $II_a$ where $I_a$ is the $A$-excenter. So $AI = IM = MI_a = \sqrt{156}$, and $AB \cdot AC = AI \cdot AI_a = 3 \cdot AI^2 = 3 \cdot 156 = 468$.

**Answer:** 468

---

## 2024-II-11: Nonnegative Integer Triples

Find the number of triples of nonnegative integers $(a,b,c)$ satisfying $a+b+c=300$ and $a^2b + a^2c + b^2a + b^2c + c^2a + c^2b = 6,\!000,\!000$.

**Solution:** The second equation simplifies to $300(ab+bc+ac) - 3abc = 6,\!000,\!000$, or $100(ab+bc+ac) - abc = 2,\!000,\!000$. Note that $(100-a)(100-b)(100-c) = 1,\!000,\!000 - 10,\!000(a+b+c) + 100(ab+bc+ac) - abc = 0$. So at least one of $a,b,c$ equals 100. Counting all triples where at least one equals 100 gives $3 \times 201 - 2 = 601$ (subtract 2 for overcounting $(100,100,100)$).

**Answer:** 601

---

## 2024-II-12: Family of Unit Segments

Let $O(0,0)$, $A(\tfrac12,0)$, and $B(0,\tfrac{\sqrt3}{2})$ be points in the coordinate plane. Let $\mathcal{F}$ be the family of segments $\overline{PQ}$ of unit length lying in the first quadrant with $P$ on the $x$-axis and $Q$ on the $y$-axis. There is a unique point $C$ on $\overline{AB}$, distinct from $A$ and $B$, that does not belong to any segment from $\mathcal{F}$. Find $OC^2$.

**Solution:** Line $AB$: $y = -\sqrt3 x + \frac{\sqrt3}{2}$. A segment with $P=(a,0)$, $Q=(0,b)$, $a^2+b^2=1$, has equation $ay+bx=ab$. Finding $C$ such that this holds only for $a=1/2$ leads to $x=1/8$, $y=3\sqrt3/8$. Then $OC^2 = (1/8)^2 + (3\sqrt3/8)^2 = 7/16$, so $7+16=23$.

**Answer:** 23

---

## 2024-II-13: 13th Root of Unity

Let $\omega \neq 1$ be a 13th root of unity. Find the remainder when $\prod_{k=0}^{12}(2 - 2\omega^k + \omega^{2k})$ is divided by 1000.

**Solution:** Rewrite as $\prod_{k=0}^{12}(r-\omega^k)(s-\omega^k)$ where $r,s$ are roots of $x^2-2x+2=0$. This equals $\frac{r^{13}-1}{r-1} \cdot \frac{s^{13}-1}{s-1}$. The denominator $(r-1)(s-1)=1$ by Vieta. The numerator $2^{13} - (r^{13}+s^{13}) + 1 = 8192 - (-128) + 1 = 8321$, so remainder is 321.

**Answer:** 321

---

## 2024-II-14: Base-b Beautiful Integers

Let $b \ge 2$ be an integer. Call a positive integer $n$ $b$-eautiful if it has exactly two digits when expressed in base $b$, and these two digits sum to $\sqrt{n}$. Find the least integer $b \ge 2$ for which there are more than ten $b$-eautiful integers.

**Solution:** Writing $n = (xy)_b = bx + y$ with $x+y = \sqrt{n}$, we get $(x+y)^2 = bx + y$, which rearranges to $z(z-1) = (b-1)x$ where $z=x+y$. For each factorization of $b'=b-1$, the number of solutions equals $2^n$ where $n$ is the number of distinct prime factors of $b'$. Need $2^n > 10$, so $n=4$. The smallest $b'$ with 4 distinct primes is $2\cdot3\cdot5\cdot7=210$, so $b=211$.

**Answer:** 211

---

## 2024-II-15: Rectangles in Dodecagon

Find the number of rectangles that can be formed inside a fixed regular dodecagon (12-gon) where each side of the rectangle lies on either a side or a diagonal of the dodecagon.

**Solution:** Count by slope cases: $k = 0, \tan30^\circ, \tan60^\circ$ give $54$ rectangles each ($3 \times 54 = 162$). $k = \tan15^\circ, \tan45^\circ, \tan75^\circ$ give $51$ rectangles each ($3 \times 51 = 153$). Total = $162 + 153 = 315$.

**Answer:** 315

---

## Bonus: Consecutive Integer Sums (Dataset ID: 2024-I-5, Duplicate Entry)

*This problem appears in the Hugging Face dataset with ID "2024-I-5" (Row 4), but the correct AIME 2024 I Problem 5 is the Rectangles problem above. This problem's true AIME identity could not be externally verified; it is preserved here as found in the source dataset.*

It is known that 2024 can be expressed as a sum of 16 consecutive positive integers. What is the largest number of consecutive positive integers whose sum is 2024?

**Solution:** For $k$ consecutive integers starting at $a$, sum $= k(2a + k - 1)/2 = 2024$, so $k(2a + k - 1) = 4048 = 2^4 \cdot 11 \cdot 23$. We need $k \mid 4048$ and $(4048/k - k + 1)$ even. Valid $k$: 1, 11, 16, 23. The largest is 23, corresponding to $77 + 78 + \cdots + 99 = 2024$.

**Answer:** 23