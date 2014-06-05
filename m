From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [RFC v3 9/9] serial: asc: Add support for KGDB's FIQ/NMI mode
Date: Thu,  5 Jun 2014 10:53:14 +0100
Message-ID: <1401961994-18033-10-git-send-email-daniel.thompson@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, Jiri Slaby <jslaby@suse.cz>, Daniel Thompson <daniel.thompson@linaro.org>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, patches@linaro.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradea
List-Id: linux-serial@vger.kernel.org

If the platform bus has provided the st-asc with a FIQ resource (i.e. a
second IRQ) then speculatively register it with KGDB when the polling
driver is initialized.

By providing this information to KGDB the serial driver offers
"permission" for KGDB to route the UART interrupt signal from the
drivers own handler to KGDBs FIQ handler (which will eventually use the
UART's polled I/O callbacks to interact with the user). This permission
also implies the st-asc driver has already unmasked RX interrupts
(otherwise the FIQ handler will never trigger). This unmask is copied
from similar code in amba-pl011.c .

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: kernel@stlinux.com
Cc: linux-serial@vger.kernel.org
---
 drivers/tty/serial/st-asc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c7f61ac..4f376d8 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
 #include <linux/clk.h>
+#include <linux/kgdb.h>
 
 #define DRIVER_NAME "st-asc"
 #define ASC_SERIAL_NAME "ttyAS"
@@ -613,6 +614,25 @@ asc_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
+
+#ifdef CONFIG_KGDB_FIQ
+/*
+ * Prepare the UART to be used from kgdb's NMI support.
+ */
+static int asc_poll_init(struct uart_port *port)
+{
+	struct asc_port *ascport = container_of(port, struct asc_port, port);
+
+	/* register the FIQ with kgdb */
+	kgdb_register_fiq(ascport->port.irq);
+
+	/* enable RX interrupts in case the interrupt is used for NMI entry. */
+	asc_enable_rx_interrupts(port);
+
+	return 0;
+}
+#endif /* CONFIG_KGDB_FIQ */
+
 /*
  * Console polling routines for writing and reading from the uart while
  * in an interrupt or debug context (i.e. kgdb).
@@ -656,6 +676,9 @@ static struct uart_ops asc_uart_ops = {
 	.verify_port	= asc_verify_port,
 	.pm		= asc_pm,
 #ifdef CONFIG_CONSOLE_POLL
+#ifdef CONFIG_KGDB_FIQ
+	.poll_init     = asc_poll_init,
+#endif /* CONFIG_KGDB_FIQ */
 	.poll_get_char = asc_get_poll_char,
 	.poll_put_char = asc_put_poll_char,
 #endif /* CONFIG_CONSOLE_POLL */
-- 
1.9.0
