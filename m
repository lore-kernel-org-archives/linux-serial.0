From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 06/15] serial: efm32: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 17:02:11 +0900
Message-ID: <008b01ce4af9$2d81da80$88858f80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:46367 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3EGICM (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:02:12 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00E224V3ZIK0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:02:11 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/efm32-uart.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/efm32-uart.c b/drivers/tty/serial/efm32-uart.c
index 7d199c8..e029907 100644
--- a/drivers/tty/serial/efm32-uart.c
+++ b/drivers/tty/serial/efm32-uart.c
@@ -778,8 +778,6 @@ static int efm32_uart_remove(struct platform_device *pdev)
 {
 	struct efm32_uart_port *efm_port = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	uart_remove_one_port(&efm32_uart_reg, &efm_port->port);
 
 	if (pdev->id >= 0 && pdev->id < ARRAY_SIZE(efm32_uart_ports))
-- 
1.7.2.5


