# pk-wallet-kit

Build mirror for a small set of Android wallet clients used by our payment
gateway. The APKs are produced upstream; this repository only publishes the
signed, install-ready artifacts so that build servers, test devices and support
staff can pull them with a stable URL instead of hunting through chat threads.

Binary artifacts are **not** committed to git. Every build is attached to a
GitHub Release and stays addressable by tag, which keeps clones small and makes
a rollback a one-line change.

## Artifacts

| Artifact | Package | Version | Size | Download |
| --- | --- | --- | --- | --- |
| `ep.apk` | `pk.com.telenor.phoenix` | 2.10.8 (547) | 184.6 MiB | [v1.0.0](https://github.com/WangHongSen391/pk-wallet-kit/releases/download/v1.0.0/ep.apk) |
| `jz.apk` | `com.techlogix.mobilinkcustomer` | 9.1.89 (9189) | 247.3 MiB | [v1.0.0](https://github.com/WangHongSen391/pk-wallet-kit/releases/download/v1.0.0/jz.apk) |
| `jcb.apk` | `com.ibm.jazzcashmerchant` | 1.2.46 (186) | 112.7 MiB | [v1.0.0](https://github.com/WangHongSen391/pk-wallet-kit/releases/download/v1.0.0/jcb.apk) |

Checksums for every artifact are in the release notes and in `SHA256SUMS`.
Verify before installing:

```bash
./scripts/fetch.sh v1.0.0 ep
```

## Install

```bash
adb install -r ep.apk
```

The clients require Android 8.0 (API 26) or newer; `jcb.apk` requires
Android 9.0 (API 28). Install over the same package name upgrades in place and
keeps the local session — switching package name means a fresh login.

## Layout

```
scripts/fetch.sh        download + checksum an artifact from a release
docs/release-process.md how a build gets published here
docs/device-notes.md    install / upgrade notes per client
CHANGELOG.md            artifact history
```

## Releasing

Bump the version in `CHANGELOG.md`, attach the binaries to a new tag and update
the table above. Full checklist in [docs/release-process.md](docs/release-process.md).

## Notes

- Packages here are unmodified upstream builds. Anything we patch or resign is
  marked as such in the release notes.
- Distribution is for internal use; the wallet operators' own terms still apply.
