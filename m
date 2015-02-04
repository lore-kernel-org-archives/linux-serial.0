From: Lad Prabhakar <prabhakar.csengg@gmail.com>
Subject: [PATCH] tty: serial/bcm63xx_uart: fix sparse warning
Date: Wed,  4 Feb 2015 18:21:22 +0000
Message-ID: <1423074082-6941-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
List-Id: linux-serial@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch fixes following sparse warnings:

bcm63xx_uart.c:857:43: warning: Using plain integer as NULL pointer
bcm63xx_uart.c:871:35: warning: Using plain integer as NULL pointer

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 Found this issue on linux-next (gcc  version 4.8.2,
 sparse version  0.4.5-rc1)and applies on top linux-next.

 drivers/tty/serial/bcm63xx_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 01d83df..681e0f3 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -854,7 +854,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&bcm_uart_driver, port);
 	if (ret) {
-		ports[pdev->id].membase = 0;
+		ports[pdev->id].membase = NULL;
 		return ret;
 	}
 	platform_set_drvdata(pdev, port);
@@ -868,7 +868,7 @@ static int bcm_uart_remove(struct platform_device *pdev)
 	port = platform_get_drvdata(pdev);
 	uart_remove_one_port(&bcm_uart_driver, port);
 	/* mark port as free */
-	ports[pdev->id].membase = 0;
+	ports[pdev->id].membase = NULL;
 	return 0;
 }
 
-- 
1.9.1
