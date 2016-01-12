From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/3] serial: earlycon: Add device-tree support for other IO types
Date: Tue, 12 Jan 2016 10:33:27 +0000
Message-ID: <1452594809-17972-2-git-send-email-jonathanh@nvidia.com>
References: <1452594809-17972-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452594809-17972-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: paul.burton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

When early console are registered via device-tree, currently it is assumed
that the console iotype is UPIO_MEM and the regshift is 0. This is not the
case for all devices and so add support for reading the device-tree
properties "reg-io-width" and "reg-shift" so that the appropriate iotype
and regshift can be specified for a given device.

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/of/fdt.c              | 26 +++++++++++++++++++++++++-
 drivers/tty/serial/earlycon.c |  6 ++++--
 include/linux/serial_core.h   |  3 ++-
 3 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 655f79db7899..f69406e42631 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -827,7 +827,9 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		return -ENODEV;
 
 	while (match->compatible[0]) {
+		const __be32 *prop;
 		u64 addr;
+		u8 iotype, regshift;
 
 		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
 			match++;
@@ -838,7 +840,29 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (addr == OF_BAD_ADDR)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		prop = fdt_getprop(fdt, offset, "reg-shift", NULL);
+		regshift = prop ? be32_to_cpup(prop) : 0;
+
+		prop = fdt_getprop(fdt, offset, "reg-io-width", NULL);
+		if (prop) {
+			switch (be32_to_cpup(prop)) {
+			case 1:
+				iotype = UPIO_MEM;
+				break;
+			case 2:
+				iotype = UPIO_MEM16;
+				break;
+			case 4:
+				iotype = UPIO_MEM32;
+				break;
+			default:
+				return -EINVAL;
+			}
+		} else {
+			iotype = UPIO_MEM;
+		}
+
+		of_setup_earlycon(addr, iotype, regshift, match->data);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 3f2423690d01..2fd2f19d7091 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -204,17 +204,19 @@ static int __init param_setup_earlycon(char *buf)
 }
 early_param("earlycon", param_setup_earlycon);
 
-int __init of_setup_earlycon(unsigned long addr,
+int __init of_setup_earlycon(unsigned long addr, unsigned char iotype,
+			     unsigned char regshift,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
 
 	spin_lock_init(&port->lock);
-	port->iotype = UPIO_MEM;
+	port->iotype = iotype;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
+	port->regshift = regshift;
 
 	early_console_dev.con->data = &early_console_dev;
 	err = setup(&early_console_dev, NULL);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index e03d6ba5e5b4..e0e1c7ef2856 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -346,7 +346,8 @@ struct earlycon_id {
 } __aligned(32);
 
 extern int setup_earlycon(char *buf);
-extern int of_setup_earlycon(unsigned long addr,
+extern int of_setup_earlycon(unsigned long addr, unsigned char iotype,
+			     unsigned char regshift,
 			     int (*setup)(struct earlycon_device *, const char *));
 
 #define EARLYCON_DECLARE(_name, func)					\
-- 
2.1.4
