From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH] serial: mxs-auart: put the device in the error path
Date: Tue, 11 Sep 2012 15:30:30 +0800
Message-ID: <1347348630-20329-1-git-send-email-b32955@freescale.com>
References: <20120910230005.GA15782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:52575
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751830Ab2IKHya (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Sep 2012 03:54:30 -0400
In-Reply-To: <20120910230005.GA15782@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, shawn.guo@linaro.org, Huang Shijie <b32955@freescale.com>

The mxs_auart_probe() gets the device by the get_device().
So we should put the device in the error path to balance the
device's reference counter.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6898413..6db3baa 100644
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
-- 
1.7.0.4


