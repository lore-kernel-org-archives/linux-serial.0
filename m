From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 07/15] serial: imx: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 17:02:50 +0900
Message-ID: <008c01ce4af9$45e6f880$d1b4e980$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:21961 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3EGICx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:02:53 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00KXV5000V60@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:02:52 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Shawn Guo <shawn.guo@linaro.org>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/imx.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 147c9e1..3d17f5b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1559,8 +1559,6 @@ static int serial_imx_remove(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 
-	platform_set_drvdata(pdev, NULL);
-
 	uart_remove_one_port(&imx_reg, &sport->port);
 
 	clk_disable_unprepare(sport->clk_per);
-- 
1.7.2.5


