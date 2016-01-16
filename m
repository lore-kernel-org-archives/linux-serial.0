From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v6 06/12] of: earlycon: Initialize port fields from DT properties
Date: Sat, 16 Jan 2016 15:23:43 -0800
Message-ID: <1452986629-17210-7-git-send-email-peter@hurleysoftware.com>
References: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
 <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Read the optional "reg-offset", "reg-shift", "reg-io-width" and endianness
properties and initialize the respective struct uart_port field if found.

NB: These bindings are common to several drivers and the values merely
indicate the default value; the registering earlycon setup() method can
simply override the values if required.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c              |  2 +-
 drivers/tty/serial/earlycon.c | 31 +++++++++++++++++++++++++++++++
 include/linux/serial_core.h   |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index cfd3b35..e8fd54a 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -839,7 +839,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (addr == OF_BAD_ADDR)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match, options);
+		of_setup_earlycon(addr, match, offset, options);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 7509ee34d..7089667 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
+#include <linux/of_fdt.h>
 
 #ifdef CONFIG_FIX_EARLYCON_MEM
 #include <asm/fixmap.h>
@@ -219,10 +220,13 @@ early_param("earlycon", param_setup_earlycon);
 
 int __init of_setup_earlycon(unsigned long addr,
 			     const struct earlycon_id *match,
+			     unsigned long node,
 			     const char *options)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
+	const __be32 *val;
+	bool big_endian;
 
 	spin_lock_init(&port->lock);
 	port->iotype = UPIO_MEM;
@@ -230,6 +234,33 @@ int __init of_setup_earlycon(unsigned long addr,
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
 
+	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
+	if (val)
+		port->mapbase += be32_to_cpu(*val);
+	val = of_get_flat_dt_prop(node, "reg-shift", NULL);
+	if (val)
+		port->regshift = be32_to_cpu(*val);
+	big_endian = of_get_flat_dt_prop(node, "big-endian", NULL) != NULL ||
+		(IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
+		 of_get_flat_dt_prop(node, "native-endian", NULL) != NULL);
+	val = of_get_flat_dt_prop(node, "reg-io-width", NULL);
+	if (val) {
+		switch (be32_to_cpu(*val)) {
+		case 1:
+			port->iotype = UPIO_MEM;
+			break;
+		case 2:
+			port->iotype = UPIO_MEM16;
+			break;
+		case 4:
+			port->iotype = (big_endian) ? UPIO_MEM32BE : UPIO_MEM32;
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
index 62a4df0..6d1bed8 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -360,6 +360,7 @@ extern const struct earlycon_id __earlycon_table_end[];
 
 extern int setup_earlycon(char *buf);
 extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match,
+			     unsigned long node,
 			     const char *options);
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
-- 
2.7.0
