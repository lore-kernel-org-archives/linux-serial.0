From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 03/15] serial: atmel: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 16:59:15 +0900
Message-ID: <008801ce4af8$c4c235d0$4e46a170$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:30334 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758336Ab3EGH7Z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 03:59:25 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF003954URP5M0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 16:59:15 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, 'Pawel Wieczorkiewicz' <wpawel@gmail.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/atmel_serial.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3467462..a7ca0e7 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1847,7 +1847,6 @@ static int atmel_serial_remove(struct platform_device *pdev)
 	int ret = 0;
 
 	device_init_wakeup(&pdev->dev, 0);
-	platform_set_drvdata(pdev, NULL);
 
 	ret = uart_remove_one_port(&atmel_uart, port);
 
-- 
1.7.2.5


