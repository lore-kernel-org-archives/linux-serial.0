From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 5/7] serial: ifx6x60: Remove casting the return value which is
 a void pointer
Date: Mon, 09 Sep 2013 14:09:55 +0900
Message-ID: <003e01cead1a$d2db1090$789131b0$%han@samsung.com>
References: <003a01cead1a$61749bb0$245dd310$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:44069 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab3IIFJ6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Sep 2013 01:09:58 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSU00CANECHBT30@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Mon, 09 Sep 2013 14:09:56 +0900 (KST)
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
 drivers/tty/serial/ifx6x60.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index af286e6..5903909 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -1008,7 +1008,7 @@ static int ifx_spi_spi_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
-	pl_data = (struct ifx_modem_platform_data *)dev_get_platdata(&spi->dev);
+	pl_data = dev_get_platdata(&spi->dev);
 	if (!pl_data) {
 		dev_err(&spi->dev, "missing platform data!");
 		return -ENODEV;
-- 
1.7.10.4


