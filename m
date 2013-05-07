From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 08/15] serial: netx: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 17:03:23 +0900
Message-ID: <008d01ce4af9$58d884e0$0a898ea0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31331 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757435Ab3EGID3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:03:29 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF00D7X51A5VG0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:03:24 +0900 (KST)
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
 drivers/tty/serial/netx-serial.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/netx-serial.c b/drivers/tty/serial/netx-serial.c
index b9a40ed..ce04f3f 100644
--- a/drivers/tty/serial/netx-serial.c
+++ b/drivers/tty/serial/netx-serial.c
@@ -693,8 +693,6 @@ static int serial_netx_remove(struct platform_device *pdev)
 {
 	struct netx_port *sport = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	if (sport)
 		uart_remove_one_port(&netx_reg, &sport->port);
 
-- 
1.7.2.5


