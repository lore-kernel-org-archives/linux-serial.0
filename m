From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v8 1/4] of/serial: move earlycon early_param handling to serial
Date: Fri, 20 May 2016 16:03:20 +0300
Message-ID: <1463749405-11640-2-git-send-email-aleksey.makarov@linaro.org>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Leif Lindholm <leif.lindholm@linaro.org>

We have multiple "earlycon" early_param handlers - merge the DT one into
the main earlycon one.  It's a cleanup that also will be useful
to defer setting up DT console until ACPI/DT decision is made.

Rename the exported function to avoid clashing with the function from
arch/microblaze/kernel/prom.c

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/of/fdt.c              | 11 +----------
 drivers/tty/serial/earlycon.c |  2 +-
 include/linux/of_fdt.h        |  2 ++
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e7a8caa..56da2a9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -906,7 +906,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 
 #ifdef CONFIG_SERIAL_EARLYCON
 
-static int __init early_init_dt_scan_chosen_serial(void)
+int __init early_init_dt_scan_chosen_stdout(void)
 {
 	int offset;
 	const char *p, *q, *options = NULL;
@@ -950,15 +950,6 @@ static int __init early_init_dt_scan_chosen_serial(void)
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
index 067783f..7aae655 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -209,7 +209,7 @@ static int __init param_setup_earlycon(char *buf)
 	 * don't generate a warning from parse_early_params() in that case
 	 */
 	if (!buf || !buf[0])
-		return 0;
+		return early_init_dt_scan_chosen_stdout();
 
 	err = setup_earlycon(buf);
 	if (err == -ENOENT || err == -EALREADY)
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 26c3302..2f69d4c 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -66,6 +66,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
 				     int depth, void *data);
+extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
@@ -94,6 +95,7 @@ extern void early_get_first_memblock_info(void *, phys_addr_t *);
 extern u64 of_flat_dt_translate_address(unsigned long node);
 extern void of_fdt_limit_memory(int limit);
 #else /* CONFIG_OF_FLATTREE */
+static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
 static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
-- 
2.8.2

