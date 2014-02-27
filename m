From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 1/3] serial: st-asc: Use SIMPLE_DEV_PM_OPS macro
Date: Thu, 27 Feb 2014 20:43:57 +0900
Message-ID: <000f01cf33b1$32c234d0$98469e70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:47291 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbaB0Ln6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Feb 2014 06:43:58 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N008CPKL90890@mailout4.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 27 Feb 2014 20:43:57 +0900 (KST)
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Srinivas Kandagatla' <srinivas.kandagatla@st.com>

Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/st-asc.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 21e6e84..93e27b9 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -883,9 +883,8 @@ static struct uart_driver asc_uart_driver = {
 	.cons		= ASC_SERIAL_CONSOLE,
 };
 
-static const struct dev_pm_ops asc_serial_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(asc_serial_suspend, asc_serial_resume)
-};
+static SIMPLE_DEV_PM_OPS(asc_serial_pm_ops, asc_serial_suspend,
+			 asc_serial_resume);
 
 static struct platform_driver asc_serial_driver = {
 	.probe		= asc_serial_probe,
-- 
1.7.10.4


