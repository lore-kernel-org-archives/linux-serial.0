From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v2 3/9] serial: samsung: switch to clkdev based clock lookup
Date: Mon, 10 Oct 2011 15:37:59 +0530
Message-ID: <1318241285-23568-4-git-send-email-thomas.abraham@linaro.org>
References: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31049 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157Ab1JJKGz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Oct 2011 06:06:55 -0400
In-reply-to: <1318241285-23568-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, grant.likely@secretlab.ca, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org

Instead of using clock names supplied in platform data, use a generic
clock name 'clk_uart_baud' to look up clocks. The platform code should
register clocks with the name 'clk_uart_baud' which can be used by the
baud rate generator. The clock lookup and selection of the best clock
as baud rate clock is reworked.

Platform code can specify the clocks that can be used as source for the
baud clock (as supported previously by passing names of clocks). A new
member is added to the platform data 'clk_sel' which holds a bit-field
value with each bit representing a baud source clock. If a bit at any
bit position is set, that clock is looked up to participate in the
selection of the baud clock source.

Cc: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/plat-samsung/include/plat/regs-serial.h |    5 +
 drivers/tty/serial/samsung.c                     |  207 +++++++++-------------
 drivers/tty/serial/samsung.h                     |    4 +
 3 files changed, 95 insertions(+), 121 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index 7207348..b493d8d 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -222,6 +222,10 @@
 #define S5PV210_UFSTAT_RXSHIFT	(0)
 
 #define NO_NEED_CHECK_CLKSRC	1
+#define S3C2410_UCON_CLKSEL0	(1 << 0)
+#define S3C2410_UCON_CLKSEL1	(1 << 1)
+#define S3C2410_UCON_CLKSEL2	(1 << 2)
+#define S3C2410_UCON_CLKSEL3	(1 << 3)
 
 #ifndef __ASSEMBLY__
 
