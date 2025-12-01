# Redmi Note 12 5G / POCO X5 5G – TWRP Device Tree (stone)

> ### Himel_Parvez TWRP Rebased Version Device tree  
> Rebased on **Pixel Shiba** device tree & blobs

---

## Device Info

| Property         | Value                                              |
|------------------|----------------------------------------------------|
| Brand            | Xiaomi / POCO                                     |
| Devices          | Redmi Note 12 5G / POCO X5 5G                     |
| Common Codename  | `stone`                                           |
| Per-device       | `sunstone` (Redmi Note 12 5G), `moonstone` (X5 5G) |
| SoC (RN12 5G)    | Qualcomm Snapdragon 4 Gen 1 (6 nm)                 |
| SoC (X5 5G)      | Qualcomm Snapdragon 695 5G (6 nm)                  |
| GPU              | Adreno 619                                        |
| Used blobs from  | Pixel Shiba                                       |

---

## Specifications

### Display

| Spec        | Redmi Note 12 5G / POCO X5 5G |
|------------|--------------------------------|
| Type       | 6.67" FHD+ AMOLED DotDisplay   |
| Resolution | 2400 × 1080 (20:9)             |
| Refresh    | Up to **120 Hz**               |
| Brightness | up to 1200 nits (peak)         |
| Features   | DCI-P3, Sunlight mode, Reading mode |

### Performance

| Component | Redmi Note 12 5G                           | POCO X5 5G                               |
|----------|--------------------------------------------|------------------------------------------|
| Chipset  | Snapdragon **4 Gen 1** (6 nm)              | Snapdragon **695 5G** (6 nm)             |
| CPU      | Octa-core, up to 2.0 GHz                   | Octa-core, up to 2.2 GHz                 |
| GPU      | Adreno 619                                 | Adreno 619                               |
| RAM      | 4 / 6 / 8 GB LPDDR4X                       | 6 / 8 GB LPDDR4X                         |
| Storage  | 128 / 256 GB UFS 2.2                       | 128 / 256 GB UFS 2.0/2.2 (varies by SKU) |
| microSD  | Up to 1 TB (hybrid slot, region-dependent) |

### Cameras

| Side        | Spec                                                                 |
|------------|----------------------------------------------------------------------|
| Rear main  | 48 MP, f/1.8, PDAF                                                   |
| Ultra-wide | 8 MP, f/2.2, 118° FOV                                                |
| Macro      | 2 MP, f/2.4                                                          |
| Video      | Up to 1080p @ 30 fps                                                 |
| Front      | 13 MP, f/2.45, up to 1080p @ 30 fps                                  |

### Battery & Charging

| Spec         | Value              |
|-------------|--------------------|
| Capacity    | 5000 mAh (typical) |
| Charging    | 33 W fast charging |
| Port        | USB Type-C         |

### Build & Connectivity

| Spec           | Value                                        |
|----------------|----------------------------------------------|
| Dimensions     | 165.9 × 76.2 × ~8.0 mm                       |
| Weight         | ~189 g                                       |
| Fingerprint    | Side-mounted                                 |
| Network        | 5G SA/NSA, 4G LTE, 3G, 2G                    |
| SIM            | Dual SIM (Nano-SIM, dual stand-by)           |
| Extras         | IR blaster, 3.5 mm jack, Wi-Fi, BT 5.x, NFC* |

\*NFC availability is region-dependent.

---

## Source Layout

```text
device/
 └── xiaomi/
     └── stone/         # Common device tree for sunstone/moonstone

kernel/
 └── xiaomi/
     └── stone/         # Matching kernel source (defconfig for stone)

vendor/
 └── xiaomi/
     ├── sunstone/      # Proprietary blobs for Redmi Note 12 5G
     └── moonstone/     # Proprietary blobs for POCO X5 5G