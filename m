From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: [PATCH 02/11] kdb: Implement disable_nmi command
Date: Mon, 24 Sep 2012 14:27:51 -0700
Message-ID: <1348522080-32629-2-git-send-email-anton.vorontsov@linaro.org>
References: <20120924212648.GA27605@lizard>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34912 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2IXVbe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Sep 2012 17:31:34 -0400
Received: by padhz1 with SMTP id hz1so1191278pad.19
        for <linux-serial@vger.kernel.org>; Mon, 24 Sep 2012 14:31:34 -0700 (PDT)
In-Reply-To: <20120924212648.GA27605@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>
Cc: Alan Cox <alan@linux.intel.com>, Jason Wessel <jason.wessel@windriver.com>, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

This command disables NMI-entry. If NMI source has been previously shared
with a serial console ("debug port"), this effectively releases the port
from KDB exclusive use, and makes the console available for normal use.

Of course, NMI can be reenabled, enable_nmi modparam is used for that:

	echo 1 > /sys/module/kdb/parameters/enable_nmi

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
Acked-by: Jason Wessel <jason.wessel@windriver.com>
---
 kernel/debug/kdb/kdb_main.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 31df170..1261dc7 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -21,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -2107,6 +2108,32 @@ static int kdb_dmesg(int argc, const char **argv)
 	return 0;
 }
 #endif /* CONFIG_PRINTK */
+
+/* Make sure we balance enable/disable calls, must disable first. */
+static atomic_t kdb_nmi_disabled;
+
+static int kdb_disable_nmi(int argc, const char *argv[])
+{
+	if (atomic_read(&kdb_nmi_disabled))
+		return 0;
+	atomic_set(&kdb_nmi_disabled, 1);
+	arch_kgdb_ops.enable_nmi(0);
+	return 0;
+}
+
+static int kdb_param_enable_nmi(const char *val, const struct kernel_param *kp)
+{
+	if (!atomic_add_unless(&kdb_nmi_disabled, -1, 0))
+		return -EINVAL;
+	arch_kgdb_ops.enable_nmi(1);
+	return 0;
+}
+
+static const struct kernel_param_ops kdb_param_ops_enable_nmi = {
+	.set = kdb_param_enable_nmi,
+};
+module_param_cb(enable_nmi, &kdb_param_ops_enable_nmi, NULL, 0600);
+
 /*
  * kdb_cpu - This function implements the 'cpu' command.
  *	cpu	[<cpunum>]
@@ -2851,6 +2878,10 @@ static void __init kdb_inittab(void)
 	kdb_register_repeat("dmesg", kdb_dmesg, "[lines]",
 	  "Display syslog buffer", 0, KDB_REPEAT_NONE);
 #endif
+	if (arch_kgdb_ops.enable_nmi) {
+		kdb_register_repeat("disable_nmi", kdb_disable_nmi, "",
+		  "Disable NMI entry to KDB", 0, KDB_REPEAT_NONE);
+	}
 	kdb_register_repeat("defcmd", kdb_defcmd, "name \"usage\" \"help\"",
 	  "Define a set of commands, down to endefcmd", 0, KDB_REPEAT_NONE);
 	kdb_register_repeat("kill", kdb_kill, "<-signal> <pid>",
-- 
1.7.12

