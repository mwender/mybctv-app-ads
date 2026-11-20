# mybctv.com app-ads.txt

Wix can't host files at the site root, so this repo hosts Bowling Center TV's `app-ads.txt` on GitHub Pages, and a 301 redirect in Wix points `https://mybctv.com/app-ads.txt` here. The IAB ads.txt spec, which app-ads.txt follows, allows one redirect to another domain.

The file is a copy of `https://mybctv.com/ads.txt`, which Wix does host (Marketing Integrations in the Wix dashboard).

## Updating it

1. Edit `ads.txt` in Wix as usual.
2. Run `bin/sync.sh` to copy the live `ads.txt` into `app-ads.txt`.
3. Commit and push `main`. GitHub Pages republishes in a minute or two.

## The Wix redirect

Wix dashboard → Marketing & SEO → SEO → URL Redirect Manager: `/app-ads.txt` → `https://mwender.github.io/mybctv-app-ads/app-ads.txt` (301).

Before 2026-11-20 it pointed at `https://streamstak.com/bctv/app-ads.txt`, which returned 404.

## Checking it

```
curl -sIL https://mybctv.com/app-ads.txt
```

That should show one 301 to the GitHub Pages URL, then a 200 with `content-type: text/plain`.
