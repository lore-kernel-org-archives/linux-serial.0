From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1b/1] serial: sh-sci: Remove cpufreq notifier to fix crash/deadlock
Date: Tue,  5 Jan 2016 19:36:37 +0100
Message-ID: <1452018997-14103-3-git-send-email-geert+renesas@glider.be>
References: <1452018997-14103-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1452018997-14103-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Michael Turquette <mturquette@baylibre.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

The BSP team noticed that there is spin/mutex lock issue on sh-sci when
CPUFREQ is used.  The issue is that the notifier function may call
mutex_lock() while the spinlock is held, which can lead to a BUG().
This may happen if CPUFREQ is changed while another CPU calls
clk_get_rate().

Taking the spinlock was added to the notifier function in commit
e552de2413edad1a ("sh-sci: add platform device private data"), to
protect the list of serial ports against modification during traversal.
At that time the Common Clock Framework didn't exist yet, and
clk_get_rate() just returned clk->rate without taking a mutex.
Note that since commit d535a2305facf9b4 ("serial: sh-sci: Require a
device per port mapping."), there's no longer a list of serial ports to
traverse, and taking the spinlock became superfluous.

To fix the issue, just remove the cpufreq notifier:
  1. The notifier doesn't work correctly: all it does is update stored
     clock rates; it does not update the divider in the hardware.
     The divider will only be updated when calling sci_set_termios().
     I believe this was broken back in 2004, when the old
     drivers/char/sh-sci.c driver (where the notifier did update the
     divider) was replaced by drivers/serial/sh-sci.c (where the
     notifier just updated port->uartclk).
     Cfr. full-history-linux commits 6f8deaef2e9675d9 ("[PATCH] sh: port
     sh-sci driver to the new API") and 3f73fe878dc9210a ("[PATCH]
     Remove old sh-sci driver").
  2. On modern SoCs, the sh-sci parent clock rate is no longer related
     to the CPU clock rate anyway, so using a cpufreq notifier is
     futile.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This version applies against scif-clk-sck-brg-for-v4.5.
---
 drivers/tty/serial/sh-sci.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6571f4d944c26297..27c60e82981ce984 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -39,7 +39,6 @@
 #include <linux/major.h>
 #include <linux/module.h>
 #include <linux/mm.h>
-#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -124,8 +123,6 @@ struct sci_port {
 	struct timer_list		rx_timer;
 	unsigned int			rx_timeout;
 #endif
-
-	struct notifier_block		freq_transition;
 };
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
@@ -1666,32 +1663,6 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	return ret;
 }
 
-/*
- * Here we define a transition notifier so that we can update all of our
- * ports' baud rate when the peripheral clock changes.
- */
-static int sci_notifier(struct notifier_block *self,
-			unsigned long phase, void *p)
-{
-	struct sci_port *sci_port;
-	unsigned long flags;
-	unsigned int i;
-
-	sci_port = container_of(self, struct sci_port, freq_transition);
-
-	if (phase == CPUFREQ_POSTCHANGE) {
-		struct uart_port *port = &sci_port->port;
-
-		spin_lock_irqsave(&port->lock, flags);
-		for (i = 0; i < SCI_NUM_CLKS; i++)
-			sci_port->clk_rates[i] =
-				clk_get_rate(sci_port->clks[i]);
-		spin_unlock_irqrestore(&port->lock, flags);
-	}
-
-	return NOTIFY_OK;
-}
-
 static const struct sci_irq_desc {
 	const char	*desc;
 	irq_handler_t	handler;
@@ -2811,9 +2782,6 @@ static int sci_remove(struct platform_device *dev)
 {
 	struct sci_port *port = platform_get_drvdata(dev);
 
-	cpufreq_unregister_notifier(&port->freq_transition,
-				    CPUFREQ_TRANSITION_NOTIFIER);
-
 	uart_remove_one_port(&sci_uart_driver, &port->port);
 
 	sci_cleanup_single(port);
@@ -2965,16 +2933,6 @@ static int sci_probe(struct platform_device *dev)
 	if (ret)
 		return ret;
 
-	sp->freq_transition.notifier_call = sci_notifier;
-
-	ret = cpufreq_register_notifier(&sp->freq_transition,
-					CPUFREQ_TRANSITION_NOTIFIER);
-	if (unlikely(ret < 0)) {
-		uart_remove_one_port(&sci_uart_driver, &sp->port);
-		sci_cleanup_single(sp);
-		return ret;
-	}
-
 #ifdef CONFIG_SH_STANDARD_BIOS
 	sh_bios_gdb_detach();
 #endif
-- 
1.9.1

