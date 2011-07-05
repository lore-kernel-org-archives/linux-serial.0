From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Tue, 5 Jul 2011 23:05:37 +0800
Message-ID: <1309878338-25697-2-git-send-email-shawn.guo@linaro.org>
References: <1309878338-25697-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:44840 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198Ab1GEO70 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Jul 2011 10:59:26 -0400
In-Reply-To: <1309878338-25697-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>

The patch removes all the uses of cpu_is_mx1().  Instead, it uses
the .id_table of platform_driver to distinguish the uart device type.

A couple of !cpu_is_mx1() logic gets turned into IS_IMX_UART, as the
codes wrapped there are really IMX specific.

It also removes macro MX1_UCR3_REF25 and MX1_UCR3_REF30 which are
not used anywhere.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 arch/arm/mach-imx/clock-imx1.c                |    6 +-
 arch/arm/plat-mxc/devices/platform-imx-uart.c |    2 +-
 drivers/tty/serial/imx.c                      |   65 ++++++++++++++++++++-----
 3 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx1.c b/arch/arm/mach-imx/clock-imx1.c
index dcc4172..4aabeb2 100644
--- a/arch/arm/mach-imx/clock-imx1.c
+++ b/arch/arm/mach-imx/clock-imx1.c
@@ -587,9 +587,9 @@ static struct clk_lookup lookups[] __initdata = {
 	_REGISTER_CLOCK(NULL, "mma", mma_clk)
 	_REGISTER_CLOCK("imx_udc.0", NULL, usbd_clk)
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk)
+	_REGISTER_CLOCK("imx1-uart.0", NULL, uart_clk)
+	_REGISTER_CLOCK("imx1-uart.1", NULL, uart_clk)
+	_REGISTER_CLOCK("imx1-uart.2", NULL, uart_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
 	_REGISTER_CLOCK("imx1-cspi.0", NULL, spi_clk)
 	_REGISTER_CLOCK("imx1-cspi.1", NULL, spi_clk)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index cfce8c9..477271a 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -152,7 +152,7 @@ struct platform_device *__init imx_add_imx_uart_3irq(
 		},
 	};
 
