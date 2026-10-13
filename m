Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AC4FD276
	for <linux-serial@vger.kernel.org>; Tue, 13 Oct 2026 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893400; cv=none; b=tQNUMlpUTrhqmIG8xJgnOZxL27JiB+6R564OdWBjNN/vj87xoKXXBDlVNkokVwfUdZfZ926CHrYVy3J2aE7gS565vfLNIgpO22p6ubtHq3c/4Td7owUcT9uAPPKZQUFfqAPIZMYgQOcYx5lmfpWAiLlyumoh1tlSrGHON78/760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893400; c=relaxed/simple;
	bh=54pgk49HR9Jfq/F9ZgLrOVK64yh9mLoAgtVrLcGJPdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQDIabApkA44TscD7Ux8kTpiLKDLylETc5g7nBtjwMTYBfedhZqbaVVldjj5yWmhxUiCgjoqhPjwVuQA1IhedweKfhJX5Fmd9ZNRtmcfS9OyFwEUg3FHnykE57qS0aZ6QxJqCDiqwOw5XAuiJGdPtdJrFbZcwtnG8mr/CGck7F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D787A1F000FF;
	Tue, 13 Oct 2026 12:09:57 +0000 (UTC)
From: Greg Ungerer <gerg@linux-m68k.org>
To: linux-m68k@lists.linux-m68k.org,
	linux-serial@vger.kernel.org
Cc: Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 2/5] serial: mcf: convert to use proper platform resources
Date: Tue, 13 Oct 2026 22:07:00 +1000
Message-ID: <20261013120831.1046590-3-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013120831.1046590-1-gerg@linux-m68k.org>
References: <20261013120831.1046590-1-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ColdFire SoC device setup code supplies a non-standard array of
hardware address information (memory address and IRQ) for initializing
the UARTS - which it does as a single blob. The mcf serial probe
function processes the whole set in one go from a single platform entry.

Convert this setup to use the proper resource structures, with one for
each UART present on a platform. Modify the probe function to process
a single platform device per call, and use the proper platform resource
API to get the memory and IRQ addresses. This results in the proper
entries now being present in /proc/iomem.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/coldfire/device.c     | 179 +++++++++++++++++++++++---------
 arch/m68k/include/asm/mcfuart.h |  10 --
 drivers/tty/serial/mcf.c        |  45 ++++----
 3 files changed, 154 insertions(+), 80 deletions(-)

diff --git a/arch/m68k/coldfire/device.c b/arch/m68k/coldfire/device.c
index 9a0258acd998..e32bc3322c97 100644
--- a/arch/m68k/coldfire/device.c
+++ b/arch/m68k/coldfire/device.c
@@ -18,8 +18,8 @@
 #include <asm/traps.h>
 #include <asm/coldfire.h>
 #include <asm/mcfsim.h>
-#include <asm/mcfuart.h>
 #include <asm/mcfqspi.h>
+#include <linux/platform_device.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/dma-mcf-edma.h>
 #include <linux/platform_data/mmc-esdhc-mcf.h>
@@ -27,71 +27,125 @@
 /*
  *	All current ColdFire parts contain from 2, 3, 4 or 10 UARTS.
  */
-static struct mcf_platform_uart mcf_uart_platform_data[] = {
-	{
-		.mapbase	= MCFUART_BASE0,
-		.irq		= MCF_IRQ_UART0,
-	},
-	{
-		.mapbase	= MCFUART_BASE1,
-		.irq		= MCF_IRQ_UART1,
-	},
+static struct resource mcf_uart0_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE0, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART0),
+};
+static struct platform_device mcf_uart0 = {
+	.name			= "mcfuart",
+	.id			= 0,
+	.num_resources		= ARRAY_SIZE(mcf_uart0_resources),
+	.resource		= mcf_uart0_resources,
+};
+
+#ifdef MCFUART_BASE1
+static struct resource mcf_uart1_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE1, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART1),
+};
+static struct platform_device mcf_uart1 = {
+	.name			= "mcfuart",
+	.id			= 1,
+	.num_resources		= ARRAY_SIZE(mcf_uart1_resources),
+	.resource		= mcf_uart1_resources,
+};
+#endif
 #ifdef MCFUART_BASE2
