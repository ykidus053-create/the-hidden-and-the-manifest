# Publication status — *The Hidden and the Manifest*

**Date:** 2026-11-02 (Africa/Addis_Ababa)
**Status:** **LIVE.** The book's own site is published and serving the full bundle. One owner-only action
remains: rename the repo so the address matches the URL the book declares.

| | |
|---|---|
| **Live now** | `https://ykidus053-create.github.io/-the-hidden-and-the-manifest-/` |
| **Intended address** | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/` — still 404 until the repo is renamed |
| **Pages build** | `status: built`, commit `c5bf61a`, source `gh-pages` / `/`, `build_type: legacy`, no build error |

About the book, from the manuscript and its build report: *The Hidden and the Manifest: A Catholic Theology of
Manifestation, and How the Church May Baptize an Age*, by Kidus Yared, imprint Clausery, first edition MMXXVI,
© 2026 Kidus Yared, `urn:uuid:8f3c1a52-6b64-5d1e-9a77-2f4e0c9b7d31`. 6 parts, 40 chapters, 8 appendices
(A–H), 75,803 words, 314 pages, free to read, copy and distribute. It is a **theological research project, not
authoritative teaching**: no *imprimatur* has been sought or granted, it was written with the help of the Holy
Spirit by a researcher, and it is submitted to the Church for correction. No reviews, credentials, endorsements
or sales claims are asserted anywhere in these materials.

---

## What was done

| # | Step | Result |
|---|------|--------|
| 1 | Source repo `getclausery/getclausery.github.io`, branch `arena/09f8871f-getclausery-github-io`, `git pull` | Correct branch, `Already up to date`, HEAD `764c110f`. No other branch created there; nothing pushed to its `main`. |
| 2 | `pip install --break-system-packages reportlab pyphen pymupdf pillow`, then `sh book/publish.sh` | **161/161 checks passed**, exit 0, `all clear.` Working tree clean (`git diff --exit-code` = 0). |
| 3 | `python3 book/make-site.py` | `13 entries at the root, 6.0 MB`; base URL `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`. 19 files. |
| 4 | Canonical check | `rel="canonical"`, `og:url`, `sitemap.xml`, `robots.txt` all name the intended address. |
| 5 | Deploy | Site files pushed to the real repo's `main` as a fast-forward (`12b1995..c5bf61a`), remote history preserved, no force. A `gh-pages` deployment branch with the identical tree was pushed too. |
| 6 | Turn on Pages | API `POST /pages` and `PUT /pages` both return `403 Resource not accessible by integration` (the connection can push but has no Pages/administration permission). GitHub auto-enabled Pages on the `gh-pages` branch instead: `status: built`, source `gh-pages` / `/`. |
| 7 | Verify live | Landing page, `/read/`, `/sitemap.xml`, `/robots.txt`, the EPUB, `triage-card.pdf` and `LICENSE-BOOK.txt` all fetched successfully from the live host. See the verification section below. |

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

## What still needs a human

**One action: rename the repository.** It is still named `-the-hidden-and-the-manifest-` (stray hyphens front
and back). Both `gh api -X PATCH … -f name=the-hidden-and-the-manifest` and
`gh repo rename the-hidden-and-the-manifest` return **403 Resource not accessible by integration**: this GitHub
connection can push to the repo (the deployment succeeded) but has no repository-administration permission. As
owner, go to **Settings → Repository name** and set it to exactly `the-hidden-and-the-manifest`. GitHub Pages
follows a repo rename, so the site moves to the intended URL with no rebuild; the canonical tag, `og:url`,
sitemap, robots, copyright/imprint rows and citation all already name that URL. Until then they point at a
404 — the one remaining inconsistency on the live site. If you would rather I do the rename and the remaining
API calls, grant the Arena GitHub connection repository-administration / Pages permission (or "All
repositories") and ask me to retry.

Optional, in the same Settings → Pages screen: switch the publishing source from `gh-pages` / `/` to `main` / `/`
to match the brief exactly. Both branches carry the identical tree, so the live site is unchanged either way; the
API for this is also 403 for this connection, so it is a UI action. Do **not** delete the `gh-pages` branch —
with source set to it, deleting it disables Pages again.

Zero-permission fallback (only if even the push had failed): drag `book/site-dist/` in with *Add file → Upload
files*, then Settings → Pages → Deploy from a branch → `main` → `/ (root)`. Never commit `book/site-dist/` to
the source repo.

---

## Verification — live, not assumed

**Live host** (`fetch_page`, since outbound `curl` to `*.github.io` is blocked in this sandbox — direct TCP to
the Pages IPs times out):

```
/                                  ✓ landing page, title, all metadata, both download buttons
/read/                             ✓ full reading edition, 58 chunks, Crimson Text declared and embedded
/sitemap.xml                       ✓ both canonical URLs
/robots.txt                        ✓ Allow: / + canonical Sitemap
/the-hidden-and-the-manifest.epub  ✓ EPUB parsed (title, copyright, 40 chapters, appendices A–H)
/triage-card.pdf                   ✓ PDF parsed, one-page pastoral card
/LICENSE-BOOK.txt                  ✓ plain text served
```

`cover.jpg`, `social/og-card.png` and the 1.5 MB `the-hidden-and-the-manifest.pdf` could not be fetched by the
page tool (it errors on large/binary responses) — **not** a 404 from the site. They are confirmed present in the
built `gh-pages` tree at their exact sizes (`cover.jpg` 631,380 B, `social/og-card.png` 405,923 B, PDF
1,550,722 B), the Pages build is `built` with no error, and all three returned **200** against the local preview
with the correct MIME types. A real `curl -o /dev/null -w '%{http_code}'` loop on the live host should be run
from a machine with unrestricted internet; the exact commands are at the end of this file.

**Local preview** (`ROOT=book/site-dist node tools/serve.mjs 8080`, book material only — never the Clausery
product site): all ten paths returned 200 with correct content types, including `/`, `/read/`, both editions,
cover, og card, sitemap, triage card, robots and 404. The **Download the PDF** anchor is
`<a class="primary" href="./the-hidden-and-the-manifest.pdf?download"
download="The-Hidden-and-the-Manifest.pdf">`; locally `?download` returns
`Content-Disposition: attachment; filename="the-hidden-and-the-manifest.pdf"` (EPUB likewise), and the landing
page also offers "open the PDF in this tab" as the stated iframe fallback. The reading edition embeds four
Crimson Text `@font-face` blocks as base64 `woff2` data URIs (all four decode with the `wOF2` magic), with zero
external font references, so the typeface renders without a network request.

The bundle contains **no `getclausery.github.io` link**; the only Clausery string is the corrections email
address (a contact, not a publication location). The book is at its own address, not a subdirectory of the
product site and not in that site's sitemap.

---

## Real artifacts

* **The live site:** `https://ykidus053-create.github.io/-the-hidden-and-the-manifest-/`
* **Local preview on port 8080** — same bundle, book material only.
* **Push-ready repo** at `/home/user/getclausery.github.io/book/site-dist/` — `main` and `gh-pages` both at
  `c5bf61a`, remote set to the existing repo. After the rename, update the remote with
  `git remote set-url origin https://github.com/ykidus053-create/the-hidden-and-the-manifest.git`.
* **File paths to hand to a reader** (no browser needed): `book/site-dist/the-hidden-and-the-manifest.pdf`
  (314 pp), `the-hidden-and-the-manifest.epub`, `cover.jpg`, `triage-card.pdf`, `read/index.html`.
* **`LAUNCH-EMAIL-DRAFT.md`** — updated with the working live link; blanks left blank, no invented claims.

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

## After the rename — verify the final URL

```sh
BASE=https://ykidus053-create.github.io/the-hidden-and-the-manifest
for p in / /read/ /the-hidden-and-the-manifest.pdf /the-hidden-and-the-manifest.epub \
         /cover.jpg /social/og-card.png /sitemap.xml; do
  curl -o /dev/null -w "$p %{http_code}\n" "$BASE$p"
done                                          # all must be 200
gh api repos/ykidus053-create/the-hidden-and-the-manifest/pages \
  --jq '{status,html_url,source}'             # confirm Pages followed the rename
```

Then open the live page and confirm the Download button saves the PDF and the reading edition renders in
Crimson Text. Optional next moves: a custom domain (`CNAME` + rebuild with
`--base-url https://domain/` + two DNS records), or renaming the repo to `ykidus053-create.github.io` for the
bare-root address.
