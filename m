From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 08/13] of: earlycon: Move address translation to of_setup_earlycon()
Date: Wed,  8 Apr 2015 13:45:14 -0400
Message-ID: <1428515119-25248-9-git-send-email-peter@hurleysoftware.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Cleanup the early DT/earlycon separation; remove the 'addr' parameter
from of_setup_earlycon() and get the uart phys addr directly with a
new wrapper function, of_flat_dt_translate_addr(). Limit
fdt_translate_address() to file scope.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/of/fdt.c              |  8 +-------
 drivers/of/fdt_address.c      | 11 ++++++++++-
 drivers/tty/serial/earlycon.c | 11 +++++++----
 include/linux/of_fdt.h        |  2 +-
 include/linux/serial_core.h   |  2 +-
 5 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 47d5054..007c330 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -791,19 +791,13 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		return -ENODEV;
 
 	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
-		unsigned long addr;
-
 		if (!match->compatible[0])
 			continue;
 
 		if (fdt_node_check_compatible(fdt, offset, match->compatible))
 			continue;
 
-		addr = fdt_translate_address(fdt, offset);
-		if (!addr)
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
index b618015..0d8f187 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -215,8 +215,7 @@ early_param("earlycon", param_setup_earlycon);
 
 #ifdef CONFIG_OF_EARLY_FLATTREE
 
-int __init of_setup_earlycon(unsigned long addr,
-			     const struct earlycon_id *match,
+int __init of_setup_earlycon(const struct earlycon_id *match,
 			     unsigned long node,
 			     const char *options)
 {
@@ -225,9 +224,13 @@ int __init of_setup_earlycon(unsigned long addr,
 	const __be32 *val;
 
 	port->iotype = UPIO_MEM;
-	port->mapbase = addr;
+	port->mapbase = of_flat_dt_translate_address(node);
+	if (!port->mapbase) {
+		pr_warn("[%s] bad address\n", match->name);
+		return -ENXIO;
+	}
 	port->uartclk = BASE_BAUD * 16;
-	port->membase = earlycon_map(addr, SZ_4K);
+	port->membase = earlycon_map(port->mapbase, SZ_4K);
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 0ff360d..d31e6cb 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -85,7 +85,7 @@ extern void unflatten_device_tree(void);
 extern void unflatten_and_copy_device_tree(void);
 extern void early_init_devtree(void *);
 extern void early_get_first_memblock_info(void *, phys_addr_t *);
-extern u64 fdt_translate_address(const void *blob, int node_offset);
+extern u64 of_flat_dt_translate_address(unsigned long node);
 extern void of_fdt_limit_memory(int limit);
 #else /* CONFIG_OF_FLATTREE */
 static inline void early_init_fdt_scan_reserved_mem(void) {}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index fe48f4e..16ee372 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -358,7 +358,7 @@ extern const struct earlycon_id __earlycon_table_end[];
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
 extern int setup_earlycon(char *buf);
-extern int of_setup_earlycon(unsigned long addr, const struct earlycon_id *match,
+extern int of_setup_earlycon(const struct earlycon_id *match,
 			     unsigned long node,
 			     const char *options);
 
-- 
2.3.5
