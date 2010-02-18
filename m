From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/not-for-mainline] sh7722: enable DMA on all SCIF ports
Date: Thu, 18 Feb 2010 20:39:12 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1002182036240.4373@axis700.grange>
References: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1002181624190.4373@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Not for inclusion - just an example how to enable DMA on SCIF.

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 2b94281..caca1b8 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -175,6 +175,9 @@ static struct plat_sci_port scif0_platform_data = {
 	.type           = PORT_SCIF,
 	.irqs           = { 80, 80, 80, 80 },
 	.clk		= "scif0",
+	.dma_dev	= &dma_device.dev,
+	.dma_slave_tx	= SHDMA_SLAVE_SCIF0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SCIF0_RX,
 };
 
 static struct platform_device scif0_device = {
@@ -191,6 +194,9 @@ static struct plat_sci_port scif1_platform_data = {
 	.type           = PORT_SCIF,
 	.irqs           = { 81, 81, 81, 81 },
 	.clk		= "scif1",
+	.dma_dev	= &dma_device.dev,
+	.dma_slave_tx	= SHDMA_SLAVE_SCIF1_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SCIF1_RX,
 };
 
 static struct platform_device scif1_device = {
@@ -207,6 +213,9 @@ static struct plat_sci_port scif2_platform_data = {
 	.type           = PORT_SCIF,
 	.irqs           = { 82, 82, 82, 82 },
 	.clk		= "scif2",
+	.dma_dev	= &dma_device.dev,
+	.dma_slave_tx	= SHDMA_SLAVE_SCIF2_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SCIF2_RX,
 };
 
 static struct platform_device scif2_device = {
