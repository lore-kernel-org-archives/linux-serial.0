From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0970/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:49 +0800
Message-ID: <20160802120349.14727-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jason.wessel@windriver.com, gregkh@linuxfoundation.org, jslaby@suse.com, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, wan.ahmad.zainie.wan.mohamad@intel.com, mail@maciej.szmigiero.name, matwey@sai.msu.ru
List-Id: linux-serial@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/tty/serial/kgdboc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index a260cde..192e53c 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -333,7 +333,7 @@ early_param("ekgdboc", kgdboc_early_init);
 
 module_init(init_kgdboc);
 module_exit(cleanup_kgdboc);
-module_param_call(kgdboc, param_set_kgdboc_var, param_get_string, &kps, 0644);
+module_param_call(kgdboc, param_set_kgdboc_var, param_get_string, &kps, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(kgdboc, "<serial_device>[,baud]");
 MODULE_DESCRIPTION("KGDB Console TTY Driver");
 MODULE_LICENSE("GPL");
-- 
2.9.2
