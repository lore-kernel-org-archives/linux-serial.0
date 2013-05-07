From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 14/15] serial: vt8500: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 17:07:35 +0900
Message-ID: <009301ce4af9$eecae6f0$cc60b4d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:47737 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3EGIHh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:07:37 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00F0057WF0L0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:07:35 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Tony Prisk <linux@prisktech.co.nz>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/vt8500_serial.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 1a8bc22..053de1b 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -630,7 +630,6 @@ static int vt8500_serial_remove(struct platform_device *pdev)
 {
 	struct vt8500_port *vt8500_port = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	clk_disable_unprepare(vt8500_port->clk);
 	uart_remove_one_port(&vt8500_uart_driver, &vt8500_port->uart);
 
-- 
1.7.2.5


