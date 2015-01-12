From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: [PATCH] tty: serial: msm_serial: Remove console unregistration from driver exit.
Date: Mon, 12 Jan 2015 19:22:12 +0530
Message-ID: <1421070732-24527-1-git-send-email-pramod.gurav@smartplayin.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Pramod Gurav <pramod.gurav@smartplayin.com>
List-Id: linux-serial@vger.kernel.org

unregister_console() will be called from uart_remove_one_port() while
removing the platform driver. So not necessary to call it in driver
exit path.

Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
---
 drivers/tty/serial/msm_serial.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 8a7af98..58ba602 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1298,9 +1298,6 @@ static int __init msm_serial_init(void)
 
 static void __exit msm_serial_exit(void)
 {
-#ifdef CONFIG_SERIAL_MSM_CONSOLE
-	unregister_console(&msm_console);
-#endif
 	platform_driver_unregister(&msm_platform_driver);
 	uart_unregister_driver(&msm_uart_driver);
 }
-- 
1.7.9.5
