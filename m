From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/2] OF: update stdout-path parsing
Date: Sat,  8 Feb 2014 12:53:52 +0100
Message-ID: <1391860433-5343-1-git-send-email-plagnioj@jcrosoft.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Today we only check if the linux,stdout-path property is present and retreive
the node. But the DT specification allow to pass the serial options too as
this
	linux,stdout-path = &UART0;

or with options

	inux,stdout-path = "/plb@0/serial@84000000:115200";

So update the parsing to support and also the backward compatible stdout-path
property.

Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
---
 drivers/of/base.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++---------
 include/linux/of.h |  4 ++--
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ff85450..ab9ff2f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -34,6 +34,7 @@ EXPORT_SYMBOL(of_allnodes);
 struct device_node *of_chosen;
 struct device_node *of_aliases;
 static struct device_node *of_stdout;
+static char *of_stdout_option;
 
 DEFINE_MUTEX(of_aliases_mutex);
 
@@ -1783,6 +1784,45 @@ static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 }
 
 /**
+ * of_stdout_path_scan - check if a device node matches the
+ *                           linux,stdout-path property and parse it
+ */
+static void of_stdout_path_scan(void)
+{
+	const char *name;
+	const char *tmp;
+	const char *tmp_option;
+
+	name = of_get_property(of_chosen, "linux,stdout-path", NULL);
+	if (!name)
+		name = of_get_property(of_chosen, "stdout-path", NULL);
+
+	if (!name)
+		return;
+
+	tmp_option = strchr(name, ':');
+
+	if (!tmp_option) {
+		of_stdout = of_find_node_by_path(name);
+		return;
+	}
+
+	tmp = kstrndup(name, strlen(name) - strlen(tmp_option), GFP_KERNEL);
+	if (!tmp)
+		return;
+
+	of_stdout = of_find_node_by_path(tmp);
+	if (!of_stdout)
+		goto out;
+
+	tmp_option++;
+	of_stdout_option = kstrdup(tmp_option, GFP_KERNEL);
+
+out:
+	kfree(tmp);
+}
+
+/**
  * of_alias_scan - Scan all properties of 'aliases' node
  *
  * The function scans all the properties of 'aliases' node and populate
@@ -1800,13 +1840,8 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))
 	if (of_chosen == NULL)
 		of_chosen = of_find_node_by_path("/chosen@0");
 
-	if (of_chosen) {
-		const char *name;
-
-		name = of_get_property(of_chosen, "linux,stdout-path", NULL);
-		if (name)
-			of_stdout = of_find_node_by_path(name);
-	}
+	if (of_chosen)
+		of_stdout_path_scan();
 
 	of_aliases = of_find_node_by_path("/aliases");
 	if (!of_aliases)
@@ -1923,13 +1958,17 @@ EXPORT_SYMBOL_GPL(of_prop_next_string);
  *                            linux,stdout-path property
  *
  * Check if this device node matches the linux,stdout-path property
- * in the chosen node. return true if yes, false otherwise.
+ * in the chosen node. return true if yes, false otherwise with the option if
+ * requested.
  */
-int of_device_is_stdout_path(struct device_node *dn)
+int of_device_is_stdout_path(struct device_node *dn, char** option)
 {
 	if (!of_stdout)
 		return false;
 
+	if (option)
+		*option = of_stdout_option;
+
 	return of_stdout == dn;
 }
 EXPORT_SYMBOL_GPL(of_device_is_stdout_path);
diff --git a/include/linux/of.h b/include/linux/of.h
index 70c64ba..a8afe44 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -352,7 +352,7 @@ const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
  */
 const char *of_prop_next_string(struct property *prop, const char *cur);
 
-int of_device_is_stdout_path(struct device_node *dn);
+int of_device_is_stdout_path(struct device_node *dn, char** option);
 
 #else /* CONFIG_OF */
 
@@ -542,7 +542,7 @@ static inline int of_machine_is_compatible(const char *compat)
 	return 0;
 }
 
-static inline int of_device_is_stdout_path(struct device_node *dn)
+static inline int of_device_is_stdout_path(struct device_node *dn, char** option)
 {
 	return 0;
 }
-- 
1.9.rc1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
