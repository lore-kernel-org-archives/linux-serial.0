From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] serial: samsung: move handling of fclk/n clock to platform code
Date: Wed, 21 Sep 2011 08:54:32 +0530
Message-ID: <1316575472-10775-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:20557 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778Ab1IUDZA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Sep 2011 23:25:00 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: alan@linux.intel.com, ben-linux@fluff.org, anarsoul@gmail.com, linux-arm-kernel@lists.infradead.org, kgene.kim@samsung.com

s3c2440 uses fclk/n (fclk divided by n) clock as one of the possible clocks used
to generate the baud rate clock. The divider 'n' in this case can be logically
represented outside of the uart controller.

This patch creates a new clock by name "fclk_n" for s3c2440 based platforms to
represent the fclk/n clock in the platform code. This clock provides a get_rate
callback that checks the UCON0/1/2 registers to determine the clock rate. The
samsung uart driver would receive the "fclk_n" clock name as one of the possible
baud rate clock options and the driver need not determine clock rate of fclk/n.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
In order to add clkdev based clock lookup (moving away from passing clock names
in platform data) for the Samsung UART driver, some portions of this driver
have to be first simplified. In this patch, the complicated handling on fclk/n
clock is removed which would further result in removing of the struct
s3c24xx_uart_clksrc itself and consolidation of the clock handling for
various SoC's supported by the Samsung UART driver.

The addition of clkdev based clock lookup is required to fully add device tree
support for the Samsung driver (no platform data when using device tree based
discovery means no list of clock names for baud rate clock).

This patch has been tested on smdk2440 board and following two patches
applied on top of linux 3.1-rc6.
[PATCH] serial: samsung: Add unified interrupt handler for s3c64xx and later SoC's
[PATCH] ARM: SAMSUNG: Remove uart irq handling from plaform code

 arch/arm/mach-s3c2440/clock.c       |   37 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-s3c2440/mach-rx1950.c |    4 +-
 arch/arm/mach-s3c2440/mach-rx3715.c |    4 +-
 drivers/tty/serial/s3c2440.c        |   33 ++----------------------------
 drivers/tty/serial/samsung.c        |   21 -------------------
 5 files changed, 44 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-s3c2440/clock.c b/arch/arm/mach-s3c2440/clock.c
index f9e6bda..8a6cf6a 100644
--- a/arch/arm/mach-s3c2440/clock.c
+++ b/arch/arm/mach-s3c2440/clock.c
@@ -34,6 +34,7 @@
 #include <linux/mutex.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/serial_core.h>
 
 #include <mach/hardware.h>
 #include <linux/atomic.h>
@@ -43,6 +44,7 @@
 
 #include <plat/clock.h>
 #include <plat/cpu.h>
+#include <plat/regs-serial.h>
 
 /* S3C2440 extended clock support */
 
@@ -108,6 +110,40 @@ static struct clk s3c2440_clk_ac97 = {
 	.ctrlbit	= S3C2440_CLKCON_CAMERA,
 };
 
