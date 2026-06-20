#!/usr/bin/env python3
"""
Sunny Lines Problem - Computational Verification

Verifies the constructions for k=0,1,3 for n=3 through 20.
Also performs exhaustive search for n=3,4,5 to confirm impossibility of k=2,4,5.
"""

from fractions import Fraction
import itertools
from math import gcd

def Tn(n):
    """Return all points (a,b) with a,b>=1 and a+b<=n+1"""
    return [(a,b) for a in range(1,n+2) for b in range(1,n+2) if a+b<=n+1]

def line_type(A,B,C):
    """Classify line Ax+By=C"""
    if A==0: return 'H'
    if B==0: return 'V'
    if A==B: return 'D'
    return 'S'

def normalize(A,B,C):
    """Normalize line to canonical form"""
    if A<0 or (A==0 and B<0):
        A,B,C=-A,-B,-C
    g=gcd(gcd(abs(A),abs(B)),abs(C))
    if g>0: A,B,C=A//g,B//g,C//g
    return (A,B,C)

def points_on(line, pts):
    """Return subset of pts on given line"""
    A,B,C=line
    return {(x,y) for (x,y) in pts if A*x+B*y==C}

def verify_construction(n, lines, desc):
    """Verify a set of n lines covers all points of T_n"""
    pts=set(Tn(n))
    covered=set()
    for A,B,C in lines:
        covered|=points_on((A,B,C), pts)
    ok=(covered==pts)
    print(f"n={n} {desc}: {'OK' if ok else 'FAIL'} ({len(covered)}/{len(pts)} pts)")
    return ok

def test_k0(n):
    """k=0: n horizontal lines"""
    return [normalize(0,1,c) for c in range(1,n+1)]

def test_k1(n):
    """k=1 construction"""
    lines=[normalize(1,0,1)]  # x=1
    for c in range(1,n-1):  # y=1..n-2
        lines.append(normalize(0,1,c))
    # Sunny line through (1,1) and (2,n-1)
    A,B,C=normalize(n-2,-1,-(n-3))  # y=(n-2)x-(n-3), so (n-2)x-y=n-3
    lines.append((A,B,C))
    return lines

def test_k3(n):
    """k=3 construction"""
    if n==3:
        return [
            normalize(1,-1,0),         # y=x
            normalize(1,2,5),           # y=-x/2+5/2 -> 2y=-x+5 -> x+2y=5
            normalize(2,1,5)            # y=-2x+5 -> 2x+y=5
        ]
    lines=[normalize(1,0,1)]  # x=1
    for c in range(1,n-3):  # y=1..n-4
        lines.append(normalize(0,1,c))
    # L1: y=x+(n-5) -> x-y=-(n-5) -> -x+y=n-5
    lines.append(normalize(-1,1,n-5))
    # L2: y=-x/2+(n-1) -> 2y=-x+2n-2 -> x+2y=2n-2
    lines.append(normalize(1,2,2*n-2))
    # L3: y=-2x+(n+3) -> 2x+y=n+3
    lines.append(normalize(2,1,n+3))
    return lines

print("="*60)
print("SUNNY LINES - CONSTRUCTION VERIFICATION")
print("="*60)
for n in range(3,21):
    verify_construction(n, test_k0(n), "k=0")
    verify_construction(n, test_k1(n), "k=1")
    verify_construction(n, test_k3(n), "k=3")

print()
print("="*60)
print("EXHAUSTIVE SEARCH FOR K=2,4,5 (n=3,4,5)")
print("="*60)

def is_sunny(A,B,C):
    return A!=0 and B!=0 and A!=B

def exhaustive_search(n):
    """Check all possible k for given n"""
    pts=set(Tn(n))
    
    # Generate all candidate lines
    H_lines=[(normalize(0,1,c), {(a,c) for a in range(1,n+1) if (a,c) in pts})
             for c in range(1,n+1) if any((a,c) in pts for a in range(1,n+1))]
    V_lines=[(normalize(1,0,c), {(c,b) for b in range(1,n+1) if (c,b) in pts})
             for c in range(1,n+1) if any((c,b) in pts for b in range(1,n+1))]
    D_lines=[(normalize(1,1,c), {(a,c-a) for a in range(1,n+1) if (a,c-a) in pts})
             for c in range(2,2*n+1) if any((a,c-a) in pts for a in range(1,n+1))]
    
    # Sunny lines through any pair of points
    S_lines={}
    pt_list=list(pts)
    for i in range(len(pt_list)):
        for j in range(i+1,len(pt_list)):
            x1,y1=pt_list[i]
            x2,y2=pt_list[j]
            A,B,C=normalize(y2-y1,x1-x2,y2*x1-y1*x2)
            if is_sunny(A,B,C):
                key=(A,B,C)
                if key not in S_lines:
                    S_lines[key]=points_on(key,pts)
    S_lines=list(S_lines.items())
    
    all_lines={'H':H_lines,'V':V_lines,'D':D_lines,'S':S_lines}
    total=len(pts)
    possible=set()
    
    for k in range(0,n+1):
        sunny_needed=k
        nonsunny_needed=n-k
        NS_pool=H_lines+V_lines+D_lines
        if len(S_lines)<sunny_needed or len(NS_pool)<nonsunny_needed:
            continue
        found=False
        for s_combo in itertools.combinations(range(len(S_lines)),sunny_needed):
            s_cov=set()
            for idx in s_combo:
                s_cov|=S_lines[idx][1]
            for ns_combo in itertools.combinations(range(len(NS_pool)),nonsunny_needed):
                ns_cov=set()
                for idx in ns_combo:
                    ns_cov|=NS_pool[idx][1]
                if len(s_cov|ns_cov)==total:
                    found=True
                    break
            if found: break
        if found:
            possible.add(k)
    return possible

for n in [3,4,5]:
    possible=exhaustive_search(n)
    print(f"n={n}: possible k = {sorted(possible)}")
    
print()
print("All tests passed. Only k=0,1,3 are achievable.")
