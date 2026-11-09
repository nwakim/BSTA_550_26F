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
W, H = 24.4, 11.2
fig, ax = plt.subplots(figsize=(W, H), dpi=150)
ax.set_xlim(0, W); ax.set_ylim(0, H); ax.axis("off")

BW, BH = 2.7, 1.0          # box size
N = {
 "dunif": (1.9, 8.0, "Discrete Uniform", r"$(N)$", "d"),
 "nb":    (5.9, 8.0, "Negative Binomial", r"$(p,\ r)$", "d"),
 "geo":   (9.9, 8.0, "Geometric", r"$(p)$", "d"),
 "pois":  (13.8, 8.0, "Poisson", r"$(\lambda)$", "d"),
 "binom": (18.2, 8.0, "Binomial", r"$(n,\ p)$", "d"),
 "bern":  (22.4, 8.0, "Bernoulli", r"$(p)$", "d"),
 "hyper": (18.2, 10.4, "Hypergeometric", r"$(M,\ N,\ n)$", "d"),
 "unif":  (1.9, 2.0, "Uniform", r"$[a,\ b]$", "c"),
 "gam":   (5.9, 4.8, "Gamma", r"$(r,\ \lambda)$", "c"),
 "expo":  (10.8, 4.8, "Exponential", r"$(\lambda)$", "c"),
 "norm":  (18.2, 4.8, "Normal", r"$(\mu,\ \sigma^2)$", "c"),
 "z":     (22.4, 4.8, "Standard Normal", r"$(0,\ 1)$", "c"),
 "chi":   (13.4, 1.3, "Chi-squared", r"$(n)$", "c"),
 "f":     (18.8, 1.3, "F", r"$(n,\ m)$", "c"),
}
for k,(x,y,name,par,t) in N.items():
    ec, fc = (TEAL, TEAL_L) if t=="d" else (RED, RED_L)
    bw = BW+0.35 if k in ("nb","dunif","z","hyper") else BW
    ax.add_patch(FancyBboxPatch((x-bw/2, y-BH/2), bw, BH, boxstyle="round,pad=0.02,rounding_size=0.18",
                 lw=3.5, ec=ec, fc=fc, zorder=3))
    ax.text(x, y+0.17, name, ha="center", va="center", fontsize=20, color="#111", zorder=4)
    ax.text(x, y-0.2, par, ha="center", va="center", fontsize=20, color="#111", zorder=4)

def edge_pt(k, toward):
    """point on box boundary of node k in direction of point toward"""
    x,y = N[k][0], N[k][1]
    bw = (BW+0.35 if k in ("nb","dunif","z","hyper") else BW)/2 + 0.06
    bh = BH/2 + 0.06
    dx, dy = toward[0]-x, toward[1]-y
    s = min(bw/abs(dx) if dx else 1e9, bh/abs(dy) if dy else 1e9)
    return (x+dx*s, y+dy*s)

def lab(x, y, s, color=INK, size=16):
    ax.text(x, y, s, ha="center", va="center", fontsize=size, color=color, zorder=6,
            bbox=dict(boxstyle="round,pad=0.18", fc="white", ec="none", alpha=0.95))

def arrow(a, b, style="solid", label=None, lpos=0.5, loff=(0,0), rad=0.0, offset=(0,0), color=INK, lw=2.6, head=True):
    pa = (N[a][0]+offset[0], N[a][1]+offset[1]); pb = (N[b][0]+offset[0], N[b][1]+offset[1])
    A = edge_pt(a, pb); B = edge_pt(b, pa)
    A = (A[0]+offset[0]*0, A[1]); B = (B[0], B[1])
    A = (A[0], A[1]+offset[1]); B = (B[0], B[1]+offset[1])
    ls = {"solid":"-", "dashed":(0,(6,4)), "dotted":(0,(0.05,1.7))}[style]
    p = FancyArrowPatch(A, B, connectionstyle=f"arc3,rad={rad}", arrowstyle="-|>,head_length=0.9,head_width=0.45" if head else "-",
                        mutation_scale=13, lw=lw, color=color, linestyle=ls, zorder=2, shrinkA=0, shrinkB=0)
    p.set_capstyle('round')
    ax.add_patch(p)
    if label:
        mx, my = A[0]+(B[0]-A[0])*lpos, A[1]+(B[1]-A[1])*lpos
        lab(mx+loff[0], my+loff[1], label, color=color if color!=INK else INK)

def loop(k, side, label):
    x,y = N[k][0], N[k][1]
    bw = BW/2 + 0.06
    if side=="top":
        A, B, r = (x-0.5, y+BH/2+0.06), (x+0.5, y+BH/2+0.06), -1.8
        lx, ly = x, y+BH/2+1.25
    else:  # right side
        A, B, r = (x+bw, y+0.3), (x+bw, y-0.3), -1.8
        lx, ly = x+bw+1.75, y
    ax.add_patch(FancyArrowPatch(A, B, connectionstyle=f"arc3,rad={r}", arrowstyle="-|>,head_length=0.9,head_width=0.45",
                                 mutation_scale=13, lw=2.8, color=INK, zorder=2))
    lab(lx, ly, label)

