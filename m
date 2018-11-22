From: Songjun Wu <songjun.wu@linux.intel.com>
Subject: [RESEND PATCH] include: Add lantiq.h in include/linux/
Date: Thu, 22 Nov 2018 15:47:35 +0800
Message-ID: <20181122074736.417-1-songjun.wu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Songjun Wu <songjun.wu@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In some existing lantiq driver, the C codes include lantiq_soc.h
header file directly.

./arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
./arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h

Those drivers need to be extended to support more platform.
lantiq.h is added in include/linux/ to make it
globally available and provides some wrapper codes.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 include/linux/lantiq.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 include/linux/lantiq.h

diff --git a/include/linux/lantiq.h b/include/linux/lantiq.h
new file mode 100644
index 000000000000..67921169d84d
--- /dev/null
+++ b/include/linux/lantiq.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_LANTIQ_H
+#define __LINUX_LANTIQ_H
+
+#ifdef CONFIG_LANTIQ
+#include <lantiq_soc.h>
+#else
+
+#ifndef LTQ_EARLY_ASC
+#define LTQ_EARLY_ASC 0
+#endif
+
+#ifndef CPHYSADDR
+#define CPHYSADDR(a) 0
+#endif
+
+static inline struct clk *clk_get_fpi(void)
+{
+	return NULL;
+}
+#endif /* CONFIG_LANTIQ */
+#endif /* __LINUX_LANTIQ_H */
-- 
2.11.0
