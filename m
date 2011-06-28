From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/12] ARM: SAMSUNG: serial: Fix on handling of one
	clock source for UART
Date: Tue, 28 Jun 2011 09:03:40 -0700
Message-ID: <1309277029-1532-3-git-send-email-gregkh@suse.de>
References: <20110628153856.GB32710@kroah.com>
	<1309277029-1532-1-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <1309277029-1532-1-git-send-email-gregkh@suse.de>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Kukjin Kim <kgene.kim@samsung.com>, stable <stable@kernel.org>, Boojin Kim <boojin.kim@samsung.com>
List-Id: linux-serial@vger.kernel.org

From: Boojin Kim <boojin.kim@samsung.com>

This patch fixes the way of comparison for handling of two or more
clock sources for UART.

For example, if just only one clock source is defined even though
there are two clock sources for UART, the serial driver does not
set proper clock up. Of course, it is problem.

So this patch changes the condition of comparison to avoid useless
setup clock and adds a flag 'NO_NEED_CHECK_CLKSRC' which means
selection of source clock is not required.

In addition, since the Exynos4210 has only one clock source for UART
this patch adds the flag into its common_init_uarts().

Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/arm/mach-exynos4/init.c                     |    1 +
 arch/arm/plat-samsung/include/plat/regs-serial.h |    2 ++
 drivers/tty/serial/s5pv210.c                     |    4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos4/init.c b/arch/arm/mach-exynos4/init.c
index cf91f50..a8a83e3 100644
--- a/arch/arm/mach-exynos4/init.c
+++ b/arch/arm/mach-exynos4/init.c
@@ -35,6 +35,7 @@ void __init exynos4_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 			tcfg->clocks = exynos4_serial_clocks;
 			tcfg->clocks_size = ARRAY_SIZE(exynos4_serial_clocks);
 		}
+		tcfg->flags |= NO_NEED_CHECK_CLKSRC;
 	}
 
 	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
diff --git a/arch/arm/plat-samsung/include/plat/regs-serial.h b/arch/arm/plat-samsung/include/plat/regs-serial.h
index c151c5f..116edfe 100644
--- a/arch/arm/plat-samsung/include/plat/regs-serial.h
+++ b/arch/arm/plat-samsung/include/plat/regs-serial.h
@@ -224,6 +224,8 @@
 #define S5PV210_UFSTAT_RXMASK	(255<<0)
 #define S5PV210_UFSTAT_RXSHIFT	(0)
 
+#define NO_NEED_CHECK_CLKSRC	1
+
 #ifndef __ASSEMBLY__
 
 /* struct s3c24xx_uart_clksrc
diff --git a/drivers/tty/serial/s5pv210.c b/drivers/tty/serial/s5pv210.c
index fb2619f..dd194dc 100644
--- a/drivers/tty/serial/s5pv210.c
+++ b/drivers/tty/serial/s5pv210.c
@@ -30,7 +30,7 @@ static int s5pv210_serial_setsource(struct uart_port *port,
 	struct s3c2410_uartcfg *cfg = port->dev->platform_data;
 	unsigned long ucon = rd_regl(port, S3C2410_UCON);
 
-	if ((cfg->clocks_size) == 1)
+	if (cfg->flags & NO_NEED_CHECK_CLKSRC)
 		return 0;
 
 	if (strcmp(clk->name, "pclk") == 0)
@@ -55,7 +55,7 @@ static int s5pv210_serial_getsource(struct uart_port *port,
 
 	clk->divisor = 1;
 
-	if ((cfg->clocks_size) == 1)
+	if (cfg->flags & NO_NEED_CHECK_CLKSRC)
 		return 0;
 
 	switch (ucon & S5PV210_UCON_CLKMASK) {
-- 
1.7.5.4

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
