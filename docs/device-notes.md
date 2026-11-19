# Install notes

## Requirements

| Artifact | Minimum Android | Notes |
| --- | --- | --- |
| `ep.apk` | 8.0 (API 26) | arm64 device recommended |
| `jz.apk` | 8.0 (API 26) | arm64 device recommended |
| `jcb.apk` | 9.0 (API 28) | arm64 device recommended |

## Install / upgrade

```bash
adb install -r <artifact>.apk
```

`-r` reinstalls over an existing copy and keeps app data, so an upgrade stays
logged in. Downgrades need `adb install -r -d` and may still be rejected when
the build increased a storage schema version.

Uninstall first only when the signing certificate changed — a mismatch shows up
as `INSTALL_FAILED_UPDATE_INCOMPATIBLE`.

## Common failures

- `INSTALL_FAILED_OLDER_SDK` — device is below the minimum Android version.
- `INSTALL_FAILED_NO_MATCHING_ABIS` — x86 emulator; use an arm image or a real
  device.
- `INSTALL_PARSE_FAILED_NOT_APK` — truncated download, check the checksum.
- `INSTALL_FAILED_INSUFFICIENT_STORAGE` — clear space, the largest build needs
  roughly three times its size during install.

## Emulators

Plain AOSP images usually work for login-screen checks only. Anything that needs
SIM/OEM services (device binding, SMS autofill, secure keystore attestation)
should be validated on hardware.