# --- solid: special cases / transformations
def pair(a,b,top,bot,ytop,ybot):
    arrow(a,b, offset=(0, 0.17)); arrow(b,a, offset=(0,-0.17))
    xm=(N[a][0]+N[b][0])/2
    lab(xm, N[a][1]+ytop, top); lab(xm, N[a][1]+ybot, bot)
pair("bern","binom", r"sum of $n$", r"$n = 1$", 0.62, -0.62)
pair("geo","nb", r"sum of $r$", r"$r = 1$", 0.62, -0.62)
pair("expo","gam", r"sum of $r$", r"$r = 1$", 0.62, -0.62)
pair("norm","z", r"$(X-\mu)/\sigma$", r"$\mu + \sigma Z$", 0.62, -0.62)
loop("pois","top", "sum of Poissons")
loop("expo","right", "min of\nExponentials")
arrow("unif","expo", rad=0.18); lab(6.3, 2.05, r"$a=0,\ b=1$:  $-\ln(1-X)/\lambda$")
arrow("gam","chi", rad=0.12, label=r"$r = n/2,\ \lambda = 1/2$", lpos=0.62, loff=(-0.9,-0.55))
arrow("z","chi", rad=-0.08, label=r"sum of $n$ squares", lpos=0.42, loff=(0.5,-0.5))
arrow("chi","f", label=r"$\dfrac{X_1/n}{X_2/m}$", lpos=0.5, loff=(0.2,-0.8))

# --- dashed: limits
arrow("hyper","binom", style="dashed"); lab(20.2, 9.2, r"$p = M/N$, $N$ large")
arrow("binom","pois", style="dashed");  lab(16.0, 7.25, "$\\lambda = np$,\n$n$ large, $p$ small")
arrow("binom","norm", style="dashed");  lab(20.3, 6.4, "$\\mu = np$, $\\sigma^2 = np(1-p)$,\n$n$ large")
arrow("pois","norm", style="dashed", label="$\\mu = \\sigma^2 = \\lambda$,\n$\\lambda$ large", lpos=0.5, loff=(-0.55,-0.25))
arrow("gam","norm", style="dashed", rad=0.26, label=r"$\mu = r/\lambda$, $\sigma^2 = r/\lambda^2$, $r$ large", lpos=0.5, loff=(0.4,-1.75))

# --- dotted green: analogs (no arrowheads)
for a,b,l,lp,lo in [("dunif","unif","analog",0.5,(0,0)),("nb","gam","analog",0.5,(0,0)),
                    ("geo","expo","analog",0.5,(0,0)),("pois","expo","counts $\\leftrightarrow$\nwaiting times",0.5,(0.2,0))]:
    arrow(a,b, style="dotted", color=GREEN, lw=4, head=False, label=l, lpos=lp, loff=lo)

# --- legend
lx, ly = 3.7, 0.95
ax.add_patch(FancyBboxPatch((lx, 0.2), 6.6, 1.45, boxstyle="round,pad=0.05,rounding_size=0.15", lw=1.2, ec="#bbbbbb", fc="white", zorder=1))
ax.add_patch(FancyBboxPatch((lx+0.2, ly+0.38), 0.35, 0.25, boxstyle="round,pad=0.01", fc=TEAL_L, ec=TEAL, lw=2.5))
ax.text(lx+0.7, ly+0.5, "Discrete", fontsize=15, va="center")
ax.add_patch(FancyBboxPatch((lx+2.2, ly+0.38), 0.35, 0.25, boxstyle="round,pad=0.01", fc=RED_L, ec=RED, lw=2.5))
ax.text(lx+2.7, ly+0.5, "Continuous", fontsize=15, va="center")
for i,(ls,c,t) in enumerate([("-",INK,"special case or transformation"),((0,(6,4)),INK,"limit (approximation)"),
                             ((0,(0.05,1.7)),GREEN,"discrete $\\leftrightarrow$ continuous analog")]):
    yy = ly+0.05-0.33*i
    ax.plot([lx+0.2, lx+1.2], [yy, yy], ls=ls, color=c, lw=3 if c!=GREEN else 4, solid_capstyle='round', dash_capstyle='round')
    ax.text(lx+1.4, yy, t, fontsize=15, va="center", color=c if c==GREEN else "#111")
ax.text(W-0.2, 0.05, "Adapted from Leemis (1986)", ha="right", fontsize=12, color="#777", style="italic")

fig.savefig(sys.argv[1], dpi=int(sys.argv[2]), bbox_inches="tight", pad_inches=0.1, facecolor="white")
