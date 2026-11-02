# Publication status — *The Hidden and the Manifest*

**Date:** 2026-11-02 (Africa/Addis_Ababa)
**Status:** **LIVE** and fully verified. The owner renamed the repo, but **one character is still wrong**:
the leading hyphen was removed, the trailing hyphen was not.

| | |
|---|---|
| **Live now** | `https://ykidus053-create.github.io/the-hidden-and-the-manifest-/` |
| **Intended address** | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/` — still 404 |
| **Dead, do not share** | `https://ykidus053-create.github.io/-the-hidden-and-the-manifest-/` — 404 after the rename; GitHub Pages did not redirect the old project path |
| **Repo's current name** | `the-hidden-and-the-manifest-` (trailing hyphen) → needs to be `the-hidden-and-the-manifest` |
| **Pages** | `status: built`, commit `c5bf61a`, `html_url` follows the repo name, source `gh-pages` / `/` |

About the book, from the manuscript and its build report: *The Hidden and the Manifest: A Catholic Theology of
Manifestation, and How the Church May Baptize an Age*, by Kidus Yared, imprint Clausery, first edition MMXXVI,
© 2026 Kidus Yared, `urn:uuid:8f3c1a52-6b64-5d1e-9a77-2f4e0c9b7d31`. 6 parts, 40 chapters, 8 appendices
(A–H), 75,803 words, 314 pages, free to read, copy and distribute. It is a **theological research project, not
authoritative teaching**: no *imprimatur* has been sought or granted, it was written with the help of the Holy
Spirit by a researcher, and it is submitted to the Church for correction. No reviews, credentials, endorsements
or sales claims are asserted anywhere in these materials.

---

## The one thing left

The rename went halfway. GitHub's API reports the repo's `name` as **`the-hidden-and-the-manifest-`** — there is
still a hyphen at the end. GitHub Pages builds its URL from the exact repo name, so the site moved from the
double-hyphen path to `…/the-hidden-and-the-manifest-/`, while the book's canonical tag, `og:url`, sitemap,
robots, copyright/imprint rows and citation all declare the clean `…/the-hidden-and-the-manifest/`.

**As owner: Settings → Repository name → delete the final hyphen** so it reads exactly
`the-hidden-and-the-manifest`. Pages follows the rename automatically (it already did once, with no rebuild),
and at that moment every declared URL becomes correct. Nothing needs to be rebuilt or re-pushed.

I retried finishing it through every API route available to this connection; all return
`403 Resource not accessible by integration`:

| Attempt on the current name | Result |
|---|---|
| `gh api -X PATCH repos/ykidus053-create/the-hidden-and-the-manifest- -f name=the-hidden-and-the-manifest` | 403 |
| `gh repo rename the-hidden-and-the-manifest --repo ykidus053-create/the-hidden-and-the-manifest-` | HTTP 403 |
| GraphQL `updateRepository` with the repo's `node_id` | `FORBIDDEN: Resource not accessible by integration` |

