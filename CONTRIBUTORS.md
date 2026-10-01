# Contributors and provenance

The mathematical Lean declarations, proofs, examples and guides are
AI-assisted Formal Frontier agent work. The original Lean notices credit
`Authors: Formal Frontier Agents`; code and documentation carry the
[Apache-2.0 license](LICENSE). Collective agent credit does not assert sole
Prism authorship, independent human review, an individual copyright holder
or a guarantee of redistribution rights.

- **Original central polynomial simplex:** one Formal Frontier agent authored
  the base [producer](SimplicialRings/CentralPolynomialSimplex.lean), its
  [private example client](SimplicialRingsTest/CentralPolynomialSimplex.lean)
  and the [base guide](docs/CentralPolynomialSimplex.md).
- **Original simplicial homotopy:** a separate Formal Frontier agent execution authored
  the [homotopy producer](SimplicialRings/CentralPolynomialSimplex/Homotopy.lean),
  its [private example client](SimplicialRingsTest/CentralPolynomialSimplex/Homotopy.lean)
  and the [homotopy guide](docs/CentralPolynomialSimplexHomotopy.md).
- **Predecessor assembly and review:** an agent assembled the predecessor;
  a separate agent independently reviewed its mathematics and guide corrections.
  Prism supplied mathematical direction and corrected the homotopy guide's
  zero-ring explanation, then accepted and integrated the predecessor. These
  roles are distinct from original proof authorship.
- **Standalone transfer and review:** an agent packaged the library,
  relocated module imports, adapted the example clients as private bare-import
  modules and updated documentation. The transferred production statements,
  proof bodies, attributes and direct mathlib imports were not new mathematical
  implementations. A distinct agent independently reviewed the destination
  mathematics, API and provenance; Prism made the requested lifecycle-prose
  correction and accepted the contribution. A further independent agent
  reviewed the first release artifacts before Prism's artifact acceptance.
- **Reader cleanup:** an agent revised public prose and aggregate-root
  notices with input from an independent read-only documentation survey. This
  editorial work is not original mathematical authorship or a review of itself.

The mathematical background includes the algebraic simplex and simplicial
homotopy discussion in Charles A. Weibel's *The K-book*, Chapter IV, §11.
That is motivation, not the origin of the Lean expression or a claim that the
chapter is fully formalized. No book pages or third-party Lean proof bodies are
bundled. Imported mathematical infrastructure, including native homotopy and
whiskering, belongs to pinned mathlib and retains its own authorship and license
in that dependency. Source-specific correspondence and exact internal
contribution/review records are kept separately from this reusable library.
