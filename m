From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 3/3] serial: tegra: Use SIMPLE_DEV_PM_OPS macro
Date: Thu, 27 Feb 2014 20:45:50 +0900
Message-ID: <001601cf33b1$7686fde0$6394f9a0$%han@samsung.com>
References: <000f01cf33b1$32c234d0$98469e70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10201 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbaB0Lpw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 27 Feb 2014 06:45:52 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N009MQKOF8C60@mailout1.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 27 Feb 2014 20:45:51 +0900 (KST)
In-reply-to: <000f01cf33b1$32c234d0$98469e70$%han@samsung.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Stephen Warren' <swarren@nvidia.com>, 'Laxman Dewangan' <ldewangan@nvidia.com>

Use SIMPLE_DEV_PM_OPS macro in order to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/tty/serial/serial-tegra.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d5c2a28..d37e96b 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1352,9 +1352,8 @@ static int tegra_uart_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops tegra_uart_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(tegra_uart_suspend, tegra_uart_resume)
-};
+static SIMPLE_DEV_PM_OPS(tegra_uart_pm_ops, tegra_uart_suspend,
+			 tegra_uart_resume);
 
 static struct platform_driver tegra_uart_platform_driver = {
 	.probe		= tegra_uart_probe,
-- 
1.7.10.4


