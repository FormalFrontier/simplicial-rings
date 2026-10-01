# Central polynomial simplices

Import `SimplicialRings.CentralPolynomialSimplex` to work with polynomial
simplices over **any unital `Ring R`**, including noncommutative rings and the
zero ring. No `CommRing`, `Nontrivial`, domain, field, or characteristic
hypothesis is required.

## Model and direction of the maps

`CentralPolynomialSimplex.PolyRing R n` is
`AddMonoidAlgebra R (Fin n →₀ ℕ)`. The free indeterminates
`generator n j`, for `j : Fin n`, commute with one another and with all
coefficients, even when the coefficients do not commute with one another.
`coefficient n : R →+* PolyRing R n` is the coefficient inclusion.
`coordinate n : Fin (n + 1) → PolyRing R n` supplies homogeneous coordinates:

* `coordinate n 0 = 1 - ∑ j, generator n j`;
* `coordinate n j.succ = generator n j`;
* `∑ j, coordinate n j = 1` (`coordinate_sum`).

For **every** ordinal arrow `alpha : ⦋m⦌ ⟶ ⦋n⦌`, including those with empty
fibres, `ordinalMap alpha : PolyRing R n →+* PolyRing R m` sends the homogeneous
coordinate `j` to `fiberValue alpha j`, the sum of target coordinates indexed
by the *whole* fibre of `alpha` over `j`. `ordinalMap_coordinate` includes
`j = 0`: this coordinate is reconstructed, not an extra independent variable.
`ordinalMap_id` and `ordinalMap_comp` establish the contravariant simplicial
identities. `coefficientMap_ordinalMap` establishes commutation with any
coefficient ring map, not just inclusions.

The reusable `substitute` helper constructs a ring homomorphism from the
coefficients and *central* images of each free generator into an arbitrary
target ring (possibly of another universe). Its proof uses native
`AddMonoidAlgebra.liftNCRingHom`: centrality verifies commutation against the
entire coefficient image. `hom_ext` is the generator-and-coefficient uniqueness
principle. `fiberValue`, `fiber_sum`, and `ordinalMap_fiberValue` prove the
fibre partitions explicitly rather than assuming the simplicial laws.

## Categorical and polynomial APIs

* `simplex A : SimplicialObject RingCat.{u}` bundles the full simplicial
  object for `A : RingCat.{u}`. `simplexFunctor : RingCat.{u} ⥤
  SimplicialObject RingCat.{u}` also acts on coefficient homomorphisms;
  `simplexFunctor_degree` and `simplexFunctor_ordinal` read back its values.
* `polynomialFunctor : RingCat.{u} ⥤ RingCat.{u}` uses native
  `Polynomial.mapRingHom`. `constantInclusion A` and `evalAtZero A` are maps
  of actual simplicial rings formed by applying `coefficientNatural` to
  native `Polynomial.C` and `Polynomial.constantCoeff`, respectively.
* `constantTransformation : simplexFunctor ⟶ polynomialFunctor ⋙ simplexFunctor`
  and `evaluationTransformation` in the reverse direction are **natural in
  coefficient rings**. `constantInclusion_evalAtZero` and
  `constantTransformation_evaluationTransformation` prove their composite is
  the identity on the original simplicial ring. Their converse composite
  is **not** proved equal to the identity in this base module; the separate
  [homotopy module](CentralPolynomialSimplexHomotopy.md) supplies an explicit
  simplicial homotopy between that composite and the identity.

All definitions and proofs are in a public Lean module; callers may import this
producer directly rather than the aggregate root `SimplicialRings`, which
publicly imports both producers. A private, bare-import example client is
`SimplicialRingsTest.CentralPolynomialSimplex`. It includes arbitrary-ring
examples, the polynomial split, coefficient-map composition, the zero ring,
and the degree-one faces `d₀(t₁)=1` and `d₁(t₁)=0` in degree zero.

For example, with only this producer imported:

```lean
import SimplicialRings.CentralPolynomialSimplex
open CategoryTheory CentralPolynomialSimplex

example (A : RingCat) : constantInclusion A ≫ evalAtZero A = 𝟙 (simplex A) :=
  constantInclusion_evalAtZero A

noncomputable example : PolyRing PUnit 0 →+* PolyRing PUnit 1 :=
  ordinalMap (R := PUnit) (SimplexCategory.σ (0 : Fin 1))
```

From the repository root, after installing the pinned `lean-toolchain` and
fetching the matching mathlib cache (mandatory before Lean/build commands):

```sh
lake exe cache get
lake build SimplicialRings.CentralPolynomialSimplex
lake build SimplicialRingsTest.CentralPolynomialSimplex
lake env lean -DwarningAsError=true SimplicialRings/CentralPolynomialSimplex.lean
lake env lean -DwarningAsError=true SimplicialRingsTest/CentralPolynomialSimplex.lean
```

Both roots include these modules in the default build; the focused commands
above are optional after cache preparation. See
[build and verification](../README.md#build-and-verification) for
revision-specific evidence and [contributors](../CONTRIBUTORS.md) for
original authorship, transfer and independent-review roles. Source-specific
correspondence and coverage decisions remain outside this source-independent
library.