The connection can push to the repo (it deployed the site) but has no repository-administration permission. If
you would rather I do it, grant the Arena GitHub connection repository-administration permission (or "All
repositories") and I'll finish it. Creating a second repo at the clean name was deliberately **not** done — it
would occupy the name and block this rename permanently.

Optional, in Settings → Pages while you are there: switch the source from `gh-pages` / `/` to `main` / `/` to
match the brief exactly. Both branches carry the identical tree. Do **not** delete `gh-pages` while it is the
source — that disables Pages again.

---

## What was done

| # | Step | Result |
|---|------|--------|
| 1 | Source repo `getclausery/getclausery.github.io`, branch `arena/09f8871f-getclausery-github-io`, `git pull` | Correct branch, `Already up to date`, HEAD `764c110f`. No other branch created there; nothing pushed to its `main`. |
| 2 | `pip install --break-system-packages reportlab pyphen pymupdf pillow`, then `sh book/publish.sh` | **161/161 checks passed**, exit 0, `all clear.` Working tree clean (`git diff --exit-code` = 0). |
| 3 | `python3 book/make-site.py` | `13 entries at the root, 6.0 MB`; base URL `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`. **18 files** (the brief's "19" is approximate; six social PNGs, not five). |
| 4 | Canonical check | `rel="canonical"`, `og:url`, `sitemap.xml`, `robots.txt` all name the intended clean address. |
| 5 | Deploy | Site files pushed to the repo's `main` as a fast-forward (`12b1995..c5bf61a`), remote history preserved, no force. A `gh-pages` branch with the identical tree was pushed too. |
| 6 | Turn on Pages | `POST`/`PUT /pages` return 403 for this connection, so GitHub's `gh-pages` convention auto-enabled it: `status: built`, source `gh-pages` / `/`. |
| 7 | Verify live | **All seven required paths verified from the live host** at the current address — see below. |

### A note on step 2, honestly

The **first** `sh book/publish.sh` on a fresh clone ended `160/161 checks passed`: one check failed,
`report: page estimate is within two pages of the typeset count — estimate 310, typeset 314`. Cause: on a fresh
sandbox `book/dist/build-report.json` does not exist, so `build.py` falls back to its default words-per-page
ratio (245.5) and advertises 310 pages, while the typeset PDF is 314 pages. The build deliberately measures the
ratio from the previous report, so **running `publish.sh` a second time** (no source edits) converges the
estimate to 314 and ends **161/161 checks passed**, with all editions stating "75,803 words and 314 printed
pages". Nothing in `book/build.py`, `book/verify.py` or the manuscript was changed. Worth telling the manuscript
chat: a clean-slate CI run will show 160/161 unless the report is seeded or the builder warms up.

---

## Verification — live, not assumed

Outbound `curl` to `*.github.io` is blocked in this sandbox (DNS resolves, but direct TCP to the Pages IPs times
out), so live verification was done by fetching the live URLs with the page tool, and binary responses through a
text-extraction proxy (`r.jina.ai`) reading the same live URLs. After the partial rename, every required path
was re-checked at the **current** address `https://ykidus053-create.github.io/the-hidden-and-the-manifest-/`:

```
/                                  ✓ landing page: title, thesis, both Download buttons, the
                                     "not authoritative" paragraph, citation and UUID
/read/                             ✓ full reading edition (58 chunks), Crimson Text declared and embedded
/the-hidden-and-the-manifest.pdf   ✓ live PDF parsed: 314 pages, half-title, copyright, imprint,
                                     contents with all 40 chapters and appendices A–H
/the-hidden-and-the-manifest.epub  ✓ served as application/epub+zip (the proxy rejected it with
                                     "unexpected content type application/epub+zip" — a MIME confirmation);
                                     its contents were parsed from the identical bundle earlier
/cover.jpg                         ✓ live image returned (book cover: candle, book, rosary, title)
/social/og-card.png                ✓ live image returned (share card)
/sitemap.xml                       ✓ both clean canonical URLs
/robots.txt                        ✓ Allow: / + clean Sitemap
/triage-card.pdf                   ✓ one-page pastoral card (PDF)
/LICENSE-BOOK.txt                  ✓ plain text served
```

All ten paths also return **200** with correct MIME types against the local preview, and all 18 blobs are
present in the built `gh-pages` tree at their exact sizes (`cover.jpg` 631,380 B, `social/og-card.png`
405,923 B, PDF 1,550,722 B). The **Download the PDF** anchor is `<a class="primary"
href="./the-hidden-and-the-manifest.pdf?download" download="The-Hidden-and-the-Manifest.pdf">`; locally
`?download` returns `Content-Disposition: attachment; filename="the-hidden-and-the-manifest.pdf"` (EPUB
likewise), and the landing page also offers "open the PDF in this tab" as the stated iframe fallback. The
reading edition embeds four Crimson Text `@font-face` blocks as base64 `woff2` data URIs (all four decode with
the `wOF2` magic), with zero external font references, so the typeface renders without a network request.

The only thing not obtainable here is the literal `curl -o /dev/null -w '%{http_code}'` line from an
unrestricted host. `verify-live.sh` runs exactly that loop plus metadata checks; it passes against the local
preview with `CHECK_METADATA=0`. **Note:** until the trailing hyphen is removed, running it against the current
live URL will legitimately warn that canonical/`og:url`/sitemap do not match — they declare the final clean URL.

The bundle contains **no `getclausery.github.io` link**; the only Clausery string is the corrections email
address (a contact, not a publication location). The book is at its own address, not a subdirectory of the
product site and not in that site's sitemap.

---

## Real artifacts

* **The live site:** `https://ykidus053-create.github.io/the-hidden-and-the-manifest-/`
* **`verify-live.sh`** — smoke test for all required paths plus canonical/`og:url`/download/sitemap checks;
  `./verify-live.sh <base-url>`, or `CHECK_METADATA=0 ./verify-live.sh http://127.0.0.1:8080/`.
* **`LAUNCH-EMAIL-DRAFT.md`** — carries the current live link; blanks left blank, no invented claims.
* **Local preview on port 8080** — same bundle, book material only, never the Clausery product site.
* **Push-ready repo** at `/home/user/getclausery.github.io/book/site-dist/` — `main` and `gh-pages` hold the
  identical 18-file tree; both git remotes (this repo and `site-dist`) were updated to
  `https://github.com/ykidus053-create/the-hidden-and-the-manifest-.git` after the partial rename. After the
  final rename, set them to `https://github.com/ykidus053-create/the-hidden-and-the-manifest.git`.
* **File paths to hand to a reader** (no browser needed): `book/site-dist/the-hidden-and-the-manifest.pdf`
  (314 pp), `the-hidden-and-the-manifest.epub`, `cover.jpg`, `triage-card.pdf`, `read/index.html`.

---

## Findings to hand back to the manuscript chat (not patched here)

The handoff says the deployment chat owns deployment only, and that anything wrong inside the book or its
imprint line should be **reported**, not patched in isolation, because `book/build.py` and `book/verify.py` are
the single source of truth. Reported, therefore:

1. Clean-slate builds start at **160/161** until `build-report.json` exists (see the step 2 note above).
2. The **press materials still send readers to the Clausery product site**: `book/PRESS-KIT.md` (imprint row
   `Clausery · getclausery.github.io`), `book/MARKETING.md` (lines ~22, ~163, ~194:
   `getclausery.github.io/book/`) and `book/PITCH.md` (line ~122). The book itself is already correct —
   `META['url']`, the copyright/imprint rows and the citation all name the book's own address. Fix the press
   materials in the manuscript chat before the launch described in `book/PRESS-KIT.md`.
3. `book/site-dist/404.html` (generated by `make-site.py`) has one absolute-root link,
   `<a href="/">Return to the book</a>`. On a GitHub Pages project site that points at the user root, not the
   book; it should be relative. It is the only absolute-root link in the bundle — everything else is relative
   and works under the project path. Minor, but worth fixing in the builder.

---

## After the final rename — verify the clean URL

```sh
./verify-live.sh                          # default: https://ykidus053-create.github.io/the-hidden-and-the-manifest/
gh api repos/ykidus053-create/the-hidden-and-the-manifest/pages \
  --jq '{status,html_url,source}'         # confirm Pages followed the rename
```

Then open the live page and confirm the Download button saves the PDF and the reading edition renders in
Crimson Text. Optional next moves: a custom domain (`CNAME` + rebuild with
`--base-url https://domain/` + two DNS records), or renaming the repo to `ykidus053-create.github.io` for the
bare-root address.
