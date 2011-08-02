From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 0/4] Add device tree enabled Exynos4 machine
Date: Wed,  3 Aug 2011 00:08:25 +0100
Message-ID: <1312326509-2723-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60016 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1HBXIr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Aug 2011 19:08:47 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org
Cc: grant.likely@secretlab.ca, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org

This patchset adds a basic device tree enabled machine for Samsung's Exynos4
processor. This enables further development of device tree coverge for
Exynos4. A basic device tree source file for Exynos4 processor and the
smdkv310 board is also included.

The device tree enabled machine has been boot tested till serial console.
The watchdog driver is probed with information from dtb.

Notes:
- The interrupt controller device tree bindings are not documented yet. That
  is because, it will be replaced with a new irq_domain support soon.


Thomas Abraham (4):
  serial: samsung: Keep a copy of the location of platform data in driver's private data
  serial: s5pv210: Add device tree support
  arm: exynos4: Add a new Exynos4 device tree enabled machine
  arm: dts: Add device tree source file for Exynos4 platforms

 Documentation/devicetree/bindings/arm/samsung.txt  |    8 ++
 .../devicetree/bindings/serial/samsung_uart.txt    |   16 ++++
 arch/arm/boot/dts/exynos4-smdkv310.dts             |   31 +++++++
 arch/arm/boot/dts/exynos4.dtsi                     |   72 +++++++++++++++++
 arch/arm/mach-exynos4/Kconfig                      |   10 +++
 arch/arm/mach-exynos4/Makefile                     |    1 +
 arch/arm/mach-exynos4/mach-exynos4-dt.c            |   84 ++++++++++++++++++++
 drivers/tty/serial/s5pv210.c                       |   55 ++++++++++++-
 drivers/tty/serial/samsung.c                       |   19 ++++-
 drivers/tty/serial/samsung.h                       |    4 +-
 10 files changed, 292 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung.txt
 create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
 create mode 100644 arch/arm/boot/dts/exynos4-smdkv310.dts
 create mode 100644 arch/arm/boot/dts/exynos4.dtsi
 create mode 100644 arch/arm/mach-exynos4/mach-exynos4-dt.c


