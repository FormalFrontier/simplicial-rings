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

## Build and verification

Use the pinned `lean-toolchain` (`leanprover/lean4:v4.34.0-rc2`) and the
`lake-manifest.json`-resolved GitHub mathlib revision. Before **any** project
build, fetch and verify the matching precompiled mathlib cache:

```sh
lake exe cache get
lake build SimplicialRings SimplicialRingsTest
```

The two roots are default Lake targets, so `lake build` also builds both.
Do not substitute a full mathlib source rebuild if cache fetching fails.

Verification history (2026-09-28): at the initial 13:08 UTC packaging checkpoint,
destination build, audit and independent review were still pending. Native CI
run 778 subsequently succeeded at 14:33:38 UTC on
`5b01e10ae51c7550d763d66af72d526dee0e2fdb`: both roots built and all 134 stored
originating declarations, including 25 private declarations and generated
support declarations, had only standard foundational axioms. The roots and
anonymous-example clients were built and inventoried with zero stored own
declarations. Independent review of that revision found the mathematics, API
and provenance sound and requested only time-qualified lifecycle wording.
These are exact-input historical checks, not a claim about arbitrary later
revisions. At this review checkpoint, owner acceptance and the first official
release/publication remained pending; build/review evidence alone is not a
release.

### Expected build cost

As a measured reference, native CI run 781 on 2026-09-28 used the same Lean,
mathlib, library and test inputs as run 778, with only documentation changes.
On the configured Linux x86-64 runner (8 CPUs, 24 GiB memory budget,
`LEAN_NUM_THREADS=2`), fetching the matching official mathlib cache took about
42.9 seconds, its offline no-build readiness check 6.0 seconds, and the
subsequent `lake build SimplicialRings SimplicialRingsTest` 8.1 seconds
(1,442 Lake jobs, including already-cached dependency targets). The six
per-module transitive axiom checks took about 36.3 seconds in total; the
whole CI job took about 136 seconds, including setup and evidence collection.
These are observed elapsed times, not a cold mathlib source-build benchmark
or a performance guarantee. Plan for minutes on comparable hardware with
network access to the official cache; network and machine differences can
dominate. Peak memory was not measured: 24 GiB is the runner's configured
budget, not a measured requirement or a claim that smaller machines fail.

Code and docs are licensed under [Apache-2.0](LICENSE). See
[contributors and provenance](CONTRIBUTORS.md) for original Formal Frontier
authorship, the distinguished transfer and independent review roles, and the
relationship to mathematical background sources.
