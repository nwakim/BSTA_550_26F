# Draws lessons/img_slides/distribution_relationships.png
# Re-render (from this folder):  python3 distribution_relationships.py distribution_relationships.png 130
# Needs matplotlib and the Lato font. Adapted from Leemis (1986).
import sys
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.patches import FancyBboxPatch, FancyArrowPatch
from matplotlib import font_manager as fm

for f in fm.findSystemFonts():
    if "lato" in f.lower() and f.endswith(".ttf"): fm.fontManager.addfont(f)
plt.rcParams.update({"font.family": "Lato", "mathtext.fontset": "cm"})

TEAL, TEAL_L = "#20c997", "#d4f4ea"
RED, RED_L   = "#d9534f", "#f9e0df"
GREEN, INK   = "#006a4e", "#3a3a3a"
W, H = 30.8, 13.4
fig, ax = plt.subplots(figsize=(W, H), dpi=150)
ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off")

NAME, LABEL = 29, 24          # font sizes: box text, line labels
BW, BH = 3.2, 1.35            # box size (wide boxes get +WIDE)
WIDE = 1.05
WIDE_BOXES = ("nb", "dunif", "z", "hyper")
c = [2.6, 8.4, 14.2, 19.9, 27.0]   # column centers
rA, rB, rC, rD = 11.9, 8.7, 5.3, 1.7
N = {
 "hyper": (c[3], rA, "Hypergeometric", r"$(M,\ N,\ n)$", "d"),
 "bern":  (c[4], rA, "Bernoulli", r"$(p)$", "d"),
 "dunif": (c[0], rB, "Discrete Uniform", r"$(N)$", "d"),
 "nb":    (c[1], rB, "Negative Binomial", r"$(p,\ r)$", "d"),
 "geo":   (c[2], rB, "Geometric", r"$(p)$", "d"),
 "pois":  (c[3], rB, "Poisson", r"$(\lambda)$", "d"),
 "binom": (c[4], rB, "Binomial", r"$(n,\ p)$", "d"),
 "unif":  (c[0], rC, "Uniform", r"$[a,\ b]$", "c"),
 "gam":   (c[1], rC, "Gamma", r"$(r,\ \lambda)$", "c"),
 "expo":  (c[2], rC, "Exponential", r"$(\lambda)$", "c"),
 "norm":  (c[4], rC, "Normal", r"$(\mu,\ \sigma^2)$", "c"),
 "z":     (c[4], rD, "Standard Normal", r"$(0,\ 1)$", "c"),
 "chi":   (18.0, rD, "Chi-squared", r"$(n)$", "c"),
 "f":     (11.8, rD, "F", r"$(n,\ m)$", "c"),
}
def bw(k): return BW + (WIDE if k in WIDE_BOXES else 0)

for k,(x,y,name,par,t) in N.items():
    ec, fc = (TEAL, TEAL_L) if t=="d" else (RED, RED_L)
    ax.add_patch(FancyBboxPatch((x-bw(k)/2, y-BH/2), bw(k), BH, boxstyle="round,pad=0.02,rounding_size=0.2",
                 lw=4, ec=ec, fc=fc, zorder=3))
    ax.text(x, y+0.25, name, ha="center", va="center", fontsize=NAME, color="#111", zorder=4)
    ax.text(x, y-0.29, par, ha="center", va="center", fontsize=NAME, color="#111", zorder=4)

def edge_pt(k, toward):
    x,y = N[k][0], N[k][1]
    hw, hh = bw(k)/2 + 0.07, BH/2 + 0.07
    dx, dy = toward[0]-x, toward[1]-y
    s = min(hw/abs(dx) if dx else 1e9, hh/abs(dy) if dy else 1e9)
    return (x+dx*s, y+dy*s)

def mid(a, b, t=0.5):
    A = edge_pt(a, N[b][:2]); B = edge_pt(b, N[a][:2])
    return (A[0]+(B[0]-A[0])*t, A[1]+(B[1]-A[1])*t)

def lab(x, y, s, color=INK, size=LABEL):
    ax.text(x, y, s, ha="center", va="center", fontsize=size, color=color, zorder=6,
            bbox=dict(boxstyle="round,pad=0.2", fc="white", ec="none", alpha=0.95))

STY = {"solid":"-", "dashed":(0,(6,4)), "dotted":(0,(0.05,1.7))}
def arrow(a, b, style="solid", rad=0.0, dx=0.0, dy=0.0, color=INK, lw=3, head=True):
    pa = (N[a][0], N[a][1]); pb = (N[b][0], N[b][1])
    A = edge_pt(a, pb); B = edge_pt(b, pa)
    A = (A[0]+dx, A[1]+dy); B = (B[0]+dx, B[1]+dy)
    p = FancyArrowPatch(A, B, connectionstyle=f"arc3,rad={rad}",
                        arrowstyle="-|>,head_length=0.9,head_width=0.45" if head else "-",
                        mutation_scale=15, lw=lw, color=color, linestyle=STY[style], zorder=2, shrinkA=0, shrinkB=0)
    p.set_capstyle("round"); ax.add_patch(p)

