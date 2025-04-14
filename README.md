<div align="center">

# Kernel-Builder
Build Android Kernel Using GitHub Actions.

[![Build kernels](https://github.com/Norikimika/Kernel-Builder/actions/workflows/build.yml/badge.svg)](https://github.com/Norikimika/Kernel-Builder/actions/workflows/build.yml)

</div>

## Introduction
Use GitHub Actions to Build Android System Kernel Support KernelSU Next and SUSFS Builds.

## KernelSU Next
The build patch from [KernelSU Next](https://github.com/rifsxd/KernelSU-Next/releases/latest) will be used to continue supporting non-GKI kernel. The manager must be downloaded from the provided link.

## Flashing Instructions
1. Download the [Kernel](https://github.com/Norikimika/Kernel-Builder/releases/latest).
2. Enter **Recovery Mode** by holding **Power + Volume Up** while the device is off.
3. **Backup** the following partitions:
   - `boot`
   - `dtbo`
   - `vendor_boot`
4. **Flash the kernel** via recovery:
   - If using a custom recovery (like TWRP or OrangeFox), tap **Install** and select the kernel zip.
   - **Do not use ADB sideload mode**.
5. Alternatively, you can use a kernel flasher app like [HKF](https://github.com/libxzr/HorizonKernelFlasher/releases/latest) or [FKM](https://play.google.com/store/apps/details?id=com.franco.kernel) to flash the kernel.

## Currently Built Kernel

### Redmi K40S / POCO F4 (munch)
- **[AOSPA Uvite](https://github.com/AOSPA/android_kernel_xiaomi_sm8250)**
- **[N0Kernel](https://github.com/EmanuelCN/kernel_xiaomi_sm8250)**

A total of 2 kernel are available, mainly for AOSP-based ROMs.

## Build Schedule
- Some updates have been made to the repository and tested.
- A new stable KernelSU Next release has been published.
- The kernel source has been updated, possibly including new features, bug fixes, or security patches.
