From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 02/15] serial: ar933x: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 16:58:33 +0900
Message-ID: <008701ce4af8$ac2d5540$0487ffc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30160 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758202Ab3EGH6f (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 03:58:35 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF0034S4SBP5M0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 16:58:34 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Gabor Juhos' <juhosg@openwrt.org>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/ar933x_uart.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 27f20c5..9824dfb 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -703,7 +703,6 @@ static int ar933x_uart_remove(struct platform_device *pdev)
 	struct ar933x_uart_port *up;
 
 	up = platform_get_drvdata(pdev);
-	platform_set_drvdata(pdev, NULL);
 
 	if (up) {
 		uart_remove_one_port(&ar933x_uart_driver, &up->port);
-- 
1.7.2.5


