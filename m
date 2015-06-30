From: Paul Osmialowski <pawelo@king.net.pl>
Subject: [PATCH v2 7/9] arm: twr-k70f120m: use Freescale eDMA driver with Kinetis SoC
Date: Tue, 30 Jun 2015 14:27:28 +0200
Message-ID: <1435667250-28299-8-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Sender: linux-gpio-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jiri Slaby <jslaby@suse.cz>, Kumar Gala <galak@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Michael Turquette <mturquette@baylibre.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, dmaengine@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, Paul Bolle <pebolle@tiscali.nl>, Thomas Gleixner <tglx@linutronix.de>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, Paul Osmialowski <pawelo@king.net.pl>, Anson Huang <b20788@freescale.com>, Frank Li <Frank.Li@freescale.com>, Jingchang Lu <jingchang.lu@freescale.com>, Rob Herring <r.herring@freescale.com>, Yuri Tikhonov <yur@emcraft.com>, Sergei Poselenov <sposelenov@emcraft.com>, Alexander Potashev <aspotashev@emcraft.com>
List-Id: linux-serial@vger.kernel.org

Note that <mach/memory.h> is needed (which is denoted by
CONFIG_NEED_MACH_MEMORY_H) as it provides macros required for proper
operation of DMA allocation functions.

Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
---
 arch/arm/Kconfig                            |  4 ++
 arch/arm/boot/dts/kinetis.dtsi              | 34 ++++++++++++++++
 arch/arm/mach-kinetis/include/mach/memory.h | 61 +++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)
 create mode 100644 arch/arm/mach-kinetis/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b21592b..8ccffee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -971,6 +971,10 @@ config ARCH_KINETIS
 	select CLKSRC_KINETIS
 	select PINCTRL
 	select PINCTRL_KINETIS
+	select DMADEVICES
+	select FSL_EDMA
+	select DMA_OF
+	select NEED_MACH_MEMORY_H
 	help
 	  This enables support for the Freescale Kinetis MCUs
 
diff --git a/arch/arm/boot/dts/kinetis.dtsi b/arch/arm/boot/dts/kinetis.dtsi
index 5ff1d3b..c2861f5 100644
--- a/arch/arm/boot/dts/kinetis.dtsi
+++ b/arch/arm/boot/dts/kinetis.dtsi
@@ -19,6 +19,40 @@
 	};
 
 	soc {
+		edma: dma-controller@40008000 {
+			compatible = "fsl,kinetis-edma";
+			reg = <0x40008000 0x2000>, /* DMAC */
+				<0x40021000 0x1000>, /* DMAMUX0 */
+				<0x40022000 0x1000>; /* DMAMUX1 */
+			#dma-cells = <2>;
+			dma-channels = <32>;
+			interrupts =	 <0>,  <1>,  <2>,  <3>,
+					 <4>,  <5>,  <6>,  <7>,
+					 <8>,  <9>, <10>, <11>,
+					<12>, <13>, <14>, <15>,
+					<16>;
+			interrupt-names = "edma-tx-0,16",
+					  "edma-tx-1,17",
+					  "edma-tx-2,18",
+					  "edma-tx-3,19",
+					  "edma-tx-4,20",
+					  "edma-tx-5,21",
+					  "edma-tx-6,22",
+					  "edma-tx-7,23",
+					  "edma-tx-8,24",
+					  "edma-tx-9,25",
+					  "edma-tx-10,26",
+					  "edma-tx-11,27",
+					  "edma-tx-12,28",
+					  "edma-tx-13,29",
+					  "edma-tx-14,30",
+					  "edma-tx-15,31",
+					  "edma-err";
+			clocks = <&mcg_cclk_gate 6 1>,
+				 <&mcg_pclk_gate 5 1>, <&mcg_pclk_gate 5 2>;
+			clock-names = "edma", "dmamux0", "dmamux1";
+		};
+
 		portA: pinmux@40049000 {
 			compatible = "fsl,kinetis-padconf";
 			reg = <0x40049000 0x1000>;
diff --git a/arch/arm/mach-kinetis/include/mach/memory.h b/arch/arm/mach-kinetis/include/mach/memory.h
new file mode 100644
index 0000000..8bad034
--- /dev/null
+++ b/arch/arm/mach-kinetis/include/mach/memory.h
@@ -0,0 +1,61 @@
+/*
+ * Based on original code by Alexander Potashev <aspotashev@emcraft.com>
+ *
+ * (C) Copyright 2011, 2012
+ * Emcraft Systems, <www.emcraft.com>
+ * Alexander Potashev <aspotashev@emcraft.com>
+ *
+ * Copyright (C) 2015 Paul Osmialowski <pawelo@king.net.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#ifndef _MACH_KINETIS_MEMORY_H
+#define _MACH_KINETIS_MEMORY_H
+
+#ifndef __ASSEMBLY__
+
+/*
+ * On Kinetis K70, consistent DMA memory resides in a special
+ * DDRAM alias region (non-cacheable DDRAM at 0x80000000).
+ *
+ */
+#define KINETIS_PHYS_DMA_OFFSET UL(0x80000000)
+
+/*
+ * Mask of the field used to distinguish DDRAM aliases
+ */
+#define KINETIS_DRAM_ALIAS_MASK UL(0xf8000000)
+
+/*
+ * This macro converts an address in the kernel run-time memory
+ * to an alias in the non-cacheable memory region
+ */
+#define KINETIS_DMA_ALIAS_ADDR(addr)					\
+		(((unsigned long)(addr) & ~KINETIS_DRAM_ALIAS_MASK) |	\
+		(KINETIS_PHYS_DMA_OFFSET & KINETIS_DRAM_ALIAS_MASK))
+
+/*
+ * This macro converts an address in the kernel code or
+ * in the non-cacheable DMA region to an alias in
+ * the run-time kernel memory region
+ */
+#define KINETIS_PHYS_ALIAS_ADDR(addr) \
+		((unsigned long)(addr) & ~KINETIS_DRAM_ALIAS_MASK)
+
+#define __arch_dma_to_pfn(dev, addr) __phys_to_pfn(addr)
+
+#define __arch_pfn_to_dma(dev, pfn) \
+		((dma_addr_t)KINETIS_DMA_ALIAS_ADDR(__pfn_to_phys(pfn)))
+
+#define __arch_dma_to_virt(dev, addr) \
+		((void *)KINETIS_PHYS_ALIAS_ADDR(addr))
+
+#define __arch_virt_to_dma(dev, addr) \
+		((dma_addr_t)KINETIS_DMA_ALIAS_ADDR(addr))
+
+#endif /* __ASSEMBLY__ */
+
+#endif /*_MACH_KINETIS_MEMORY_H */
-- 
2.3.6

