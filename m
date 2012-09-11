From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: [PATCH 02/12] kdb: Implement disable_nmi command
Date: Tue, 11 Sep 2012 02:34:56 -0700
Message-ID: <1347356106-25368-2-git-send-email-anton.vorontsov@linaro.org>
References: <20120911093042.GA12471@lizard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120911093042.GA12471@lizard>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, John Stultz <john.stultz@linaro.org>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, kgdb-bugreport@lists.sourceforge.net, kernel-team@android.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This command disables NMI-entry. If NMI source has been previously shared
with a serial console ("debug port"), this effectively releases the port
from KDB exclusive use, and makes the console available for normal use.

Of course, NMI can be reenabled, enable_nmi modparam is used for that:

	echo 1 > /sys/module/kdb/parameters/enable_nmi

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 kernel/debug/kdb/kdb_main.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 31df170..9fadff1 100644
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
+	kgdb_enable_nmi(0);
+	return 0;
+}
+
+static int kdb_param_enable_nmi(const char *val, const struct kernel_param *kp)
+{
+	if (!atomic_add_unless(&kdb_nmi_disabled, -1, 0))
+		return -EINVAL;
+	kgdb_enable_nmi(1);
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
@@ -2851,6 +2878,8 @@ static void __init kdb_inittab(void)
 	kdb_register_repeat("dmesg", kdb_dmesg, "[lines]",
 	  "Display syslog buffer", 0, KDB_REPEAT_NONE);
 #endif
+	kdb_register_repeat("disable_nmi", kdb_disable_nmi, "",
+	  "Disable NMI entry to KDB", 0, KDB_REPEAT_NONE);
 	kdb_register_repeat("defcmd", kdb_defcmd, "name \"usage\" \"help\"",
 	  "Define a set of commands, down to endefcmd", 0, KDB_REPEAT_NONE);
 	kdb_register_repeat("kill", kdb_kill, "<-signal> <pid>",
-- 
1.7.11.5
