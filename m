From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] serial: sirf: make of_device_ids const.
Date: Tue, 27 Jun 2017 17:06:17 +0530
Message-ID: <c6d28ba7176bc1257d3ca030b8204b930039f255.1498563206.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, baohua@kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    877	   1864	     88	   2829	    b0d	drivers/tty/serial/sirfsoc_uart.o

File size after constify:
   text	   data	    bss	    dec	    hex	filename
   1885	    840	     88	   2813	    afd	drivers/tty/serial/sirfsoc_uart.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/tty/serial/sirfsoc_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index e03282d..684cb8d 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1253,7 +1253,7 @@ static int __init sirfsoc_uart_console_init(void)
 	return HRTIMER_RESTART;
 }
 
-static struct of_device_id sirfsoc_uart_ids[] = {
+static const struct of_device_id sirfsoc_uart_ids[] = {
 	{ .compatible = "sirf,prima2-uart", .data = &sirfsoc_uart,},
 	{ .compatible = "sirf,atlas7-uart", .data = &sirfsoc_uart},
 	{ .compatible = "sirf,prima2-usp-uart", .data = &sirfsoc_usp},
-- 
1.9.1
