# Search Console readiness — *The Hidden and the Manifest*

**Date:** 2026-11-02 (Africa/Addis_Ababa)
**Status:** the Google verification file is **deployed and serving**. Click **Verify** in Search Console.

| | |
|---|---|
| **Site** | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/` |
| **Verification file URL** | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/google1b6d1c6a6ec1afbf.html` |
| **Exact content (53 bytes, no trailing newline)** | `google-site-verification: google1b6d1c6a6ec1afbf.html` |
| **SHA-256** | `1d56e5dc62809938d97a0d8462583284116d775d35ab1b6bc89cf8be6ee2bcc8` |
| **Sitemap to submit** | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/sitemap.xml` |
| **Pages build** | `built`, commit `e9f08ae`, source `gh-pages` / `/` |

The uploaded file was named `google1b6d1c6a6ec1afbf (2).html` (a duplicate download). It was deployed
under the **exact** name Google expects, `google1b6d1c6a6ec1afbf.html`, with its bytes unchanged — the
`(2)` suffix is not part of the token. A backup copy is kept at
`/home/user/-the-hidden-and-the-manifest-/google1b6d1c6a6ec1afbf.html`.

---

## 1. Add the property — use **URL prefix**, not Domain

1. Go to Google Search Console → **Add property** → choose the **URL prefix** option (the right-hand column).
2. Paste exactly:
   ```
   https://ykidus053-create.github.io/the-hidden-and-the-manifest/
   ```
   (Equivalent without the trailing slash. Do not add `index.html`, `read/` or any other path.)
3. Expand **HTML file** under "Verify ownership". The file is already live — you do not need to re-upload it.
4. Click **Verify**.

**Why not a Domain property:** a Domain property can only be verified with a DNS TXT record, and
`ykidus053-create.github.io` is a shared GitHub domain you do not control. For a **URL prefix that includes a
path**, Google checks the HTML file at that prefix's root — `/the-hidden-and-the-manifest/google…html` — not at
the bare domain root [1](https://www.semrush.com/blog/google-search-console/). That is the standard way a
GitHub Pages project site is verified [2](https://github.com/orgs/community/discussions/163649).

The verification URL was fetched from the live host and returned exactly the token above, with no redirect.
Google's HTML-file check does not follow redirects, so this direct 200 is what matters.

---

## 2. After verification

* **Submit the sitemap**: Sitemaps → `https://ykidus053-create.github.io/the-hidden-and-the-manifest/sitemap.xml`.
  It currently lists the two canonical URLs (root, priority 1.0, and `/read/`, priority 0.8).
* Optionally use URL Inspection → **Request indexing** for `/` and `/read/`. Indexing is Google's decision;
  nothing here promises a crawl, a ranking or a date.
* **Keep the verification file permanently.** Google rechecks ownership; deleting it can expire verification.
* Log the verification date and the sitemap submission in `outreach-tracker.csv`.

---

## 3. Readiness checklist (all verified on the live host)

| Check | State |
|---|---|
| HTTPS | Yes — GitHub Pages serves https by default |
| Verification file returns 200 with exact content | Yes (fetched live, both directly and via a text proxy) |
| File not redirected, not blocked | Yes; `robots.txt` is `User-agent: * / Allow: /` |
| No `noindex` on the landing page | Confirmed — no `name="robots"` directive in `index.html` |
| Canonical tag | `https://ykidus053-create.github.io/the-hidden-and-the-manifest/` |
| `og:url` | same URL |
| `sitemap.xml` `<loc>` values | clean URL root and `/read/` |
| `robots.txt` Sitemap line | clean URL `sitemap.xml` |
| All seven required live paths | verified earlier; `./verify-live.sh` re-checks them plus the verification file |
| `.nojekyll` present | Yes — the verification file is served verbatim, not processed by Jekyll |

### Two honest caveats

1. **The sitemap lists only two URLs.** That is what `book/make-site.py` generates. The PDF, EPUB, cover and
   triage card are discoverable through links from the landing page, but they are not in the sitemap. Adding
   them is a builder change for the manuscript chat, not a patch here — reported, not done.
2. **Old hyphenated addresses.** `-the-hidden-and-the-manifest-` now 404s; the intermediate
   `…/the-hidden-and-the-manifest-/` path may still serve a cached copy. Every page declares the clean
   canonical URL, so Google has one consistent signal. Do not link to the hyphenated paths.

---

## 4. If `book/make-site.py` is ever run again

`make-site.py` clears `book/site-dist/`, so it **will delete the verification file**. Before any redeploy,
copy the backup back in:

```sh
cp /home/user/-the-hidden-and-the-manifest-/google1b6d1c6a6ec1afbf.html \
   /home/user/getclausery.github.io/book/site-dist/google1b6d1c6a6ec1afbf.html
```

Then commit in `/home/user/getclausery.github.io/book/site-dist` and push `main` and `gh-pages` as before.
`verify-live.sh` now checks `/google1b6d1c6a6ec1afbf.html` too, so a rebuild that drops it will fail the smoke
test instead of silently expiring your Search Console verification. A durable fix would be to have
`make-site.py` copy a verification file into the bundle — report that to the manuscript chat rather than
patching the builder here.

The bundle is deployed from the nested repository inside `book/site-dist/`, which is gitignored by the source
repo `getclausery/getclausery.github.io`. Nothing was committed to that source repo, and the live site's
content is unchanged apart from this one 53-byte file.
