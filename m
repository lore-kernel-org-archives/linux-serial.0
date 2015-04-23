From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] serial: ifx6x60: Remove dangerous spi_driver casts
Date: Thu, 23 Apr 2015 16:15:39 +0200
Message-ID: <1429798541-32252-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-serial@vger.kernel.org

Casting spi_driver pointers to "void *" when calling
spi_{,un}register_driver() bypasses all type checking.

Remove the superfluous casts to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/ifx6x60.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 590390970996b78f..7d858a74ee38d8ce 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1381,7 +1381,7 @@ static void __exit ifx_spi_exit(void)
 	/* unregister */
 	tty_unregister_driver(tty_drv);
 	put_tty_driver(tty_drv);
-	spi_unregister_driver((void *)&ifx_spi_driver);
+	spi_unregister_driver(&ifx_spi_driver);
 	unregister_reboot_notifier(&ifx_modem_reboot_notifier_block);
 }
 
@@ -1420,7 +1420,7 @@ static int __init ifx_spi_init(void)
 		goto err_free_tty;
 	}
 
-	result = spi_register_driver((void *)&ifx_spi_driver);
+	result = spi_register_driver(&ifx_spi_driver);
 	if (result) {
 		pr_err("%s: spi_register_driver failed(%d)",
 			DRVNAME, result);
@@ -1436,7 +1436,7 @@ static int __init ifx_spi_init(void)
 
 	return 0;
 err_unreg_spi:
-	spi_unregister_driver((void *)&ifx_spi_driver);
+	spi_unregister_driver(&ifx_spi_driver);
 err_unreg_tty:
 	tty_unregister_driver(tty_drv);
 err_free_tty:
-- 
1.9.1
