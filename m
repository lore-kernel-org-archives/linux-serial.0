From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v2 5/9] serial: samsung: remove all uses of get_clksrc and
 set_clksrc
Date: Mon, 10 Oct 2011 15:38:01 +0530
Message-ID: <1318241285-23568-6-git-send-email-thomas.abraham@linaro.org>
References: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org
List-Id: linux-serial@vger.kernel.org

With clkdev based clock lookup support, the clock set and get operation
using clock names communicated between the samsung uart driver and the
SoC specific extension can be removed.

In addition to that, for each platform specific extension, add the
default clock selection, number of clock options for uart baud generator,
clock selection bit mask and shift values which is required by the
clkdev support in samsung uart driver.

The default clock selection value 'def_clk_sel' specifies the default clock
to be used as the source clock for baud rate generator in case the platform
code does not specify the same.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos4/init.c                     |    4 +-
 arch/arm/plat-samsung/include/plat/regs-serial.h |    7 ++-
 drivers/tty/serial/s3c2410.c                     |   31 ++----------
 drivers/tty/serial/s3c2412.c                     |   55 ++------------------
 drivers/tty/serial/s3c2440.c                     |   58 ++-------------------
 drivers/tty/serial/s3c6400.c                     |   54 ++------------------
 drivers/tty/serial/s5pv210.c                     |   60 ++--------------------
 drivers/tty/serial/samsung.h                     |    5 --
 8 files changed, 27 insertions(+), 247 deletions(-)

diff --git a/arch/arm/mach-exynos4/init.c b/arch/arm/mach-exynos4/init.c
index e836c9c..3c9590b 100644
--- a/arch/arm/mach-exynos4/init.c
+++ b/arch/arm/mach-exynos4/init.c
@@ -20,10 +20,8 @@ void __init exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 	struct s3c2410_uartcfg *tcfg = cfg;
 	u32 ucnt;
 
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
+	for (ucnt = 0; ucnt < no; ucnt++, tcfg++)
 		tcfg->has_fracval = 1;
-		tcfg->flags |= NO_NEED_CHECK_CLKSRC;
-	}
 
 	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
 }
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index 25f0c36..133fa97 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -71,6 +71,7 @@
 #define S3C2410_LCON_IRM          (1<<6)
 
 #define S3C2440_UCON_CLKMASK	  (3<<10)
+#define S3C2440_UCON_CLKSHIFT	  (10)
 #define S3C2440_UCON_PCLK	  (0<<10)
 #define S3C2440_UCON_UCLK	  (1<<10)
 #define S3C2440_UCON_PCLK2	  (2<<10)
@@ -78,6 +79,7 @@
 #define S3C2443_UCON_EPLL	  (3<<10)
 
 #define S3C6400_UCON_CLKMASK	(3<<10)
+#define S3C6400_UCON_CLKSHIFT	(10)
 #define S3C6400_UCON_PCLK	(0<<10)
 #define S3C6400_UCON_PCLK2	(2<<10)
 #define S3C6400_UCON_UCLK0	(1<<10)
@@ -90,11 +92,14 @@
 #define S3C2440_UCON_DIVSHIFT	  (12)
 
 #define S3C2412_UCON_CLKMASK	(3<<10)
+#define S3C2412_UCON_CLKSHIFT	(10)
 #define S3C2412_UCON_UCLK	(1<<10)
 #define S3C2412_UCON_USYSCLK	(3<<10)
 #define S3C2412_UCON_PCLK	(0<<10)
 #define S3C2412_UCON_PCLK2	(2<<10)
 
+#define S3C2410_UCON_CLKMASK	(1 << 10)
+#define S3C2410_UCON_CLKSHIFT	(10)
 #define S3C2410_UCON_UCLK	  (1<<10)
 #define S3C2410_UCON_SBREAK	  (1<<4)
 
@@ -193,6 +198,7 @@
 
 /* Following are specific to S5PV210 */
 #define S5PV210_UCON_CLKMASK	(1<<10)
+#define S5PV210_UCON_CLKSHIFT	(10)
 #define S5PV210_UCON_PCLK	(0<<10)
 #define S5PV210_UCON_UCLK	(1<<10)
 
@@ -221,7 +227,6 @@
 #define S5PV210_UFSTAT_RXMASK	(255<<0)
 #define S5PV210_UFSTAT_RXSHIFT	(0)
 
-#define NO_NEED_CHECK_CLKSRC	1
 #define S3C2410_UCON_CLKSEL0	(1 << 0)
 #define S3C2410_UCON_CLKSEL1	(1 << 1)
 #define S3C2410_UCON_CLKSEL2	(1 << 2)
