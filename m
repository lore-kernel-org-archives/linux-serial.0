From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 15/15] serial: pxa: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 17:07:54 +0900
Message-ID: <009401ce4af9$fa3284d0$ee978e70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:32401 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3EGIHz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:07:55 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF003P358KP5M0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:07:55 +0900 (KST)
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
 drivers/tty/serial/pxa.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 05f504e..ac8b2f5 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -945,8 +945,6 @@ static int serial_pxa_remove(struct platform_device *dev)
 {
 	struct uart_pxa_port *sport = platform_get_drvdata(dev);
 
-	platform_set_drvdata(dev, NULL);
-
 	uart_remove_one_port(&serial_pxa_reg, &sport->port);
 
 	clk_unprepare(sport->clk);
-- 
1.7.2.5


