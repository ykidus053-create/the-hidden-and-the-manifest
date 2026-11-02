# Publication status — *The Hidden and the Manifest*

**Date:** 2026-11-02 (Africa/Addis_Ababa)
**Status:** the book is **built, verified and push-ready. It is not live.**
**Intended address:** `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`

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
| 1 | Source repo `getclausery/getclausery.github.io`, branch `arena/09f8871f-getclausery-github-io`, `git pull` | On the right branch; `Already up to date`; HEAD `764c110f`. No other branch created, nothing pushed to `main` there. |
| 2 | `pip install --break-system-packages reportlab pyphen pymupdf pillow`, then `sh book/publish.sh` | **161/161 checks passed**, exit 0, `all clear.` Working tree clean (`git diff --exit-code` = 0). |
| 3 | `python3 book/make-site.py` | `wrote …/book/site-dist — 13 entries at the root, 6.0 MB`; `base url: https://ykidus053-create.github.io/the-hidden-and-the-manifest/`. |
| 4 | Canonical check | `rel="canonical" href="https://ykidus053-create.github.io/the-hidden-and-the-manifest/"`; `og:url` identical; `sitemap.xml` and `robots.txt` point at the same address. 19 files, 6.0 MB. |
| 5 | Deploy (`git init -b main` in `book/site-dist`, commit `The Hidden and the Manifest — the book's own site`, push to the canonical remote) | **Blocked:** `remote: Repository not found.` The canonical repo does not exist yet. |
| 6 | Pages API | `POST repos/ykidus053-create/the-hidden-and-the-manifest/pages` → 404. Not enabled. |
| 7 | Live verification | **Blocked / not live.** Both `…/the-hidden-and-the-manifest/` and `…/-the-hidden-and-the-manifest-/` return GitHub Pages' *Site not found* 404. |

### A note on step 2, honestly

The **first** `sh book/publish.sh` on a fresh clone ended `160/161 checks passed`: one check failed,
`report: page estimate is within two pages of the typeset count — estimate 310, typeset 314`. Cause: on a fresh
sandbox `book/dist/build-report.json` does not exist, so `build.py` falls back to its default words-per-page
ratio (245.5) and advertises 310 pages, while the typeset PDF is 314 pages. The build deliberately measures the
ratio from the previous report, so **running `publish.sh` a second time** (no source edits) converges the
estimate to 314 and ends **161/161 checks passed**, with all editions stating "75,803 words and 314 printed
pages". Nothing in `book/build.py`, `book/verify.py` or the manuscript was changed. This is worth telling the
manuscript chat: a clean-slate CI run will show 160/161 unless the report is seeded or the builder warms up.

---

## Why it is not live — and what a human must do

The target repo is **still named `-the-hidden-and-the-manifest-`** (stray hyphens front and back).
`gh api repos/ykidus053-create/the-hidden-and-the-manifest` returns 404, and both attempts to rename it fail:
`gh api -X PATCH … -f name=the-hidden-and-the-manifest` → **403 Resource not accessible by integration**, and
`gh repo rename the-hidden-and-the-manifest` → **HTTP 403: Resource not accessible by integration**.

Precise diagnosis: **this connection can in fact write to the book repo.** A dry-run push reached the ref
check, and a real `git push origin arena/709a67c4-the-hidden-and-the-manifest` succeeded (it is how this status
report and the email draft reached GitHub). What the connection lacks is *repository administration* — the
rename — which is why the canonical repo does not exist and step 5's push returns not-found rather than
permission-denied.

**In one paragraph, what is needed:** as the repo owner, rename the repo in Settings → Repository name to
exactly `the-hidden-and-the-manifest` (and, if you want me to do the rename and the Pages API calls myself, add
repository-administration permission to the Arena GitHub connection — or switch it to "All repositories");
then steps 5–7 can be retried and will produce the URL the book already declares in its canonical tag,
`og:url`, sitemap and robots. GitHub Pages follows a repo rename, so once renamed the site appears at the
intended address with no rebuild needed.

**Zero-permission fallback:** drag `book/site-dist/` into the repo with *Add file → Upload files*, then
Settings → Pages → Deploy from a branch → `main` → `/ (root)`. (Do not use the drag-and-drop fallback on the
source repo — `book/site-dist/` must never be committed there.)

I deliberately did **not** publish to the hyphenated address: the bundle's canonical, `og:url`, sitemap and
robots all declare the exact intended URL, and publishing under the malformed path would put the book at the
wrong address. Nothing was forced, and no success was claimed.

---

## What is ready right now (real artifacts, not promises)

* **Live local preview on port 8080**, serving only the deployable book bundle (`ROOT=book/site-dist node
  tools/serve.mjs 8080`). It shows book material only — never the Clausery product site. `/` renders the landing
  page, `/read/` the full reading edition.
* **Push-ready git repo** at `/home/user/getclausery.github.io/book/site-dist/` — commit on `main`, remote
  already set to `https://github.com/ykidus053-create/the-hidden-and-the-manifest.git`. After the rename, the
  single command `git push -u origin main` completes step 5.
