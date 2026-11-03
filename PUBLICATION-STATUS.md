# Publication status — *The Hidden and the Manifest*

**Date:** 2026-11-03 (Africa/Addis_Ababa) — rights revision
**Status:** **PUBLISHED.** The book is live at its own exact address. No remaining human action is needed to
publish it.

| | |
|---|---|
| **Live URL** | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/` |
| **Repo** | `ykidus053-create/the-hidden-and-the-manifest` (exact name, no stray hyphens) |
| **Pages** | `status: built`, `html_url` matches the live URL, source `gh-pages` / `/`, build commit `b24d943`, no build error |
| **Canonical / og:url / sitemap / robots** | all declare the live URL above |

About the book, from the manuscript and its build report: *The Hidden and the Manifest: A Catholic Theology of
Manifestation, and How the Church May Baptize an Age*, by Kidus Yared, imprint Clausery, first edition MMXXVI,
© 2026 Kidus Yared, `urn:uuid:8f3c1a52-6b64-5d1e-9a77-2f4e0c9b7d31`. 6 parts, 40 chapters, 8 appendices
(A–H), 75,803 words, 314 pages, © 2026 Kidus Yared, all rights reserved. It is a **theological research project, not
authoritative teaching**: no *imprimatur* has been sought or granted, it was written with the help of the Holy
Spirit by a researcher, and it is submitted to the Church for correction. No reviews, credentials, endorsements
or sales claims are asserted anywhere in these materials.

---

## What was done

| # | Step | Result |
|---|------|--------|
| 1 | Source repo `getclausery/getclausery.github.io`, branch `arena/09f8871f-getclausery-github-io`, `git pull` | Correct branch, `Already up to date`, HEAD `764c110f`. No other branch created there; nothing pushed to its `main`. |
| 2 | `pip install --break-system-packages reportlab pyphen pymupdf pillow`, then `sh book/publish.sh` | **161/161 checks passed**, exit 0, `all clear.` Working tree clean (`git diff --exit-code` = 0). |
| 3 | `python3 book/make-site.py` | `13 entries at the root, 6.0 MB`; base URL `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`. **18 files** (the brief's "19" is approximate; six social PNGs, not five). |
| 4 | Canonical check | `rel="canonical"`, `og:url`, `sitemap.xml`, `robots.txt` all name the live URL. |
| 5 | Deploy | Site files pushed to the repo's `main` as a fast-forward (`12b1995..c5bf61a`), remote history preserved, no force. A `gh-pages` branch with the identical tree was pushed too. |
| 6 | Turn on Pages | `POST`/`PUT /pages` return 403 for this connection (push access only, no Pages/administration permission), so GitHub's `gh-pages` convention auto-enabled it. After the owner's rename, Pages rebuilt automatically: `status: built`, `html_url` = the clean URL. |
| 7 | Verify live | **All seven required paths verified from the live host** — see below. |

### A note on step 2, honestly

The **first** `sh book/publish.sh` on a fresh clone ended `160/161 checks passed`: one check failed,
`report: page estimate is within two pages of the typeset count — estimate 310, typeset 314`. Cause: on a fresh
sandbox `book/dist/build-report.json` does not exist, so `build.py` falls back to its default words-per-page
ratio (245.5) and advertises 310 pages, while the typeset PDF is 314 pages. The build deliberately measures the
ratio from the previous report, so **running `publish.sh` a second time** (no source edits) converges the
estimate to 314 and ends **161/161 checks passed**, with all editions stating "75,803 words and 314 printed
pages". Nothing in `book/build.py`, `book/verify.py` or the manuscript was changed. Worth telling the manuscript
chat: a clean-slate CI run will show 160/161 unless the report is seeded or the builder warms up.

### The rename, for the record

The repo began as `-the-hidden-and-the-manifest-`. The owner renamed it in Settings in two steps (front hyphen,
then back hyphen), because this chat's GitHub connection can push but returns
`403 Resource not accessible by integration` for every repository-administration route (REST `PATCH`,
`gh repo rename`, GraphQL `updateRepository`). Pages followed each rename automatically, with a fresh build.
Both git remotes (this repo and `book/site-dist`) are now set to
`https://github.com/ykidus053-create/the-hidden-and-the-manifest.git`.

---

## Verification — live, not assumed

Outbound `curl` to `*.github.io` is blocked in this sandbox (DNS resolves, but direct TCP to the Pages IPs times
out), so live verification was done by fetching the live URLs with the page tool, and binary responses through a
text-extraction proxy (`r.jina.ai`) reading the same live URLs. All checks below were made **after** the final
rename, at the clean URL:

