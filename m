Return-Path: <SRS0=9Zku=3F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE45C33CB7
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F1B20728
	for <linux-serial@archiver.kernel.org>; Thu, 16 Jan 2020 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194983;
	bh=DQki7PZzjNa4opcLggjE1aYk8b+80ED2ncPPxwBq4zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CnS5z3Evsw2l0/FckbRfzYD89vqeP4ZTU6UzhAEXQ5PYAFYfUyycetM3qn+jeraJu
	 LNb12BRf3BZaOsQPzJqk6knp1LERkeQjv7aXLXA36WWmjzxs3JNjEupo7hJIS7hefX
	 B7vRUhUMJPNHK9j8oXVoXA5V5uRJaibXldNEUYiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbgAPROL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:14:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390934AbgAPROK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Jan 2020 12:14:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB89246B0;
        Thu, 16 Jan 2020 17:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194850;
        bh=DQki7PZzjNa4opcLggjE1aYk8b+80ED2ncPPxwBq4zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/PVO3XykfUaSCP/m/jJC0wO4F+52DSBhkJxtQgUTtbFhOyksQcJW6Kz9UERP4Bgj
         xazc9D7V65Yb5hTsZll84O21Mv6yK9SyS+GxOuZuzJ6ruzAksObYgOXce7jgxIJVxm
         QunwNB/0ouxsfVloD1gikSq/DKYgqL4sHx4+ThiM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 646/671] tty: serial: pch_uart: correct usage of dma_unmap_sg
Date:   Thu, 16 Jan 2020 12:04:44 -0500
Message-Id: <20200116170509.12787-383-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 74887542fdcc92ad06a48c0cca17cdf09fc8aa00 ]

Per Documentation/DMA-API-HOWTO.txt,
To unmap a scatterlist, just call:
	dma_unmap_sg(dev, sglist, nents, direction);

.. note::

	The 'nents' argument to the dma_unmap_sg call must be
	the _same_ one you passed into the dma_map_sg call,
	it should _NOT_ be the 'count' value _returned_ from the
	dma_map_sg call.

However in the driver, priv->nent is directly assigned with value
returned from dma_map_sg, and dma_unmap_sg use priv->nent for unmap,
this breaks the API usage.

So introduce a new entry orig_nent to remember 'nents'.

Fixes: da3564ee027e ("pch_uart: add multi-scatter processing")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/1573623259-6339-1-git-send-email-peng.fan@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/pch_uart.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index cb85002a10d8..3245cdbf9116 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -235,6 +235,7 @@ struct eg20t_port {
 	struct dma_chan			*chan_rx;
 	struct scatterlist		*sg_tx_p;
 	int				nent;
+	int				orig_nent;
 	struct scatterlist		sg_rx;
 	int				tx_dma_use;
 	void				*rx_buf_virt;
@@ -789,9 +790,10 @@ static void pch_dma_tx_complete(void *arg)
 	}
 	xmit->tail &= UART_XMIT_SIZE - 1;
 	async_tx_ack(priv->desc_tx);
-	dma_unmap_sg(port->dev, sg, priv->nent, DMA_TO_DEVICE);
+	dma_unmap_sg(port->dev, sg, priv->orig_nent, DMA_TO_DEVICE);
 	priv->tx_dma_use = 0;
 	priv->nent = 0;
+	priv->orig_nent = 0;
 	kfree(priv->sg_tx_p);
 	pch_uart_hal_enable_interrupt(priv, PCH_UART_HAL_TX_INT);
 }
@@ -1015,6 +1017,7 @@ static unsigned int dma_handle_tx(struct eg20t_port *priv)
 		dev_err(priv->port.dev, "%s:dma_map_sg Failed\n", __func__);
 		return 0;
 	}
+	priv->orig_nent = num;
 	priv->nent = nent;
 
 	for (i = 0; i < nent; i++, sg++) {
-- 
2.20.1