-	{
-		.mapbase	= MCFUART_BASE2,
-		.irq		= MCF_IRQ_UART2,
-	},
+static struct resource mcf_uart2_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE2, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART2),
+};
+static struct platform_device mcf_uart2 = {
+	.name			= "mcfuart",
+	.id			= 2,
+	.num_resources		= ARRAY_SIZE(mcf_uart2_resources),
+	.resource		= mcf_uart2_resources,
+};
 #endif
 #ifdef MCFUART_BASE3
-	{
-		.mapbase	= MCFUART_BASE3,
-		.irq		= MCF_IRQ_UART3,
-	},
+static struct resource mcf_uart3_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE3, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART3),
+};
+static struct platform_device mcf_uart3 = {
+	.name			= "mcfuart",
+	.id			= 3,
+	.num_resources		= ARRAY_SIZE(mcf_uart3_resources),
+	.resource		= mcf_uart3_resources,
+};
 #endif
 #ifdef MCFUART_BASE4
-	{
-		.mapbase	= MCFUART_BASE4,
-		.irq		= MCF_IRQ_UART4,
-	},
+static struct resource mcf_uart4_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE4, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART4),
+};
+static struct platform_device mcf_uart4 = {
+	.name			= "mcfuart",
+	.id			= 4,
+	.num_resources		= ARRAY_SIZE(mcf_uart4_resources),
+	.resource		= mcf_uart4_resources,
+};
 #endif
 #ifdef MCFUART_BASE5
-	{
-		.mapbase	= MCFUART_BASE5,
-		.irq		= MCF_IRQ_UART5,
-	},
+static struct resource mcf_uart5_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE5, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART5),
+};
+static struct platform_device mcf_uart5 = {
+	.name			= "mcfuart",
+	.id			= 5,
+	.num_resources		= ARRAY_SIZE(mcf_uart5_resources),
+	.resource		= mcf_uart5_resources,
+};
 #endif
 #ifdef MCFUART_BASE6
-	{
-		.mapbase	= MCFUART_BASE6,
-		.irq		= MCF_IRQ_UART6,
-	},
+static struct resource mcf_uart6_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE6, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART6),
+};
+static struct platform_device mcf_uart6 = {
+	.name			= "mcfuart",
+	.id			= 6,
+	.num_resources		= ARRAY_SIZE(mcf_uart6_resources),
+	.resource		= mcf_uart6_resources,
+};
 #endif
 #ifdef MCFUART_BASE7
-	{
-		.mapbase	= MCFUART_BASE7,
-		.irq		= MCF_IRQ_UART7,
-	},
+static struct resource mcf_uart7_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE7, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART7),
+};
+static struct platform_device mcf_uart7 = {
+	.name			= "mcfuart",
+	.id			= 7,
+	.num_resources		= ARRAY_SIZE(mcf_uart7_resources),
+	.resource		= mcf_uart7_resources,
+};
 #endif
 #ifdef MCFUART_BASE8
-	{
-		.mapbase	= MCFUART_BASE8,
-		.irq		= MCF_IRQ_UART8,
-	},
+static struct resource mcf_uart8_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE8, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART8),
+};
+static struct platform_device mcf_uart8 = {
+	.name			= "mcfuart",
+	.id			= 8,
+	.num_resources		= ARRAY_SIZE(mcf_uart8_resources),
+	.resource		= mcf_uart8_resources,
+};
 #endif
 #ifdef MCFUART_BASE9
-	{
-		.mapbase	= MCFUART_BASE9,
-		.irq		= MCF_IRQ_UART9,
-	},
-#endif
-	{ },
+static struct resource mcf_uart9_resources[] = {
+	DEFINE_RES_MEM(MCFUART_BASE9, 0x80),
+	DEFINE_RES_IRQ(MCF_IRQ_UART9),
 };
