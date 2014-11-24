From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V3 2/7] of/fdt: Add endianness helper function for early init code
Date: Mon, 24 Nov 2014 15:36:17 -0800
Message-ID: <1416872182-6440-3-git-send-email-cernekee@gmail.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:41333 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbaKXXgb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Nov 2014 18:36:31 -0500
In-Reply-To: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org

Provide a libfdt-based equivalent for of_device_is_big_endian(), suitable
for use in the early_init_* functions.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c       | 19 +++++++++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 30e97bc..658656f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -107,6 +107,25 @@ int of_fdt_is_compatible(const void *blob,
 }
 
 /**
+ * of_fdt_is_big_endian - Return true if given node needs BE MMIO accesses
+ * @blob: A device tree blob
+ * @node: node to test
+ *
+ * Returns true if the node has a "big-endian" property, or if the kernel
+ * was compiled for BE *and* the node has a "native-endian" property.
+ * Returns false otherwise.
+ */
+bool of_fdt_is_big_endian(const void *blob, unsigned long node)
+{
+	if (fdt_getprop(blob, node, "big-endian", NULL))
+		return true;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
+	    fdt_getprop(blob, node, "native-endian", NULL))
+		return true;
+	return false;
+}
+
+/**
  * of_fdt_match - Return true if node matches a list of compatible values
  */
 int of_fdt_match(const void *blob, unsigned long node,
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 0ff360d5b..587ee50 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -33,6 +33,8 @@ extern void *of_fdt_get_property(const void *blob,
 extern int of_fdt_is_compatible(const void *blob,
 				unsigned long node,
 				const char *compat);
+extern bool of_fdt_is_big_endian(const void *blob,
+				 unsigned long node);
 extern int of_fdt_match(const void *blob, unsigned long node,
 			const char *const *compat);
 extern void of_fdt_unflatten_tree(unsigned long *blob,
-- 
2.1.0

