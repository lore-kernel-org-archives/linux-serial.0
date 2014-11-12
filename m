From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 04/10] of: Change of_device_is_available() to return bool
Date: Wed, 12 Nov 2014 12:54:01 -0800
Message-ID: <1415825647-6024-5-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:55348 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaKLUyj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 15:54:39 -0500
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

This function can only return true or false; using a bool makes it more
obvious to the reader.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/base.c  | 22 +++++++++++-----------
 include/linux/of.h |  6 +++---
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 707395c..81c095f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -507,27 +507,27 @@ EXPORT_SYMBOL(of_machine_is_compatible);
  *
  *  @device: Node to check for availability, with locks already held
  *
- *  Returns 1 if the status property is absent or set to "okay" or "ok",
- *  0 otherwise
+ *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  false otherwise
  */
-static int __of_device_is_available(const struct device_node *device)
+static bool __of_device_is_available(const struct device_node *device)
 {
 	const char *status;
 	int statlen;
 
 	if (!device)
-		return 0;
+		return false;
 
 	status = __of_get_property(device, "status", &statlen);
 	if (status == NULL)
-		return 1;
+		return true;
 
 	if (statlen > 0) {
 		if (!strcmp(status, "okay") || !strcmp(status, "ok"))
-			return 1;
+			return true;
 	}
 
-	return 0;
+	return false;
 }
 
 /**
@@ -535,13 +535,13 @@ static int __of_device_is_available(const struct device_node *device)
  *
  *  @device: Node to check for availability
  *
- *  Returns 1 if the status property is absent or set to "okay" or "ok",
- *  0 otherwise
+ *  Returns true if the status property is absent or set to "okay" or "ok",
+ *  false otherwise
  */
-int of_device_is_available(const struct device_node *device)
+bool of_device_is_available(const struct device_node *device)
 {
 	unsigned long flags;
-	int res;
+	bool res;
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 	res = __of_device_is_available(device);
diff --git a/include/linux/of.h b/include/linux/of.h
index 29f0adc..7aaaa59 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -275,7 +275,7 @@ extern int of_property_read_string_helper(struct device_node *np,
 					      const char **out_strs, size_t sz, int index);
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
-extern int of_device_is_available(const struct device_node *device);
+extern bool of_device_is_available(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
@@ -426,9 +426,9 @@ static inline int of_device_is_compatible(const struct device_node *device,
 	return 0;
 }
 
-static inline int of_device_is_available(const struct device_node *device)
+static inline bool of_device_is_available(const struct device_node *device)
 {
-	return 0;
+	return false;
 }
 
 static inline struct property *of_find_property(const struct device_node *np,
-- 
2.1.1

