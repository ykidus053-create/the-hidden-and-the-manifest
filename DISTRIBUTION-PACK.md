# Distribution pack — repositories, metadata and identifiers

**Date:** 2026-11-02 · **Book:** *The Hidden and the Manifest*, Kidus Yared, Clausery, first edition MMXXVI
**Live site:** `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`
**File to upload:** `/home/user/getclausery.github.io/book/site-dist/the-hidden-and-the-manifest.pdf`
(314 pages, 1,550,722 bytes; verification build ends 161/161 checks passed)

`book/MARKETING.md` §7 calls a DOI the single highest-credibility action in the whole plan: it turns
"a PDF on a website" into "a publication with an identifier". These are copy-paste fields. **Nothing has
been uploaded.** Blanks stay blank.

---

## Guardrails before any upload

* **No ISBN. DOI pending.** Do not paste a placeholder that looks like one. The identifier that exists is
  `urn:uuid:8f3c1a52-6b64-5d1e-9a77-2f4e0c9b7d31`.
* **Licence is the author's decision.** The book's own copyright page says: *"Free to read, copy, and
  distribute, in whole or in part, provided this notice travels with it and any changes are marked as
  changes."* `book/MARKETING.md` §7 suggests a CC licence for Internet Archive — check compatibility with
  that notice before choosing one, and leave the field blank until you have.
* **No authority claims.** Every description must state that this is a theological research project, not
  an authoritative text, with no imprimatur sought or granted.
* **Correct citation.** Use the citation from the book's copyright page (below). `book/PITCH.md` line ~122
  still ends with `getclausery.github.io` — reported to the manuscript chat, not patched here. Do not use it.

> Yared, Kidus. *The Hidden and the Manifest: A Catholic Theology of Manifestation, and How the Church May
> Baptize an Age*. First edition. Clausery, 2026.
> `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`

---

## 1. Academia.edu — verbatim fields from `book/ACADEMIA.md`

**Title**
```
The Hidden and the Manifest: A Catholic Theology of Manifestation, and How the Church May Baptize an Age
```

**Publication name (journal / publisher / book series)**
```
Clausery
```
If the form wants "where it was published" rather than a publisher:
```
Clausery — first edition, self-published research monograph
```

**Other fields:** Year `2026` · Author `Kidus Yared` · Pages `314` · Language `English (en-US)` ·
ISBN/DOI `none` · Identifier `urn:uuid:8f3c1a52-6b64-5d1e-9a77-2f4e0c9b7d31` ·
Link `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`

**Abstract (long, ~250 words)**
```
The manifestation movement is not, in the first place, a set of false beliefs. It is a set of true
observations — attention shapes perception, expectation shapes action, habit hardens into character,
words do things, the interior life is not private — attached to a false engine: a universe that answers
to the intensity of feeling, that has no person at the centre of it, and that bills the sufferer for her
own suffering.

This book takes that grammar as a rival account of reality and does what Thomas Aquinas did with
Aristotle in the thirteenth century: it describes it in its own terms, tests it, refuses what is false,
keeps what is true, and rebuilds the rest inside the faith. It sets out the manifest space's seven rules
and their datable history (Quimby, Evans, Hopkins, Eddy, the Fillmores, Holmes, Goddard, Byrne);
Aquinas's six moves of reconstruction, with the four limits of the analogy stated rather than hidden;
four tests — who is creator, what is nature, what is the cross, and who is this for; fourteen central
claims with fourteen verdicts (four integrate, three correct, seven reject); and a constructive pastoral
programme: six marks of a Catholic practice, four transpositions of the methods people actually use, a
nine-day Novena of Desire, a one-page triage card for the priest in the car park, a thirty-day pilot
with controls, and forty disputed questions where the real argument belongs.

It is a theological research project, not an authoritative text: no imprimatur has been sought or
granted. It was written with the help of the Holy Spirit and is submitted to the Church for correction.
```

**Abstract (short, ~90 words)**
```
Manifestation is not a set of false beliefs but a set of true observations attached to a false engine.
This book does with the manifest space what Aquinas did with Aristotle: it states its grammar in its own
terms, tests every claim, rejects what is false, keeps what is true, and rebuilds the rest inside the
faith — fourteen verdicts, four tests, six marks of a Catholic practice, a nine-day novena, and a
one-page triage card. A theological research project; not authoritative, and offered for correction.
```