diff --git a/drivers/tty/serial/s3c2410.c b/drivers/tty/serial/s3c2410.c
index b1d7e7c..e668a9d 100644
--- a/drivers/tty/serial/s3c2410.c
+++ b/drivers/tty/serial/s3c2410.c
@@ -25,31 +25,6 @@
 
 #include "samsung.h"
 
-static int s3c2410_serial_setsource(struct uart_port *port,
-				    struct s3c24xx_uart_clksrc *clk)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	if (strcmp(clk->name, "uclk") == 0)
-		ucon |= S3C2410_UCON_UCLK;
-	else
-		ucon &= ~S3C2410_UCON_UCLK;
-
-	wr_regl(port, S3C2410_UCON, ucon);
-	return 0;
-}
-
-static int s3c2410_serial_getsource(struct uart_port *port,
-				    struct s3c24xx_uart_clksrc *clk)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	clk->divisor = 1;
-	clk->name = (ucon & S3C2410_UCON_UCLK) ? "uclk" : "pclk";
-
-	return 0;
-}
-
 static int s3c2410_serial_resetport(struct uart_port *port,
 				    struct s3c2410_uartcfg *cfg)
 {
@@ -77,8 +52,10 @@ static struct s3c24xx_uart_info s3c2410_uart_inf = {
 	.tx_fifofull	= S3C2410_UFSTAT_TXFULL,
 	.tx_fifomask	= S3C2410_UFSTAT_TXMASK,
 	.tx_fifoshift	= S3C2410_UFSTAT_TXSHIFT,
-	.get_clksrc	= s3c2410_serial_getsource,
-	.set_clksrc	= s3c2410_serial_setsource,
+	.def_clk_sel	= S3C2410_UCON_CLKSEL0,
+	.num_clks	= 2,
+	.clksel_mask	= S3C2410_UCON_CLKMASK,
+	.clksel_shift	= S3C2410_UCON_CLKSHIFT,
 	.reset_port	= s3c2410_serial_resetport,
 };
 
diff --git a/drivers/tty/serial/s3c2412.c b/drivers/tty/serial/s3c2412.c
index 2234bf9..5b85c19 100644
--- a/drivers/tty/serial/s3c2412.c
+++ b/drivers/tty/serial/s3c2412.c
@@ -25,55 +25,6 @@
 
 #include "samsung.h"
 
-static int s3c2412_serial_setsource(struct uart_port *port,
-				     struct s3c24xx_uart_clksrc *clk)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	ucon &= ~S3C2412_UCON_CLKMASK;
-
-	if (strcmp(clk->name, "uclk") == 0)
-		ucon |= S3C2440_UCON_UCLK;
-	else if (strcmp(clk->name, "pclk") == 0)
-		ucon |= S3C2440_UCON_PCLK;
-	else if (strcmp(clk->name, "usysclk") == 0)
-		ucon |= S3C2412_UCON_USYSCLK;
-	else {
-		printk(KERN_ERR "unknown clock source %s\n", clk->name);
-		return -EINVAL;
-	}
-
-	wr_regl(port, S3C2410_UCON, ucon);
-	return 0;
-}
-
-
-static int s3c2412_serial_getsource(struct uart_port *port,
-				    struct s3c24xx_uart_clksrc *clk)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	switch (ucon & S3C2412_UCON_CLKMASK) {
-	case S3C2412_UCON_UCLK:
-		clk->divisor = 1;
-		clk->name = "uclk";
-		break;
-
-	case S3C2412_UCON_PCLK:
-	case S3C2412_UCON_PCLK2:
-		clk->divisor = 1;
-		clk->name = "pclk";
-		break;
-
-	case S3C2412_UCON_USYSCLK:
-		clk->divisor = 1;
-		clk->name = "usysclk";
-		break;
-	}
-
-	return 0;
-}
-
 static int s3c2412_serial_resetport(struct uart_port *port,
 				    struct s3c2410_uartcfg *cfg)
 {
@@ -108,8 +59,10 @@ static struct s3c24xx_uart_info s3c2412_uart_inf = {
 	.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
 	.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
 	.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
-	.get_clksrc	= s3c2412_serial_getsource,
-	.set_clksrc	= s3c2412_serial_setsource,
+	.def_clk_sel	= S3C2410_UCON_CLKSEL2,
+	.num_clks	= 4,
+	.clksel_mask	= S3C2412_UCON_CLKMASK,
+	.clksel_shift	= S3C2412_UCON_CLKSHIFT,
 	.reset_port	= s3c2412_serial_resetport,
 };
 
diff --git a/drivers/tty/serial/s3c2440.c b/drivers/tty/serial/s3c2440.c
index 4498828..39930f8 100644
--- a/drivers/tty/serial/s3c2440.c
+++ b/drivers/tty/serial/s3c2440.c
@@ -25,58 +25,6 @@
 
 #include "samsung.h"
 
-
-static int s3c2440_serial_setsource(struct uart_port *port,
-				     struct s3c24xx_uart_clksrc *clk)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	/* todo - proper fclk<>nonfclk switch. */
-
-	ucon &= ~S3C2440_UCON_CLKMASK;
-
-	if (strcmp(clk->name, "uclk") == 0)
-		ucon |= S3C2440_UCON_UCLK;
-	else if (strcmp(clk->name, "pclk") == 0)
-		ucon |= S3C2440_UCON_PCLK;
-	else if (strcmp(clk->name, "fclk_n") == 0)
-		ucon |= S3C2440_UCON_FCLK;
-	else {
-		printk(KERN_ERR "unknown clock source %s\n", clk->name);
-		return -EINVAL;
-	}
-
-	wr_regl(port, S3C2410_UCON, ucon);
-	return 0;
-}
-
-
-static int s3c2440_serial_getsource(struct uart_port *port,
-				    struct s3c24xx_uart_clksrc *clk)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	switch (ucon & S3C2440_UCON_CLKMASK) {
-	case S3C2440_UCON_UCLK:
-		clk->divisor = 1;
-		clk->name = "uclk";
-		break;
-
-	case S3C2440_UCON_PCLK:
-	case S3C2440_UCON_PCLK2:
-		clk->divisor = 1;
-		clk->name = "pclk";
-		break;
-
-	case S3C2440_UCON_FCLK:
-		clk->divisor = 1;
-		clk->name = "fclk_n";
-		break;
-	}
-
-	return 0;
-}
-
 static int s3c2440_serial_resetport(struct uart_port *port,
 				    struct s3c2410_uartcfg *cfg)
 {
@@ -110,8 +58,10 @@ static struct s3c24xx_uart_info s3c2440_uart_inf = {
 	.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
 	.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
 	.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
-	.get_clksrc	= s3c2440_serial_getsource,
-	.set_clksrc	= s3c2440_serial_setsource,
+	.def_clk_sel	= S3C2410_UCON_CLKSEL2,
+	.num_clks	= 4,
+	.clksel_mask	= S3C2440_UCON_CLKMASK,
+	.clksel_shift	= S3C2440_UCON_CLKSHIFT,
 	.reset_port	= s3c2440_serial_resetport,
 };
 
diff --git a/drivers/tty/serial/s3c6400.c b/drivers/tty/serial/s3c6400.c
index e2f6913..c5a6d46 100644
--- a/drivers/tty/serial/s3c6400.c
+++ b/drivers/tty/serial/s3c6400.c
@@ -26,54 +26,6 @@
 
 #include "samsung.h"
 
-static int s3c6400_serial_setsource(struct uart_port *port,
-				    struct s3c24xx_uart_clksrc *clk)
-{
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	if (strcmp(clk->name, "uclk0") == 0) {
-		ucon &= ~S3C6400_UCON_CLKMASK;
-		ucon |= S3C6400_UCON_UCLK0;
-	} else if (strcmp(clk->name, "uclk1") == 0)
-		ucon |= S3C6400_UCON_UCLK1;
-	else if (strcmp(clk->name, "pclk") == 0) {
-		/* See notes about transitioning from UCLK to PCLK */
-		ucon &= ~S3C6400_UCON_UCLK0;
-	} else {
-		printk(KERN_ERR "unknown clock source %s\n", clk->name);
-		return -EINVAL;
-	}
-
-	wr_regl(port, S3C2410_UCON, ucon);
-	return 0;
-}
-
-
-static int s3c6400_serial_getsource(struct uart_port *port,
-				    struct s3c24xx_uart_clksrc *clk)
-{
-	u32 ucon = rd_regl(port, S3C2410_UCON);
-
-	clk->divisor = 1;
-
-	switch (ucon & S3C6400_UCON_CLKMASK) {
-	case S3C6400_UCON_UCLK0:
-		clk->name = "uclk0";
-		break;
-
-	case S3C6400_UCON_UCLK1:
-		clk->name = "uclk1";
-		break;
-
-	case S3C6400_UCON_PCLK:
-	case S3C6400_UCON_PCLK2:
-		clk->name = "pclk";
-		break;
-	}
-
-	return 0;
-}
-
 static int s3c6400_serial_resetport(struct uart_port *port,
 				    struct s3c2410_uartcfg *cfg)
 {
@@ -108,8 +60,10 @@ static struct s3c24xx_uart_info s3c6400_uart_inf = {
 	.tx_fifofull	= S3C2440_UFSTAT_TXFULL,
 	.tx_fifomask	= S3C2440_UFSTAT_TXMASK,
 	.tx_fifoshift	= S3C2440_UFSTAT_TXSHIFT,
-	.get_clksrc	= s3c6400_serial_getsource,
-	.set_clksrc	= s3c6400_serial_setsource,
+	.def_clk_sel	= S3C2410_UCON_CLKSEL2,
+	.num_clks	= 4,
+	.clksel_mask	= S3C6400_UCON_CLKMASK,
+	.clksel_shift	= S3C6400_UCON_CLKSHIFT,
 	.reset_port	= s3c6400_serial_resetport,
 };
 
diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
index 03b249e..173df5a 100644
--- a/drivers/tty/serial/s5pv210.c
+++ b/drivers/tty/serial/s5pv210.c
@@ -25,60 +25,6 @@
 #include <plat/regs-serial.h>
 #include "samsung.h"
 
-static int s5pv210_serial_setsource(struct uart_port *port,
-					struct s3c24xx_uart_clksrc *clk)
-{
-	struct s3c24xx_uart_port *ourport;
-	struct s3c2410_uartcfg *cfg;
-	unsigned long ucon = rd_regl(port, S3C2410_UCON);
-
-	ourport = container_of(port, struct s3c24xx_uart_port, port);
-	cfg = ourport->cfg;
-
-	if (cfg->flags & NO_NEED_CHECK_CLKSRC)
-		return 0;
-
-	if (strcmp(clk->name, "pclk") == 0)
-		ucon &= ~S5PV210_UCON_CLKMASK;
-	else if (strcmp(clk->name, "uclk1") == 0)
-		ucon |= S5PV210_UCON_CLKMASK;
-	else {
-		printk(KERN_ERR "unknown clock source %s\n", clk->name);
-		return -EINVAL;
-	}
-
-	wr_regl(port, S3C2410_UCON, ucon);
-	return 0;
-}
-
-
-static int s5pv210_serial_getsource(struct uart_port *port,
-					struct s3c24xx_uart_clksrc *clk)
-{
-	struct s3c24xx_uart_port *ourport;
-	struct s3c2410_uartcfg *cfg;
-	u32 ucon = rd_regl(port, S3C2410_UCON);
-
-	ourport = container_of(port, struct s3c24xx_uart_port, port);
-	cfg = ourport->cfg;
-
-	clk->divisor = 1;
-
-	if (cfg->flags & NO_NEED_CHECK_CLKSRC)
-		return 0;
-
-	switch (ucon & S5PV210_UCON_CLKMASK) {
-	case S5PV210_UCON_PCLK:
-		clk->name = "pclk";
-		break;
-	case S5PV210_UCON_UCLK:
-		clk->name = "uclk1";
-		break;
-	}
-
-	return 0;
-}
-
 static int s5pv210_serial_resetport(struct uart_port *port,
 					struct s3c2410_uartcfg *cfg)
 {
@@ -109,8 +55,10 @@ static int s5pv210_serial_resetport(struct uart_port *port,
 		.tx_fifofull	= S5PV210_UFSTAT_TXFULL,	\
 		.tx_fifomask	= S5PV210_UFSTAT_TXMASK,	\
 		.tx_fifoshift	= S5PV210_UFSTAT_TXSHIFT,	\
-		.get_clksrc	= s5pv210_serial_getsource,	\
-		.set_clksrc	= s5pv210_serial_setsource,	\
+		.def_clk_sel	= S3C2410_UCON_CLKSEL0,		\
+		.num_clks	= 2,				\
+		.clksel_mask	= S5PV210_UCON_CLKMASK,		\
+		.clksel_shift	= S5PV210_UCON_CLKSHIFT,	\
 		.reset_port	= s5pv210_serial_resetport
 
 static struct s3c24xx_uart_info s5p_port_fifo256 = {
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 40e9ef1..c9cab2c 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -28,11 +28,6 @@ struct s3c24xx_uart_info {
 
 	unsigned int		has_divslot:1;
 
-	/* clock source control */
-
-	int (*get_clksrc)(struct uart_port *, struct s3c24xx_uart_clksrc *clk);
-	int (*set_clksrc)(struct uart_port *, struct s3c24xx_uart_clksrc *clk);
-
 	/* uart controls */
 	int (*reset_port)(struct uart_port *, struct s3c2410_uartcfg *);
 };
-- 
1.6.6.rc2
