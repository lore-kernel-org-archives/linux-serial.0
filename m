From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 4/4] sh-mobile: add SCIFA and SCIFB DMA slave definitions
 for sh7372
Date: Fri, 21 May 2010 17:49:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005211736070.8450@axis700.grange>
References: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:51372 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933612Ab0EUPtG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 May 2010 11:49:06 -0400
In-Reply-To: <Pine.LNX.4.64.1005211731480.8450@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org

SH7372 can use DMA with the SCI serial driver. Add required slave IDs, slave
descriptors and move DMA platform device definitions to the top of the file for
the time, when we have to reference them from SCI device data to enable DMA
for them.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/include/mach/sh7372.h |   14 +
 arch/arm/mach-shmobile/setup-sh7372.c        |  346 ++++++++++++++++----------
 2 files changed, 223 insertions(+), 137 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh7372.h b/arch/arm/mach-shmobile/include/mach/sh7372.h
index 57e033a..c2d2d81 100644
--- a/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ b/arch/arm/mach-shmobile/include/mach/sh7372.h
@@ -433,6 +433,20 @@ enum {
 
 /* DMA slave IDs */
 enum {
+	SHDMA_SLAVE_SCIF0_TX,
+	SHDMA_SLAVE_SCIF0_RX,
+	SHDMA_SLAVE_SCIF1_TX,
+	SHDMA_SLAVE_SCIF1_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SCIF3_TX,
+	SHDMA_SLAVE_SCIF3_RX,
+	SHDMA_SLAVE_SCIF4_TX,
+	SHDMA_SLAVE_SCIF4_RX,
+	SHDMA_SLAVE_SCIF5_TX,
+	SHDMA_SLAVE_SCIF5_RX,
+	SHDMA_SLAVE_SCIF6_TX,
+	SHDMA_SLAVE_SCIF6_RX,
 	SHDMA_SLAVE_SDHI0_RX,
 	SHDMA_SLAVE_SDHI0_TX,
 	SHDMA_SLAVE_SDHI1_RX,
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index ba70910..927cbe8 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -34,143 +34,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-static struct plat_sci_port scif0_platform_data = {
-	.mapbase	= 0xe6c40000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIFA,
-	.irqs		= { 80, 80, 80, 80 },
-};
-
-static struct platform_device scif0_device = {
-	.name		= "sh-sci",
-	.id		= 0,
-	.dev		= {
-		.platform_data	= &scif0_platform_data,
-	},
-};
-
-static struct plat_sci_port scif1_platform_data = {
-	.mapbase	= 0xe6c50000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIFA,
-	.irqs           = { 81, 81, 81, 81 },
-};
-
-static struct platform_device scif1_device = {
-	.name		= "sh-sci",
-	.id		= 1,
-	.dev		= {
-		.platform_data	= &scif1_platform_data,
-	},
-};
-
-static struct plat_sci_port scif2_platform_data = {
-	.mapbase	= 0xe6c60000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIFA,
-	.irqs           = { 82, 82, 82, 82 },
-};
-
-static struct platform_device scif2_device = {
-	.name		= "sh-sci",
-	.id		= 2,
-	.dev		= {
-		.platform_data	= &scif2_platform_data,
-	},
-};
-
-static struct plat_sci_port scif3_platform_data = {
-	.mapbase	= 0xe6c70000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIFA,
-	.irqs           = { 83, 83, 83, 83 },
-};
-
-static struct platform_device scif3_device = {
-	.name		= "sh-sci",
-	.id		= 3,
-	.dev		= {
-		.platform_data	= &scif3_platform_data,
-	},
-};
-
-static struct plat_sci_port scif4_platform_data = {
-	.mapbase	= 0xe6c80000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIFA,
-	.irqs           = { 89, 89, 89, 89 },
-};
-
-static struct platform_device scif4_device = {
-	.name		= "sh-sci",
-	.id		= 4,
-	.dev		= {
-		.platform_data	= &scif4_platform_data,
-	},
-};
-
-static struct plat_sci_port scif5_platform_data = {
-	.mapbase	= 0xe6cb0000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIFA,
-	.irqs           = { 90, 90, 90, 90 },
-};
-
-static struct platform_device scif5_device = {
-	.name		= "sh-sci",
-	.id		= 5,
-	.dev		= {
-		.platform_data	= &scif5_platform_data,
-	},
-};
-
-static struct plat_sci_port scif6_platform_data = {
-	.mapbase	= 0xe6c30000,
-	.flags		= UPF_BOOT_AUTOCONF,
-	.type		= PORT_SCIFB,
-	.irqs           = { 91, 91, 91, 91 },
-};
-
-static struct platform_device scif6_device = {
-	.name		= "sh-sci",
-	.id		= 6,
-	.dev		= {
-		.platform_data	= &scif6_platform_data,
-	},
-};
-
-static struct sh_timer_config cmt10_platform_data = {
-	.name = "CMT10",
-	.channel_offset = 0x10,
-	.timer_bit = 0,
-	.clk = "cmt1",
-	.clockevent_rating = 125,
-	.clocksource_rating = 125,
-};
-
-static struct resource cmt10_resources[] = {
-	[0] = {
-		.name	= "CMT10",
-		.start	= 0xe6138010,
-		.end	= 0xe613801b,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= 72,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device cmt10_device = {
-	.name		= "sh_cmt",
-	.id		= 10,
-	.dev = {
-		.platform_data	= &cmt10_platform_data,
-	},
-	.resource	= cmt10_resources,
-	.num_resources	= ARRAY_SIZE(cmt10_resources),
-};
-
 /* DMA */
 /* Transmit sizes and respective CHCR register values */
 enum {
@@ -199,6 +62,76 @@ enum {
 
 static const struct sh_dmae_slave_config sh7724_dmae_slaves[] = {
 	{
+		.slave_id	= SHDMA_SLAVE_SCIF0_TX,
+		.addr		= 0xe6c40020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x21,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF0_RX,
+		.addr		= 0xe6c40024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x22,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_TX,
+		.addr		= 0xe6c50020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x25,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_RX,
+		.addr		= 0xe6c50024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x26,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_TX,
+		.addr		= 0xe6c60020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x29,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_RX,
+		.addr		= 0xe6c60024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF3_TX,
+		.addr		= 0xe6c70020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF3_RX,
+		.addr		= 0xe6c70024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2e,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF4_TX,
+		.addr		= 0xe6c80020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x39,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF4_RX,
+		.addr		= 0xe6c80024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF5_TX,
+		.addr		= 0xe6cb0020,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x35,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF5_RX,
+		.addr		= 0xe6cb0024,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x36,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF6_TX,
+		.addr		= 0xe6c30040,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF6_RX,
+		.addr		= 0xe6c30060,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3e,
+	}, {
 		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
 		.addr		= 0xe6850030,
 		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
@@ -389,6 +322,145 @@ static struct platform_device dma2_device = {
 	},
 };
 
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xe6c40000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { 80, 80, 80, 80 },
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xe6c50000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs           = { 81, 81, 81, 81 },
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
+	},
+};
+
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xe6c60000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs           = { 82, 82, 82, 82 },
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &scif2_platform_data,
+	},
+};
+
+static struct plat_sci_port scif3_platform_data = {
+	.mapbase	= 0xe6c70000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs           = { 83, 83, 83, 83 },
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
+	.dev		= {
+		.platform_data	= &scif3_platform_data,
+	},
+};
+
+static struct plat_sci_port scif4_platform_data = {
+	.mapbase	= 0xe6c80000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs           = { 89, 89, 89, 89 },
+};
+
+static struct platform_device scif4_device = {
+	.name		= "sh-sci",
+	.id		= 4,
+	.dev		= {
+		.platform_data	= &scif4_platform_data,
+	},
+};
+
+static struct plat_sci_port scif5_platform_data = {
+	.mapbase	= 0xe6cb0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs           = { 90, 90, 90, 90 },
+};
+
+static struct platform_device scif5_device = {
+	.name		= "sh-sci",
+	.id		= 5,
+	.dev		= {
+		.platform_data	= &scif5_platform_data,
+		.coherent_dma_mask = ~0,
+	},
+};
+
+static struct plat_sci_port scif6_platform_data = {
+	.mapbase	= 0xe6c30000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFB,
+	.irqs           = { 91, 91, 91, 91 },
+};
+
+static struct platform_device scif6_device = {
+	.name		= "sh-sci",
+	.id		= 6,
+	.dev		= {
+		.platform_data	= &scif6_platform_data,
+		.coherent_dma_mask = ~0,
+	},
+};
+
+static struct sh_timer_config cmt10_platform_data = {
+	.name = "CMT10",
+	.channel_offset = 0x10,
+	.timer_bit = 0,
+	.clk = "cmt1",
+	.clockevent_rating = 125,
+	.clocksource_rating = 125,
+};
+
+static struct resource cmt10_resources[] = {
+	[0] = {
+		.name	= "CMT10",
+		.start	= 0xe6138010,
+		.end	= 0xe613801b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 72,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt10_device = {
+	.name		= "sh_cmt",
+	.id		= 10,
+	.dev = {
+		.platform_data	= &cmt10_platform_data,
+	},
+	.resource	= cmt10_resources,
+	.num_resources	= ARRAY_SIZE(cmt10_resources),
+};
+
 static struct platform_device *sh7372_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
-- 
1.6.2.4

