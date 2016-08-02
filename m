From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0968/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:03:39 +0800
Message-ID: <20160802120339.14595-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, m.chehab@samsung.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, phillip.raffeck@fau.de, anton.wuerfel@fau.de, andriy.shevchenko@linux.intel.com, chuansheng.liu@intel.com, baolex.ni@intel.com, wan.ahmad.zainie.wan.mohamad@intel.com, mail@maciej.szmigiero.name, matwey@sai.msu.ru
List-Id: linux-serial@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/tty/serial/8250/serial_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/serial_cs.c b/drivers/tty/serial/8250/serial_cs.c
index 933c268..6778d81 100644
--- a/drivers/tty/serial/8250/serial_cs.c
+++ b/drivers/tty/serial/8250/serial_cs.c
@@ -60,8 +60,8 @@ static int do_sound = 1;
 /* Skip strict UART tests? */
 static int buggy_uart;
 
-module_param(do_sound, int, 0444);
-module_param(buggy_uart, int, 0444);
+module_param(do_sound, int, S_IRUSR | S_IRGRP | S_IROTH);
+module_param(buggy_uart, int, S_IRUSR | S_IRGRP | S_IROTH);
 
 /*====================================================================*/
 
-- 
2.9.2
