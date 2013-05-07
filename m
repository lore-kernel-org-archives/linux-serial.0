From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 01/15] serial: altera: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 16:15:28 +0900
Message-ID: <007301ce4af2$a72676e0$f57364a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:26586 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757767Ab3EGHPa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 03:15:30 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF002V82TTD8J0@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 16:15:29 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Tobias Klauser' <tklauser@distanz.ch>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/altera_uart.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 13471dd..1d46966 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -604,7 +604,6 @@ static int altera_uart_remove(struct platform_device *pdev)
 
 	if (port) {
 		uart_remove_one_port(&altera_uart_driver, port);
-		platform_set_drvdata(pdev, NULL);
 		port->mapbase = 0;
 	}
 
-- 
1.7.2.5


