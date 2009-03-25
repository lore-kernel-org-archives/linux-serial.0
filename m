From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 2/2] Alchemy: UART PM through serial framework.
Date: Wed, 25 Mar 2009 18:55:12 +0100
Message-ID: <1238003712-17521-3-git-send-email-mano@roarinelk.homelinux.net>
References: <1238003712-17521-1-git-send-email-mano@roarinelk.homelinux.net>
 <1238003712-17521-2-git-send-email-mano@roarinelk.homelinux.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59310 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760634AbZCYRzU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Mar 2009 13:55:20 -0400
Received: by fxm2 with SMTP id 2so162764fxm.37
        for <linux-serial@vger.kernel.org>; Wed, 25 Mar 2009 10:55:17 -0700 (PDT)
In-Reply-To: <1238003712-17521-2-git-send-email-mano@roarinelk.homelinux.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>
Cc: Manuel Lauss <mlau@msc-ge.com>, Manuel Lauss <mano@roarinelk.homelinux.net>

From: Manuel Lauss <mlau@msc-ge.com>

Hook up the Alchemy on-chip uarts with the platform 8250 PM callback
enable/disable clocks to the uart blocks as needed.

Tested on Au1200.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/platform.c |   21 ++++++++++++++++++++-
 arch/mips/alchemy/common/power.c    |   35 -----------------------------------
 2 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 5c76c64..3cc4aac 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -20,6 +20,24 @@
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 
+#if defined(CONFIG_SERIAL_8250_AU1X00)
+static void au1xx0_uart_pm(struct uart_port *port, unsigned int state,
+			   unsigned int old_state)
+{
+	if (state == 0) {		/* power on */
+		au_writel(0, (unsigned long)port->membase + UART_MOD_CNTRL);
+		au_sync();
+		au_writel(1, (unsigned long)port->membase + UART_MOD_CNTRL);
+		au_sync();
+		au_writel(3, (unsigned long)port->membase + UART_MOD_CNTRL);
+		au_sync();
+	} else if (state == 3) {	/* power off */
+		au_writel(0, (unsigned long)port->membase + UART_MOD_CNTRL);
+		au_sync();
+	}
+}
+#endif
+
 #define PORT(_base, _irq)				\
 	{						\
 		.iobase		= _base,		\
@@ -28,7 +46,8 @@
 		.irq		= _irq,			\
 		.regshift	= 2,			\
 		.iotype		= UPIO_AU,		\
-		.flags		= UPF_SKIP_TEST 	\
+		.flags		= UPF_SKIP_TEST,	\
+		.pm		= au1xx0_uart_pm	\
 	}
 
 static struct plat_serial8250_port au1x00_uart_data[] = {
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index 6ab7b42..cf37e27 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -52,11 +52,6 @@
  * We only have to save/restore registers that aren't otherwise
  * done as part of a driver pm_* function.
  */
-static unsigned int sleep_uart0_inten;
-static unsigned int sleep_uart0_fifoctl;
-static unsigned int sleep_uart0_linectl;
-static unsigned int sleep_uart0_clkdiv;
-static unsigned int sleep_uart0_enable;
 static unsigned int sleep_usb[2];
 static unsigned int sleep_sys_clocks[5];
 static unsigned int sleep_sys_pinfunc;
@@ -65,22 +60,6 @@ static unsigned int sleep_static_memctlr[4][3];
 
 static void save_core_regs(void)
 {
-	extern void save_au1xxx_intctl(void);
-	extern void pm_eth0_shutdown(void);
-
-	/*
-	 * Do the serial ports.....these really should be a pm_*
-	 * registered function by the driver......but of course the
-	 * standard serial driver doesn't understand our Au1xxx
-	 * unique registers.
-	 */
-	sleep_uart0_inten = au_readl(UART0_ADDR + UART_IER);
-	sleep_uart0_fifoctl = au_readl(UART0_ADDR + UART_FCR);
-	sleep_uart0_linectl = au_readl(UART0_ADDR + UART_LCR);
-	sleep_uart0_clkdiv = au_readl(UART0_ADDR + UART_CLK);
-	sleep_uart0_enable = au_readl(UART0_ADDR + UART_MOD_CNTRL);
-	au_sync();
-
 #ifndef CONFIG_SOC_AU1200
 	/* Shutdown USB host/device. */
 	sleep_usb[0] = au_readl(USB_HOST_CONFIG);
@@ -186,20 +165,6 @@ static void restore_core_regs(void)
 	au_writel(sleep_static_memctlr[3][1], MEM_STTIME3);
 	au_writel(sleep_static_memctlr[3][2], MEM_STADDR3);
 
-	/*
-	 * Enable the UART if it was enabled before sleep.
-	 * I guess I should define module control bits........
-	 */
-	if (sleep_uart0_enable & 0x02) {
-		au_writel(0, UART0_ADDR + UART_MOD_CNTRL); au_sync();
-		au_writel(1, UART0_ADDR + UART_MOD_CNTRL); au_sync();
-		au_writel(3, UART0_ADDR + UART_MOD_CNTRL); au_sync();
-		au_writel(sleep_uart0_inten, UART0_ADDR + UART_IER); au_sync();
-		au_writel(sleep_uart0_fifoctl, UART0_ADDR + UART_FCR); au_sync();
-		au_writel(sleep_uart0_linectl, UART0_ADDR + UART_LCR); au_sync();
-		au_writel(sleep_uart0_clkdiv, UART0_ADDR + UART_CLK); au_sync();
-	}
-
 	restore_au1xxx_intctl();
 
 #if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
-- 
1.6.2

