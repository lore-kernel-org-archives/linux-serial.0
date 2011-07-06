From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
Date: Thu, 7 Jul 2011 00:30:13 +0800
Message-ID: <1309969814-13195-2-git-send-email-shawn.guo@linaro.org>
References: <1309969814-13195-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:47105 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753546Ab1GFQX5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Jul 2011 12:23:57 -0400
In-Reply-To: <1309969814-13195-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, Alan Cox <alan@linux.intel.com>

The patch removes all the uses of cpu_is_mx1().  Instead, it uses
the .id_table of platform_driver to distinguish the uart device type,
IMX1_UART and IMX21_UART.  The IMX21_UART type runs on all i.mx
except i.mx1.

A couple of !cpu_is_mx1() logic gets turned into IS_IMX21_UART,
as the codes wrapped there are really IMX21 type uart specific.

It also removes macro MX1_UCR3_REF25 and MX1_UCR3_REF30 which are
not used anywhere.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Alan Cox <alan@linux.intel.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/mach-imx/clock-imx1.c                |    6 +-
 arch/arm/mach-imx/clock-imx21.c               |    8 ++--
 arch/arm/mach-imx/clock-imx25.c               |   11 ++--
 arch/arm/mach-imx/clock-imx27.c               |   13 +++--
 arch/arm/mach-imx/clock-imx31.c               |   11 ++--
 arch/arm/mach-imx/clock-imx35.c               |    7 ++-
 arch/arm/mach-mx5/clock-mx51-mx53.c           |   18 ++++---
 arch/arm/plat-mxc/devices/platform-imx-uart.c |    7 ++-
 drivers/tty/serial/imx.c                      |   66 ++++++++++++++++++++-----
 9 files changed, 97 insertions(+), 50 deletions(-)

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
diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
index bf30a8c..ee15d8c 100644
--- a/arch/arm/mach-imx/clock-imx21.c
+++ b/arch/arm/mach-imx/clock-imx21.c
@@ -1162,10 +1162,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "perclk3", per_clk[2])
 	_REGISTER_CLOCK(NULL, "perclk4", per_clk[3])
 	_REGISTER_CLOCK(NULL, "clko", clko_clk)
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart_clk[0])
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart_clk[1])
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart_clk[2])
-	_REGISTER_CLOCK("imx-uart.3", NULL, uart_clk[3])
+	_REGISTER_CLOCK("imx21-uart.0", NULL, uart_clk[0])
+	_REGISTER_CLOCK("imx21-uart.1", NULL, uart_clk[1])
+	_REGISTER_CLOCK("imx21-uart.2", NULL, uart_clk[2])
+	_REGISTER_CLOCK("imx21-uart.3", NULL, uart_clk[3])
 	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[0])
 	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[1])
 	_REGISTER_CLOCK(NULL, "gpt1", gpt_clk[2])
diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index a65838f..42ef76a 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -272,11 +272,12 @@ DEFINE_CLOCK(can2_clk,	 1, CCM_CGCR1,  3, get_rate_ipg, NULL, NULL);
 	},
 
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx-uart.4", NULL, uart5_clk)
+	/* i.mx25 has the i.mx21 type uart */
+	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
+	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
+	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
+	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
+	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 583f251..8c9a681 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -624,12 +624,13 @@ DEFINE_CLOCK1(csi_clk,     0, NULL,   0, parent, &csi_clk1, &per4_clk);
 	},
 
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx-uart.4", NULL, uart5_clk)
-	_REGISTER_CLOCK("imx-uart.5", NULL, uart6_clk)
+	/* i.mx27 has the i.mx21 type uart */
+	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
+	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
+	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
+	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
+	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
+	_REGISTER_CLOCK("imx21-uart.5", NULL, uart6_clk)
 	_REGISTER_CLOCK(NULL, "gpt1", gpt1_clk)
 	_REGISTER_CLOCK(NULL, "gpt2", gpt2_clk)
 	_REGISTER_CLOCK(NULL, "gpt3", gpt3_clk)
