From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH 7/9] serial: samsung: merge all SoC specific port reset
 functions
Date: Tue, 27 Sep 2011 00:37:16 +0530
Message-ID: <1317064038-32428-8-git-send-email-thomas.abraham@linaro.org>
References: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:30769 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab1IZTHn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Sep 2011 15:07:43 -0400
In-reply-to: <1317064038-32428-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org

The SoC specific port reset functions is removed from SoC extensions of
the Samsung serial driver and merged into a single port reset function.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/tty/serial/s3c2410.c |   18 ------------------
 drivers/tty/serial/s3c2412.c |   24 ------------------------
 drivers/tty/serial/s3c2440.c |   24 ------------------------
 drivers/tty/serial/s3c6400.c |   24 ------------------------
 drivers/tty/serial/s5pv210.c |   22 +---------------------
 drivers/tty/serial/samsung.c |   25 +++++++++++++++++++------
 6 files changed, 20 insertions(+), 117 deletions(-)

diff --git a/drivers/tty/serial/s3c2410.c b/drivers/tty/serial/s3c2410.c
index e668a9d..1491c32 100644
--- a/drivers/tty/serial/s3c2410.c
+++ b/drivers/tty/serial/s3c2410.c
@@ -25,23 +25,6 @@
 
 #include "samsung.h"
 
-static int s3c2410_serial_resetport(struct uart_port *port,
-				    struct s3c2410_uartcfg *cfg)
-{
-	dbg("s3c2410_serial_resetport: port=%p (%08lx), cfg=%p\n",
-	    port, port->mapbase, cfg);
-
-	wr_regl(port, S3C2410_UCON,  cfg->ucon);
-	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
-
-	/* reset both fifos */
-
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
-
-	return 0;
-}
-
 static struct s3c24xx_uart_info s3c2410_uart_inf = {
 	.name		= "Samsung S3C2410 UART",
 	.type		= PORT_S3C2410,
@@ -56,7 +39,6 @@ static struct s3c24xx_uart_info s3c2410_uart_inf = {
 	.num_clks	= 2,
 	.clksel_mask	= S3C2410_UCON_CLKMASK,
 	.clksel_shift	= S3C2410_UCON_CLKSHIFT,
-	.reset_port	= s3c2410_serial_resetport,
 };
 
 static int s3c2410_serial_probe(struct platform_device *dev)
diff --git a/drivers/tty/serial/s3c2412.c b/drivers/tty/serial/s3c2412.c
index 5b85c19..38ae730 100644
--- a/drivers/tty/serial/s3c2412.c
+++ b/drivers/tty/serial/s3c2412.c
@@ -25,29 +25,6 @@
 
 #include "samsung.h"
 
-static int s3c2412_serial_resetport(struct uart_port *port,
-				    struct s3c2410_uartcfg *cfg)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	dbg("%s: port=%p (%08lx), cfg=%p\n",
-	    __func__, port, port->mapbase, cfg);
-
-	/* ensure we don't change the clock settings... */
-
-	ucon &= S3C2412_UCON_CLKMASK;
-
-	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
-	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
-
-	/* reset both fifos */
-
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
-
-	return 0;
-}
-
 static struct s3c24xx_uart_info s3c2412_uart_inf = {
 	.name		= "Samsung S3C2412 UART",
 	.type		= PORT_S3C2412,
@@ -63,7 +40,6 @@ static struct s3c24xx_uart_info s3c2412_uart_inf = {
 	.num_clks	= 4,
 	.clksel_mask	= S3C2412_UCON_CLKMASK,
 	.clksel_shift	= S3C2412_UCON_CLKSHIFT,
-	.reset_port	= s3c2412_serial_resetport,
 };
 
 /* device management */
diff --git a/drivers/tty/serial/s3c2440.c b/drivers/tty/serial/s3c2440.c
index 39930f8..70652f5 100644
--- a/drivers/tty/serial/s3c2440.c
+++ b/drivers/tty/serial/s3c2440.c
@@ -25,29 +25,6 @@
 
 #include "samsung.h"
 
-static int s3c2440_serial_resetport(struct uart_port *port,
-				    struct s3c2410_uartcfg *cfg)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	dbg("s3c2440_serial_resetport: port=%p (%08lx), cfg=%p\n",
-	    port, port->mapbase, cfg);
-
-	/* ensure we don't change the clock settings... */
-
-	ucon &= (S3C2440_UCON0_DIVMASK | (3<<10));
-
-	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
-	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
-
-	/* reset both fifos */
-
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
-
-	return 0;
-}
-
 static struct s3c24xx_uart_info s3c2440_uart_inf = {
 	.name		= "Samsung S3C2440 UART",
 	.type		= PORT_S3C2440,
@@ -62,7 +39,6 @@ static struct s3c24xx_uart_info s3c2440_uart_inf = {
 	.num_clks	= 4,
 	.clksel_mask	= S3C2440_UCON_CLKMASK,
 	.clksel_shift	= S3C2440_UCON_CLKSHIFT,
-	.reset_port	= s3c2440_serial_resetport,
 };
 
 /* device management */
diff --git a/drivers/tty/serial/s3c6400.c b/drivers/tty/serial/s3c6400.c
index c5a6d46..30a69f1 100644
--- a/drivers/tty/serial/s3c6400.c
+++ b/drivers/tty/serial/s3c6400.c
@@ -26,29 +26,6 @@
 
 #include "samsung.h"
 
-static int s3c6400_serial_resetport(struct uart_port *port,
-				    struct s3c2410_uartcfg *cfg)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	dbg("s3c6400_serial_resetport: port=%p (%08lx), cfg=%p\n",
-	    port, port->mapbase, cfg);
-
-	/* ensure we don't change the clock settings... */
-
-	ucon &= S3C6400_UCON_CLKMASK;
-
-	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
-	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
-
-	/* reset both fifos */
-
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
-
-	return 0;
-}
-
 static struct s3c24xx_uart_info s3c6400_uart_inf = {
 	.name		= "Samsung S3C6400 UART",
 	.type		= PORT_S3C6400,
@@ -64,7 +41,6 @@ static struct s3c24xx_uart_info s3c6400_uart_inf = {
 	.num_clks	= 4,
 	.clksel_mask	= S3C6400_UCON_CLKMASK,
 	.clksel_shift	= S3C6400_UCON_CLKSHIFT,
-	.reset_port	= s3c6400_serial_resetport,
 };
 
 /* device management */
diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
index 173df5a..d232094 100644
--- a/drivers/tty/serial/s5pv210.c
+++ b/drivers/tty/serial/s5pv210.c
@@ -25,25 +25,6 @@
 #include <plat/regs-serial.h>
 #include "samsung.h"
 
-static int s5pv210_serial_resetport(struct uart_port *port,
-					struct s3c2410_uartcfg *cfg)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	ucon &= S5PV210_UCON_CLKMASK;
-	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
-	wr_regl(port, S3C2410_ULCON, cfg->ulcon);
-
-	/* reset both fifos */
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
-	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
-
-	/* It is need to delay When reset FIFO register */
-	udelay(1);
-
-	return 0;
-}
-
 #define S5PV210_UART_DEFAULT_INFO(fifo_size)			\
 		.name		= "Samsung S5PV210 UART0",	\
 		.type		= PORT_S3C6400,			\
