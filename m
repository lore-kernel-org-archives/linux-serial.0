From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 4/8] ACPI: genaralize iterating over subtables in ACPI_PROBE_TABLE()
Date: Mon, 22 Feb 2016 16:46:52 +0300
Message-ID: <1456148818-26257-5-git-send-email-aleksey.makarov@linaro.org>
References: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456148818-26257-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, John Stultz <john.stultz@linaro.org>
List-Id: linux-serial@vger.kernel.org

Refactor ACPI_PROBE_TABLE() so that it is possible to iterate
over subtables that do not have acpi_subtype header (for example
over subtables of DBG2 table)

To do so:

- Add void * data pointer argument for callback.  It will allow to
  parse the table and iterate over subtables calling the subtable
  callbacks that are provided via this data pointer.
- Save only ACPI table id, callback and callback data in the linker
  tables.  This makes tables more terse and simplifies the semantics
  of the fields of it's elements.
  The additional data that required for subtable parsing are saved
  in static namespace without increasing the size of linker tables.
- Introduce two macros with clear meaning of arguments, instead one.
  The old ACPI_DECLARE_PROBE_ENTRY() macros has arguments that have
  different meaning if the entry is for table or for subtable.  The
  arguments of the new macroses ACPI_DECLARE_PROBE_ENTRY() and
  ACPI_DECLARE_PROBE_SUBTYPE_ENTRY() have unambiguous meaning.
- Document arguments of those macroses instead of the fields of linker
  table data.
- Fix the issue that prevents using this macros for parsing subtables
  other than MADT.  In the original code, MADT-specific function
  was used to iterate over subtables, while the name was common.
  Introduce a new parameter to macors that specifies the size of
  the table to do it in common way.
- Don't expose the internals of the tables to the drivers passing
  a pointer to struct acpi_probe_entry to the subtable callback validator.
  Instead, pass the sideband data specified by the driver.
- Fix the driver's callback signatures: a. Add an unused pointer to void
  for table matchers (currently only clocksource callback) b. Change
  the type of sideband data to kernel_ulong_t.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/scan.c                  |  44 ++++++++++-----
 drivers/clocksource/arm_arch_timer.c |   3 +-
 drivers/irqchip/irq-gic.c            |   4 +-
 include/linux/acpi.h                 | 104 ++++++++++++++++++++++++-----------
 include/linux/clocksource.h          |   2 +-
 include/linux/irqchip.h              |   5 +-
 6 files changed, 109 insertions(+), 53 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 407a376..a258594 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1968,16 +1968,38 @@ static struct acpi_probe_entry *ape;
 static int acpi_probe_count;
 static DEFINE_SPINLOCK(acpi_probe_lock);
 
-static int __init acpi_match_madt(struct acpi_subtable_header *header,
-				  const unsigned long end)
+static int __init acpi_match_and_setup(struct acpi_subtable_header *header,
+				       const unsigned long end)
 {
-	if (!ape->subtable_valid || ape->subtable_valid(header, ape))
-		if (!ape->probe_subtbl(header, end))
+	const struct acpi_probe_subtype_data *data = ape->data;
+
+	if (data->valid(header, data->data))
+		if (!data->setup(header, end))
 			acpi_probe_count++;
 
 	return 0;
 }
 
+int __init acpi_probe_subtype_setup(struct acpi_table_header *table,
+				    const void *data)
+{
+	const struct acpi_probe_subtype_data *data_subtype = data;
+
+	return acpi_parse_entries(ape->id, data_subtype->size,
+				  acpi_match_and_setup, table,
+				  data_subtype->subtype, 0);
+}
+
+static int __init acpi_probe_table_handler(struct acpi_table_header *table)
+{
+	int err = ape->setup(table, ape->data);
+
+	if (ape->setup != acpi_probe_subtype_setup && err >= 0)
+		acpi_probe_count++;
+
+	return err;
+}
+
 int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 {
 	int count = 0;
@@ -1987,16 +2009,10 @@ int __init __acpi_probe_device_table(struct acpi_probe_entry *ap_head, int nr)
 
 	spin_lock(&acpi_probe_lock);
 	for (ape = ap_head; nr; ape++, nr--) {
-		if (ACPI_COMPARE_NAME(ACPI_SIG_MADT, ape->id)) {
-			acpi_probe_count = 0;
-			acpi_table_parse_madt(ape->type, acpi_match_madt, 0);
-			count += acpi_probe_count;
-		} else {
-			int res;
-			res = acpi_table_parse(ape->id, ape->probe_table);
-			if (!res)
-				count++;
-		}
+		acpi_probe_count = 0;
+		if (acpi_table_parse(ape->id, acpi_probe_table_handler) < 0)
+			continue;
+		count += acpi_probe_count;
 	}
 	spin_unlock(&acpi_probe_lock);
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index c64d543..95c4922e 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -826,7 +826,8 @@ static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 }
 
 /* Initialize per-processor generic timer */
