From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v10 1/4] of/serial: move earlycon early_param handling to
 serial
Date: Mon,  5 Sep 2016 15:36:12 +0300
Message-ID: <20160905123617.18775-2-aleksey.makarov@linaro.org>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160905123617.18775-1-aleksey.makarov@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Yury Norov <ynorov@caviumnetworks.com>, "Zheng, Lv" <lv.zheng@intel.com>, Frank Rowand <frowand.list@gmail.com>, Russell King <linux@arm.linux.org.uk>, linux-acpi@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, linux-serial@vger.kernel.org, Mark Salter <msalter@redhat.com>, Len Brown <lenb@kernel.org>, devicetree@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Leif Lindholm <leif.lindholm@linaro.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, Rob Herring <robh+dt@kernel.org>, Christopher Covington <cov@codeaurora.org>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
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
Tested-by: Christopher Covington <cov@codeaurora.org>
---
 drivers/of/fdt.c              | 11 +----------
 drivers/tty/serial/earlycon.c |  2 +-
 include/linux/of_fdt.h        |  3 +++
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 085c638..c89d5d2 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -924,7 +924,7 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 
 #ifdef CONFIG_SERIAL_EARLYCON
 
-static int __init early_init_dt_scan_chosen_serial(void)
+int __init early_init_dt_scan_chosen_stdout(void)
 {
 	int offset;
 	const char *p, *q, *options = NULL;
@@ -968,15 +968,6 @@ static int __init early_init_dt_scan_chosen_serial(void)
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
index 26c3302..4341f32 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -14,6 +14,7 @@
 
 #include <linux/types.h>
 #include <linux/init.h>
+#include <linux/errno.h>
 
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
@@ -66,6 +67,7 @@ extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
 				     int depth, void *data);
 extern int early_init_dt_scan_memory(unsigned long node, const char *uname,
 				     int depth, void *data);
+extern int early_init_dt_scan_chosen_stdout(void);
 extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
@@ -94,6 +96,7 @@ extern void early_get_first_memblock_info(void *, phys_addr_t *);
 extern u64 of_flat_dt_translate_address(unsigned long node);
 extern void of_fdt_limit_memory(int limit);
 #else /* CONFIG_OF_FLATTREE */
+static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
 static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
-- 
2.9.3
