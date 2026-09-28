/-
SPDX-License-Identifier: Apache-2.0
Authors: Formal Frontier Agents
-/
module

import SimplicialRings.CentralPolynomialSimplex

open CategoryTheory CentralPolynomialSimplex

universe u

noncomputable section

variable (R : Type u) [Ring R]

example : SimplicialObject RingCat.{u} := simplexFunctor.obj (RingCat.of R)

example (n : ℕ) : (simplexFunctor.obj (RingCat.of R)).obj
    (Opposite.op (SimplexCategory.mk n)) = RingCat.of (PolyRing R n) :=
  simplexFunctor_degree ..

example (phi : R →+* R) (psi : R →+* R) (n : ℕ) :
    (coefficientMap psi n).comp (coefficientMap phi n) =
      coefficientMap (psi.comp phi) n := coefficientMap_comp phi psi n

example : constantInclusion (RingCat.of R) ≫ evalAtZero (RingCat.of R) =
    𝟙 (simplex (RingCat.of R)) := constantInclusion_evalAtZero _

example : constantTransformation ≫ evaluationTransformation =
    𝟙 (simplexFunctor : RingCat.{u} ⥤ SimplicialObject RingCat.{u}) :=
  constantTransformation_evaluationTransformation

example : (simplexFunctor.obj (RingCat.of R)).δ (0 : Fin 2)
    (generator 1 (0 : Fin 1)) = (1 : PolyRing R 0) := by
  change ordinalMap (R := R) (SimplexCategory.δ (0 : Fin 2))
    (generator 1 (0 : Fin 1)) = 1
  rw [ordinalMap_generator]
  simp [fiberValue, SimplexCategory.δ_zero_eq_const, coordinate_zero]

example : (simplexFunctor.obj (RingCat.of R)).δ (1 : Fin 2)
    (generator 1 (0 : Fin 1)) = (0 : PolyRing R 0) := by
  change ordinalMap (R := R) (SimplexCategory.δ (1 : Fin 2))
    (generator 1 (0 : Fin 1)) = 0
  rw [ordinalMap_generator]
  simp [fiberValue, SimplexCategory.δ]

example (phi : R →+* R) (alpha : SimplexCategory.mk 0 ⟶ SimplexCategory.mk 1) :
    (coefficientMap phi 0).comp (ordinalMap alpha) =
      (ordinalMap alpha).comp (coefficientMap phi 1) :=
  coefficientMap_ordinalMap phi alpha

example : PolyRing PUnit 0 →+* PolyRing PUnit 1 :=
  ordinalMap (R := PUnit) (SimplexCategory.σ (0 : Fin 1))

example : constantInclusion (RingCat.of R) ≫ evalAtZero (RingCat.of R) =
    𝟙 (simplex (RingCat.of R)) := constantInclusion_evalAtZero _
