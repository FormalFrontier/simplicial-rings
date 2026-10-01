# Central-polynomial simplicial homotopy

Import `SimplicialRings.CentralPolynomialSimplex.Homotopy`. The module supplies
a combinatorial contraction of the simplicial ring of polynomials with one
additional central variable. It assumes only a unital `Ring R`: coefficients
may be noncommutative, and the zero ring is permitted. The public producer
retains its original mathlib simplicial-homotopy and matrix imports.

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

In degree `n`, the underlying ring is `PolyRing (Polynomial R) n`, with
`n` central simplex generators and an extra central polynomial coefficient
`Polynomial.X`. The degree-raising map `homotopyMap n i`, for
`i : Fin (n + 1)`, fixes constant coefficients; it takes each homogeneous
simplex coordinate through the actual degeneracy `SimplexCategory.σ i` and
sends `X` to

```lean
coefficient (R := Polynomial R) (n + 1) Polynomial.X *
  tail (R := Polynomial R) (n + 1) (i.val + 1)
```

Here `tail n q` sums homogeneous `coordinate n j` with `q ≤ j.val`;
`tail_zero` gives `1` and `tail_empty` gives `0` for `n < q`. Public
`ordinalMap_tail_face` and `ordinalMap_tail_degeneracy` cover **all**
cutoffs and all face/degeneracy indices, including the empty boundaries.
The coordinate-zero formula follows from `coordinate_sum`, not an extra
independent generator. `homotopyCoefficient` uses mathlib's
`Polynomial.eval₂RingHom'` with explicit centrality of the image of `X`;
`homotopyMap` then uses stage-one `substitute` only for central degeneracy
coordinate sums. Thus none of the arguments requires commutative coefficients.

The native `SimplicialObject.Homotopy` has a map family `h` and seven identity-law fields. The ring-map
identities are available as `homotopyMap_face_zero`,
`homotopyMap_face_last`, `homotopyMap_face_before`,
`homotopyMap_face_middle`, `homotopyMap_face_after`,
`homotopyMap_degeneracy_before`, and `homotopyMap_degeneracy_after`.
The middle equality uses the **same** middle face on both sides; each
degeneracy region includes its equality boundary. These equations are
proved on the polynomial coefficient's constants and `X`, and then on
the simplex generators using `polynomialPolyRing_hom_ext` and the native
simplex-category identities. `homotopyMap_natural phi n i` provides
coefficient naturality for every unital `phi : R →+* S`.

At degree zero, `homotopyMap 0 0` takes `X` to `X * t₁`;
`homotopyMap_face_zero 0` gives the first face `X`, while
`homotopyMap_face_last 0` gives the last face `0`. In particular, the
**first** face is the identity endpoint and the **last** face is
`evalAtZero ≫ constantInclusion`. The reverse composite
`constantInclusion ≫ evalAtZero` is strictly the identity on the
unextended simplicial ring; `evalAtZero ≫ constantInclusion` is *not generally*
the identity on the polynomial extension. For nontrivial coefficient rings it
differs from the identity already on `X`, which it kills; for the zero ring
the composite and the identity coincide.

For any supplied covariant `F : RingCat.{u} ⥤ D`, use the existing native
`(contraction A).whiskerRight F` to transport the homotopy to simplicial
objects in `D`. The result is an algebraic combinatorial homotopy, not a
claim about geometric realization, spectra, or topological equivalence.
See the private, bare-import example client
`SimplicialRingsTest.CentralPolynomialSimplex.Homotopy`, including actual
noncommuting integer matrices and `PUnit`. The module is a public mathematics
producer; the example client does not export further API.

From this project's root, prepare the matching precompiled
mathlib cache and run the two focused targets:

```sh
lake exe cache get
lake build SimplicialRings.CentralPolynomialSimplex.Homotopy
lake build SimplicialRingsTest.CentralPolynomialSimplex.Homotopy
```

Both roots include these modules in the default build; the focused commands
above are optional after cache preparation. See
[build and verification](../README.md#build-and-verification) for
revision-specific evidence and [contributors](../CONTRIBUTORS.md) for
original authorship, transfer and independent-review roles. No geometric
realization, K-theoretic comparison or source-coverage decision follows from
the combinatorial algebraic homotopy alone.
