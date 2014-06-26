From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
Date: Thu, 26 Jun 2014 13:24:32 +0200
Message-ID: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Drake <drake@endlessm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Tomasz Figa <t.figa@samsung.com>
List-Id: linux-serial@vger.kernel.org

Current Samsung UART driver relies on probe order of particular
samsung-uart instances, which makes it impossible to get proper
initialization of ports when not all ports are available on board,
not even saying of deterministic device naming.

This series intends to fix this situation by adding support to parse
aliases from device tree and use them to assign instance IDs to
particular port instances.

Tested on Exynos4412-based Trats2 board:
 1) without patch 3/3 adding aliases,
 2) with patch 3/3 with all UART ports enabled,
 3) with patch 3/3 with selected UART ports disabled.

Tomasz Figa (3):
  Documentation: devicetree: Update samsung UART bindings
  serial: samsung: Consider DT alias when probing ports
  ARM: dts: SAMSUNG: Add aliases of UART nodes

 .../devicetree/bindings/serial/samsung_uart.txt    | 52 +++++++++++++++++++---
 arch/arm/boot/dts/exynos3250.dtsi                  |  2 +
 arch/arm/boot/dts/exynos4.dtsi                     | 12 +++--
 arch/arm/boot/dts/exynos5.dtsi                     | 15 +++++--
 arch/arm/boot/dts/exynos5260.dtsi                  |  4 ++
 arch/arm/boot/dts/exynos5410.dtsi                  |  6 +++
 arch/arm/boot/dts/exynos5440.dtsi                  |  6 ++-
 arch/arm/boot/dts/s3c2416.dtsi                     |  6 ++-
 arch/arm/boot/dts/s3c24xx.dtsi                     |  9 ++--
 arch/arm/boot/dts/s3c64xx.dtsi                     |  4 ++
 drivers/tty/serial/samsung.c                       | 13 ++++--
 11 files changed, 106 insertions(+), 23 deletions(-)

-- 
1.9.3
