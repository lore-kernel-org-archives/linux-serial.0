From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 05/13] of: earlycon: Add options string handling
Date: Wed,  8 Apr 2015 13:45:11 -0400
Message-ID: <1428515119-25248-6-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
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
index 89fc70c..e0b8013 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -764,7 +764,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 static int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
-	const char *p, *q;
+	const char *p, *q, *options = NULL;
 	int l;
 	const struct earlycon_id *match;
 	const void *fdt = initial_boot_params;
@@ -782,6 +782,8 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		return -ENOENT;
 
 	q = strchrnul(p, ':');
+	if (*q != '\0')
+		options = q + 1;
 
 	/* Get the node specified by stdout-path */
 	offset = fdt_path_offset_namelen(fdt, p, (int)(q - p));
@@ -801,7 +803,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match);
+		of_setup_earlycon(addr, match, options);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 1cb2864..46f39c9 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -210,7 +210,8 @@ static int __init param_setup_earlycon(char *buf)
 early_param("earlycon", param_setup_earlycon);
 
 int __init of_setup_earlycon(unsigned long addr,
-			     const struct earlycon_id *match)
+			     const struct earlycon_id *match,
+			     const char *options)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
@@ -220,8 +221,12 @@ int __init of_setup_earlycon(unsigned long addr,
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
 
+	if (options) {
+		strlcpy(early_console_dev.options, options,
+			sizeof(early_console_dev.options));
+	}
 	earlycon_init(&early_console_dev, match->name);
-	err = match->setup(&early_console_dev, NULL);
+	err = match->setup(&early_console_dev, options);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 63662e8..3cc5e42 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -358,7 +358,8 @@ extern const struct earlycon_id __earlycon_table_end[];
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
 extern int setup_earlycon(char *buf);
-extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match);
+extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match,
+			     const char *options);
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
-- 
2.3.5