-
-static struct platform_device mcf_uart = {
+static struct platform_device mcf_uart9 = {
 	.name			= "mcfuart",
-	.id			= 0,
-	.dev.platform_data	= mcf_uart_platform_data,
+	.id			= 9,
+	.num_resources		= ARRAY_SIZE(mcf_uart9_resources),
+	.resource		= mcf_uart9_resources,
 };
+#endif
 
 #ifdef MCFFEC_BASE0
 
@@ -623,7 +677,34 @@ static struct platform_device mcf_flexcan0 = {
 #endif /* MCFFLEXCAN_SIZE */
 
 static struct platform_device *mcf_devices[] __initdata = {
-	&mcf_uart,
+	&mcf_uart0,
+#ifdef MCFUART_BASE1
+	&mcf_uart1,
+#endif
+#ifdef MCFUART_BASE2
+	&mcf_uart2,
+#endif
+#ifdef MCFUART_BASE3
+	&mcf_uart3,
+#endif
+#ifdef MCFUART_BASE4
+	&mcf_uart4,
+#endif
+#ifdef MCFUART_BASE5
+	&mcf_uart5,
+#endif
+#ifdef MCFUART_BASE6
+	&mcf_uart6,
+#endif
+#ifdef MCFUART_BASE7
+	&mcf_uart7,
+#endif
+#ifdef MCFUART_BASE8
+	&mcf_uart8,
+#endif
+#ifdef MCFUART_BASE9
+	&mcf_uart9,
+#endif
 #ifdef MCFFEC_BASE0
 	&mcf_fec0,
 #endif
diff --git a/arch/m68k/include/asm/mcfuart.h b/arch/m68k/include/asm/mcfuart.h
index a1f35352f328..c80b022c1ebb 100644
--- a/arch/m68k/include/asm/mcfuart.h
+++ b/arch/m68k/include/asm/mcfuart.h
@@ -13,16 +13,6 @@
 #define	mcfuart_h
 /****************************************************************************/
 
-#include <linux/serial_core.h>
-#include <linux/platform_device.h>
-
-struct mcf_platform_uart {
-	unsigned long	mapbase;	/* Physical address base */
-	void __iomem	*membase;	/* Virtual address if mapped */
-	unsigned int	irq;		/* Interrupt vector */
-	unsigned int	uartclk;	/* UART clock rate */
-};
-
 /*
  *	Define the ColdFire UART register set addresses.
  */
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 2b862dfe39ab..3651910dff99 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -570,31 +570,34 @@ static struct uart_driver mcf_driver = {
 
 static int mcf_probe(struct platform_device *pdev)
 {
-	struct mcf_platform_uart *platp = dev_get_platdata(&pdev->dev);
 	struct uart_port *port;
-	int i;
+	struct resource *res;
 
-	for (i = 0; ((i < MCF_MAXPORTS) && (platp[i].mapbase)); i++) {
-		port = &mcf_ports[i].port;
+	if (pdev->id >= MCF_MAXPORTS)
+		return -ENODEV;
+	port = &mcf_ports[pdev->id].port;
 
-		port->line = i;
-		port->type = PORT_MCF;
-		port->mapbase = platp[i].mapbase;
-		port->membase = (platp[i].membase) ? platp[i].membase :
-			(unsigned char __iomem *) platp[i].mapbase;
-		port->dev = &pdev->dev;
-		port->iotype = SERIAL_IO_MEM;
-		port->irq = platp[i].irq;
-		port->uartclk = MCF_BUSCLK;
-		port->ops = &mcf_uart_ops;
-		port->flags = UPF_BOOT_AUTOCONF;
-		port->rs485_config = mcf_config_rs485;
-		port->rs485_supported = mcf_rs485_supported;
-		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
-
-		uart_add_one_port(&mcf_driver, port);
-	}
+	port->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+	port->mapbase = res->start;
+
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0)
+		return port->irq;
 
+	port->line = pdev->id;
+	port->type = PORT_MCF;
+	port->dev = &pdev->dev;
+	port->iotype = SERIAL_IO_MEM;
+	port->uartclk = MCF_BUSCLK;
+	port->ops = &mcf_uart_ops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->rs485_config = mcf_config_rs485;
+	port->rs485_supported = mcf_rs485_supported;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MCF_CONSOLE);
+
+	uart_add_one_port(&mcf_driver, port);
 	return 0;
 }
 
-- 
2.55.0