diff --git a/arch/arm/mach-imx/clock-imx31.c b/arch/arm/mach-imx/clock-imx31.c
index 25f343f..8d212a9 100644
--- a/arch/arm/mach-imx/clock-imx31.c
+++ b/arch/arm/mach-imx/clock-imx31.c
@@ -547,11 +547,12 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usb_clk1)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usb_clk2)
 	_REGISTER_CLOCK("mx3-camera.0", NULL, csi_clk)
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx-uart.4", NULL, uart5_clk)
+	/* i.mx31 has the i.mx21 type uart */
+	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
+	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
+	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
+	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
+	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
 	_REGISTER_CLOCK("imx-i2c.2", NULL, i2c3_clk)
diff --git a/arch/arm/mach-imx/clock-imx35.c b/arch/arm/mach-imx/clock-imx35.c
index 5a4cc1e..b44cb06 100644
--- a/arch/arm/mach-imx/clock-imx35.c
+++ b/arch/arm/mach-imx/clock-imx35.c
@@ -486,9 +486,10 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
+	/* i.mx35 has the i.mx21 type uart */
+	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
+	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
+	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
 	_REGISTER_CLOCK("mxc-ehci.0", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc-ehci.1", "usb", usbotg_clk)
 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 699b0d2..6634f6c 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -1422,9 +1422,10 @@ DEFINE_CLOCK(ipu_di1_clk, 0, MXC_CCM_CCGR6, MXC_CCM_CCGRx_CG6_OFFSET,
        },
 
 static struct clk_lookup mx51_lookups[] = {
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
+	/* i.mx51 has the i.mx21 type uart */
+	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
+	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
+	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("mxc_pwm.0", "pwm", pwm1_clk)
@@ -1469,11 +1470,12 @@ static struct clk_lookup mx51_lookups[] = {
 };
 
 static struct clk_lookup mx53_lookups[] = {
-	_REGISTER_CLOCK("imx-uart.0", NULL, uart1_clk)
-	_REGISTER_CLOCK("imx-uart.1", NULL, uart2_clk)
-	_REGISTER_CLOCK("imx-uart.2", NULL, uart3_clk)
-	_REGISTER_CLOCK("imx-uart.3", NULL, uart4_clk)
-	_REGISTER_CLOCK("imx-uart.4", NULL, uart5_clk)
+	/* i.mx53 has the i.mx21 type uart */
+	_REGISTER_CLOCK("imx21-uart.0", NULL, uart1_clk)
+	_REGISTER_CLOCK("imx21-uart.1", NULL, uart2_clk)
+	_REGISTER_CLOCK("imx21-uart.2", NULL, uart3_clk)
+	_REGISTER_CLOCK("imx21-uart.3", NULL, uart4_clk)
+	_REGISTER_CLOCK("imx21-uart.4", NULL, uart5_clk)
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK(NULL, "iim_clk", iim_clk)
diff --git a/arch/arm/plat-mxc/devices/platform-imx-uart.c b/arch/arm/plat-mxc/devices/platform-imx-uart.c
index cfce8c9..a425a5a 100644
--- a/arch/arm/plat-mxc/devices/platform-imx-uart.c
+++ b/arch/arm/plat-mxc/devices/platform-imx-uart.c
@@ -152,7 +152,7 @@ struct platform_device *__init imx_add_imx_uart_3irq(
 		},
 	};
 
-	return imx_add_platform_device("imx-uart", data->id, res,
+	return imx_add_platform_device("imx1-uart", data->id, res,
 			ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
 
@@ -172,6 +172,7 @@ struct platform_device *__init imx_add_imx_uart_1irq(
 		},
 	};
 
-	return imx_add_platform_device("imx-uart", data->id, res, ARRAY_SIZE(res),
-			pdata, sizeof(*pdata));
+	/* i.mx21 type uart runs on all i.mx expcept i.mx1 */
+	return imx_add_platform_device("imx21-uart", data->id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
 }
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 22fe801..6a979b4 100644
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
+#define IMX21_ONEMS 0xb0 /* One Millisecond register */
+#define IMX1_UTS 0xd0 /* UART Test Register on i.mx1 */
+#define IMX21_UTS 0xb4 /* UART Test Register on all other i.mx*/
 
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
+#define  IMX21_UCR3_RXDMUXSEL	 (1<<2)  /* RXD Muxed Input Select */
 #define  UCR3_INVT  	 (1<<1)  /* Inverted Infrared transmission */
 #define  UCR3_BPEN  	 (1<<0)  /* Preset registers enable */
 #define  UCR4_CTSTL_SHF  10      /* CTS trigger level shift */
@@ -181,6 +179,18 @@
 
 #define UART_NR 8
 
+/* i.mx21 type uart runs on all i.mx expcept i.mx1 */
+enum imx_uart_type {
+	IMX1_UART,
+	IMX21_UART,
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
@@ -192,6 +202,7 @@ struct imx_port {
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk;
+	struct imx_uart_data	*devdata;
 };
 
 #ifdef CONFIG_IRDA
@@ -200,6 +211,33 @@ struct imx_port {
 #define USE_IRDA(sport)	(0)
 #endif
 
+#define UTS (sport->devdata->uts_reg)
+#define IS_IMX1_UART()	(sport->devdata->devtype == IMX1_UART)
+#define IS_IMX21_UART()	(sport->devdata->devtype == IMX21_UART)
+
+static struct imx_uart_data imx_uart_devdata[] = {
+	[IMX1_UART] = {
+		.uts_reg = IMX1_UTS,
+		.devtype = IMX1_UART,
+	},
+	[IMX21_UART] = {
+		.uts_reg = IMX21_UTS,
+		.devtype = IMX21_UART,
+	},
+};
+
+static struct platform_device_id imx_uart_devtype[] = {
+	{
+		.name = "imx1-uart",
+		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX1_UART],
+	}, {
+		.name = "imx21-uart",
+		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX21_UART],
+	}, {
+		/* sentinel */
+	}
+};
+
 /*
  * Handle any change of modem status signal since we were last called.
  */
@@ -689,9 +727,9 @@ static int imx_startup(struct uart_port *port)
 		}
 	}
 
-	if (!cpu_is_mx1()) {
+	if (IS_IMX21_UART()) {
 		temp = readl(sport->port.membase + UCR3);
-		temp |= MX2_UCR3_RXDMUXSEL;
+		temp |= IMX21_UCR3_RXDMUXSEL;
 		writel(temp, sport->port.membase + UCR3);
 	}
 
@@ -923,9 +961,9 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	writel(num, sport->port.membase + UBIR);
 	writel(denom, sport->port.membase + UBMR);
 
-	if (!cpu_is_mx1())
+	if (IS_IMX21_UART())
 		writel(sport->port.uartclk / div / 1000,
-				sport->port.membase + MX2_ONEMS);
+				sport->port.membase + IMX21_ONEMS);
 
 	writel(old_ucr1, sport->port.membase + UCR1);
 
@@ -1062,8 +1100,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	ucr1 = old_ucr1 = readl(sport->port.membase + UCR1);
 	old_ucr2 = readl(sport->port.membase + UCR2);
 
-	if (cpu_is_mx1())
-		ucr1 |= MX1_UCR1_UARTCLKEN;
+	if (IS_IMX1_UART())
+		ucr1 |= IMX1_UCR1_UARTCLKEN;
 	ucr1 |= UCR1_UARTEN;
 	ucr1 &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN);
 
@@ -1262,6 +1300,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	init_timer(&sport->timer);
 	sport->timer.function = imx_timeout;
 	sport->timer.data     = (unsigned long)sport;
+	sport->devdata = (struct imx_uart_data	*) pdev->id_entry->driver_data;
 
 	sport->clk = clk_get(&pdev->dev, "uart");
 	if (IS_ERR(sport->clk)) {
@@ -1340,6 +1379,7 @@ static struct platform_driver serial_imx_driver = {
 
 	.suspend	= serial_imx_suspend,
 	.resume		= serial_imx_resume,
+	.id_table	= imx_uart_devtype,
 	.driver		= {
 		.name	= "imx-uart",
 		.owner	= THIS_MODULE,
-- 
1.7.4.1


