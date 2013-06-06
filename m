From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH 00/13] add exynos5420 support
Date: Thu,  6 Jun 2013 16:31:28 +0530
Message-ID: <1370516488-25860-14-git-send-email-chander.kashyap@linaro.org>
References: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1370516488-25860-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, s.nawrocki@samsung.com, thomas.ab@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>
List-Id: linux-serial@vger.kernel.org

Exynos5420 is new SoC in Samsung's Exynos5 SoC series.

Patches 1 and 2 are generic enhancement patches applicable for all
Exynos based SoCs.

Patches 3 and 4 factor out the common DT nodes for Exynos5 based SoCs.

Remaining patches provide support for Exynos5420 SoC and SMDK5420 board.

Chander Kashyap (13):
  ARM: Exynos: initialize l2x0 cache controller only for cortex-a9
    based SoCs
  ARM: Exynos: fix secondary cpu power control register address
    calculation
  ARM: dts: fork out common Exynos5 nodes
  ARM: dts: list the CPU nodes for Exynos5250
  ARM: Exynos: Add support for Exynos5420 SoC
  serial: samsung: add support for Exynos5420
  ARM: Exynos: use four additional chipid bits to identify Exynos
    family
  irqchip: exynos-combiner: set irq base as 256 for Exynos5420
  clk: exynos5420: register clocks using common clock framework
  ARM: dts: Add initial device tree support for Exynos5420
  clocksource: exynos_mct: extend local timer support for four cores
  ARM: Exynos: add secondary CPU boot base location for Exynos5420
  ARM: Exynos: extend soft-reset support for Exynos5420

 .../devicetree/bindings/clock/exynos5420-clock.txt |  201 ++++++
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/exynos5.dtsi                     |  121 ++++
 arch/arm/boot/dts/exynos5250.dtsi                  |   84 +--
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   40 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  101 +++
 arch/arm/mach-exynos/Kconfig                       |   10 +
 arch/arm/mach-exynos/common.c                      |   13 +-
 arch/arm/mach-exynos/include/mach/regs-pmu.h       |    6 +
 arch/arm/mach-exynos/include/mach/uncompress.h     |    7 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    1 +
 arch/arm/mach-exynos/platsmp.c                     |   22 +-
 arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |  762 ++++++++++++++++++++
 drivers/clocksource/exynos_mct.c                   |   33 +-
 drivers/irqchip/exynos-combiner.c                  |    5 +-
 drivers/tty/serial/samsung.c                       |    2 +-
 18 files changed, 1328 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5420-clock.txt
 create mode 100644 arch/arm/boot/dts/exynos5.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5420-smdk5420.dts
 create mode 100644 arch/arm/boot/dts/exynos5420.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos5420.c

-- 
1.7.9.5
