From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/7] serial: mpsc: Remove casting the return value which is a
 void pointer
Date: Mon, 09 Sep 2013 14:07:54 +0900
Message-ID: <003b01cead1a$8a963da0$9fc2b8e0$%han@samsung.com>
References: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:38499 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3IIFIB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 01:08:01 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00LY8E90ESM0@mailout2.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 09 Sep 2013 14:07:55 +0900 (KST)
In-reply-to: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/mpsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 8d70267..e30a3ca 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -2030,7 +2030,7 @@ static void mpsc_drv_get_platform_data(struct mpsc_port_info *pi,
 {
 	struct mpsc_pdata	*pdata;
 
-	pdata = (struct mpsc_pdata *)dev_get_platdata(&pd->dev);
+	pdata = dev_get_platdata(&pd->dev);
 
 	pi->port.uartclk = pdata->brg_clk_freq;
 	pi->port.iotype = UPIO_MEM;
-- 
1.7.10.4


