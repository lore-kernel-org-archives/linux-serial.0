From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 04/13] of: earlycon: Fixup earlycon console name and index
Date: Wed,  8 Apr 2015 13:45:10 -0400
Message-ID: <1428515119-25248-5-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Use the console name embedded in the OF earlycon table by the
OF_EARLYCON_DECLARE() macro to initialize the struct console 'name'
and 'index' fields.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c              | 2 +-
 drivers/tty/serial/earlycon.c | 6 +++---
 include/linux/serial_core.h   | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 0ec1643..89fc70c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -801,7 +801,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->setup);
+		of_setup_earlycon(addr, match);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 1bd822c..1cb2864 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -210,7 +210,7 @@ static int __init param_setup_earlycon(char *buf)
 early_param("earlycon", param_setup_earlycon);
 
 int __init of_setup_earlycon(unsigned long addr,
-			     int (*setup)(struct earlycon_device *, const char *))
+			     const struct earlycon_id *match)
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
@@ -220,8 +220,8 @@ int __init of_setup_earlycon(unsigned long addr,
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
 
-	early_console_dev.con->data = &early_console_dev;
-	err = setup(&early_console_dev, NULL);
+	earlycon_init(&early_console_dev, match->name);
+	err = match->setup(&early_console_dev, NULL);
 	if (err < 0)
 		return err;
 	if (!early_console_dev.con->write)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index b8367c0..63662e8 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -358,8 +358,7 @@ extern const struct earlycon_id __earlycon_table_end[];
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
 extern int setup_earlycon(char *buf);
-extern int of_setup_earlycon(unsigned long addr,
-			     int (*setup)(struct earlycon_device *, const char *));
+extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match);
 
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
-- 
2.3.5
