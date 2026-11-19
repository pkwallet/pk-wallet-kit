# Release process

1. Collect the APK from the upstream build channel and check it installs on a
   scratch device.
2. Record the exact `versionName` / `versionCode` and the SHA-256.
3. Add a `CHANGELOG.md` entry describing what changed and whether the package was
   patched or resigned.
4. Regenerate `SHA256SUMS` in the same directory as the binaries:

   ```bash
   shasum -a 256 ep.apk jz.apk jcb.apk > SHA256SUMS
   ```

5. Create the tag and attach the binaries plus `SHA256SUMS`:

   ```bash
   gh release create v1.0.0 --title "v1.0.0" --notes-file notes.md \
     ep.apk jz.apk jcb.apk SHA256SUMS
   ```

6. Update the artifact table in `README.md` so the newest tag is the one people
   land on. Keep the previous tag — old packages must stay downloadable so
   support can walk a user back.

## Rules

- Never reuse a tag or silently replace an asset; clients cache by URL.
- Never commit an APK to git. If a single build ever exceeds the release asset
  limit, split it, do not reach for LFS.
- Keep asset names stable (`ep.apk`, `jz.apk`, `jcb.apk`). Downstream configs
  point at the name, only the tag changes.
