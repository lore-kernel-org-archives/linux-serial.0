From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 01/28] serial: earlycon: allow MEM32 I/O for DT earlycon
Date: Mon, 30 Nov 2015 16:21:26 +0000
Message-ID: <1448900513-20856-2-git-send-email-paul.burton@imgtec.com>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@imgtec.com>, devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
List-Id: linux-serial@vger.kernel.org

Read the reg-io-width property when earlycon is setup via device tree,
and set the I/O type to UPIO_MEM32 when 4 is read. This behaviour
matches that of the of_serial driver, and is needed for DT configured
earlycon on the MIPS Boston board.

Note that this is only possible when CONFIG_LIBFDT is enabled, but
enabling it everywhere seems like overkill. Thus systems that need this
functionality should select CONFIG_LIBFDT for themselves.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

 drivers/of/fdt.c              |  2 +-
 drivers/tty/serial/Makefile   |  1 +
 drivers/tty/serial/earlycon.c | 15 ++++++++++++++-
 include/linux/serial_core.h   |  2 +-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d243029..71c7f0d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -833,7 +833,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (addr == OF_BAD_ADDR)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		of_setup_earlycon(fdt, offset, addr, match->data);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 5ab4111..1d290d6 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_SERIAL_21285) += 21285.o
 
 obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
 obj-$(CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST) += earlycon-arm-semihost.o
+CFLAGS_earlycon.o += -I$(srctree)/scripts/dtc/libfdt
 
 # These Sparc drivers have to appear before others such as 8250
 # which share ttySx minor node space.  Otherwise console device
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index f096360..2b936a7 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/libfdt.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
 #include <linux/mod_devicetable.h>
@@ -196,17 +197,29 @@ static int __init param_setup_earlycon(char *buf)
 }
 early_param("earlycon", param_setup_earlycon);
 
-int __init of_setup_earlycon(unsigned long addr,
+int __init of_setup_earlycon(const void *fdt, int offset, unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *))
 {
 	int err;
 	struct uart_port *port = &early_console_dev.port;
+	const __be32 *prop;
 
 	port->iotype = UPIO_MEM;
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
 	port->membase = earlycon_map(addr, SZ_4K);
 
+	if (config_enabled(CONFIG_LIBFDT)) {
+		prop = fdt_getprop(fdt, offset, "reg-io-width", NULL);
+		if (prop) {
+			switch (be32_to_cpup(prop)) {
+			case 4:
+				port->iotype = UPIO_MEM32;
+				break;
+			}
+		}
+	}
+
 	early_console_dev.con->data = &early_console_dev;
 	err = setup(&early_console_dev, NULL);
 	if (err < 0)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 297d4fa..aa375f1 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -345,7 +345,7 @@ struct earlycon_id {
 } __aligned(32);
 
 extern int setup_earlycon(char *buf);
-extern int of_setup_earlycon(unsigned long addr,
+extern int of_setup_earlycon(const void *fdt, int offset, unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *));
 
 #define EARLYCON_DECLARE(_name, func)					\
-- 
2.6.2
