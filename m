From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0969/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:44 +0800
Message-ID: <20160802120344.14661-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, andriy.shevchenko@linux.intel.com, wan.ahmad.zainie.wan.mohamad@intel.com, mail@maciej.szmigiero.name, matwey@sai.msu.ru
List-Id: linux-serial@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/tty/serial/kgdb_nmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/kgdb_nmi.c b/drivers/tty/serial/kgdb_nmi.c
index 117df15..522c980 100644
--- a/drivers/tty/serial/kgdb_nmi.c
+++ b/drivers/tty/serial/kgdb_nmi.c
@@ -31,7 +31,7 @@
 #include <linux/kdb.h>
 
 static int kgdb_nmi_knock = 1;
-module_param_named(knock, kgdb_nmi_knock, int, 0600);
+module_param_named(knock, kgdb_nmi_knock, int, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(knock, "if set to 1 (default), the special '$3#33' command " \
 			"must be used to enter the debugger; when set to 0, " \
 			"hitting return key is enough to enter the debugger; " \
@@ -39,7 +39,7 @@ MODULE_PARM_DESC(knock, "if set to 1 (default), the special '$3#33' command " \
 			"upon NMI");
 
 static char *kgdb_nmi_magic = "$3#33";
-module_param_named(magic, kgdb_nmi_magic, charp, 0600);
+module_param_named(magic, kgdb_nmi_magic, charp, S_IRUSR | S_IWUSR);
 MODULE_PARM_DESC(magic, "magic sequence to enter NMI debugger (default $3#33)");
 
 static atomic_t kgdb_nmi_num_readers = ATOMIC_INIT(0);
-- 
2.9.2