+static unsigned long  s3c2440_fclk_n_getrate(struct clk *clk)
+{
+	unsigned long ucon0, ucon1, ucon2, divisor;
+
+	/* the fun of calculating the uart divisors on the s3c2440 */
+	ucon0 = __raw_readl(S3C24XX_VA_UART0 + S3C2410_UCON);
+	ucon1 = __raw_readl(S3C24XX_VA_UART1 + S3C2410_UCON);
+	ucon2 = __raw_readl(S3C24XX_VA_UART2 + S3C2410_UCON);
+
+	ucon0 &= S3C2440_UCON0_DIVMASK;
+	ucon1 &= S3C2440_UCON1_DIVMASK;
+	ucon2 &= S3C2440_UCON2_DIVMASK;
+
+	if (ucon0 != 0)
+		divisor = (ucon0 >> S3C2440_UCON_DIVSHIFT) + 6;
+	else if (ucon1 != 0)
+		divisor = (ucon1 >> S3C2440_UCON_DIVSHIFT) + 21;
+	else if (ucon2 != 0)
+		divisor = (ucon2 >> S3C2440_UCON_DIVSHIFT) + 36;
+	else
+		/* manual calims 44, seems to be 9 */
+		divisor = 9;
+
+	return clk_get_rate(clk->parent) / divisor;
+}
+
+static struct clk s3c2440_clk_fclk_n = {
+	.name		= "fclk_n",
+	.parent		= &clk_f,
+	.ops		= &(struct clk_ops) {
+		.get_rate	= s3c2440_fclk_n_getrate,
+	},
+};
+
 static int s3c2440_clk_add(struct sys_device *sysdev)
 {
 	struct clk *clock_upll;
@@ -126,6 +162,7 @@ static int s3c2440_clk_add(struct sys_device *sysdev)
 	s3c2440_clk_cam.parent = clock_h;
 	s3c2440_clk_ac97.parent = clock_p;
 	s3c2440_clk_cam_upll.parent = clock_upll;
+	s3c24xx_register_clock(&s3c2440_clk_fclk_n);
 
 	s3c24xx_register_clock(&s3c2440_clk_ac97);
 	s3c24xx_register_clock(&s3c2440_clk_cam);
diff --git a/arch/arm/mach-s3c2440/mach-rx1950.c b/arch/arm/mach-s3c2440/mach-rx1950.c
index 27ea950..9528b37 100644
--- a/arch/arm/mach-s3c2440/mach-rx1950.c
+++ b/arch/arm/mach-s3c2440/mach-rx1950.c
@@ -69,8 +69,8 @@ static struct map_desc rx1950_iodesc[] __initdata = {
 
 static struct s3c24xx_uart_clksrc rx1950_serial_clocks[] = {
 	[0] = {
-	       .name = "fclk",
-	       .divisor = 0x0a,
+	       .name = "fclk_n",
+	       .divisor = 1,
 	       .min_baud = 0,
 	       .max_baud = 0,
 	},
diff --git a/arch/arm/mach-s3c2440/mach-rx3715.c b/arch/arm/mach-s3c2440/mach-rx3715.c
index 1472b1a..a88247e 100644
--- a/arch/arm/mach-s3c2440/mach-rx3715.c
+++ b/arch/arm/mach-s3c2440/mach-rx3715.c
@@ -70,8 +70,8 @@ static struct map_desc rx3715_iodesc[] __initdata = {
 
 static struct s3c24xx_uart_clksrc rx3715_serial_clocks[] = {
 	[0] = {
-		.name		= "fclk",
-		.divisor	= 0,
+		.name		= "fclk_n",
+		.divisor	= 1,
 		.min_baud	= 0,
 		.max_baud	= 0,
 	}
diff --git a/drivers/tty/serial/s3c2440.c b/drivers/tty/serial/s3c2440.c
index 1d0c324..4498828 100644
--- a/drivers/tty/serial/s3c2440.c
+++ b/drivers/tty/serial/s3c2440.c
@@ -39,7 +39,7 @@ static int s3c2440_serial_setsource(struct uart_port *port,
 		ucon |= S3C2440_UCON_UCLK;
 	else if (strcmp(clk->name, "pclk") == 0)
 		ucon |= S3C2440_UCON_PCLK;
-	else if (strcmp(clk->name, "fclk") == 0)
+	else if (strcmp(clk->name, "fclk_n") == 0)
 		ucon |= S3C2440_UCON_FCLK;
 	else {
 		printk(KERN_ERR "unknown clock source %s\n", clk->name);
@@ -55,7 +55,6 @@ static int s3c2440_serial_getsource(struct uart_port *port,
 				    struct s3c24xx_uart_clksrc *clk)
 {
 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-	unsigned long ucon0, ucon1, ucon2;
 
 	switch (ucon & S3C2440_UCON_CLKMASK) {
 	case S3C2440_UCON_UCLK:
@@ -70,34 +69,8 @@ static int s3c2440_serial_getsource(struct uart_port *port,
 		break;
 
 	case S3C2440_UCON_FCLK:
-		/* the fun of calculating the uart divisors on
-		 * the s3c2440 */
-
-		ucon0 = __raw_readl(S3C24XX_VA_UART0 + S3C2410_UCON);
-		ucon1 = __raw_readl(S3C24XX_VA_UART1 + S3C2410_UCON);
-		ucon2 = __raw_readl(S3C24XX_VA_UART2 + S3C2410_UCON);
-
-		printk("ucons: %08lx, %08lx, %08lx\n", ucon0, ucon1, ucon2);
-
-		ucon0 &= S3C2440_UCON0_DIVMASK;
-		ucon1 &= S3C2440_UCON1_DIVMASK;
-		ucon2 &= S3C2440_UCON2_DIVMASK;
-
-		if (ucon0 != 0) {
-			clk->divisor = ucon0 >> S3C2440_UCON_DIVSHIFT;
-			clk->divisor += 6;
-		} else if (ucon1 != 0) {
-			clk->divisor = ucon1 >> S3C2440_UCON_DIVSHIFT;
-			clk->divisor += 21;
-		} else if (ucon2 != 0) {
-			clk->divisor = ucon2 >> S3C2440_UCON_DIVSHIFT;
-			clk->divisor += 36;
-		} else {
-			/* manual calims 44, seems to be 9 */
-			clk->divisor = 9;
-		}
-
-		clk->name = "fclk";
+		clk->divisor = 1;
+		clk->name = "fclk_n";
 		break;
 	}
 
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 6edafb5..97e45cd 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -569,27 +569,6 @@ static unsigned int s3c24xx_serial_getclk(struct uart_port *port,
 		if (cfg->clocks_size == 0)
 			clkp = &tmp_clksrc;
 
-		/* check to see if we're sourcing fclk, and if so we're
-		 * going to have to update the clock source
-		 */
-
-		if (strcmp(clkp->name, "fclk") == 0) {
-			struct s3c24xx_uart_clksrc src;
-
-			s3c24xx_serial_getsource(port, &src);
-
-			/* check that the port already using fclk, and if
-			 * not, then re-select fclk
-			 */
-
-			if (strcmp(src.name, clkp->name) == 0) {
-				s3c24xx_serial_setsource(port, clkp);
-				s3c24xx_serial_getsource(port, &src);
-			}
-
-			clkp->divisor = src.divisor;
-		}
-
 		s3c24xx_serial_calcbaud(res, port, clkp, baud);
 		best = res;
 		resptr = best + 1;
-- 
1.6.6.rc2

