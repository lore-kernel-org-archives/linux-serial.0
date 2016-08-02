From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0967/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:32 +0800
Message-ID: <20160802120332.14527-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com, phillip.raffeck@fau.de, anton.wuerfel@fau.de, peter@hurleysoftware.com, yamada.masahiro@socionext.com, wan.ahmad.zainie.wan.mohamad@intel.com, mail@maciej.szmigiero.name, matwey@sai.msu.ru, chuansheng.liu@intel.com, baolex.ni@intel.com
List-Id: linux-serial@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/tty/serial/8250/8250_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0fbd7c0..9309ec1 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1188,17 +1188,17 @@ module_exit(serial8250_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 serial driver");
 
-module_param(share_irqs, uint, 0644);
+module_param(share_irqs, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(share_irqs, "Share IRQs with other non-8250/16x50 devices (unsafe)");
 
-module_param(nr_uarts, uint, 0644);
+module_param(nr_uarts, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(nr_uarts, "Maximum number of UARTs supported. (1-" __MODULE_STRING(CONFIG_SERIAL_8250_NR_UARTS) ")");
 
-module_param(skip_txen_test, uint, 0644);
+module_param(skip_txen_test, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(skip_txen_test, "Skip checking for the TXEN bug at init time");
 
 #ifdef CONFIG_SERIAL_8250_RSA
-module_param_array(probe_rsa, ulong, &probe_rsa_count, 0444);
+module_param_array(probe_rsa, ulong, &probe_rsa_count, S_IRUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(probe_rsa, "Probe I/O ports for RSA");
 #endif
 MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
-- 
2.9.2