**Research interests (priority order)**
```
Catholic Theology
Theology of Grace
Thomas Aquinas
Sacramental Theology
Pastoral Theology
Discernment of Spirits
New Thought Movement
New Age and Alternative Spirituality
Psychology of Religion
Apologetics
Practical Theology
Medieval Scholasticism
```

**Keywords**
```
manifestation, Law of Assumption, Neville Goddard, New Thought, Catholic theology, Thomas Aquinas,
imagination, presumption, discernment of spirits, spiritual narcissism, theology of grace, pastoral
theology, New Age, the Secret
```

**Text field note to paste under the file**
```
Free to read, copy and distribute in whole or in part, provided the copyright notice travels with it and
any changes are marked as changes. Not an official publication of any ecclesiastical authority: no
imprimatur has been sought or granted. Written with the help of the Holy Spirit and submitted to the
Church for correction. Typeset edition, 314 pages, first edition MMXXVI.
```

After uploading, add the book to the profile's "Books" section.

---

## 2. Zenodo — mint the DOI

Fill only what exists; leave the rest blank.

| Field | Value |
|---|---|
| Upload type | `Book` / `Publication` |
| Title | `The Hidden and the Manifest: A Catholic Theology of Manifestation, and How the Church May Baptize an Age` |
| Creator | `Yared, Kidus` |
| Description | the short (~90-word) abstract above, plus the not-authoritative sentence |
| Publication date | `2026` |
| Publisher | `Clausery` |
| Language | `eng` |
| Licence | `[blank — author to choose; see guardrails]` |
| Related identifier | `urn:uuid:8f3c1a52-6b64-5d1e-9a77-2f4e0c9b7d31` (type: `Other`) |
| Alternate URL | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/` |
| Keywords | the keyword list above |
| Notes | `First edition MMXXVI. 75,803 words, 314 pages. No ISBN. No imprimatur sought or granted.` |

When Zenodo issues a DOI, record it here and in `LAUNCH-KIT.md` §2 — and only then submit the record to
Semantic Scholar / Google Scholar. Do not write "DOI pending" into any form as though it were an identifier.

---

## 3. Internet Archive

| Field | Value |
|---|---|
| Title | `The Hidden and the Manifest: A Catholic Theology of Manifestation, and How the Church May Baptize an Age` |
| Creator | `Kidus Yared` |
| Date | `2026` |
| Publisher | `Clausery` |
| Description | short abstract + the not-authoritative sentence + live URL |
| Subject tags | the twelve research interests above |
| Identifier | `urn:uuid:8f3c1a52-6b64-5d1e-9a77-2f4e0c9b7d31` |
| Language | `English` |
| Licence | `[blank — author to choose; check against the book's notice]` |
| Files | the typeset PDF; optionally the EPUB and `LICENSE-BOOK.txt` |

`book/MARKETING.md` §7 notes that a repository copy is citable, mirrored and indexed more reliably than a
GitHub Pages URL. Include the book's `LICENSE-BOOK.txt` so the rights notice travels with the file.

---

## 4. Cataloguing metadata (from `book/PITCH.md` §Metadata)

```
Title:      The Hidden and the Manifest
Subtitle:   A Catholic Theology of Manifestation, and How the Church May Baptize an Age
Author:     Kidus Yared
Imprint:    Clausery
Edition:    first, MMXXVI (2026)
Length:     75,803 words · 40 chapters · 8 appendices · 314 typeset pages at 5.5 × 8.5 in
Typeface:   Crimson Text 11/15
Keywords:   manifestation, law of attraction, Neville Goddard, New Thought, Catholic theology,
            Aquinas, discernment of spirits, providence, novena, pastoral care, spiritual direction
BISAC:      REL010000 RELIGION / Christianity / Catholic
            REL062000 RELIGION / Spirituality
            OCC014000 BODY, MIND & SPIRIT / New Thought
Identifier: urn:uuid:8f3c1a52-6b64-5d1e-9a77-2f4e0c9b7d31
ISBN/DOI:   none / pending
```

---

## 5. Order of operations, and what to log

1. Academia.edu — fields above; add to profile Books.
2. Internet Archive — PDF + `LICENSE-BOOK.txt`; choose a licence that matches the book's notice.
3. Zenodo — mint the DOI; record it in `LAUNCH-KIT.md` §2 and in `PUBLICATION-STATUS.md`.
4. Semantic Scholar / Google Scholar — only after a DOI exists.
5. Log each upload in `outreach-tracker.csv` with the resulting URL and the date.

Do not claim a citation count, a view count, an adoption or a review. Establish a baseline; write `n/a`
where there is no counter rather than estimating.
