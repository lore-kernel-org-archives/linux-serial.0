Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D57BC54E76
	for <linux-serial@archiver.kernel.org>; Sun, 19 Nov 2023 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjKSP3u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Nov 2023 10:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjKSP3t (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Nov 2023 10:29:49 -0500
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D53D126
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 07:29:45 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4jjwrvAGSmTW54jjxrDo1w; Sun, 19 Nov 2023 16:29:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700407783;
        bh=M/DjUxLaOupRVKEtY71THqnxeBXaH7E/KMuBzoQWOwI=;
        h=From:To:Cc:Subject:Date;
        b=WLfHFr8CmcnxZBwgBnCX+i0RbqVE6KD2nCYNd42ufdbg0jAS4FXGQ+VrHL3D8TrWr
         O5y9AjnLcOSvVrk98bz9lppZJUezU9uXY2CBA2oHA0HGyV4s4CQ7EILLGFFZJJpnvJ
         nLGTwUH9XIshh4f5ykTP7Vuxh4IpznsLFPeN4QLnFHeUON2sQasjc/MyER1UdMJVVo
         Al9fwij0ysqRukCWM33XLs4pQXgTyIHMZ75jhRdl6mc/W/KfB7GIyjYKtG5DeD+md1
         FJnhP/GvzARXDkWYdApHpE4ZLrWDqaCphDaMGqvYusKlxc1PPaUmcNxWtU34UibuLl
         nUxs09nZvqZRA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Nov 2023 16:29:43 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Richard Genoud <richard.genoud@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: atmel: convert not to use dma_request_slave_channel()
Date:   Sun, 19 Nov 2023 16:29:39 +0100
Message-Id: <f0522ae5a08a772268c901da6f74efe4ec2fe96c.1700407759.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dma_request_slave_channel() is deprecated. dma_request_chan() should
be used directly instead.

Switch to the preferred function and update the error handling accordingly.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/atmel_serial.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 1946fafc3f3e..a58cfaa87f1d 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1013,14 +1013,18 @@ static int atmel_prepare_tx_dma(struct uart_port *port)
 	struct device *mfd_dev = port->dev->parent;
 	dma_cap_mask_t		mask;
 	struct dma_slave_config config;
+	struct dma_chan *chan;
 	int ret, nent;
 
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	atmel_port->chan_tx = dma_request_slave_channel(mfd_dev, "tx");
-	if (atmel_port->chan_tx == NULL)
+	chan = dma_request_chan(mfd_dev, "tx");
+	if (IS_ERR(chan)) {
+		atmel_port->chan_tx = NULL;
 		goto chan_err;
+	}
+	atmel_port->chan_tx = chan;
 	dev_info(port->dev, "using %s for tx DMA transfers\n",
 		dma_chan_name(atmel_port->chan_tx));
 
-- 
2.34.1

