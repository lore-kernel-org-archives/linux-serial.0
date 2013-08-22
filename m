From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/2] serial: st-asc: remove unnecessary platform_set_drvdata()
Date: Thu, 22 Aug 2013 11:06:47 +0900
Message-ID: <001f01ce9edc$421b1d30$c6515790$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58289 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab3HVCGu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Aug 2013 22:06:50 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MRW008XJTV6M3E0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 22 Aug 2013 11:06:49 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Srinivas Kandagatla' <srinivas.kandagatla@st.com>, 'Jingoo Han' <jg1.han@samsung.com>

The driver core clears the driver data to NULL after device_release
or on probe failure. Thus, it is not needed to manually clear the
device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/st-asc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 4f5caa38..21e6e84 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -753,7 +753,6 @@ static int asc_serial_remove(struct platform_device *pdev)
 {
 	struct uart_port *port = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	return uart_remove_one_port(&asc_uart_driver, port);
 }
 
-- 
1.7.10.4


