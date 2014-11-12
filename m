From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 05/10] of: Add helper function to check MMIO register endianness
Date: Wed, 12 Nov 2014 12:54:02 -0800
Message-ID: <1415825647-6024-6-git-send-email-cernekee@gmail.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:39095 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaKLUyl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Nov 2014 15:54:41 -0500
In-Reply-To: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

SoC peripherals can come in several different flavors:

 - little-endian: registers always need to be accessed in LE mode (so the
   kernel should perform a swap if the CPU is running BE)

 - big-endian: registers always need to be accessed in BE mode (so the
   kernel should perform a swap if the CPU is running LE)

 - native-endian: the bus will automatically swap accesses, so the kernel
   should never swap

Introduce a function that checks an OF device node to see whether it
contains a "big-endian" or "native-endian" property.  For the former case,
always return true.  For the latter case, return true iff the kernel was
built for BE (implying that the BE MMIO accessors do not perform a swap).
Otherwise return false, assuming LE registers.

LE registers are assumed by default because most existing drivers (libahci,
serial8250, usb) always use readl/writel in the absence of instructions
to the contrary, so that will be our fallback.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/of/base.c  | 23 +++++++++++++++++++++++
 include/linux/of.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 81c095f..35d95a1 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -552,6 +552,29 @@ bool of_device_is_available(const struct device_node *device)
 EXPORT_SYMBOL(of_device_is_available);
 
 /**
+ *  of_device_is_big_endian - check if a device has BE registers
+ *
+ *  @device: Node to check for endianness
+ *
+ *  Returns true if the device has a "big-endian" property, or if the kernel
+ *  was compiled for BE *and* the device has a "native-endian" property.
+ *  Returns false otherwise.
+ *
+ *  Callers would nominally use ioread32be/iowrite32be if
+ *  of_device_is_big_endian() == true, or readl/writel otherwise.
+ */
+bool of_device_is_big_endian(const struct device_node *device)
+{
+	if (of_property_read_bool(device, "big-endian"))
+		return true;
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
+	    of_property_read_bool(device, "native-endian"))
+		return true;
+	return false;
+}
+EXPORT_SYMBOL(of_device_is_big_endian);
+
+/**
  *	of_get_parent - Get a node's parent if any
  *	@node:	Node to get parent
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 7aaaa59..fc70b01 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -276,6 +276,7 @@ extern int of_property_read_string_helper(struct device_node *np,
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
 extern bool of_device_is_available(const struct device_node *device);
+extern bool of_device_is_big_endian(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
@@ -431,6 +432,11 @@ static inline bool of_device_is_available(const struct device_node *device)
 	return false;
 }
 
+static inline bool of_device_is_big_endian(const struct device_node *device)
+{
+	return false;
+}
+
 static inline struct property *of_find_property(const struct device_node *np,
 						const char *name,
 						int *lenp)
-- 
2.1.1