-static int __init arch_timer_acpi_init(struct acpi_table_header *table)
+static int __init arch_timer_acpi_init(struct acpi_table_header *table,
+				       const void *data)
 {
 	struct acpi_table_gtdt *gtdt;
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8f9ebf7..37a5eed 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1287,12 +1287,12 @@ static bool __init acpi_gic_redist_is_present(void)
 }
 
 static bool __init gic_validate_dist(struct acpi_subtable_header *header,
-				     struct acpi_probe_entry *ape)
+				     kernel_ulong_t driver_data)
 {
 	struct acpi_madt_generic_distributor *dist;
 	dist = (struct acpi_madt_generic_distributor *)header;
 
-	return (dist->version == ape->driver_data &&
+	return (dist->version == driver_data &&
 		(dist->version != ACPI_MADT_GIC_VERSION_NONE ||
 		 !acpi_gic_redist_is_present()));
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..9636c32 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -879,47 +879,76 @@ int acpi_dev_prop_read(struct acpi_device *adev, const char *propname,
 struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 					    struct fwnode_handle *subnode);
 
-struct acpi_probe_entry;
 typedef bool (*acpi_probe_entry_validate_subtbl)(struct acpi_subtable_header *,
-						 struct acpi_probe_entry *);
+						 kernel_ulong_t);
+
+typedef int (*acpi_probe_entry_setup)(struct acpi_table_header *, const void *);
 
 #define ACPI_TABLE_ID_LEN	5
 
-/**
- * struct acpi_probe_entry - boot-time probing entry
- * @id:			ACPI table name
- * @type:		Optional subtable type to match
- *			(if @id contains subtables)
- * @subtable_valid:	Optional callback to check the validity of
- *			the subtable
- * @probe_table:	Callback to the driver being probed when table
- *			match is successful
- * @probe_subtbl:	Callback to the driver being probed when table and
- *			subtable match (and optional callback is successful)
- * @driver_data:	Sideband data provided back to the driver
- */
 struct acpi_probe_entry {
 	__u8 id[ACPI_TABLE_ID_LEN];
-	__u8 type;
-	acpi_probe_entry_validate_subtbl subtable_valid;
-	union {
-		acpi_tbl_table_handler probe_table;
-		acpi_tbl_entry_handler probe_subtbl;
-	};
-	kernel_ulong_t driver_data;
+	acpi_probe_entry_setup setup;
+	const void *data;
 };
 
-#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, valid, data, fn)	\
+/**
+ * ACPI_DECLARE_PROBE_ENTRY() - declare boot-time probing entry
+ * @table:		Name of subsystem to match
+ * @name:               Identifier to compose name of table data
+ * @table_id:		ACPI table name
+ * @setup_fn:		Callback to the driver being probed when table
+ *			matches (of type acpi_probe_entry_setup)
+ * @data_ptr:		Sideband data provided back to the driver
+ */
+#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, setup_fn, data_ptr) \
 	static const struct acpi_probe_entry __acpi_probe_##name	\
 		__used __section(__##table##_acpi_probe_table)		\
 		 = {							\
 			.id = table_id,					\
-			.type = subtable,				\
-			.subtable_valid = valid,			\
-			.probe_table = (acpi_tbl_table_handler)fn,	\
-			.driver_data = data, 				\
+			.setup = setup_fn,				\
+			.data = data_ptr,				\
 		   }
 
+struct acpi_probe_subtype_data {
+	u8 subtype;
+	unsigned long size;
+	acpi_probe_entry_validate_subtbl valid;
+	acpi_tbl_entry_handler setup;
+	kernel_ulong_t data;
+};
+
+int acpi_probe_subtype_setup(struct acpi_table_header *table, const void *data);
+
+/**
+ * ACPI_DECLARE_PROBE_SUBTYPE_ENTRY() - declare boot-time probing entry that
+ *				      matches subtables
+ * @table:		Name of subsystem to match
+ * @name:               Identifier to compose name of table data
+ * @table_id:		ACPI table name
+ * @table_size:		Size of the table (without subtables) of type table_id
+ * @subtable:		Subtable type to match
+ * @valid_fn:		Callback to check the validity of the subtable
+ *			(of type acpi_probe_entry_validate_subtbl)
+ * @data_int:		Sideband data provided back to the driver
+ *			(of type kernel_ulong_t)
+ * @setup_fn:		Callback to the driver being probed when table and
+ *			subtable match and valid_fn callback is successful
+ *			(of type acpi_tbl_entry_handler)
+ */
+#define ACPI_DECLARE_PROBE_SUBTYPE_ENTRY(table, name, table_id, table_size, \
+				subtable, valid_fn, data_int, setup_fn)     \
+	static const struct acpi_probe_subtype_data			    \
+	__acpi_probe_subtype_##name __used = {				    \
+			.subtype = subtable,				    \
+			.size = table_size,				    \
+			.valid = valid_fn,				    \
+			.setup = setup_fn,				    \
+			.data = data_int,				    \
+		   };							    \
+	ACPI_DECLARE_PROBE_ENTRY(table, name, table_id,			    \
+		acpi_probe_subtype_setup, &__acpi_probe_subtype_##name)
+
 #define ACPI_PROBE_TABLE(name)		__##name##_acpi_probe_table
 #define ACPI_PROBE_TABLE_END(name)	__##name##_acpi_probe_table_end
 
@@ -992,14 +1021,23 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 	return NULL;
 }
 
