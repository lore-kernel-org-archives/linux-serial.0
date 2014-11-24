From: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT properties
Date: Mon, 24 Nov 2014 15:36:20 -0800
Message-ID: <1416872182-6440-6-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

If an earlycon (stdout-path) node is being used, check for "big-endian"
or "native-endian" properties and pass the appropriate iotype to the
driver.

Note that LE sets UPIO_MEM (8-bit) but BE sets UPIO_MEM32BE (32-bit).  The
big-endian property only really makes sense in the context of 32-bit
registers, since 8-bit accesses never require data swapping.

At some point, the of_earlycon code may want to pass in the reg-io-width,
reg-offset, and reg-shift parameters too.

Signed-off-by: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/of/fdt.c              | 7 ++++++-
 drivers/tty/serial/earlycon.c | 4 ++--
 include/linux/serial_core.h   | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 658656f..9d21472 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -794,6 +794,8 @@ int __init early_init_dt_scan_chosen_serial(void)
 
 	while (match->compatible[0]) {
 		unsigned long addr;
+		unsigned char iotype = UPIO_MEM;
+
 		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
 			match++;
 			continue;
@@ -803,7 +805,10 @@ int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		if (of_fdt_is_big_endian(fdt, offset))
+			iotype = UPIO_MEM32BE;
+
+		of_setup_earlycon(addr, iotype, match->data);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a514ee6..548f7d7 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -148,13 +148,13 @@ int __init setup_earlycon(char *buf, const char *match,
 	return 0;
 }
 
-int __init of_setup_earlycon(unsigned long addr,
+int __init of_setup_earlycon(unsigned long addr, unsigned char iotype,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
 
-	port->iotype = UPIO_MEM;
+	port->iotype = iotype;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index d2d5bf6..0d60c64 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -310,7 +310,7 @@ struct earlycon_device {
 int setup_earlycon(char *buf, const char *match,
 		   int (*setup)(struct earlycon_device *, const char *));
 
-extern int of_setup_earlycon(unsigned long addr,
+extern int of_setup_earlycon(unsigned long addr, unsigned char iotype,
 			     int (*setup)(struct earlycon_device *, const char *));
 
 #define EARLYCON_DECLARE(name, func) \
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
