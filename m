From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH] serial: mxs-auart: put the device when exit or error
Date: Fri, 7 Sep 2012 10:33:07 +0800
Message-ID: <1346985187-30459-1-git-send-email-b32955@freescale.com>
References: <20120907024349.GH26709@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:43076
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757845Ab2IGC4I (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 22:56:08 -0400
In-Reply-To: <20120907024349.GH26709@S2101-09.ap.freescale.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>

We call the get_device() in the mxs_auart_probe().
For the balance of the reference count, we should put the
device in the mxs_auart_remove() or in the error path of
probe.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 3a667ee..203e512 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -781,6 +781,7 @@ out_free_irq:
 	auart_port[pdev->id] = NULL;
 	free_irq(s->irq, s);
 out_free_clk:
+	put_device(s->dev);
 	clk_put(s->clk);
 out_free:
 	kfree(s);
@@ -796,6 +797,7 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
 
 	auart_port[pdev->id] = NULL;
 
+	put_device(s->dev);
 	clk_put(s->clk);
 	free_irq(s->irq, s);
 	kfree(s);
-- 
1.7.0.4


