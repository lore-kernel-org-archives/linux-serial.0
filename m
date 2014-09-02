From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v11 16/19] serial: asc: Add support for KGDB's FIQ/NMI mode
Date: Tue,  2 Sep 2014 14:00:50 +0100
Message-ID: <1409662853-29313-17-git-send-email-daniel.thompson@linaro.org>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:58771 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbaIBNHb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Sep 2014 09:07:31 -0400
Received: by mail-we0-f175.google.com with SMTP id k48so6898655wev.34
        for <linux-serial@vger.kernel.org>; Tue, 02 Sep 2014 06:07:29 -0700 (PDT)
In-Reply-To: <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kgdb-bugreport@lists.sourceforge.net, patches@linaro.org, linaro-kernel@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Colin Cross <ccross@android.com>, kernel-team@android.com, Rob Herring <robherring2@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Catalin Marinas <catalin.marinas@arm.com>, Dave Martin <Dave.Martin@arm.com>, Fabio Estevam <festevam@gmail.com>, Frederic Weisbecker <fweisbec@gmail.com>, Nicolas Pitre <nico@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, kernel@s

Add a .poll_init() function that enables UART RX and registers the
UART's irq with KGDB. By providing this information to KGDB the serial
driver offers "permission" for KGDB to route the UART interrupt signal
from the drivers own handler to KGDBs FIQ handler (which will eventually
use the UART's polled I/O callbacks to interact with the user).

Note that the RX is not only enabled but also unmasked. This is required
because otherwise the FIQ handler could never trigger. This unmask is
copied from similar code in amba-pl011.c .

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
index 8b2d735..2b5eb6e 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
 #include <linux/clk.h>
+#include <linux/kgdb.h>
 
 #define DRIVER_NAME "st-asc"
 #define ASC_SERIAL_NAME "ttyAS"
@@ -607,6 +608,25 @@ asc_verify_port(struct uart_port *port, struct serial_struct *ser)
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
@@ -649,6 +669,9 @@ static struct uart_ops asc_uart_ops = {
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
1.9.3

