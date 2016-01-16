From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v6 02/12] earlycon: Use common framework for earlycon declarations
Date: Sat, 16 Jan 2016 15:23:39 -0800
Message-ID: <1452986629-17210-3-git-send-email-peter@hurleysoftware.com>
References: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
 <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Use a single common table of struct earlycon_id for both command line
and devicetree. Re-define OF_EARLYCON_DECLARE() macro to instance a
unique earlycon declaration (the declaration is only guaranteed to be
unique within a compilation unit; separate compilation units must still
use unique earlycon names).

The semantics of OF_EARLYCON_DECLARE() is different; it declares an
earlycon which can matched either on the command line or by devicetree.
EARLYCON_DECLARE() is semantically unchanged; it declares an earlycon
which is matched by command line only. Remove redundant instances of
EARLYCON_DECLARE().

This enables all earlycons to properly initialize struct console
with the appropriate name and index, which improves diagnostics and
enables direct earlycon-to-console handoff.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c                  | 14 +++++++-------
 drivers/tty/serial/amba-pl011.c   |  1 -
 drivers/tty/serial/arc_uart.c     |  1 -
 drivers/tty/serial/earlycon.c     | 10 +---------
 drivers/tty/serial/msm_serial.c   |  2 --
 drivers/tty/serial/samsung.c      |  6 ------
 drivers/tty/serial/sprd_serial.c  |  2 --
 include/asm-generic/vmlinux.lds.h |  6 ++----
 include/linux/serial_core.h       | 22 +++++++++++++---------
 9 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 655f79d..1686118 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -796,14 +796,13 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 #ifdef CONFIG_SERIAL_EARLYCON
-extern struct of_device_id __earlycon_of_table[];
 
 static int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
 	const char *p;
 	int l;
-	const struct of_device_id *match = __earlycon_of_table;
+	const struct earlycon_id *match;
 	const void *fdt = initial_boot_params;
 
 	offset = fdt_path_offset(fdt, "/chosen");
@@ -826,19 +825,20 @@ static int __init early_init_dt_scan_chosen_serial(void)
 	if (offset < 0)
 		return -ENODEV;
 
