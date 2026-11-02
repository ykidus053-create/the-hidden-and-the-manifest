# Publication status — *The Hidden and the Manifest*

**Date:** 2026-11-02 (Africa/Addis_Ababa)
**Status:** **PUBLISHED.** The book is live at its own exact address. No remaining human action is needed to
publish it.

| | |
|---|---|
| **Live URL** | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/` |
| **Repo** | `ykidus053-create/the-hidden-and-the-manifest` (exact name, no stray hyphens) |
| **Pages** | `status: built`, `html_url` matches the live URL, source `gh-pages` / `/`, build commit `c5bf61a`, no build error |
| **Canonical / og:url / sitemap / robots** | all declare the live URL above |

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

## Real artifacts

* **The live site:** `https://ykidus053-create.github.io/the-hidden-and-the-manifest/`
* **`verify-live.sh`** — smoke test for all required paths plus canonical/`og:url`/download/sitemap checks;
  `./verify-live.sh`, or `CHECK_METADATA=0 ./verify-live.sh http://127.0.0.1:8080/`.
* **`LAUNCH-KIT.md`** — ready-to-use launch package built from `book/PRESS-KIT.md`: verbatim copy blocks,
  quotable lines, editor angles, outreach drafts, live asset inventory, launch-week checklist and guardrails.
  All links point at the live URL; no invented claims; blanks left blank.
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
   the copyright/imprint rows and the citation all name the live book address. Fix the press materials in the
   manuscript chat before the launch.
3. `book/site-dist/404.html` (generated by `make-site.py`) has one absolute-root link,
   `<a href="/">Return to the book</a>`. On a GitHub Pages project site that points at the user root, not the
   book; it should be relative. It is the only absolute-root link in the bundle — everything else is relative
   and works under the project path. Minor, but worth fixing in the builder.
