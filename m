From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] tty: serial: constify dev_pm_ops structures
Date: Sun, 15 Jan 2017 16:30:30 +0530
Message-ID: <1484478030-5946-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-serial@vger.kernel.org

Declare dev_pm_ops structures as const as they are only stored in the pm
field of a device_driver structure. This field is of type const, so
dev_pm_ops structures having similar properties can be declared const
too.

Size details after cross compiling the .o file for blackfin architecture.

File size before:
  text	   data	    bss	    dec	    hex	filename
   3572	    320	     16	   3908	    f44 tty/serial/bfin_sport_uart.o

File size after:
   text	   data	    bss	    dec	    hex	filename
   3664	    228	     16	   3908	    f44 tty/serial/bfin_sport_uart.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/tty/serial/bfin_sport_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/bfin_sport_uart.c b/drivers/tty/serial/bfin_sport_uart.c
index 984e1c0..6b03fb1 100644
--- a/drivers/tty/serial/bfin_sport_uart.c
+++ b/drivers/tty/serial/bfin_sport_uart.c
@@ -740,7 +740,7 @@ static int sport_uart_resume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops bfin_sport_uart_dev_pm_ops = {
+static const struct dev_pm_ops bfin_sport_uart_dev_pm_ops = {
 	.suspend	= sport_uart_suspend,
 	.resume		= sport_uart_resume,
 };
-- 
1.9.1
