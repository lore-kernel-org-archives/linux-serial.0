Return-Path: <SRS0=liNn=C3=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61928C43464
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228D9235F7
	for <linux-serial@archiver.kernel.org>; Fri, 18 Sep 2020 02:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600395992;
	bh=CRsjg3TOysFEb6PVC+Iq4aSMLT6JDEkSutZn15IF4Dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LgtW8orwh1MN27xAa+GX6sYTCxuqcUOGGHRKZ+GMi8TQjRuSADedkOsKtLhgs9mug
	 sr+YgY14w8mduEW22LOtRHgJeGoCEdObZ+2om91F9EEXzN2Q9uPmwQ4zRgJQhE4mqd
	 8dYGWQU6lqkroFDG+YHA6elp9pU9wqD5q9Qro94c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgIRC0W (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728707AbgIRCQC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Sep 2020 22:16:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B31452396D;
        Fri, 18 Sep 2020 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395361;
        bh=CRsjg3TOysFEb6PVC+Iq4aSMLT6JDEkSutZn15IF4Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Le+5v+f0tBPe1kqqN/SFdSiy1qbOOBbXl9QufVoSwL4HmUCwZpujbouhIrvAr0NZ3
         JQAotMZJrnvTYWCksuDDzEXWiIngQefMs1zIaJ3n79Wuu7Is9IDwaXm8rttpsqved0
         wkODjJy939/guUkWLtvz3ZAMdIzNyELgjFs+ytns=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 55/90] serial: 8250: 8250_omap: Terminate DMA before pushing data on RX timeout
Date:   Thu, 17 Sep 2020 22:14:20 -0400
Message-Id: <20200918021455.2067301-55-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021455.2067301-1-sashal@kernel.org>
References: <20200918021455.2067301-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

[ Upstream commit 7cf4df30a98175033e9849f7f16c46e96ba47f41 ]

Terminate and flush DMA internal buffers, before pushing RX data to
higher layer. Otherwise, this will lead to data corruption, as driver
would end up pushing stale buffer data to higher layer while actual data
is still stuck inside DMA hardware and has yet not arrived at the
memory.
While at that, replace deprecated dmaengine_terminate_all() with
dmaengine_terminate_async().

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Link: https://lore.kernel.org/r/20200319110344.21348-2-vigneshr@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/8250/8250_omap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 7d4680ef5307d..d41be02abced2 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -773,7 +773,10 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
 
 	count = dma->rx_size - state.residue;
-
+	if (count < dma->rx_size)
+		dmaengine_terminate_async(dma->rxchan);
+	if (!count)
+		goto unlock;
 	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
 
 	p->port.icount.rx += ret;
@@ -811,7 +814,6 @@ static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
 	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
 
 	__dma_rx_do_complete(p);
-	dmaengine_terminate_all(dma->rxchan);
 }
 
 static int omap_8250_rx_dma(struct uart_8250_port *p)
-- 
2.25.1

