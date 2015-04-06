From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH V3 5/7] serial: earlycon: Set UPIO_MEM32BE based on DT
 properties
Date: Mon, 06 Apr 2015 13:36:14 -0400
Message-ID: <5522C40E.5060705@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-6-git-send-email-cernekee@gmail.com> <54F3914F.3080905@hurleysoftware.com> <20150328013604.488A0C4091F@trevor.secretlab.ca> <5516DE64.6000104@hurleysoftware.com> <CAL_JsqKQD2ivpZ5kOy8ehmzsdFy8EMFZ-KvO2QS3fxtLgQL8Lw@mail.gmail.com> <551D61A5.8000604@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551D61A5.8000604-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-MIPS <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On 04/02/2015 11:35 AM, Peter Hurley wrote:
> On 04/02/2015 09:46 AM, Rob Herring wrote:
>> Sorry about that. I had thought about doing the same thing. At least
>> unifying the macros, but not necessarily the tables. If it is also
>> extendable to other firmware interfaces like ACPI perhaps that would
>> be good.
> 
> No need to apologize; I'll make those changes and resubmit for your
> review.

What about something like the following?

This patch makes both __earlycon_table and __earlycon_of_table
arrays of struct earlycon_id, and a follow-on patch would use the
earlycon name to initialize the struct console fields.

The benefits of this approach are
1. diagnostics can readily identify the earlycon if there is some error
2. it would be trivial to enable both command line and devicetree
   earlycon from the same earlycon declaration.

And a single table is doable from this point.

AFAICT there is no benefit to using actual OF tables, and I see no
other reasonable way to initialize the name of the struct console
for devicetree earlycons.

Regards,
Peter Hurley


--- >% ---
Subject: [PATCH] serial: earlycon: Use common framework for earlycon
 declarations

Use common table definition and implementation macro to declare an
earlycon, but retain separate tables for command line and devicetree.
Add __EARLYCON_DECLARE() macro to instance a unique earlycon
declaration for the specified table.

This enables all earlycons to properly initialize the earlycon console
structure with name and index.

Signed-off-by: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
---
 drivers/of/fdt.c                  |  6 +++---
 drivers/tty/serial/earlycon.c     |  3 +--
 include/asm-generic/vmlinux.lds.h |  8 ++++++--
 include/linux/serial_core.h       | 30 +++++++++++++++++++++---------
 4 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 7cef9f9..f640efa 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -760,14 +760,14 @@ static inline void early_init_dt_check_for_initrd(unsigned long node)
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 #ifdef CONFIG_SERIAL_EARLYCON
-extern struct of_device_id __earlycon_of_table[];
+extern struct earlycon_id __earlycon_of_table[];
 
 static int __init early_init_dt_scan_chosen_serial(void)
 {
 	int offset;
 	const char *p, *q;
 	int l;
-	const struct of_device_id *match = __earlycon_of_table;
+	const struct earlycon_id *match = __earlycon_of_table;
 	const void *fdt = initial_boot_params;
 
 	offset = fdt_path_offset(fdt, "/chosen");
@@ -800,7 +800,7 @@ static int __init early_init_dt_scan_chosen_serial(void)
 		if (!addr)
 			return -ENXIO;
 
-		of_setup_earlycon(addr, match->data);
+		of_setup_earlycon(addr, match->setup);
 		return 0;
 	}
 	return -ENODEV;
diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index 5fdc9f3..bf7eb76 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -19,7 +19,6 @@
 #include <linux/io.h>
 #include <linux/serial_core.h>
 #include <linux/sizes.h>
-#include <linux/mod_devicetable.h>
 
 #ifdef CONFIG_FIX_EARLYCON_MEM
 #include <asm/fixmap.h>
@@ -41,7 +40,7 @@ extern struct earlycon_id __earlycon_table[];
 static const struct earlycon_id __earlycon_table_sentinel
 	__used __section(__earlycon_table_end);
 
-static const struct of_device_id __earlycon_of_table_sentinel
+static const struct earlycon_id __earlycon_of_table_sentinel
 	__used __section(__earlycon_of_table_end);
 
 static void __iomem * __init earlycon_map(unsigned long paddr, size_t size)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 561daf4..7322c30 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -155,8 +155,13 @@
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 *(__earlycon_table)			\
 			 *(__earlycon_table_end)
+#define EARLYCON_OF_TABLE()	STRUCT_ALIGN();				 \
+				VMLINUX_SYMBOL(__earlycon_of_table) = .; \
+				*(__earlycon_of_table)			 \
+				*(__earlycon_of_table_end)
 #else
 #define EARLYCON_TABLE()
+#define EARLYCON_OF_TABLE()
 #endif
 
 #define ___OF_TABLE(cfg, name)	_OF_TABLE_##cfg(name)
@@ -175,7 +180,6 @@
 #define IOMMU_OF_TABLES()	OF_TABLE(CONFIG_OF_IOMMU, iommu)
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
-#define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
@@ -512,7 +516,7 @@
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	EARLYCON_TABLE()						\
-	EARLYCON_OF_TABLES()
+	EARLYCON_OF_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 025dad9..9455e97 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -341,22 +341,34 @@ struct earlycon_device {
 
 struct earlycon_id {
 	char	name[16];
+	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
 } __aligned(32);
 
+#define EARLYCON_TABLE __used __section(__earlycon_table)
+
+#ifdef CONFIG_OF
+#define EARLYCON_OF_TABLE __used __section(__earlycon_of_table)
+#else
+#define EARLYCON_OF_TABLE __attribute__((unused))
+#endif
+
+#define __EARLYCON_DECLARE(_name, compat, fn, pre, section)		\
+	static const struct earlycon_id __UNIQUE_ID(pre##_name) section	\
+		 = { .name = __stringify(_name),			\
+		     .compatible = compat,				\
+		     .setup = fn  }
+
+#define EARLYCON_DECLARE(_name, fn)					\
+	__EARLYCON_DECLARE(_name, "", fn, __earlycon_, EARLYCON_TABLE)
+
+#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
+	__EARLYCON_DECLARE(_name, compat, fn, __earlycon_of_, EARLYCON_OF_TABLE)
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
2.3.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
