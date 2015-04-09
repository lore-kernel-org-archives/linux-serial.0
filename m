From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V4 2/5] of/fdt: Add endianness helper function for early init code
Date: Thu,  9 Apr 2015 13:05:15 -0700
Message-ID: <1428609918-10290-3-git-send-email-cernekee@gmail.com>
References: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428609918-10290-1-git-send-email-cernekee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org
Cc: arnd@arndb.de, peter@hurleysoftware.com, f.fainelli@gmail.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Provide a libfdt-based equivalent for of_device_is_big_endian(), suitable
for use in the early_init_* functions.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/fdt.c       | 19 +++++++++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 3a896c9aeb74..1ebd6194fe7f 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -109,6 +109,25 @@ int of_fdt_is_compatible(const void *blob,
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
index 0ff360d5b3b3..587ee507965d 100644
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
2.2.2