-	while (match->compatible[0]) {
+	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
 		u64 addr;
 
-		if (fdt_node_check_compatible(fdt, offset, match->compatible)) {
-			match++;
+		if (!match->compatible[0])
+			continue;
+
+		if (fdt_node_check_compatible(fdt, offset, match->compatible))
 			continue;
-		}
 
 		addr = fdt_translate_address(fdt, offset);
 		if (addr == OF_BAD_ADDR)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		of_setup_earlycon(addr, match->setup);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index c0da0cc..de84602 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2327,7 +2327,6 @@ static int __init pl011_early_console_setup(struct earlycon_device *device,
 	device->con->write = pl011_early_write;
 	return 0;
 }
-EARLYCON_DECLARE(pl011, pl011_early_console_setup);
 OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
 
 #else
diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index 03ebe40..3a1de5c 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -576,7 +576,6 @@ static int __init arc_early_console_setup(struct earlycon_device *dev,
 	dev->con->write = arc_early_serial_write;
 	return 0;
 }
-EARLYCON_DECLARE(arc_uart, arc_early_console_setup);
 OF_EARLYCON_DECLARE(arc_uart, "snps,arc-uart", arc_early_console_setup);
 
 #endif	/* CONFIG_SERIAL_ARC_CONSOLE */
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 54419a2..d50b700 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
-#include <linux/mod_devicetable.h>
 
 #ifdef CONFIG_FIX_EARLYCON_MEM
 #include <asm/fixmap.h>
@@ -37,13 +36,6 @@ static struct earlycon_device early_console_dev = {
 	.con = &early_con,
 };
 
-extern struct earlycon_id __earlycon_table[];
-static const struct earlycon_id __earlycon_table_sentinel
-	__used __section(__earlycon_table_end);
-
-static const struct of_device_id __earlycon_of_table_sentinel
-	__used __section(__earlycon_of_table_end);
-
 static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
 {
 	void __iomem *base;
@@ -166,7 +158,7 @@ int __init setup_earlycon(char *buf)
 	if (early_con.flags & CON_ENABLED)
 		return -EALREADY;
 
-	for (match = __earlycon_table; match->name[0]; match++) {
+	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
 		size_t len = strlen(match->name);
 
 		if (strncmp(buf, match->name, len))
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index dcde955..96d3ce8 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1478,7 +1478,6 @@ msm_serial_early_console_setup(struct earlycon_device *device, const char *opt)
 	device->con->write = msm_serial_early_write;
 	return 0;
 }
-EARLYCON_DECLARE(msm_serial, msm_serial_early_console_setup);
 OF_EARLYCON_DECLARE(msm_serial, "qcom,msm-uart",
 		    msm_serial_early_console_setup);
 
@@ -1500,7 +1499,6 @@ msm_serial_early_console_setup_dm(struct earlycon_device *device,
 	device->con->write = msm_serial_early_write_dm;
 	return 0;
 }
-EARLYCON_DECLARE(msm_serial_dm, msm_serial_early_console_setup_dm);
 OF_EARLYCON_DECLARE(msm_serial_dm, "qcom,msm-uartdm",
 		    msm_serial_early_console_setup_dm);
 
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index d72cd73..fd9c47f 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -2451,7 +2451,6 @@ static int __init s3c2410_early_console_setup(struct earlycon_device *device,
 }
 OF_EARLYCON_DECLARE(s3c2410, "samsung,s3c2410-uart",
 			s3c2410_early_console_setup);
-EARLYCON_DECLARE(s3c2410, s3c2410_early_console_setup);
 
 /* S3C2412, S3C2440, S3C64xx */
 static struct samsung_early_console_data s3c2440_early_console_data = {
@@ -2470,9 +2469,6 @@ OF_EARLYCON_DECLARE(s3c2440, "samsung,s3c2440-uart",
 			s3c2440_early_console_setup);
 OF_EARLYCON_DECLARE(s3c6400, "samsung,s3c6400-uart",
 			s3c2440_early_console_setup);
-EARLYCON_DECLARE(s3c2412, s3c2440_early_console_setup);
-EARLYCON_DECLARE(s3c2440, s3c2440_early_console_setup);
-EARLYCON_DECLARE(s3c6400, s3c2440_early_console_setup);
 
 /* S5PV210, EXYNOS */
 static struct samsung_early_console_data s5pv210_early_console_data = {
@@ -2489,8 +2485,6 @@ OF_EARLYCON_DECLARE(s5pv210, "samsung,s5pv210-uart",
 			s5pv210_early_console_setup);
 OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
 			s5pv210_early_console_setup);
-EARLYCON_DECLARE(s5pv210, s5pv210_early_console_setup);
-EARLYCON_DECLARE(exynos4210, s5pv210_early_console_setup);
 #endif
 
 MODULE_ALIAS("platform:samsung-uart");
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index ef26c4a..1897106 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -624,8 +624,6 @@ static int __init sprd_early_console_setup(
 	device->con->write = sprd_early_write;
 	return 0;
 }
-
-EARLYCON_DECLARE(sprd_serial, sprd_early_console_setup);
 OF_EARLYCON_DECLARE(sprd_serial, "sprd,sc9836-uart",
 		    sprd_early_console_setup);
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c4bd0e2..e9a81a6 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -157,7 +157,7 @@
 #define EARLYCON_TABLE() STRUCT_ALIGN();			\
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 *(__earlycon_table)			\
-			 *(__earlycon_table_end)
+			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
 #else
 #define EARLYCON_TABLE()
 #endif
@@ -179,7 +179,6 @@
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
-#define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
@@ -526,8 +525,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(clksrc)					\
-	EARLYCON_TABLE()						\
-	EARLYCON_OF_TABLES()
+	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index e03d6ba..25e0514 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -342,22 +342,26 @@ struct earlycon_device {
 
 struct earlycon_id {
 	char	name[16];
+	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
 } __aligned(32);
 
+extern const struct earlycon_id __earlycon_table[];
+extern const struct earlycon_id __earlycon_table_end[];
+
+#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
+	static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name)	\
+	     __used __section(__earlycon_table)				\
+		= { .name = __stringify(_name),				\
+		    .compatible = compat,				\
+		    .setup = fn  }
+
+#define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
+
 extern int setup_earlycon(char *buf);
 extern int of_setup_earlycon(unsigned long addr,
 			     int (*setup)(struct earlycon_device *, const char *));
 
-#define EARLYCON_DECLARE(_name, func)					\
-	static const struct earlycon_id __earlycon_##_name		\
-		__used __section(__earlycon_table)			\
-		 = { .name  = __stringify(_name),			\
-		     .setup = func  }
-
-#define OF_EARLYCON_DECLARE(name, compat, fn)				\
-	_OF_DECLARE(earlycon, name, compat, fn, void *)
-
 struct uart_port *uart_get_console(struct uart_port *ports, int nr,
 				   struct console *c);
 int uart_parse_earlycon(char *p, unsigned char *iotype, unsigned long *addr,
-- 
2.7.0
