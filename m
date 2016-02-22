From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 2/8] of/serial: move earlycon early_param handling to serial
Date: Mon, 22 Feb 2016 16:46:50 +0300
Message-ID: <1456148818-26257-3-git-send-email-aleksey.makarov@linaro.org>
References: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Leif Lindholm <leif.lindholm@linaro.org>

We have multiple "earlycon" early_param handlers - merge the DT one into
the main earlycon one. This means the earlycon early_param handler does
not just return success if no options are specified.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 drivers/of/fdt.c              | 11 +----------
 drivers/tty/serial/earlycon.c |  3 ++-
 include/linux/of_fdt.h        |  2 ++
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 655f79d..6b4ab4f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -798,7 +798,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 #ifdef CONFIG_SERIAL_EARLYCON
 extern struct of_device_id __earlycon_of_table[];
 
-static int __init early_init_dt_scan_chosen_serial(void)
+int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
 	const char *p;
@@ -843,15 +843,6 @@ static int __init early_init_dt_scan_chosen_serial(void)
 	}
 	return -ENODEV;
 }
-
-static int __init setup_of_earlycon(char *buf)
-{
-	if (buf)
-		return 0;
-
-	return early_init_dt_scan_chosen_serial();
-}
-early_param("earlycon", setup_of_earlycon);
 #endif
 
 /**
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 3f24236..05f9e4b 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of_fdt.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
 #include <linux/mod_devicetable.h>
@@ -195,7 +196,7 @@ static int __init param_setup_earlycon(char *buf)
 	 * don't generate a warning from parse_early_params() in that case
 	 */
 	if (!buf || !buf[0])
-		return 0;
+		return early_init_dt_scan_chosen_serial();
 
 	err = setup_earlycon(buf);
 	if (err == -ENOENT || err == -EALREADY)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index df9ef38..4d783aa8 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -63,6 +63,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
 				     int depth, void *data);
+extern int early_init_dt_scan_chosen_serial(void);
 extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
@@ -91,6 +92,7 @@ extern void early_get_first_memblock_info(void *, phys_addr_t *);
 extern u64 fdt_translate_address(const void *blob, int node_offset);
 extern void of_fdt_limit_memory(int limit);
 #else /* CONFIG_OF_FLATTREE */
+static inline int early_init_dt_scan_chosen_serial(void) { return -ENODEV; }
 static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
-- 
2.7.1
