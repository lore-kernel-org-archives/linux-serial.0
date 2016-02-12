From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 3/9] ACPI: introduce acpi_table_parse2()
Date: Fri, 12 Feb 2016 20:43:34 +0300
Message-ID: <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

The function acpi_table_parse() has some problems:
1 It can be called only from __init code
2 It does not pass any data to the handler
3 It just throws out the value returned from the handler

These issues are addressed in this patch

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 drivers/acpi/tables.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 include/linux/acpi.h  |  8 ++++++++
 2 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 6c0f079..98ae052 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -40,7 +40,7 @@ static char *mps_inti_flags_trigger[] = { "dfl", "edge", "res", "level" };
 
 static struct acpi_table_desc initial_tables[ACPI_MAX_TABLES] __initdata;
 
-static int acpi_apic_instance __initdata;
+static int acpi_apic_instance;
 
 /*
  * Disable table checksum verification for the early stage due to the size
@@ -374,19 +374,27 @@ acpi_table_parse_madt(enum acpi_madt_type id,
 }
 
 /**
- * acpi_table_parse - find table with @id, run @handler on it
+ * acpi_table_parse2 - find table with @id, run @handler on it
  * @id: table id to find
  * @handler: handler to run
+ * @data: data to pass to handler
  *
  * Scan the ACPI System Descriptor Table (STD) for a table matching @id,
  * run @handler on it.
  *
- * Return 0 if table found, -errno if not.
+ * How it differs from acpi_table_parse()
+ * 1. It respect the return value of the handler function
+ * 2. It has additional data argument to make closures
+ * 3. It can be called from everywhere from the kernel (no __init)
+ *
+ * Return: the value returned by the handler if table found, -errno if not.
  */
-int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
+int acpi_table_parse2(char *id,
+	int (*handler)(struct acpi_table_header *table, void *data), void *data)
 {
 	struct acpi_table_header *table = NULL;
 	acpi_size tbl_size;
+	int err;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -395,16 +403,43 @@ int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
 		return -EINVAL;
 
 	if (strncmp(id, ACPI_SIG_MADT, 4) == 0)
-		acpi_get_table_with_size(id, acpi_apic_instance, &table, &tbl_size);
+		acpi_get_table_with_size(id, acpi_apic_instance, &table,
+					 &tbl_size);
 	else
 		acpi_get_table_with_size(id, 0, &table, &tbl_size);
 
 	if (table) {
-		handler(table);
+		err = handler(table, data);
 		early_acpi_os_unmap_memory(table, tbl_size);
-		return 0;
+		return err;
 	} else
 		return -ENODEV;
+
+}
+
+/*
+ * 1. fix the signature
+ * 2. always return 0, don't respect the value returned from the handler
+ */
+static int legacy_acpi_table_handler(struct acpi_table_header *table, void *d)
+{
+	((acpi_tbl_table_handler)d)(table);
+	return 0;
+}
+
+/**
+ * acpi_table_parse - find table with @id, run @handler on it
+ * @id: table id to find
+ * @handler: handler to run
+ *
+ * Scan the ACPI System Descriptor Table (STD) for a table matching @id,
+ * run @handler on it.
+ *
+ * Return 0 if table found, -errno if not.
+ */
+int __init acpi_table_parse(char *id, acpi_tbl_table_handler handler)
+{
+	return acpi_table_parse2(id, legacy_acpi_table_handler, handler);
 }
 
 /* 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..bed9b89 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -218,6 +218,8 @@ int acpi_numa_init (void);
 
 int acpi_table_init (void);
 int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
+int acpi_table_parse2(char *id, int (*handler)(struct acpi_table_header *table,
+					       void *data), void *data);
 int __init acpi_parse_entries(char *id, unsigned long table_size,
 			      acpi_tbl_entry_handler handler,
 			      struct acpi_table_header *table_header,
@@ -636,6 +638,12 @@ static inline int acpi_table_parse(char *id,
 	return -ENODEV;
 }
 
+int acpi_table_parse2(char *id, int (*handler)(struct acpi_table_header *table,
+					       void *data), void *data)
+{
+	return -ENODEV;
+}
+
 static inline int acpi_nvs_register(__u64 start, __u64 size)
 {
 	return 0;
-- 
2.7.0

