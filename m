From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 -next 05/14] of: earlycon: Add options string handling
Date: Fri,  6 Mar 2015 14:25:21 -0500
Message-ID: <1425669930-22137-6-git-send-email-peter@hurleysoftware.com>
References: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425669930-22137-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Pass-through any options string in the 'stdout-path' property to the
earlycon "driver" setup.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c              | 6 ++++--
 drivers/tty/serial/earlycon.c | 9 +++++++--
 include/linux/serial_core.h   | 3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 777c894..a8ad540 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -765,7 +765,7 @@ extern struct of_device_id __earlycon_of_table[];
 static int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
-	const char *p, *q;
+	const char *p, *q, *options = NULL;
 	int l;
 	const struct of_device_id *match = __earlycon_of_table;
 	const void *fdt = initial_boot_params;
@@ -783,6 +783,8 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		return -ENOENT;
 
 	q = strchrnul(p, ':');
+	if (*q != '\0')
+		options = q + 1;
 
 	/* Get the node specified by stdout-path */
 	offset = fdt_path_offset_namelen(fdt, p, (int)(q - p));
@@ -800,7 +802,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match);
+		of_setup_earlycon(addr, match, options);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index bfe5e27..023ebbb 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -218,7 +218,8 @@ static int __init param_setup_earlycon(char *buf)
 early_param("earlycon", param_setup_earlycon);
 
 int __init of_setup_earlycon(unsigned long addr,
-			     const struct of_device_id *match)
+			     const struct of_device_id *match,
+			     const char *options)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
@@ -229,8 +230,12 @@ int __init of_setup_earlycon(unsigned long addr,
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
 
+	if (options) {
+		strlcpy(early_console_dev.options, options,
+			sizeof(early_console_dev.options));
+	}
 	earlycon_init(&early_console_dev, match->name);
-	err = setup(&early_console_dev, NULL);
+	err = setup(&early_console_dev, options);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index a2db5bd..ebbcd43 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -346,7 +346,8 @@ struct earlycon_id {
 
 extern int setup_earlycon(char *buf);
 extern int of_setup_earlycon(unsigned long addr,
-			     const struct of_device_id *match);
+			     const struct of_device_id *match,
+			     const char *options);
 
 #define EARLYCON_DECLARE(_name, func)					\
 	static const struct earlycon_id __earlycon_##_name		\
-- 
2.3.1
