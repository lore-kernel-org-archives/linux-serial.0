From: Aleksey Makarov <aleksey.makarov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 1/6] of/serial: move earlycon early_param handling to serial
Date: Tue, 22 Mar 2016 13:46:28 +0300
Message-ID: <1458643595-14719-2-git-send-email-aleksey.makarov@linaro.org>
References: <1458643595-14719-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458643595-14719-1-git-send-email-aleksey.makarov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Aleksey Makarov <aleksey.makarov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Graeme Gregory <graeme.gregory-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Al Stone <ahs3-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christopher Covington <cov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Yury Norov <ynorov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, "Zheng, Lv" <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

From: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

We have multiple "earlycon" early_param handlers - merge the DT one into
the main earlycon one.  It's a cleanup that also will be useful
to decide if ACPI SPCR earlycon should be set up.

Signed-off-by: Leif Lindholm <leif.lindholm-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Aleksey Makarov <aleksey.makarov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/of/fdt.c              | 11 +----------
 drivers/tty/serial/earlycon.c |  3 ++-
 include/linux/of_fdt.h        |  2 ++
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3349d2a..0547256 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -805,7 +805,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 
 #ifdef CONFIG_SERIAL_EARLYCON
 
-static int __init early_init_dt_scan_chosen_serial(void)
+int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
 	const char *p, *q, *options = NULL;
@@ -849,15 +849,6 @@ static int __init early_init_dt_scan_chosen_serial(void)
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
index 067783f..d217366 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/of_fdt.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
 #include <linux/of.h>
@@ -209,7 +210,7 @@ static int __init param_setup_earlycon(char *buf)
 	 * don't generate a warning from parse_early_params() in that case
 	 */
 	if (!buf || !buf[0])
-		return 0;
+		return early_init_dt_scan_chosen_serial();
 
 	err = setup_earlycon(buf);
 	if (err == -ENOENT || err == -EALREADY)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 2fbe868..56b2a43 100644
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
 extern u64 of_flat_dt_translate_address(unsigned long node);
 extern void of_fdt_limit_memory(int limit);
 #else /* CONFIG_OF_FLATTREE */
+static inline int early_init_dt_scan_chosen_serial(void) { return -ENODEV; }
 static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
