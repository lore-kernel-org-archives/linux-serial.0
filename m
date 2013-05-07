From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 13/15] serial: sirfsoc: remove unnecessary
 platform_set_drvdata()
Date: Tue, 07 May 2013 17:06:53 +0900
Message-ID: <009201ce4af9$d5e4b210$81ae1630$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38288 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757648Ab3EGIGz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 May 2013 04:06:55 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMF0014T56JTHN0@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Tue, 07 May 2013 17:06:54 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Barry Song <baohua.song@csr.com>, 'Rong Wang' <Rong.Wang@csr.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/sirfsoc_uart.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 03465b6..f256440 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -716,7 +716,6 @@ port_err:
 	clk_disable_unprepare(sirfport->clk);
 	clk_put(sirfport->clk);
 clk_err:
-	platform_set_drvdata(pdev, NULL);
 	if (sirfport->hw_flow_ctrl)
 		pinctrl_put(sirfport->p);
 err:
@@ -727,7 +726,7 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 {
 	struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
 	struct uart_port *port = &sirfport->port;
-	platform_set_drvdata(pdev, NULL);
+
 	if (sirfport->hw_flow_ctrl)
 		pinctrl_put(sirfport->p);
 	clk_disable_unprepare(sirfport->clk);
-- 
1.7.2.5