-#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, subtable, validate, data, fn) \
+#define ACPI_DECLARE_PROBE_ENTRY(table, name, table_id, match, data)	\
 	static const void * __acpi_table_##name[]			\
 		__attribute__((unused))					\
-		 = { (void *) table_id,					\
-		     (void *) subtable,					\
-		     (void *) valid,					\
-		     (void *) fn,					\
-		     (void *) data }
+		 = { (void *)table_id,					\
+		     (void *)match,					\
+		     (void *)data }
+
+#define ACPI_DECLARE_PROBE_SUBTYPE_ENTRY(table, name, table_id, table_size, \
+				subtable, valid_fn, data_int, setup_fn)	    \
+	static const void *__acpi_table_##name[]			\
+		__attribute__((unused))					\
+		 = { (void *)table_id,					\
+		     (void *)table_size,				\
+		     (void *)subtable,					\
+		     (void *)valid_fn,					\
+		     (void *)data_int,					\
+		     (void *)setup_fn }
 
 #define acpi_probe_device_table(t)	({ int __r = 0; __r;})
 #endif
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 6013021..2bb5d51 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -259,6 +259,6 @@ static inline void clocksource_probe(void) {}
 #endif
 
 #define CLOCKSOURCE_ACPI_DECLARE(name, table_id, fn)		\
-	ACPI_DECLARE_PROBE_ENTRY(clksrc, name, table_id, 0, NULL, 0, fn)
+	ACPI_DECLARE_PROBE_ENTRY(clksrc, name, table_id, fn, NULL)
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 89c34b2..cc4c455 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -39,8 +39,9 @@
  * @fn: initialization function
  */
 #define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
-	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
-				 subtable, validate, data, fn)
+	ACPI_DECLARE_PROBE_SUBTYPE_ENTRY(irqchip, name, ACPI_SIG_MADT,	\
+					 sizeof(struct acpi_table_madt),\
+					 subtable, validate, data, fn)
 
 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
-- 
2.7.1