-	return imx_add_platform_device("imx-uart", data->id, res,
+	return imx_add_platform_device("imx1-uart", data->id, res,
 			ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
 
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 22fe801..ddebb5c 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -48,7 +48,6 @@
 
 #include <asm/io.h>
 #include <asm/irq.h>
-#include <mach/hardware.h>
 #include <mach/imx-uart.h>
 
 /* Register definitions */
@@ -66,8 +65,9 @@
 #define UBIR  0xa4 /* BRM Incremental Register */
 #define UBMR  0xa8 /* BRM Modulator Register */
 #define UBRC  0xac /* Baud Rate Count Register */
-#define MX2_ONEMS 0xb0 /* One Millisecond register */
-#define UTS (cpu_is_mx1() ? 0xd0 : 0xb4) /* UART Test Register */
+#define IMX_ONEMS 0xb0 /* One Millisecond register */
+#define IMX1_UTS 0xd0 /* UART Test Register on i.mx1 */
+#define IMX_UTS 0xb4 /* UART Test Register on all other i.mx*/
 
 /* UART Control Register Bit Fields.*/
 #define  URXD_CHARRDY    (1<<15)
@@ -87,7 +87,7 @@
 #define  UCR1_RTSDEN     (1<<5)	 /* RTS delta interrupt enable */
 #define  UCR1_SNDBRK     (1<<4)	 /* Send break */
 #define  UCR1_TDMAEN     (1<<3)	 /* Transmitter ready DMA enable */
-#define  MX1_UCR1_UARTCLKEN  (1<<2)	 /* UART clock enabled, mx1 only */
+#define  IMX1_UCR1_UARTCLKEN  (1<<2)  /* UART clock enabled, i.mx1 only */
 #define  UCR1_DOZE       (1<<1)	 /* Doze */
 #define  UCR1_UARTEN     (1<<0)	 /* UART enabled */
 #define  UCR2_ESCI     	 (1<<15) /* Escape seq interrupt enable */
@@ -113,9 +113,7 @@
 #define  UCR3_RXDSEN	 (1<<6)  /* Receive status interrupt enable */
 #define  UCR3_AIRINTEN   (1<<5)  /* Async IR wake interrupt enable */
 #define  UCR3_AWAKEN	 (1<<4)  /* Async wake interrupt enable */
-#define  MX1_UCR3_REF25 	 (1<<3)  /* Ref freq 25 MHz, only on mx1 */
-#define  MX1_UCR3_REF30 	 (1<<2)  /* Ref Freq 30 MHz, only on mx1 */
-#define  MX2_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select, on mx2/mx3 */
+#define  IMX_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select */
 #define  UCR3_INVT  	 (1<<1)  /* Inverted Infrared transmission */
 #define  UCR3_BPEN  	 (1<<0)  /* Preset registers enable */
 #define  UCR4_CTSTL_SHF  10      /* CTS trigger level shift */
@@ -181,6 +179,17 @@
 
 #define UART_NR 8
 
+enum imx_uart_type {
+	IMX1_UART,
+	IMX_UART,
+};
+
+/* device type dependent stuff */
+struct imx_uart_data {
+	unsigned uts_reg;
+	enum imx_uart_type devtype;
+};
+
 struct imx_port {
 	struct uart_port	port;
 	struct timer_list	timer;
@@ -192,6 +201,7 @@ struct imx_port {
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk;
+	struct imx_uart_data	*devdata;
 };
 
 #ifdef CONFIG_IRDA
@@ -200,6 +210,33 @@ struct imx_port {
 #define USE_IRDA(sport)	(0)
 #endif
 
+#define UTS (sport->devdata->uts_reg)
+#define IS_IMX1_UART()	(sport->devdata->devtype == IMX1_UART)
+#define IS_IMX_UART()	(sport->devdata->devtype == IMX_UART)
+
+static struct imx_uart_data imx_uart_devdata[] = {
+	[IMX1_UART] = {
+		.uts_reg = IMX1_UTS,
+		.devtype = IMX1_UART,
+	},
+	[IMX_UART] = {
+		.uts_reg = IMX_UTS,
+		.devtype = IMX_UART,
+	},
+};
+
+static struct platform_device_id imx_uart_devtype[] = {
+	{
+		.name = "imx1-uart",
+		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX1_UART],
+	}, {
+		.name = "imx-uart",
+		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX_UART],
+	}, {
+		/* sentinel */
+	}
+};
+
 /*
  * Handle any change of modem status signal since we were last called.
  */
@@ -689,9 +726,9 @@ static int imx_startup(struct uart_port *port)
 		}
 	}
 
-	if (!cpu_is_mx1()) {
+	if (IS_IMX_UART()) {
 		temp = readl(sport->port.membase + UCR3);
-		temp |= MX2_UCR3_RXDMUXSEL;
+		temp |= IMX_UCR3_RXDMUXSEL;
 		writel(temp, sport->port.membase + UCR3);
 	}
 
@@ -923,9 +960,9 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	writel(num, sport->port.membase + UBIR);
 	writel(denom, sport->port.membase + UBMR);
 
-	if (!cpu_is_mx1())
+	if (IS_IMX_UART())
 		writel(sport->port.uartclk / div / 1000,
-				sport->port.membase + MX2_ONEMS);
+				sport->port.membase + IMX_ONEMS);
 
 	writel(old_ucr1, sport->port.membase + UCR1);
 
@@ -1062,8 +1099,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	ucr1 = old_ucr1 = readl(sport->port.membase + UCR1);
 	old_ucr2 = readl(sport->port.membase + UCR2);
 
-	if (cpu_is_mx1())
-		ucr1 |= MX1_UCR1_UARTCLKEN;
+	if (IS_IMX1_UART())
+		ucr1 |= IMX1_UCR1_UARTCLKEN;
 	ucr1 |= UCR1_UARTEN;
 	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN);
 
@@ -1262,6 +1299,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	init_timer(&sport->timer);
 	sport->timer.function = imx_timeout;
 	sport->timer.data     = (unsigned long)sport;
+	sport->devdata = (struct imx_uart_data	*) pdev->id_entry->driver_data;
 
 	sport->clk = clk_get(&pdev->dev, "uart");
 	if (IS_ERR(sport->clk)) {
@@ -1340,6 +1378,7 @@ static struct platform_driver serial_imx_driver = {
 
 	.suspend	= serial_imx_suspend,
 	.resume		= serial_imx_resume,
+	.id_table	= imx_uart_devtype,
 	.driver		= {
 		.name	= "imx-uart",
 		.owner	= THIS_MODULE,
-- 
1.7.4.1


