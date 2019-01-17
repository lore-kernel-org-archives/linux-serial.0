From: <zhe.he@windriver.com>
Subject: [PATCH] serial: 8250: Fix serial8250 initialization crash
Date: Thu, 17 Jan 2019 17:00:19 +0800
Message-ID: <1547715619-181299-1-git-send-email-zhe.he@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, andriy.shevchenko@linux.intel.com, bigeasy@linutronix.de, Jisheng.Zhang@synaptics.com, darwin.dingel@alliedtelesis.co.nz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, zhe.he@windriver.com
List-Id: linux-serial@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

The initialization code of interrupt backoff work might reference NULL
pointer and cause the following crash, if no port was found.

[   10.017727] CPU 0 Unable to handle kernel paging request at virtual address 000001b0, epc == 807088e0, ra == 8070863c
---- snip ----
[   11.704470] [<807088e0>] serial8250_register_8250_port+0x318/0x4ac
[   11.747251] [<80708d74>] serial8250_probe+0x148/0x1c0
[   11.789301] [<80728450>] platform_drv_probe+0x40/0x94
[   11.830515] [<807264f8>] really_probe+0xf8/0x318
[   11.870876] [<80726b7c>] __driver_attach+0x110/0x12c
[   11.910960] [<80724374>] bus_for_each_dev+0x78/0xcc
[   11.951134] [<80725958>] bus_add_driver+0x200/0x234
[   11.989756] [<807273d8>] driver_register+0x84/0x148
[   12.029832] [<80d72f84>] serial8250_init+0x138/0x198
[   12.070447] [<80100e6c>] do_one_initcall+0x5c/0x2a0
[   12.110104] [<80d3a208>] kernel_init_freeable+0x370/0x484
[   12.150722] [<80a49420>] kernel_init+0x10/0xf8
[   12.191517] [<8010756c>] ret_from_kernel_thread+0x14/0x1c

This patch makes sure the initialization code can be reached only if a port
is found.

Fixes: commit 6d7f677a2afa ("serial: 8250: Rate limit serial port rx interrupts during input overruns")
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/tty/serial/8250/8250_core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 189ab12..e441221 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1070,15 +1070,16 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 			ret = 0;
 		}
-	}
 
-	/* Initialise interrupt backoff work if required */
-	if (up->overrun_backoff_time_ms > 0) {
-		uart->overrun_backoff_time_ms = up->overrun_backoff_time_ms;
-		INIT_DELAYED_WORK(&uart->overrun_backoff,
-				  serial_8250_overrun_backoff_work);
-	} else {
-		uart->overrun_backoff_time_ms = 0;
+		/* Initialise interrupt backoff work if required */
+		if (up->overrun_backoff_time_ms > 0) {
+			uart->overrun_backoff_time_ms =
+				up->overrun_backoff_time_ms;
+			INIT_DELAYED_WORK(&uart->overrun_backoff,
+					serial_8250_overrun_backoff_work);
+		} else {
+			uart->overrun_backoff_time_ms = 0;
+		}
 	}
 
 	mutex_unlock(&serial_mutex);
-- 
2.7.4
