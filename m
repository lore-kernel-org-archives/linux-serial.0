From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 2/2] serial: imx: check the return value when enabling the clocks
Date: Wed, 26 Jun 2013 17:35:59 +0800
Message-ID: <1372239359-4054-2-git-send-email-b32955@freescale.com>
References: <1372239359-4054-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-db9lp0252.outbound.messaging.microsoft.com ([213.199.154.252]:36005
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751853Ab3FZKQD (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Jun 2013 06:16:03 -0400
In-Reply-To: <1372239359-4054-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, Huang Shijie <b32955@freescale.com>

In the probe function, we do not check the return value of the
clk_prepare_enable(). But in actually, the clk_prepare_enable() may fails,
so check the return value when we enable the clocks.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index bfdf764..2aec568 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1593,8 +1593,15 @@ static int serial_imx_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	clk_prepare_enable(sport->clk_per);
-	clk_prepare_enable(sport->clk_ipg);
+	ret = clk_prepare_enable(sport->clk_per);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(sport->clk_ipg);
+	if (ret) {
+		clk_disable_unprepare(sport->clk_per);
+		return ret;
+	}
 
 	sport->port.uartclk = clk_get_rate(sport->clk_per);
 
-- 
1.7.1


