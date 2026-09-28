/-
SPDX-License-Identifier: Apache-2.0
Authors: Formal Frontier Agents
-/
module

import SimplicialRings.CentralPolynomialSimplex.Homotopy

open CategoryTheory CentralPolynomialSimplex

universe u v w

noncomputable section

variable {R : Type u} [Ring R]

example : SimplicialObject.Homotopy
    (evalAtZero (RingCat.of R) ≫ constantInclusion (RingCat.of R))
    (𝟙 (simplex (polynomialFunctor.obj (RingCat.of R)))) :=
  contraction (RingCat.of R)

example : homotopyMap (R := R) 0 (0 : Fin 1)
    (coefficient 0 Polynomial.X) =
      coefficient (R := Polynomial R) 1 Polynomial.X * generator 1 (0 : Fin 1) := by
  rw [homotopyMap_X]
  simp [tail, Fin.sum_univ_succ, coordinate_succ]

example : ((ordinalMap (R := Polynomial R) (SimplexCategory.δ (0 : Fin 2))).comp
      (homotopyMap 0 (0 : Fin 1))) (coefficient 0 Polynomial.X) =
        coefficient (R := Polynomial R) 0 Polynomial.X := by
  rw [homotopyMap_face_zero]
  rfl

example : ((ordinalMap (R := Polynomial R) (SimplexCategory.δ (1 : Fin 2))).comp
      (homotopyMap 0 (0 : Fin 1))) (coefficient 0 Polynomial.X) = 0 := by
  have h : (ordinalMap (R := Polynomial R) (SimplexCategory.δ (1 : Fin 2))).comp
      (homotopyMap 0 (0 : Fin 1)) =
      (coefficientMap (Polynomial.C (R := R)) 0).comp
        (coefficientMap (Polynomial.constantCoeff (R := R)) 0) :=
    homotopyMap_face_last (R := R) 0
  rw [h]
  simp [RingHom.comp_apply, Polynomial.constantCoeff]

example : (ordinalMap (R := Polynomial R)
      (SimplexCategory.δ (0 : Fin 1).castSucc.succ)).comp
      (homotopyMap 1 (0 : Fin 1).succ) =
    (ordinalMap (R := Polynomial R)
      (SimplexCategory.δ (0 : Fin 1).castSucc.succ)).comp
      (homotopyMap 1 (0 : Fin 1).castSucc) :=
  homotopyMap_face_middle (0 : Fin 1)

example : (ordinalMap (R := Polynomial R)
      (SimplexCategory.σ (0 : Fin 1).castSucc)).comp (homotopyMap 0 (0 : Fin 1)) =
    (homotopyMap 1 (0 : Fin 1).succ).comp
      (ordinalMap (SimplexCategory.σ (0 : Fin 1))) :=
  homotopyMap_degeneracy_before (0 : Fin 1) (0 : Fin 1) (le_refl _)

example : (ordinalMap (R := Polynomial R)
      (SimplexCategory.σ (0 : Fin 1).succ)).comp (homotopyMap 0 (0 : Fin 1)) =
    (homotopyMap 1 (0 : Fin 1).castSucc).comp
      (ordinalMap (SimplexCategory.σ (0 : Fin 1))) :=
  homotopyMap_degeneracy_after (0 : Fin 1) (0 : Fin 1) (le_refl _)

example {S : Type v} [Ring S] (phi : R →+* S) (n : ℕ) (i : Fin (n + 1)) :
    (coefficientMap (Polynomial.mapRingHom phi) (n + 1)).comp (homotopyMap n i) =
      (homotopyMap (R := S) n i).comp
        (coefficientMap (Polynomial.mapRingHom phi) n) :=
  homotopyMap_natural phi n i

example {D : Type w} [Category.{v} D] (F : RingCat.{u} ⥤ D) :
    SimplicialObject.Homotopy
      (((SimplicialObject.whiskering RingCat.{u} D).obj F).map
        (evalAtZero (RingCat.of R) ≫ constantInclusion (RingCat.of R)))
      (((SimplicialObject.whiskering RingCat.{u} D).obj F).map
        (𝟙 (simplex (polynomialFunctor.obj (RingCat.of R))))) :=
  (contraction (RingCat.of R)).whiskerRight F

example : SimplicialObject.Homotopy
    (evalAtZero (RingCat.of (Matrix (Fin 2) (Fin 2) ℤ)) ≫
      constantInclusion (RingCat.of (Matrix (Fin 2) (Fin 2) ℤ)))
    (𝟙 (simplex (polynomialFunctor.obj
      (RingCat.of (Matrix (Fin 2) (Fin 2) ℤ))))) :=
  contraction _

example : ¬ ∀ upper lower : Matrix (Fin 2) (Fin 2) ℤ, upper * lower = lower * upper := by
  intro h
  let upper : Matrix (Fin 2) (Fin 2) ℤ :=
    fun row col => if row = 0 ∧ col = 1 then 1 else 0
  let lower : Matrix (Fin 2) (Fin 2) ℤ :=
    fun row col => if row = 1 ∧ col = 0 then 1 else 0
  have h00 := congrArg (fun matrix : Matrix (Fin 2) (Fin 2) ℤ => matrix 0 0)
    (h upper lower)
  rw [(Matrix.two_mul_expl upper lower).1, (Matrix.two_mul_expl lower upper).1] at h00
  simp [upper, lower] at h00

example : SimplicialObject.Homotopy
    (evalAtZero (RingCat.of PUnit) ≫ constantInclusion (RingCat.of PUnit))
    (𝟙 (simplex (polynomialFunctor.obj (RingCat.of PUnit)))) :=
  contraction _
