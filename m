From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 04/11] of: earlycon: Add options string handling
Date: Tue, 12 Jan 2016 11:41:05 -0800
Message-ID: <1452627672-9482-5-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452627672-9482-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Sebastian Frias <sf84@laposte.net>, Paul Burton <paul.burton@imgtec.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Pass-through any options string in the 'stdout-path' property to the
earlycon "driver" setup.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c              | 11 ++++++-----
 drivers/tty/serial/earlycon.c |  9 +++++++--
 include/linux/serial_core.h   |  3 ++-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ec14595..cfd3b35 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -800,7 +800,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 static int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
-	const char *p;
+	const char *p, *q, *options = NULL;
 	int l;
 	const struct earlycon_id *match;
 	const void *fdt = initial_boot_params;
@@ -817,11 +817,12 @@ static int __init early_init_dt_scan_chosen_serial(void)
 	if (!p || !l)
 		return -ENOENT;
 
-	/* Remove console options if present */
-	l = strchrnul(p, ':') - p;
+	q = strchrnul(p, ':');
+	if (*q != '\0')
+		options = q + 1;
 
 	/* Get the node specified by stdout-path */
-	offset = fdt_path_offset_namelen(fdt, p, l);
+	offset = fdt_path_offset_namelen(fdt, p, q - p);
 	if (offset < 0)
 		return -ENODEV;
 
@@ -838,7 +839,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (addr == OF_BAD_ADDR)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match);
+		of_setup_earlycon(addr, match, options);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 47e54de..7509ee34d 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -218,7 +218,8 @@ early_param("earlycon", param_setup_earlycon);
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
 int __init of_setup_earlycon(unsigned long addr,
-			     const struct earlycon_id *match)
+			     const struct earlycon_id *match,
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
-	err = match->setup(&early_console_dev, NULL);
+	err = match->setup(&early_console_dev, options);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 63fdb55..62a4df0 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -359,7 +359,8 @@ extern const struct earlycon_id __earlycon_table_end[];
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
 extern int setup_earlycon(char *buf);
-extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match);
+extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match,
+			     const char *options);
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
-- 
2.7.0