@@ -257,6 +261,7 @@ struct s3c2410_uartcfg {
 	unsigned char	   unused;
 	unsigned short	   flags;
 	upf_t		   uart_flags;	 /* default uart flags */
+	unsigned int	   clk_sel;
 
 	unsigned int	   has_fracval;
 
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index fc242b2..dc5a4ed 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -49,6 +49,7 @@
 #include <mach/map.h>
 
 #include <plat/regs-serial.h>
+#include <plat/clock.h>
 
 #include "samsung.h"
 
@@ -558,133 +559,98 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
  *
 */
 
+#define MAX_CLK_NAME_LENGTH 15
 
-#define MAX_CLKS (8)
-
-static struct s3c24xx_uart_clksrc tmp_clksrc = {
-	.name		= "pclk",
-	.min_baud	= 0,
-	.max_baud	= 0,
-	.divisor	= 1,
-};
-
-static inline int
-s3c24xx_serial_getsource(struct uart_port *port, struct s3c24xx_uart_clksrc *c)
+static inline int s3c24xx_serial_getsource(struct uart_port *port)
 {
 	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	unsigned int ucon;
 
-	return (info->get_clksrc)(port, c);
-}
-
-static inline int
-s3c24xx_serial_setsource(struct uart_port *port, struct s3c24xx_uart_clksrc *c)
-{
-	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	if (info->num_clks == 1)
+		return 0;
 
-	return (info->set_clksrc)(port, c);
+	ucon = rd_regl(port, S3C2410_UCON);
+	ucon &= info->clksel_mask;
+	return ucon >> info->clksel_shift;
 }
 
-struct baud_calc {
-	struct s3c24xx_uart_clksrc	*clksrc;
-	unsigned int			 calc;
-	unsigned int			 divslot;
-	unsigned int			 quot;
-	struct clk			*src;
-};
-
-static int s3c24xx_serial_calcbaud(struct baud_calc *calc,
-				   struct uart_port *port,
-				   struct s3c24xx_uart_clksrc *clksrc,
-				   unsigned int baud)
+static void s3c24xx_serial_setsource(struct uart_port *port,
+			unsigned int clk_sel)
 {
-	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long rate;
-
-	calc->src = clk_get(port->dev, clksrc->name);
-	if (calc->src == NULL || IS_ERR(calc->src))
-		return 0;
-
-	rate = clk_get_rate(calc->src);
-	rate /= clksrc->divisor;
+	struct s3c24xx_uart_info *info = s3c24xx_port_to_info(port);
+	unsigned int ucon;
 
-	calc->clksrc = clksrc;
+	if (info->num_clks == 1)
+		return;
 
-	if (ourport->info->has_divslot) {
-		unsigned long div = rate / baud;
-
-		/* The UDIVSLOT register on the newer UARTs allows us to
-		 * get a divisor adjustment of 1/16th on the baud clock.
-		 *
-		 * We don't keep the UDIVSLOT value (the 16ths we calculated
-		 * by not multiplying the baud by 16) as it is easy enough
-		 * to recalculate.
-		 */
-
-		calc->quot = div / 16;
-		calc->calc = rate / div;
-	} else {
-		calc->quot = (rate + (8 * baud)) / (16 * baud);
-		calc->calc = (rate / (calc->quot * 16));
-	}
+	ucon = rd_regl(port, S3C2410_UCON);
+	if ((ucon & info->clksel_mask) >> info->clksel_shift == clk_sel)
+		return;
 
-	calc->quot--;
-	return 1;
+	ucon &= ~info->clksel_mask;
+	ucon |= clk_sel << info->clksel_shift;
+	wr_regl(port, S3C2410_UCON, ucon);
 }
 
-static unsigned int s3c24xx_serial_getclk(struct uart_port *port,
-					  struct s3c24xx_uart_clksrc **clksrc,
-					  struct clk **clk,
-					  unsigned int baud)
+static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
+			unsigned int req_baud, struct clk **best_clk,
+			unsigned int *clk_num)
 {
-	struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
-	struct s3c24xx_uart_clksrc *clkp;
-	struct baud_calc res[MAX_CLKS];
-	struct baud_calc *resptr, *best, *sptr;
-	int i;
-
-	clkp = cfg->clocks;
-	best = NULL;
-
-	if (cfg->clocks_size < 2) {
-		if (cfg->clocks_size == 0)
-			clkp = &tmp_clksrc;
-
-		s3c24xx_serial_calcbaud(res, port, clkp, baud);
-		best = res;
-		resptr = best + 1;
-	} else {
-		resptr = res;
-
-		for (i = 0; i < cfg->clocks_size; i++, clkp++) {
-			if (s3c24xx_serial_calcbaud(resptr, port, clkp, baud))
-				resptr++;
+	struct s3c24xx_uart_info *info = ourport->info;
+	struct clk *clk;
+	unsigned long rate;
+	unsigned int cnt, baud, quot, clk_sel, best_quot = 0;
+	char clkname[MAX_CLK_NAME_LENGTH];
+	int calc_deviation, deviation = (1 << 30) - 1;
+
+	*best_clk = NULL;
+	clk_sel = (ourport->cfg->clk_sel) ? ourport->cfg->clk_sel :
+			ourport->info->def_clk_sel;
+	for (cnt = 0; cnt < info->num_clks; cnt++) {
+		if (!(clk_sel & (1 << cnt)))
+			continue;
+
+		sprintf(clkname, "clk_uart_baud%d", cnt);
+		clk = clk_get(ourport->port.dev, clkname);
+		if (IS_ERR_OR_NULL(clk))
+			continue;
+
+		rate = clk_get_rate(clk);
+		if (!rate)
+			continue;
+
+		if (ourport->info->has_divslot) {
+			unsigned long div = rate / req_baud;
+
+			/* The UDIVSLOT register on the newer UARTs allows us to
+			 * get a divisor adjustment of 1/16th on the baud clock.
+			 *
+			 * We don't keep the UDIVSLOT value (the 16ths we
+			 * calculated by not multiplying the baud by 16) as it
+			 * is easy enough to recalculate.
+			 */
+
+			quot = div / 16;
+			baud = rate / div;
+		} else {
+			quot = (rate + (8 * req_baud)) / (16 * req_baud);
+			baud = rate / (quot * 16);
 		}
-	}
-
-	/* ok, we now need to select the best clock we found */
-
-	if (!best) {
-		unsigned int deviation = (1<<30)|((1<<30)-1);
-		int calc_deviation;
+		quot--;
 
-		for (sptr = res; sptr < resptr; sptr++) {
-			calc_deviation = baud - sptr->calc;
-			if (calc_deviation < 0)
-				calc_deviation = -calc_deviation;
+		calc_deviation = req_baud - baud;
+		if (calc_deviation < 0)
+			calc_deviation = -calc_deviation;
 
-			if (calc_deviation < deviation) {
-				best = sptr;
-				deviation = calc_deviation;
-			}
+		if (calc_deviation < deviation) {
+			*best_clk = clk;
+			best_quot = quot;
+			*clk_num = cnt;
+			deviation = calc_deviation;
 		}
 	}
 
-	/* store results to pass back */
-
-	*clksrc = best->clksrc;
-	*clk    = best->src;
-
-	return best->quot;
+	return best_quot;
 }
 
 /* udivslot_table[]
@@ -717,10 +683,9 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 {
 	struct s3c2410_uartcfg *cfg = s3c24xx_port_to_cfg(port);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	struct s3c24xx_uart_clksrc *clksrc = NULL;
 	struct clk *clk = NULL;
 	unsigned long flags;
-	unsigned int baud, quot;
+	unsigned int baud, quot, clk_sel = 0;
 	unsigned int ulcon;
 	unsigned int umcon;
 	unsigned int udivslot = 0;
@@ -736,17 +701,16 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 	 */
 
 	baud = uart_get_baud_rate(port, termios, old, 0, 115200*8);
-
+	quot = s3c24xx_serial_getclk(ourport, baud, &clk, &clk_sel);
 	if (baud == 38400 && (port->flags & UPF_SPD_MASK) == UPF_SPD_CUST)
 		quot = port->custom_divisor;
-	else
-		quot = s3c24xx_serial_getclk(port, &clksrc, &clk, baud);
+	if (!clk)
+		return;
 
 	/* check to see if we need  to change clock source */
 
-	if (ourport->clksrc != clksrc || ourport->baudclk != clk) {
-		dbg("selecting clock %p\n", clk);
-		s3c24xx_serial_setsource(port, clksrc);
+	if (ourport->baudclk != clk) {
+		s3c24xx_serial_setsource(port, clk_sel);
 
 		if (ourport->baudclk != NULL && !IS_ERR(ourport->baudclk)) {
 			clk_disable(ourport->baudclk);
@@ -755,7 +719,6 @@ static void s3c24xx_serial_set_termios(struct uart_port *port,
 
 		clk_enable(clk);
 
-		ourport->clksrc = clksrc;
 		ourport->baudclk = clk;
 		ourport->baudclk_rate = clk ? clk_get_rate(clk) : 0;
 	}
@@ -1202,7 +1165,7 @@ static ssize_t s3c24xx_serial_show_clksrc(struct device *dev,
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
-	return snprintf(buf, PAGE_SIZE, "* %s\n", ourport->clksrc->name);
+	return snprintf(buf, PAGE_SIZE, "* %s\n", ourport->baudclk->name);
 }
 
 static DEVICE_ATTR(clock_source, S_IRUGO, s3c24xx_serial_show_clksrc, NULL);
@@ -1382,12 +1345,13 @@ static void __init
 s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 			   int *parity, int *bits)
 {
-	struct s3c24xx_uart_clksrc clksrc;
 	struct clk *clk;
 	unsigned int ulcon;
 	unsigned int ucon;
 	unsigned int ubrdiv;
 	unsigned long rate;
+	unsigned int clk_sel;
+	char clk_name[MAX_CLK_NAME_LENGTH];
 
 	ulcon  = rd_regl(port, S3C2410_ULCON);
 	ucon   = rd_regl(port, S3C2410_UCON);
@@ -1432,11 +1396,12 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 
 		/* now calculate the baud rate */
 
-		s3c24xx_serial_getsource(port, &clksrc);
+		clk_sel = s3c24xx_serial_getsource(port);
+		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
 
-		clk = clk_get(port->dev, clksrc.name);
+		clk = clk_get(port->dev, clk_name);
 		if (!IS_ERR(clk) && clk != NULL)
-			rate = clk_get_rate(clk) / clksrc.divisor;
+			rate = clk_get_rate(clk);
 		else
 			rate = 1;
 
diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index 6c9cb9d..11369f3 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -19,6 +19,10 @@ struct s3c24xx_uart_info {
 	unsigned long		tx_fifomask;
 	unsigned long		tx_fifoshift;
 	unsigned long		tx_fifofull;
+	unsigned int		def_clk_sel;
+	unsigned long		num_clks;
+	unsigned long		clksel_mask;
+	unsigned long		clksel_shift;
 
 	/* uart port features */
 
-- 
1.6.6.rc2

