# Chain of Tangent Circles in a Triangle

**Problem:** Eight circles of radius $34$ are sequentially tangent, and two of the circles are tangent to $AB$ and $BC$ of triangle $ABC$, respectively. $2024$ circles of radius $1$ can be arranged in the same manner. The inradius of triangle $ABC$ can be expressed as $\frac{m}{n}$, where $m$ and $n$ are relatively prime positive integers. Find $m+n$.

## Configuration

Consider triangle $ABC$ with inradius $r_{\text{in}}$. A chain of $n$ equal circles of radius $r$ is arranged along side $AC$:

- The first circle is tangent to side $AB$ and side $AC$ (inscribed in angle $A$).
- The last circle is tangent to side $BC$ and side $AC$ (inscribed in angle $C$).
- The $n-2$ intermediate circles are tangent to side $AC$ and to their neighbors.
- All circles are pairwise sequentially tangent (center-to-center distance $=2r$).

## Derivation

Let $S = \cot\frac{A}{2} + \cot\frac{C}{2}$.

**From the tangency geometry:**
The first circle touches $AC$ at distance $r\cot\frac{A}{2}$ from $A$; the last circle touches $AC$ at distance $r\cot\frac{C}{2}$ from $C$. Between these two points lie $n-1$ gaps of length $2r$, so:

$$AC = r\cot\frac{A}{2} + 2r(n-1) + r\cot\frac{C}{2} = 2r(n-1) + rS.$$

**From the inradius formula:**
A standard result gives $AC = r_{\text{in}}(\cot\frac{A}{2} + \cot\frac{C}{2}) = r_{\text{in}}S.$

Equating the two expressions for $AC$:

$$r_{\text{in}}S = 2r(n-1) + rS \quad\Longrightarrow\quad (r_{\text{in}} - r)S = 2r(n-1).$$

Hence $S = \dfrac{2r(n-1)}{r_{\text{in}} - r}$.  

For the two given configurations:

- $(r=34,\;n=8)$: $\displaystyle S = \frac{2\cdot 34 \cdot 7}{r_{\text{in}} - 34} = \frac{476}{r_{\text{in}} - 34}.$
- $(r=1,\;n=2024)$: $\displaystyle S = \frac{2\cdot 1 \cdot 2023}{r_{\text{in}} - 1} = \frac{4046}{r_{\text{in}} - 1}.$

Since $S$ is the same for both (same triangle), equate:

$$\frac{476}{r_{\text{in}} - 34} = \frac{4046}{r_{\text{in}} - 1}.$$

Cross-multiply:

$$476(r_{\text{in}} - 1) = 4046(r_{\text{in}} - 34)$$
$$476r_{\text{in}} - 476 = 4046r_{\text{in}} - 137564$$
$$3570r_{\text{in}} = 137088$$
$$r_{\text{in}} = \frac{137088}{3570} = \frac{192}{5} = 38.4.$$

## Result

The inradius is $\displaystyle\frac{192}{5}$, so $m=192$, $n=5$, and $m+n = 197$.

## Verification

- $r_{\text{in}} = \frac{192}{5}$ gives $S = \frac{476}{38.4-34} = \frac{1190}{11} \approx 108.1818$.
- For $(r=34,n=8)$: $AC = 2\cdot34\cdot7 + 34\cdot\frac{1190}{11} = \frac{45696}{11} \approx 4154.18$.
- For $(r=1,n=2024)$: $AC = 2\cdot1\cdot2023 + 1\cdot\frac{1190}{11} = \frac{45696}{11}$.
- The inradius formula: $r_{\text{in}}S = \frac{192}{5}\cdot\frac{1190}{11} = \frac{45696}{11}$.

All three values coincide, confirming internal consistency.
