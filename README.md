# Simplicial rings: central polynomial simplices

Authors: Formal Frontier Agents.

This Lean library constructs polynomial simplices and an explicit algebraic
simplicial homotopy over **arbitrary unital rings**, including noncommutative and
zero rings. It is a focused starting point for simplicial-ring calculations,
not a general simplicial-ring or algebraic K-theory library. The mathematical
namespace is `CentralPolynomialSimplex`.

## Headline results

- [`PolyRing R n`](SimplicialRings/CentralPolynomialSimplex.lean) has `n` central
  indeterminates over any `Ring R`; homogeneous
  [`coordinate`](SimplicialRings/CentralPolynomialSimplex.lean) values sum to one.
  [`substitute`](SimplicialRings/CentralPolynomialSimplex.lean) evaluates free
  generators at **whole-target-center** elements (a sufficient, not necessarily
  minimal, condition); [`hom_ext`](SimplicialRings/CentralPolynomialSimplex.lean)
  determines ring maps by coefficients and generators.
- [`simplexFunctor`](SimplicialRings/CentralPolynomialSimplex.lean) sends a ring
  to an actual simplicial ring, with contravariant
  [`ordinalMap`](SimplicialRings/CentralPolynomialSimplex.lean) for every ordinal
  arrow, including empty fibres. Polynomial
  [`constantInclusion`](SimplicialRings/CentralPolynomialSimplex.lean) followed
  by [`evalAtZero`](SimplicialRings/CentralPolynomialSimplex.lean) is strictly
  the identity on the unextended simplex; both maps are coefficient-natural.
- [`contraction`](SimplicialRings/CentralPolynomialSimplex/Homotopy.lean) is a
  native seven-identity `SimplicialObject.Homotopy` from evaluation-then-inclusion
  to the identity on the polynomially extended simplex. Its first face is the
  **identity** endpoint and its last face is **evaluation-then-inclusion**;
  [`homotopyMap_natural`](SimplicialRings/CentralPolynomialSimplex/Homotopy.lean)
  handles every unital coefficient map. Whiskering along a supplied covariant
  functor uses mathlib's existing `Homotopy.whiskerRight`, not a new wrapper here.

See the [simplex guide](docs/CentralPolynomialSimplex.md) and
[homotopy guide](docs/CentralPolynomialSimplexHomotopy.md) for the precise
coordinate, degree, face, degeneracy and universe conventions.

## Use

Add the published library to your `lakefile.toml`:

```toml
[[require]]
name = "simplicial-rings"
git = "https://github.com/FormalFrontier/simplicial-rings.git"
rev = "79a68e78417cb591897f5d8cfdb56c81334e365e"
```

The example pins a published release by its full commit. To choose another
release, use its full commit from the GitHub `main` release history. Lake records
the selected commit in `lake-manifest.json`. Use compatible Lean and mathlib pins
across your dependencies;
this library's pins are in [`lean-toolchain`](lean-toolchain) and
[`lake-manifest.json`](lake-manifest.json).

Import `SimplicialRings.CentralPolynomialSimplex` for the basic construction, or
`SimplicialRings.CentralPolynomialSimplex.Homotopy` for the contraction. The
aggregate `SimplicialRings` exports both production modules but no test modules.
This base-module example is included in the private test library:

```lean
import SimplicialRings.CentralPolynomialSimplex
open CategoryTheory CentralPolynomialSimplex

universe u
variable (R : Type u) [Ring R]
noncomputable section

example : constantInclusion (RingCat.of R) ≫ evalAtZero (RingCat.of R) =
    𝟙 (simplex (RingCat.of R)) := constantInclusion_evalAtZero _
```

The following homotopy-module example is likewise in the private tests:

```lean
import SimplicialRings.CentralPolynomialSimplex.Homotopy
open CategoryTheory CentralPolynomialSimplex

universe u
variable {R : Type u} [Ring R]
noncomputable section

example : SimplicialObject.Homotopy
    (evalAtZero (RingCat.of R) ≫ constantInclusion (RingCat.of R))
    (𝟙 (simplex (polynomialFunctor.obj (RingCat.of R)))) :=
  contraction (RingCat.of R)
```

The private examples also cover genuinely noncommuting `2 × 2` integer
matrices, `PUnit` as a zero ring, degree-one faces, degree-zero endpoints,
equality boundaries, coefficient naturality and native whiskering. The zero-ring
case can make the two homotopy endpoints equal; no universally nonidentity map
is claimed. `substitute` asks for values in the entire target center, not just
images commuting with coefficients. The construction does not include
nonunital rings, geometric realization, GL/BGL, KV/KH comparisons or a claim
of complete source formalization.

## Building

Use the pinned `lean-toolchain` (`leanprover/lean4:v4.34.0-rc2`) and the
`lake-manifest.json`-resolved GitHub mathlib revision. Before **any** project
build, fetch and verify the matching precompiled mathlib cache:

```sh
lake exe cache get
lake build SimplicialRings SimplicialRingsTest
```

The two roots are default Lake targets, so `lake build` also builds both.
Do not substitute a full mathlib source rebuild if cache fetching fails.

Build time and memory use depend on the machine, network and cached state; no
fixed runtime or minimum memory requirement is claimed.

Code and docs are licensed under [Apache-2.0](LICENSE). See
[contributors and provenance](CONTRIBUTORS.md) for original Formal Frontier
authorship, mathematical and software contributions, and the relationship to
mathematical background sources.