@@ -58,8 +39,7 @@ static int s5pv210_serial_resetport(struct uart_port *port,
 		.def_clk_sel	= S3C2410_UCON_CLKSEL0,		\
 		.num_clks	= 2,				\
 		.clksel_mask	= S5PV210_UCON_CLKMASK,		\
-		.clksel_shift	= S5PV210_UCON_CLKSHIFT,	\
-		.reset_port	= s5pv210_serial_resetport
+		.clksel_shift	= S5PV210_UCON_CLKSHIFT
 
 static struct s3c24xx_uart_info s5p_port_fifo256 = {
 	S5PV210_UART_DEFAULT_INFO(256),
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index dc5a4ed..7cd78b3 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -965,16 +965,29 @@ static struct s3c24xx_uart_port s3c24xx_serial_ports[CONFIG_SERIAL_SAMSUNG_UARTS
 
 /* s3c24xx_serial_resetport
  *
- * wrapper to call the specific reset for this port (reset the fifos
- * and the settings)
+ * reset the fifos and other the settings.
 */
 
-static inline int s3c24xx_serial_resetport(struct uart_port *port,
-					   struct s3c2410_uartcfg *cfg)
+static void s3c24xx_serial_resetport(struct uart_port *port,
+				   struct s3c2410_uartcfg *cfg)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	unsigned long ucon = rd_regl(port, S3C2410_UCON);
+	unsigned int ucon_mask;
 
-	return (info->reset_port)(port, cfg);
+	ucon_mask = info->clksel_mask;
+	if (info->type == PORT_S3C2440)
+		ucon_mask |= S3C2440_UCON0_DIVMASK;
+
+	ucon &= ucon_mask;
+	wr_regl(port, S3C2410_UCON,  ucon | cfg->ucon);
+
+	/* reset both fifos */
+	wr_regl(port, S3C2410_UFCON, cfg->ufcon | S3C2410_UFCON_RESETBOTH);
+	wr_regl(port, S3C2410_UFCON, cfg->ufcon);
+
+	/* some delay is required after fifo reset */
+	udelay(1);
 }
 
 
-- 
1.6.6.rc2

