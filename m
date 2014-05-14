From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC 6/8] serial: asc: Add support for KGDB's FIQ/NMI mode
Date: Wed, 14 May 2014 16:58:43 +0100
Message-ID: <1400083125-1464-7-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, Frederic Weisbecker <fweisbec@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@lin>
List-Id: linux-serial@vger.kernel.org

For a serial driver to support FIQ/NMI debugging it must enable the RX
interrupt when a polling client attaches itself (otherwise the FIQ signal
will never be asserted). This concept is copied from similar code in
amba-pl011.c .

It must also register the appropriate FIQ number with kgdb. kgdb will use
this to make calls to enable_fiq/disable_fiq/eoi_fiq. The FIQ number must
be supplied via the devices bus (in this case platform bus).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/st-asc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c7f61ac..e93803f 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
 #include <linux/clk.h>
+#include <linux/kgdb.h>
 
 #define DRIVER_NAME "st-asc"
 #define ASC_SERIAL_NAME "ttyAS"
@@ -613,6 +614,14 @@ asc_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
+static int asc_poll_init(struct uart_port *port)
+{
+	/* enable RX interrupts in case the interrupt is used for NMI entry. */
+	asc_enable_rx_interrupts(port);
+
+	return 0;
+}
+
 /*
  * Console polling routines for writing and reading from the uart while
  * in an interrupt or debug context (i.e. kgdb).
@@ -656,11 +665,25 @@ static struct uart_ops asc_uart_ops = {
 	.verify_port	= asc_verify_port,
 	.pm		= asc_pm,
 #ifdef CONFIG_CONSOLE_POLL
+	.poll_init     = asc_poll_init,
 	.poll_get_char = asc_get_poll_char,
 	.poll_put_char = asc_put_poll_char,
 #endif /* CONFIG_CONSOLE_POLL */
 };
 
+#ifdef CONFIG_KGDB_FIQ
+/* Register with KGDB if there is a FIQ linked to this device */
+static void asc_register_fiq(struct platform_device *pdev)
+{
+	int fiq = platform_get_irq(pdev, 1);
+	if (fiq >= 0)
+		kgdb_register_fiq(fiq);
+}
+#else
+static void asc_register_fiq(struct platform_device *pdev) {}
+#endif
+
+
 static int asc_init_port(struct asc_port *ascport,
 			  struct platform_device *pdev)
 {
@@ -692,6 +715,8 @@ static int asc_init_port(struct asc_port *ascport,
 	WARN_ON(ascport->port.uartclk == 0);
 	clk_disable_unprepare(ascport->clk);
 
+	asc_register_fiq(pdev);
+
 	return 0;
 }
 
-- 
1.9.0