```
/                                  ✓ landing page: title, thesis, both Download buttons, the
                                     "not authoritative" paragraph, citation and UUID
/read/                             ✓ full reading edition (58 chunks), Crimson Text declared and embedded
/the-hidden-and-the-manifest.pdf   ✓ live PDF parsed: 314 pages, half-title, copyright, imprint,
                                     contents with all 40 chapters and appendices A–H
/the-hidden-and-the-manifest.epub  ✓ EPUB parsed: title, copyright, 40 chapters, appendices A–H
/cover.jpg                         ✓ live image returned (the book cover)
/social/og-card.png                ✓ live image returned (share card)
/sitemap.xml                       ✓ both canonical URLs — now matching the live URL
/robots.txt                        ✓ Allow: / + matching Sitemap
/triage-card.pdf                   ✓ one-page pastoral card (PDF)
/LICENSE-BOOK.txt                  ✓ plain text served
```

The **Download the PDF** anchor is `<a class="primary"
href="./the-hidden-and-the-manifest.pdf?download" download="The-Hidden-and-the-Manifest.pdf">`; locally
`?download` returns `Content-Disposition: attachment; filename="the-hidden-and-the-manifest.pdf"` (EPUB
likewise), and the landing page also offers "open the PDF in this tab" as the stated iframe fallback. The
reading edition embeds four Crimson Text `@font-face` blocks as base64 `woff2` data URIs (all four decode with
the `wOF2` magic), with zero external font references, so the typeface renders without a network request.

All ten paths also return **200** with correct MIME types against the local preview, and all 18 blobs are
present in the built `gh-pages` tree at their exact sizes (`cover.jpg` 631,380 B, `social/og-card.png`
405,923 B, PDF 1,550,722 B). The only check not obtainable inside this sandbox is the literal
`curl -o /dev/null -w '%{http_code}'` loop against the live host; `verify-live.sh` runs exactly that plus
metadata checks. It passes against the local preview with `CHECK_METADATA=0` — run plain `./verify-live.sh`
from any machine with unrestricted internet for the numeric status codes.

The bundle contains **no `getclausery.github.io` link**; the only Clausery string is the corrections email
address (a contact, not a publication location). The book is at its own address, not a subdirectory of the
product site and not in that site's sitemap. The old double-hyphen address now 404s; the intermediate
`…/the-hidden-and-the-manifest-/` path may still serve a cached copy, so always share the clean URL.

---

## Search Console readiness

The Google HTML verification file is live at
`https://ykidus053-create.github.io/the-hidden-and-the-manifest/google1b6d1c6a6ec1afbf.html`, serving the
exact 53-byte token `google-site-verification: google1b6d1c6a6ec1afbf.html` (no redirect, `.nojekyll` keeps
it verbatim). It was added to the deployed bundle at commit `e9f08ae`, Pages rebuilt `built`, and both `main`
and `gh-pages` carry it. `robots.txt` allows it; there is no `noindex`; canonical, `og:url`, sitemap and
sitemap-in-robots all name the clean URL. The property to add is a **URL prefix**, not a Domain property —
`https://ykidus053-create.github.io/the-hidden-and-the-manifest/` — and the sitemap to submit is
`.../sitemap.xml`. Full steps in `SEARCH-CONSOLE.md`. Indexing is Google's decision; no crawl or ranking is
promised.

---

## Real artifacts

* **The live site:** `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`
* **`verify-live.sh`** — smoke test for all required paths plus canonical/`og:url`/download/sitemap checks
  and the Search Console verification file; `./verify-live.sh`, or
  `CHECK_METADATA=0 ./verify-live.sh http://127.0.0.1:8080/`.
* **`SEARCH-CONSOLE.md`** — Google verification file deployed and serving; the exact URL-prefix property to
  add, the sitemap to submit, and the rebuild caveat.
* **`google1b6d1c6a6ec1afbf.html`** — backup of the 53-byte verification token, restored after any
  `make-site.py` rebuild.
* **`LAUNCH-KIT.md`** — ready-to-use launch package built from `book/PRESS-KIT.md`: verbatim copy blocks,
  quotable lines, editor angles, outreach drafts, live asset inventory, launch-week checklist and guardrails.
  All links point at the live URL; no invented claims; blanks left blank.
