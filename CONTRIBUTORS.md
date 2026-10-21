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
- **Mathematical direction and guide corrections:** Prism supplied mathematical
  direction and corrected the homotopy guide's zero-ring explanation. These
  contributions are distinct from original proof authorship.
- **Assembly and packaging:** AI contributors assembled the library, relocated
  module imports, adapted the example clients as private bare-import modules
  and updated documentation. Production statements, proof bodies, attributes
  and direct mathlib imports remain credited to their original contributors;
  packaging is not new mathematical implementation.
- **Independent review:** Other AI contributors reviewed the mathematics,
  guide corrections, API, provenance and packaging.
- **Reader documentation:** Prism contributed editorial corrections. Other AI
  contributors revised public prose and aggregate-root notices, with input from
  an independent read-only documentation survey. This editorial work is distinct
  from original mathematical authorship.

The mathematical background includes the algebraic simplex and simplicial
homotopy discussion in Charles A. Weibel's *The K-book*, Chapter IV, §11.
That is motivation, not the origin of the Lean expression or a claim that the
chapter is fully formalized. No book pages or third-party Lean proof bodies are
bundled. Imported mathematical infrastructure, including native homotopy and
whiskering, belongs to pinned mathlib and retains its own authorship and license
in that dependency.
