From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH] pch_uart: check kzalloc result in dma_handle_tx()
Date: Sat, 28 Jul 2012 20:43:57 +0800
Message-ID: <20120728124357.GA13192@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16435 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab2G1MoF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Jul 2012 08:44:05 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

Reported by coccinelle:

drivers/tty/serial/pch_uart.c:979:1-14: alloc with no test, possible model on line 994

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/tty/serial/pch_uart.c |    4 ++++
 1 file changed, 4 insertions(+)

WARNING: this may be a superficial fix!

--- linux.orig/drivers/tty/serial/pch_uart.c	2012-06-07 05:39:57.550846385 +0800
+++ linux/drivers/tty/serial/pch_uart.c	2012-07-28 20:37:27.803145392 +0800
@@ -974,6 +974,10 @@ static unsigned int dma_handle_tx(struct
 	priv->tx_dma_use = 1;
 
 	priv->sg_tx_p = kzalloc(sizeof(struct scatterlist)*num, GFP_ATOMIC);
+	if (!priv->sg_tx_p) {
+		dev_err(priv->port.dev, "%s:kzalloc Failed\n", __func__);
+		return 0;
+	}
 
 	sg_init_table(priv->sg_tx_p, num); /* Initialize SG table */
 	sg = priv->sg_tx_p;
