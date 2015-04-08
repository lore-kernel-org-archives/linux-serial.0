From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 07/13] of: earlycon: Initialize port fields from DT properties
Date: Wed,  8 Apr 2015 13:45:13 -0400
Message-ID: <1428515119-25248-8-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Read the optional "reg-offset", "reg-shift" and "reg-io-width" properties
and initialize the respective struct uart_port field if found.

NB: These bindings are common to several drivers and the values merely
indicate the default value; the registering earlycon setup() method can
simply override the values if required.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c              |  2 +-
 drivers/tty/serial/earlycon.c | 27 +++++++++++++++++++++++++++
 include/linux/serial_core.h   |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e0b8013..47d5054 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -803,7 +803,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match, options);
+		of_setup_earlycon(addr, match, offset, options);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 96e3ad1..b618015 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -20,6 +20,10 @@
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
 
+#ifdef CONFIG_OF_EARLY_FLATTREE
+#include <linux/of_fdt.h>
+#endif
+
 #ifdef CONFIG_FIX_EARLYCON_MEM
 #include <asm/fixmap.h>
 #endif
@@ -213,16 +217,39 @@ early_param("earlycon", param_setup_earlycon);
 
 int __init of_setup_earlycon(unsigned long addr,
 			     const struct earlycon_id *match,
+			     unsigned long node,
 			     const char *options)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
+	const __be32 *val;
 
 	port->iotype = UPIO_MEM;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
 
+	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
+	if (val)
+		port->mapbase += be32_to_cpu(*val);
+	val = of_get_flat_dt_prop(node, "reg-shift", NULL);
+	if (val)
+		port->regshift = be32_to_cpu(*val);
+	val = of_get_flat_dt_prop(node, "reg-io-width", NULL);
+	if (val) {
+		switch (be32_to_cpu(*val)) {
+		case 1:
+			port->iotype = UPIO_MEM;
+			break;
+		case 4:
+			port->iotype = UPIO_MEM32;
+			break;
+		default:
+			pr_warn("[%s] unsupported reg-io-width\n", match->name);
+			return -EINVAL;
+		}
+	}
+
 	if (options) {
 		strlcpy(early_console_dev.options, options,
 			sizeof(early_console_dev.options));
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3cc5e42..fe48f4e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -359,6 +359,7 @@ extern const struct earlycon_id __earlycon_table_end[];
 
 extern int setup_earlycon(char *buf);
 extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match,
+			     unsigned long node,
 			     const char *options);
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
-- 
2.3.5
