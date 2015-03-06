From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 04/14] of: earlycon: Fixup earlycon console name and index
Date: Fri,  6 Mar 2015 14:25:20 -0500
Message-ID: <1425669930-22137-5-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Use the console name embedded in the OF earlycon table by the
OF_EARLYCON_DECLARE() macro to initialize the struct console::name
and ::index fields.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c              | 2 +-
 drivers/tty/serial/earlycon.c | 5 +++--
 include/linux/serial_core.h   | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7cef9f9..777c894 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -800,7 +800,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		of_setup_earlycon(addr, match);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 1ffdb61..bfe5e27 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -218,17 +218,18 @@ static int __init param_setup_earlycon(char *buf)
 early_param("earlycon", param_setup_earlycon);
 
 int __init of_setup_earlycon(unsigned long addr,
-			     int (*setup)(struct earlycon_device *, const char *))
+			     const struct of_device_id *match)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
+	int (*setup)(struct earlycon_device *, const char *) = match->data;
 
 	port->iotype = UPIO_MEM;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
 
-	early_console_dev.con->data = &early_console_dev;
+	earlycon_init(&early_console_dev, match->name);
 	err = setup(&early_console_dev, NULL);
 	if (err < 0)
 		return err;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index c523785..a2db5bd 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -346,7 +346,7 @@ struct earlycon_id {
 
 extern int setup_earlycon(char *buf);
 extern int of_setup_earlycon(unsigned long addr,
-			     int (*setup)(struct earlycon_device *, const char *));
+			     const struct of_device_id *match);
 
 #define EARLYCON_DECLARE(_name, func)					\
 	static const struct earlycon_id __earlycon_##_name		\
-- 
2.3.1