* **`MARKETING-CALENDAR.md`** — six-week follow-on with full post copy per chapter, X/Bluesky, LinkedIn,
  Reddit, Instagram/TikTok and parish-bulletin rewrites, weekly log template. Original drafts' unverified
  claims about reception and the author's working life were removed.
* **`OUTREACH-PACK.md`** — five segmented email drafts, follow-ups, a factual press advisory, an interview
  one-pager with "never state on the record" rules, and a corrections log.
* **`DISTRIBUTION-PACK.md`** — copy-paste fields for Academia.edu, Zenodo, Internet Archive and cataloguing
  metadata; ISBN/DOI/licence left blank; correct citation from the copyright page.
* **`outreach-tracker.csv`** — contact log with one real launch-milestone row and empty rows; no invented data.
* **`LAUNCH-EMAIL-DRAFT.md`** — the general announcement email; blanks left blank, no invented claims.
* **Local preview on port 8080** — same bundle, book material only, never the Clausery product site.
* **Push-ready repo** at `/home/user/getclausery.github.io/book/site-dist/` — `main` and `gh-pages` hold the
  identical 18-file tree, remote set to the final repo name.
* **File paths to hand to a reader** (no browser needed): `book/site-dist/the-hidden-and-the-manifest.pdf`
  (314 pp), `the-hidden-and-the-manifest.epub`, `cover.jpg`, `triage-card.pdf`, `read/index.html`.

---

## Optional next moves (nothing blocking publication)

**Decision, 2026-11-02:** asked whether to shorten the URL further (bare root
`https://ykidus053-create.github.io/` via a repo rename, or a custom domain via DNS), the owner chose to
**keep the exact URL**. No rename, no `CNAME`, no rebuild was performed; the site is unchanged and still
`built` at `c5bf61a`. The work moved to the launch instead — see `LAUNCH-KIT.md`.

1. In Settings → Pages, switch the publishing source from `gh-pages` / `/` to `main` / `/` to match the brief
   literally. Both branches carry the identical tree, so the site is unchanged. Do **not** delete `gh-pages`
   while it is the source — that disables Pages.
2. Use `book/PRESS-KIT.md` for the launch; its asset inventory and "what not to say in a pitch" are ready.
3. A custom domain: add `CNAME`, rebuild with `--base-url https://domain/`, add the two DNS records at the
   registrar. Or rename the repo to `ykidus053-create.github.io` for the bare-root address.

---

## Findings to hand back to the manuscript chat (not patched here)

The handoff says the deployment chat owns deployment only, and that anything wrong inside the book or its
imprint line should be **reported**, not patched in isolation, because `book/build.py` and `book/verify.py` are
the single source of truth. Reported, therefore:

1. Clean-slate builds start at **160/161** until `build-report.json` exists (see the step 2 note above).
2. The **press materials still send readers to the Clausery product site**: `book/PRESS-KIT.md` (imprint row
   `Clausery · getclausery.github.io`), `book/MARKETING.md` (lines ~22, ~163, ~194:
   `getclausery.github.io/book/`) and `book/PITCH.md` (line ~122). The book itself is correct — `META['url']`,
   the copyright/imprint rows and the citation all name the live book address. These were corrected in `RIGHTS-CHANGE.patch` (this repo, 2026-11-03); apply that patch in the
   manuscript chat before the launch.
3. `book/site-dist/404.html` (generated by `make-site.py`) has one absolute-root link,
   `<a href="/">Return to the book</a>`. On a GitHub Pages project site that points at the user root, not the
   book; it should be relative. It is the only absolute-root link in the bundle — everything else is relative
   and works under the project path. Minor, but worth fixing in the builder.

---

## Rights revision and marketing batch 2 — 2026-11-03

The author reversed the earlier grant: **"DONT MAKE IT FREE TO COPY MAKE SURE IT HAS COPYRIGHT PROTECTION AND
RIGHTS AND ALSO DO MORE MARKETING ON THE BOOK."** The old *"Free to read, copy and distribute"* notice is gone.
The current, single notice is:

> © 2026 Kidus Yared. **All rights reserved.** No part of this book may be reproduced, distributed, or
> adapted without the author's written permission, except brief quotations in a review with attribution.

**"Free to read" now means access only** — no charge, no account, no email, no card to read the official
editions at the live URL. It is not a licence to copy. Downloading for personal reading is permitted.

