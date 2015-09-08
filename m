From: Leif Lindholm <leif.lindholm@linaro.org>
Subject: [RFC 2/5] of/serial: move earlycon early_param handling to serial
Date: Tue,  8 Sep 2015 13:43:34 +0100
Message-ID: <1441716217-23786-3-git-send-email-leif.lindholm@linaro.org>
References: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441716217-23786-1-git-send-email-leif.lindholm@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mark.rutland@arm.com, al.stone@linaro.org, torez@redhat.com, jcm@redhat.com, graeme.gregory@linaro.org, linaro-acpi@lists.linaro.org, lv.zheng@intel.com
List-Id: linux-serial@vger.kernel.org

We have multiple "earlycon" early_param handlers - merge the DT one into
the main earlycon one. This means the earlycon early_param handler does
not just return success if no options are specified.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
---
 drivers/of/fdt.c              | 11 +----------
 drivers/tty/serial/earlycon.c |  4 +++-
 include/linux/of_fdt.h        |  1 +
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6e82bc42..fcfc4c7 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -793,7 +793,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 #ifdef CONFIG_SERIAL_EARLYCON
 extern struct of_device_id __earlycon_of_table[];
 
-static int __init early_init_dt_scan_chosen_serial(void)
+int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
 	const char *p;
@@ -834,15 +834,6 @@ static int __init early_init_dt_scan_chosen_serial(void)
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
index f096360..2bda09a 100644
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
@@ -187,7 +188,8 @@ static int __init param_setup_earlycon(char *buf)
 	 * don't generate a warning from parse_early_params() in that case
 	 */
 	if (!buf || !buf[0])
-		return 0;
+		if (IS_ENABLED(CONFIG_OF_FLATTREE))
+			return early_init_dt_scan_chosen_serial();
 
 	err = setup_earlycon(buf);
 	if (err == -ENOENT || err == -EALREADY)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index df9ef38..772c47c 100644
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
-- 
2.1.4