* **File paths to hand to a reader today** (no browser required):
  * PDF: `/home/user/getclausery.github.io/book/site-dist/the-hidden-and-the-manifest.pdf` (314 pp)
  * EPUB: `/home/user/getclausery.github.io/book/site-dist/the-hidden-and-the-manifest.epub`
  * Cover: `/home/user/getclausery.github.io/book/site-dist/cover.jpg`
  * One-page triage card: `/home/user/getclausery.github.io/book/site-dist/triage-card.pdf`
  * Reading edition: `/home/user/getclausery.github.io/book/site-dist/read/index.html`
* **`LAUNCH-EMAIL-DRAFT.md`** in this repo — a launch email with blanks left blank and no invented claims.

### Local verification of the exact paths that must be 200 when live

All checked against the preview server with the real bundle:

```
/                                  200  text/html; charset=utf-8
/read/                             200  text/html; charset=utf-8
/the-hidden-and-the-manifest.pdf   200  application/pdf
/the-hidden-and-the-manifest.epub  200  application/epub+zip
/cover.jpg                         200  image/jpeg
/social/og-card.png                200  image/png
/sitemap.xml                       200  application/xml
/triage-card.pdf                   200  application/pdf
/robots.txt                        200  text/plain; charset=utf-8
/404.html                          200  text/html; charset=utf-8
```

* The landing page's **Download the PDF** button is `<a class="primary"
  href="./the-hidden-and-the-manifest.pdf?download" download="The-Hidden-and-the-Manifest.pdf">`; requesting
  that URL returns `Content-Disposition: attachment; filename="the-hidden-and-the-manifest.pdf"` (EPUB
  likewise). A second, plain link opens the PDF in a new tab as a stated fallback for sandboxed iframes.
* The **reading edition renders in its own typeface without network requests**: it embeds four Crimson Text
  `@font-face` blocks as base64 `woff2` data URIs (all four decode with the `wOF2` magic, 28–30 KB each), with
  zero external font references.
* The bundle contains **no `getclausery.github.io` link**; the only Clausery string is the corrections email
  address, which is a contact, not a publication location. Nothing from the Clausery product site's sitemap is
  referenced.
* Note: outbound `curl` to `*.github.io` is blocked in this sandbox, so HTTP status codes were checked against
  the local preview. The live 404s above were confirmed through the page-fetch tool. Step 7's live `curl`
  checks still need to be run after deployment.

---

## Findings to hand back to the manuscript chat (not patched here)

The handoff says the deployment chat owns deployment only, and that anything wrong inside the book or its
imprint line should be **reported**, not patched in isolation, because `book/build.py` and `book/verify.py`
are the single source of truth. Reported, therefore:

1. Clean-slate builds start at **160/161** until `build-report.json` exists (see the step 2 note above).
2. The **press materials still send readers to the Clausery product site**, which the book must not live under:
   `book/PRESS-KIT.md` (imprint row: `Clausery · getclausery.github.io`), `book/MARKETING.md` (lines ~22, ~163,
   ~194: `getclausery.github.io/book/`) and `book/PITCH.md` (line ~122). The book itself is already correct —
   `META['url']`, the copyright/imprint rows and the citation all name
   `ykidus053-create.github.io/the-hidden-and-the-manifest/`. Fix the press materials in the manuscript chat
   before the launch described in `book/PRESS-KIT.md`.
3. `book/site-dist/404.html` (generated by `make-site.py`) has one absolute-root link,
   `<a href="/">Return to the book</a>`. On a GitHub Pages *project* site that points at
   `https://ykidus053-create.github.io/` rather than the book; it should be relative to the book root. It is the
   only absolute-root link in the bundle — every other link is relative and works under the project path.
   Minor, but worth fixing in the builder before launch.

---

## Retry sequence once the human has acted

```sh
cd /home/user/getclausery.github.io/book/site-dist
git push -u origin main                       # step 5 (remote already configured)
gh api -X POST repos/ykidus053-create/the-hidden-and-the-manifest/pages \
  -f 'source[branch]=main' -f 'source[path]=/'   # step 6; 409 means Pages is already on
gh api repos/ykidus053-create/the-hidden-and-the-manifest/pages/builds/latest --jq .status
for p in / /read/ /the-hidden-and-the-manifest.pdf /the-hidden-and-the-manifest.epub \
         /cover.jpg /social/og-card.png /sitemap.xml; do
  curl -o /dev/null -w "$p %{http_code}\n" "https://ykidus053-create.github.io/the-hidden-and-the-manifest$p"
done                                          # step 7: all must be 200
```

Then open the live page and confirm the download button downloads the PDF and the reading edition renders in
Crimson Text. Optional next moves once live: a custom domain (`CNAME` + rebuild with
`--base-url https://domain/` + two DNS records), or renaming the repo to `ykidus053-create.github.io` for the
bare-root address.