def hpair(a, b, top, bot, top_dx=0.0):        # a -> b on top, b -> a below
    arrow(a, b, dy=0.2); arrow(b, a, dy=-0.2)
    xm = (N[a][0]+N[b][0])/2; y = N[a][1]
    lab(xm+top_dx, y+1.05, top); lab(xm, y-0.8, bot)

def vpair(a, b, left, right):     # a -> b on the left, b -> a on the right
    arrow(a, b, dx=-0.22); arrow(b, a, dx=0.22)
    x = N[a][0]; ym = (N[a][1]+N[b][1])/2
    lab(x-1.1, ym+0.1, left); lab(x+1.35, ym, right)

def loop(k, side, label, lxy):
    x,y = N[k][0], N[k][1]
    hw = bw(k)/2 + 0.07
    if side=="left":
        A, B = (x-hw, y-0.42), (x-hw, y+0.42)
    else:
        A, B = (x+hw, y+0.42), (x+hw, y-0.42)
    ax.add_patch(FancyArrowPatch(A, B, connectionstyle="arc3,rad=-2.1",
                 arrowstyle="-|>,head_length=0.9,head_width=0.45", mutation_scale=15, lw=3.2, color=INK, zorder=2))
    lab(*lxy, label)

# --- solid: special cases and transformations
vpair("bern", "binom", r"$\sum_{i=1}^{n} X_i$", r"$n = 1$")
hpair("geo", "nb", r"$\sum_{i=1}^{r} X_i$", r"$r = 1$", top_dx=0.45)
hpair("expo", "gam", r"$\sum_{i=1}^{r} X_i$", r"$r = 1$")
vpair("norm", "z", r"$\dfrac{X-\mu}{\sigma}$", r"$\mu + \sigma Z$")
loop("pois", "left", r"$\sum X_i$", (c[3]-3.2, rB+0.05))
loop("expo", "right", "min of\nExponentials", (c[2]+4.15, rC))
arrow("z", "chi"); lab((N["z"][0]+N["chi"][0])/2 - 0.4, rD+1.0, r"$\sum_{i=1}^{n} Z_i^2$")
arrow("chi", "f"); lab((N["chi"][0]+N["f"][0])/2, rD+0.95, r"$\dfrac{X_1/n}{X_2/m}$")

# --- dashed: limits
arrow("hyper", "binom", style="dashed"); lab(c[3]+0.55, 10.2, "$p = M/N$,\n$N$ large")
arrow("binom", "pois", style="dashed");  x_, y_ = mid("binom", "pois", 0.62); lab(x_, y_+0.6, "$\\lambda = np$,\n$n$ large, $p$ small")
arrow("binom", "norm", style="dashed");  lab(c[4]+2.2, 7.0, "$\\mu = np$,\n$\\sigma^2 = np(1-p)$,\n$n$ large")
arrow("pois", "norm", style="dashed");   lab(*mid("pois", "norm"), "$\\mu = \\sigma^2 = \\lambda$,\n$\\lambda$ large")

# --- dotted green: discrete <-> continuous analogs (no arrowheads)
for a,b in [("dunif","unif"), ("nb","gam"), ("geo","expo"), ("pois","expo")]:
    arrow(a, b, style="dotted", color=GREEN, lw=4.5, head=False)
for k in ("dunif", "nb", "geo"):
    lab(N[k][0], (rB+rC)/2, "analog", color=GREEN)
lab(c[2]+2.75, 7.05, "counts $\\leftrightarrow$\nwaiting times", color=GREEN)

# --- legend
lx, ly = 0.3, 0.45
ax.add_patch(FancyBboxPatch((lx, ly), 7.6, 2.55, boxstyle="round,pad=0.05,rounding_size=0.15", lw=1.4, ec="#bbbbbb", fc="white", zorder=1))
ax.add_patch(FancyBboxPatch((lx+0.25, ly+1.95), 0.45, 0.32, boxstyle="round,pad=0.01", fc=TEAL_L, ec=TEAL, lw=3))
ax.text(lx+0.9, ly+2.1, "Discrete", fontsize=LABEL, va="center")
ax.add_patch(FancyBboxPatch((lx+3.0, ly+1.95), 0.45, 0.32, boxstyle="round,pad=0.01", fc=RED_L, ec=RED, lw=3))
ax.text(lx+3.65, ly+2.1, "Continuous", fontsize=LABEL, va="center")
for i,(sty,col,txt) in enumerate([("-", INK, "special case or transformation"),
                                  ((0,(6,4)), INK, "limit (approximation)"),
                                  ((0,(0.05,1.7)), GREEN, "discrete $\\leftrightarrow$ continuous analog")]):
    yy = ly + 1.45 - 0.5*i
    ax.plot([lx+0.25, lx+1.35], [yy, yy], ls=sty, color=col, lw=3 if col!=GREEN else 4.5, dash_capstyle="round", solid_capstyle="round")
    ax.text(lx+1.6, yy, txt, fontsize=LABEL-2, va="center", color=col if col==GREEN else "#111")
ax.text(W-0.15, 0.1, "Adapted from Leemis (1986)", ha="right", fontsize=15, color="#777", style="italic")

fig.savefig(sys.argv[1], dpi=int(sys.argv[2]), bbox_inches="tight", pad_inches=0.1, facecolor="white")
