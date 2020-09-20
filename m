Return-Path: <SRS0=gJKf=C5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A20C43463
	for <linux-serial@archiver.kernel.org>; Sun, 20 Sep 2020 12:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223A521789
	for <linux-serial@archiver.kernel.org>; Sun, 20 Sep 2020 12:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgITMQd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 20 Sep 2020 08:16:33 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:33993 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgITMQX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 20 Sep 2020 08:16:23 -0400
X-IronPort-AV: E=Sophos;i="5.77,282,1596492000"; 
   d="scan'208";a="468612187"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 20 Sep 2020 14:08:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] pch_uart: drop double zeroing
Date:   Sun, 20 Sep 2020 13:26:13 +0200
Message-Id: <1600601186-7420-2-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
References: <1600601186-7420-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

sg_init_table zeroes its first argument, so the allocation of that argument
doesn't have to.

the semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x,n,flags;
@@

x = 
- kcalloc
+ kmalloc_array
  (n,sizeof(struct scatterlist),flags)
...
sg_init_table(x,n)
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/tty/serial/pch_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -981,7 +981,7 @@ static unsigned int dma_handle_tx(struct
 
 	priv->tx_dma_use = 1;
 
-	priv->sg_tx_p = kcalloc(num, sizeof(struct scatterlist), GFP_ATOMIC);
+	priv->sg_tx_p = kmalloc_array(num, sizeof(struct scatterlist), GFP_ATOMIC);
 	if (!priv->sg_tx_p) {
 		dev_err(priv->port.dev, "%s:kzalloc Failed\n", __func__);
 		return 0;

