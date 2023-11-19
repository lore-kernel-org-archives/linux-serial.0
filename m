Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC67C54E76
	for <linux-serial@archiver.kernel.org>; Sun, 19 Nov 2023 15:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjKSPAS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 19 Nov 2023 10:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKSPAS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 19 Nov 2023 10:00:18 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Nov 2023 07:00:14 PST
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FD7DE1
        for <linux-serial@vger.kernel.org>; Sun, 19 Nov 2023 07:00:14 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 4jA9ruwTOmTW54jA9rDjNP; Sun, 19 Nov 2023 15:52:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1700405562;
        bh=pAh5rfKWMlNtS3iglM7rvXZUQgMkHc1XA5sjN2Bujj0=;
        h=From:To:Cc:Subject:Date;
        b=nr1WCNZ17TxtLQoBclQyq/hfThLxHkEbPzeLuCWXz17pZ3yIGLXTEexG7YAO1Ykqr
         /LNk7LDQms7vr5V7RZGWFaKhOLv1DeVys/wkB22wK5ng7xljxPxQ7yNI+AOs0CwUqo
         BuzeFrzWCLR7m5spvt0AAugudqbH2pFKA4VA8JqUjm4f09OpsBwSD1AMxS7kSo9v0F
         wIbgip2ykR2lE6zTJD5srTPeX9Zff+1wdEcxMIVVOe+DXn4mowsAJaaJMY3lpZTJ6z
         PJ3xrlbJ+AHzgsEJXx6u1bSgStXLScOTflJYKrLF7MyugPVICwJIpAiuO0UE4YOpHU
         WgvzA+/G/0pSQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 19 Nov 2023 15:52:42 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-serial@vger.kernel.org
Subject: [PATCH] serial: amba-pl011: convert not to use dma_request_slave_channel()
Date:   Sun, 19 Nov 2023 15:52:39 +0100
Message-Id: <6f76e22f77d776d6c1f176d56e7ee341314d8554.1700405529.git.christophe.jaillet@wanadoo.fr>
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
 drivers/tty/serial/amba-pl011.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 61cc24cd90e4..6d7bfe9399db 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -444,9 +444,9 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 		 dma_chan_name(uap->dmatx.chan));
 
 	/* Optionally make use of an RX channel as well */
-	chan = dma_request_slave_channel(dev, "rx");
+	chan = dma_request_chan(dev, "rx");
 
-	if (!chan && plat && plat->dma_rx_param) {
+	if (IS_ERR(chan) && plat && plat->dma_rx_param) {
 		chan = dma_request_channel(mask, plat->dma_filter, plat->dma_rx_param);
 
 		if (!chan) {
@@ -455,7 +455,7 @@ static void pl011_dma_probe(struct uart_amba_port *uap)
 		}
 	}
 
-	if (chan) {
+	if (!IS_ERR(chan)) {
 		struct dma_slave_config rx_conf = {
 			.src_addr = uap->port.mapbase +
 				pl011_reg_to_offset(uap, REG_DR),
-- 
2.34.1

