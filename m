From: Max Staudt <mstaudt@suse.de>
Subject: [PATCHv2] 8250: option 'force_polling' for buggy IRQs
Date: Tue, 26 Jul 2016 13:47:31 +0200
Message-ID: <1469533651-23384-1-git-send-email-mstaudt@suse.de>
References: <201607260241.cWzeZvYH%fengguang.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201607260241.cWzeZvYH%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: mstaudt@suse.de, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Some serial ports may not emit IRQs properly, or there may be a defect
in their routing on the motherboard.

This patch allows these ports to be used anyway (or until a better
workaround is known for a specific platform), though with no guarantees.

If you have such a buggy UART, boot Linux with 8250.force_polling=1 .

It is essentially the kernel level version of:

  setserial /dev/ttySn irq 0

and builds upon the polling code that is already in the kernel.
---

v2:
- Fixed module_param_cb() line
---
 drivers/tty/serial/8250/8250_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 13ad5c3..536e226 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -58,6 +58,11 @@ static struct uart_driver serial8250_reg;
 
 static unsigned int skip_txen_test; /* force skip of txen test at init time */
 
+/* Force polled mode for all newly detected ports.
+ * This can be used if IRQs don't arrive and similar buggyness.
+ */
+static unsigned int force_polling;
+
 #define PASS_LIMIT	512
 
 #include <asm/serial.h>
@@ -335,6 +340,13 @@ static int univ8250_setup_irq(struct uart_8250_port *up)
 			  uart_poll_timeout(port) + HZ / 5);
 	}
 
+	if (force_polling) {
+		pr_debug("ttyS%d - using polled mode instead of interrupt %u\n",
+			 serial_index(port),
+			 port->irq);
+		port->irq = 0;
+	}
+
 	/*
 	 * If the "interrupt" for this port doesn't correspond with any
 	 * hardware interrupt, we use a timer-based system.  The original
@@ -1206,6 +1218,9 @@ MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STR
 module_param(skip_txen_test, uint, 0644);
 MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
 
+module_param(force_polling, uint, 0644);
+MODULE_PARM_DESC(force_polling, "Set ports to polling mode at init time");
+
 #ifdef CONFIG_SERIAL_8250_RSA
 module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
@@ -1232,6 +1247,7 @@ static void __used s8250_options(void)
 	module_param_cb(share_irqs, &param_ops_uint, &share_irqs, 0644);
 	module_param_cb(nr_uarts, &param_ops_uint, &nr_uarts, 0644);
 	module_param_cb(skip_txen_test, &param_ops_uint, &skip_txen_test, 0644);
+	module_param_cb(force_polling, &param_ops_uint, &force_polling, 0644);
 #ifdef CONFIG_SERIAL_8250_RSA
 	__module_param_call(MODULE_PARAM_PREFIX, probe_rsa,
 		&param_array_ops, .arr = &__param_arr_probe_rsa,
-- 
2.6.6
