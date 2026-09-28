# Contributors and provenance

The mathematical Lean declarations, proof bodies and original examples in this
library are Formal Frontier project work under Apache-2.0; the file headers say
“Authors: Formal Frontier Agents” without asserting unverified rights ownership.
The unmodified Apache-2.0 text is in [LICENSE](LICENSE). No mathematical source
text, original book pages or third-party Lean proof bodies are bundled.

- **Formalization Worker A**, Task
  `hive-request-b60f70daf55d8e8182d3f7a8f5b3c998ffdb8807` (UID
  `a2e99187-43af-450b-968e-cf8d8364ad48`): original central-polynomial
  simplex producer, original example client and base guide.
- **Formalization Worker A**, Task
  `hive-request-c9f39f9778fc200cdd5edd1fdfe6d366d936bb59` (UID
  `a9cdbe08-b671-49dc-9f78-97dcd906a573`): original simplicial homotopy
  producer, original example client and homotopy guide.
- **Prism**, responsible maintainer: mathematical direction, correcting the
  zero-ring explanation in the homotopy guide, accepting and integrating the
  predecessor. **Formalization Worker A** assembled the reviewed predecessor
  files; **Formalization Worker B** independently reviewed the predecessor
  mathematics and guide corrections. These roles are distinct from the original
  authors of the proof bodies.
- **Formalization Worker A**, Task
  `hive-request-21caa5fc9e9924c13d78b08e3554229b6acc453f` (UID
  `0a6ad6b1-ab24-476c-a7ae-7c6f203ad18e`): initial standalone packaging,
  import relocation, private-client adaptation and updated documentation.
  At the initial 2026-09-28 13:08 UTC packaging checkpoint, independent
  destination review was still pending.
- **Formalization Worker B**, Task
  `hive-request-1978a9007bc975fa604df4c3c76fb8dbeace2c5d` (UID
  `de826b06-e115-4c6c-82b7-190996d88fa8`): independent destination review
  of `5b01e10ae51c7550d763d66af72d526dee0e2fdb`, including the successful
  native run 778. Mathematics, API and provenance passed; time-qualified
  lifecycle wording was requested before acceptance. **Prism** supplied that
  editorial correction without changing the mathematical or build inputs.
  Review, maintainer acceptance and official publication are separate decisions.

The exact predecessor is the accepted FormalFrontier/incubator commit
`ebae9ec4b9f04b9174608d5f5701d4c91afee6f3`. Its base and homotopy
producers came from `Incubator/Algebra/CentralPolynomialSimplex.lean` and
`Incubator/Algebra/CentralPolynomialSimplex/Homotopy.lean`; their clients
from the corresponding `IncubatorTest/Algebra/` files; their guides from
`Incubator/Algebra/CentralPolynomialSimplex/README.md` and
`docs/CentralPolynomialSimplexHomotopy.md`. The production proof bodies,
statements, attributes and direct mathlib imports remain unchanged; module
imports were relocated and the example clients became private bare-import
modules. The original `Formal Frontier Agents` credit and SPDX notices remain
on all transferred Lean files. Additional review and source correspondence
records are maintained separately from this reusable library.

Underlying mathematical motivation includes standard algebraic simplex and
simplicial-homotopy constructions, discussed for example in Charles A.
Weibel's *The K-book*, Chapter IV, §11. That reference is mathematical
background, not the origin of the transferred Lean expression and not a claim
that the book or that chapter is fully formalized here. The imported Lean
infrastructure comes from pinned mathlib and retains its own authorship and
license in that dependency; it is not copied into this repository.