| # | What changed | Result |
|---|--------------|--------|
| 1 | `book/build.py` (`META['rights']`, copyright row, colophon), `book/make-pdf.py` (triage-card footer), `book/make-site.py` (LICENSE/README/landing line), `book/landing/index.html`, `book/make-social.py` | All rebuilt with the new notice; captured verbatim in `RIGHTS-CHANGE.patch` (10 source files) |
| 2 | `sh book/publish.sh` | Fresh clone: first pass 160/161 (known page-estimate warm-up), second pass **161/161 checks passed, all clear.** |
| 3 | `python3 book/make-social.py` | Six share cards regenerated with `ALL RIGHTS RESERVED` in the credit line |
| 4 | `python3 book/make-site.py` | `13 entries at the root, 6.0 MB`; Google verification file restored from backup before deploying |
| 5 | Edition-level audit | PDF page 4 copyright page, page 313 colophon, PDF XMP `dc:rights`, EPUB `dc:rights` + `copyright.xhtml`, reading edition, `LICENSE-BOOK.txt`, triage card footer — all carry the notice; no old grant remains |
| 6 | Landing page | `Rights: All rights reserved`, footer notice, `<meta name="copyright">`, `<meta name="rights">`, `<link rel="license">`, and links to `LICENSE-BOOK.txt` |
| 7 | Deploy | `gh-pages` and `main` both at **`b24d943`**; Pages `status: built` at that commit; live landing page, `LICENSE-BOOK.txt`, PDF copyright page and the verification token re-fetched from the host |
| 8 | Previous materials revised | `LAUNCH-EMAIL-DRAFT.md`, `LAUNCH-KIT.md`, `MARKETING-CALENDAR.md`, `OUTREACH-PACK.md`, `DISTRIBUTION-PACK.md`, `PUBLICATION-STATUS.md`, `outreach-tracker.csv` — every free-to-copy grant removed, a rights notice added at the top of each, disclosures now carry the notice |
| 9 | `DISTRIBUTION-PACK.md` | Full-text repository uploads are now permission-gated; metadata-only records are the safe default; no Creative Commons licence; all licence fields blank |
| 10 | `verify-live.sh` | Adds `/LICENSE-BOOK.txt` to the 11 required paths and asserts the rights notice on the landing page and in the terms file, even in local-preview mode |

### New artifacts

- **`PERMISSIONS-POLICY.md`** — the authoritative rights statement: what is permitted, what needs written
  permission, a permission-request template, a polite takedown template, and the honest limits of the notice.
- **`CATALOGUE-SHEET.md`** — metadata-only catalogue record for librarians and indexers, with verified
  descriptions, the citation, and a rights-compliant local note.
- **`MARKETING-BATCH-2.md`** — ten new posts, a five-email announcement sequence, a 40-week chapter-a-week
  series built from the book's own table of contents, a reader FAQ, a share-it-correctly card, and an
  execution checklist. All carry the rights line.

### What was deliberately not done

- **No technical copy protection.** The PDF and EPUB are still downloadable. This is a legal notice and clear
  terms, not a lock. If you want downloads removed, watermarked files or a gated reading room, say so.
- **No formal licence was chosen.** The author did not specify one, so nothing was invented: no Creative
  Commons, no "all rights reserved with exceptions" beyond brief review quotations and personal reading.
  `PERMISSIONS-POLICY.md` says plainly that this is not legal advice.
- **The manuscript prose was not rewritten.** The brief says the book is finished and verified. Three pastoral
  lines still speak of photocopying the triage card (`book/manuscript/apxB.md` lede,
  `03-how-to-read.md` and `ch37.md`). They are narrative, not a licence grant; they are reported here rather
  than patched. Say the word if you want them changed too.
- **The source repo was not pushed.** The workspace reset between turns removed the source clone; it was
  re-cloned on `arena/09f8871f-getclausery-github-io`, edited, rebuilt, and its exact text diff saved as
  `RIGHTS-CHANGE.patch` in this repo so the manuscript chat can apply it. Nothing was pushed to that repo's
  `main`, and no other branch was created there.
- **Earlier copies are outside our control.** PDFs/EPUBs downloaded before 2026-11-03 carry the old notice.
  `PERMISSIONS-POLICY.md` tells holders to follow the current notice on the live site.
- **No invented facts.** No reviews, credentials, endorsements, blurbs, sales claims, ISBN, DOI, imprimatur
  or ecclesiastical approval. Blanks stay blank. The theological-research / no-imprimatur / submitted-for-
  correction line is in every outward document.

Search Console is unaffected: use the URL-prefix property, HTML-file method, click Verify, then submit
`/sitemap.xml`. See `SEARCH-CONSOLE.md`.
