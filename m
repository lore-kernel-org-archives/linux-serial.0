From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 04/15] serial: bcm63xx: remove unnecessary
 platform_set_drvdata()
Date: Tue, 07 May 2013 17:00:12 +0900
Message-ID: <008901ce4af8$e6d95270$b48bf750$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36539 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757281Ab3EGIAO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:00:14 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00MYA4VFLYN0@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:00:12 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Jonas Gorski' <jogo@openwrt.org>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/bcm63xx_uart.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 6fa2ae7..d14ba5a 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -852,7 +852,6 @@ static int bcm_uart_remove(struct platform_device *pdev)
 
 	port = platform_get_drvdata(pdev);
 	uart_remove_one_port(&bcm_uart_driver, port);
-	platform_set_drvdata(pdev, NULL);
 	/* mark port as free */
 	ports[pdev->id].membase = 0;
 	return 0;
-- 
1.7.2.5


