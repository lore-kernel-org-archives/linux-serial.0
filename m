From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] serial: ifx6x60: fix use-after-free on module unload
Date: Wed, 26 Apr 2017 12:24:21 +0200
Message-ID: <20170426102421.28833-1-johan@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Jun Chen <jun.d.chen@intel.com>
List-Id: linux-serial@vger.kernel.org

Make sure to deregister the SPI driver before releasing the tty driver
to avoid use-after-free in the SPI remove callback where the tty
devices are deregistered.

Fixes: 72d4724ea54c ("serial: ifx6x60: Add modem power off function in the platform reboot process")
Cc: stable <stable@vger.kernel.org>     # 3.8
Cc: Jun Chen <jun.d.chen@intel.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/ifx6x60.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 157883653256..f190a84a0246 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1382,9 +1382,9 @@ static struct spi_driver ifx_spi_driver = {
 static void __exit ifx_spi_exit(void)
 {
 	/* unregister */
+	spi_unregister_driver(&ifx_spi_driver);
 	tty_unregister_driver(tty_drv);
 	put_tty_driver(tty_drv);
-	spi_unregister_driver(&ifx_spi_driver);
 	unregister_reboot_notifier(&ifx_modem_reboot_notifier_block);
 }
 
-- 
2.12.2
