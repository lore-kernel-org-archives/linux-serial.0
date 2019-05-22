From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/6] arm64: Initial support Texas Instrument's J721E Platform
Date: Wed, 22 May 2019 11:19:15 -0500
Message-ID: <20190522161921.20750-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <ssantosh@kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-serial@vger.kernel.org

Hi,

This series adds support for the latest new SoC, J721E, from Texas Instruments.

The series is an based off v5.2-rc1 and has the following driver
dependencies for a successful boot:
1.  https://lore.kernel.org/lkml/20190429131533.25122-1-afd@ti.com (for newer firmware)
2.  https://lore.kernel.org/linux-arm-kernel/1555093342-428-1-git-send-email-t-kristo@ti.com/
    - Clock IDs cannot be guarenteed to be sequential, has to be
      discovered from hardware description in dts
    - Clock IDs on this massive chip also exceeds 255, so, the support
      for the same is expected in follow on patches.

The full series is available here (including dependencies):
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v5.2-rc1/j7es-base-v1

Boot Log: https://pastebin.ubuntu.com/p/j3NtfF8FQr/

NOTE:
 - If Greg is ok, we can pick up the uart compatibility via the k3 tree,
   else, I can spawn it off the series.
 - I will resubmit patch 6 (defconfig update) separately once again once
   patches 1-5 hit the next tree or for 5.3-rc2 which ever is convenient.

The J721E SoC belongs to the K3 Multicore SoC architecture platform
for automotive applications such as infotainment, cluster, premium
Audio, Gateway, industrial and a range of broad market applications.
This SoC is designed around reducing the system cost by eliminating
the need of an external system MCU and is targeted towards ASIL-B/C
certification/requirements in addition to allowing complex software
and system use-cases.

The Linux development follows AM654 in most of the configurations, but
adds new capabilities (details in follow on patches).

See J721E Technical Reference Manual (SPRUIL1, May 2019)
for further details: http://www.ti.com/lit/pdf/spruil1

Nishanth Menon (6):
  dt-bindings: arm: ti: Add bindings for J721E SoC
  dt-bindings: serial: 8250_omap: Add compatible for J721E UART
    controller
  arm64: dts: ti: Add Support for J721E SoC
  soc: ti: Add Support for J721E SoC config option
  arm64: dts: ti: Add support for J721E Common Processor Board
  arm64: defconfig: Enable TI's J721E SoC platform

 .../devicetree/bindings/arm/ti/k3.txt         |   3 +
 .../bindings/serial/omap_serial.txt           |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../dts/ti/k3-j721e-common-proc-board.dts     |  50 +++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 202 ++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  72 +++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   |  29 +++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          | 176 +++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/ti/Kconfig                        |   5 +
 10 files changed, 541 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e.dtsi

-- 
2.21.0.777.g83232e38648b
