From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v6 07/12] of: earlycon: Move address translation to of_setup_earlycon()
Date: Sat, 16 Jan 2016 15:23:44 -0800
Message-ID: <1452986629-17210-8-git-send-email-peter@hurleysoftware.com>
References: <1452980244-20512-1-git-send-email-peter@hurleysoftware.com>
 <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452986629-17210-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Paul Burton <paul.burton@imgtec.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Cleanup the early DT/earlycon separation; remove the 'addr' parameter
from of_setup_earlycon() and get the uart phys addr directly with a
new wrapper function, of_flat_dt_translate_addr(). Limit
fdt_translate_address() to file scope.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c              |  8 +-------
 drivers/of/fdt_address.c      | 11 ++++++++++-
 drivers/tty/serial/earlycon.c | 12 +++++++++---
 include/linux/of_fdt.h        |  2 +-
 include/linux/serial_core.h   |  2 +-
 5 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e8fd54a..918809e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -827,19 +827,13 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		return -ENODEV;
 
 	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
-		u64 addr;
-
 		if (!match->compatible[0])
 			continue;
 
 		if (fdt_node_check_compatible(fdt, offset, match->compatible))
 			continue;
 
-		addr = fdt_translate_address(fdt, offset);
-		if (addr == OF_BAD_ADDR)
-			return -ENXIO;
-
-		of_setup_earlycon(addr, match, offset, options);
+		of_setup_earlycon(match, offset, options);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/of/fdt_address.c b/drivers/of/fdt_address.c
index 8d3dc6f..dca8f9b 100644
--- a/drivers/of/fdt_address.c
+++ b/drivers/of/fdt_address.c
@@ -161,7 +161,7 @@ static int __init fdt_translate_one(const void *blob, int parent,
  * that can be mapped to a cpu physical address). This is not really specified
  * that way, but this is traditionally the way IBM at least do things
  */
-u64 __init fdt_translate_address(const void *blob, int node_offset)
+static u64 __init fdt_translate_address(const void *blob, int node_offset)
 {
 	int parent, len;
 	const struct of_bus *bus, *pbus;
@@ -239,3 +239,12 @@ u64 __init fdt_translate_address(const void *blob, int node_offset)
  bail:
 	return result;
 }
+
+/**
+ * of_flat_dt_translate_address - translate DT addr into CPU phys addr
+ * @node: node in the flat blob
+ */
+u64 __init of_flat_dt_translate_address(unsigned long node)
+{
+	return fdt_translate_address(initial_boot_params, node);
+}
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 7089667..baee9ad 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 
 #ifdef CONFIG_FIX_EARLYCON_MEM
@@ -218,8 +219,7 @@ early_param("earlycon", param_setup_earlycon);
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
-int __init of_setup_earlycon(unsigned long addr,
-			     const struct earlycon_id *match,
+int __init of_setup_earlycon(const struct earlycon_id *match,
 			     unsigned long node,
 			     const char *options)
 {
@@ -227,12 +227,18 @@ int __init of_setup_earlycon(unsigned long addr,
 	struct uart_port *port = &early_console_dev.port;
 	const __be32 *val;
 	bool big_endian;
+	u64 addr;
 
 	spin_lock_init(&port->lock);
 	port->iotype = UPIO_MEM;
+	addr = of_flat_dt_translate_address(node);
+	if (addr == OF_BAD_ADDR) {
+		pr_warn("[%s] bad address\n", match->name);
+		return -ENXIO;
+	}
 	port->mapbase = addr;
 	port->uartclk = BASE_BAUD * 16;
-	port->membase = earlycon_map(addr, SZ_4K);
+	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index df9ef38..2fbe868 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -88,7 +88,7 @@ extern void unflatten_device_tree(void);
 extern void unflatten_and_copy_device_tree(void);
 extern void early_init_devtree(void *);
 extern void early_get_first_memblock_info(void *, phys_addr_t *);
-extern u64 fdt_translate_address(const void *blob, int node_offset);
+extern u64 of_flat_dt_translate_address(unsigned long node);
 extern void of_fdt_limit_memory(int limit);
 #else /* CONFIG_OF_FLATTREE */
 static inline void early_init_fdt_scan_reserved_mem(void) {}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 6d1bed8..cbfcf38 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -359,7 +359,7 @@ extern const struct earlycon_id __earlycon_table_end[];
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
 extern int setup_earlycon(char *buf);
-extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match,
+extern int of_setup_earlycon(const struct earlycon_id *match,
 			     unsigned long node,
 			     const char *options);
 
-- 
2.7.0
