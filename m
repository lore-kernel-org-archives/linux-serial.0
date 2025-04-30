Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BAE1ADC69;
	Wed, 30 Apr 2025 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.2.72.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031541; cv=none; b=dt9C1wVhaws1gGvczbRI+u9ougS4aoYxA8/+MhPXmWYR157urX0mid2Eq4XsFRwmwpR2JC/Ar/XlHDm0eQCoas7FCnh2xvvKeJec4kvgcOX/J62DZBuHrtC7hmSL0RN+/netoZQB99jTKFJ3M5Gtsvv8e1QjGe8b21dNYbx+SEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031541; c=relaxed/simple;
	bh=7lWr4OMbkRSnBUxwM3XWJdY3O2AMAYEwZJRX+iFrkGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCKTl/p4a8OqmEOifJ8X6Hy5Bun3q6ntHAM803jr8RAX31SPqwhynnifHmQOFLeEeRIkHHA4rVt3UO9VrkND2FmREdp8UG/B5uban8ZWhP2JAw8MdWCNyK2kokrhOpPi/sJEyWhCtaHV7c47BwFsc/QzZnCLxX+g7Um8wRDf/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com; spf=pass smtp.mailfrom=mansr.com; arc=none smtp.client-ip=81.2.72.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mansr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mansr.com
Received: from raven.mansr.com (raven.mansr.com [IPv6:2001:8b0:ca0d:1::3])
	by unicorn.mansr.com (Postfix) with ESMTPS id 86AD315366;
	Wed, 30 Apr 2025 17:37:26 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
	id 761F921A3DA; Wed, 30 Apr 2025 17:37:26 +0100 (BST)
From: Mans Rullgard <mans@mansr.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] tty: serial: 8250_omap: fix tx with dma
Date: Wed, 30 Apr 2025 17:37:09 +0100
Message-ID: <20250430163709.15850-1-mans@mansr.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
introduced two errors in the TX DMA handling for 8250_omap.

Firstly, kfifo_dma_out_prepare_mapped() needs a scatterlist with two
entries whereas only one is provided.  The same error was fixed for
8250_dma in 59449c9dbdaa ("tty: serial: 8250_dma: use sgl with 2 nents
to take care of buffer wrap").

Secondly, when the OMAP_DMA_TX_KICK flag is set, one byte is pulled from
the kfifo and emitted directly in order to start the DMA.  This is done
without updating DMA tx_size which leads to uart_xmit_advance() called
in the DMA complete callback advancing the kfifo by one too much.

In practice, transmitting N bytes has been seen to result in the last
N-1 bytes being sent repeatedly.

This change fixes both problems.

Fixes: 1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/tty/serial/8250/8250_omap.c | 35 +++++++++++++++--------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index f1aee915bc02..84a2f013015e 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1152,9 +1152,11 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 	struct omap8250_priv		*priv = p->port.private_data;
 	struct tty_port			*tport = &p->port.state->port;
 	struct dma_async_tx_descriptor	*desc;
-	struct scatterlist sg;
+	struct scatterlist *sg;
+	struct scatterlist sgl[2];
 	int skip_byte = -1;
 	int ret;
+	int i;
 
 	if (dma->tx_running)
 		return 0;
@@ -1173,16 +1175,6 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 		return 0;
 	}
 
-	sg_init_table(&sg, 1);
-	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
-					   UART_XMIT_SIZE, dma->tx_addr);
-	if (ret != 1) {
-		serial8250_clear_THRI(p);
-		return 0;
-	}
-
-	dma->tx_size = sg_dma_len(&sg);
-
 	if (priv->habit & OMAP_DMA_TX_KICK) {
 		unsigned char c;
 		u8 tx_lvl;
@@ -1207,7 +1199,7 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 			ret = -EBUSY;
 			goto err;
 		}
-		if (dma->tx_size < 4) {
+		if (kfifo_len(&tport->xmit_fifo) < 4) {
 			ret = -EINVAL;
 			goto err;
 		}
@@ -1216,12 +1208,19 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 			goto err;
 		}
 		skip_byte = c;
-		/* now we need to recompute due to kfifo_get */
-		kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, &sg, 1,
-				UART_XMIT_SIZE, dma->tx_addr);
 	}
 
-	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1, DMA_MEM_TO_DEV,
+	sg_init_table(sgl, ARRAY_SIZE(sgl));
+
+	ret = kfifo_dma_out_prepare_mapped(&tport->xmit_fifo, sgl, ARRAY_SIZE(sgl),
+					   UART_XMIT_SIZE, dma->tx_addr);
+
+	dma->tx_size = 0;
+
+	for_each_sg(sgl, sg, ret, i)
+		dma->tx_size += sg_dma_len(sg);
+
+	desc = dmaengine_prep_slave_sg(dma->txchan, sgl, ret, DMA_MEM_TO_DEV,
 			DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
 		ret = -EBUSY;
@@ -1248,8 +1247,10 @@ static int omap_8250_tx_dma(struct uart_8250_port *p)
 err:
 	dma->tx_err = 1;
 out_skip:
-	if (skip_byte >= 0)
+	if (skip_byte >= 0) {
 		serial_out(p, UART_TX, skip_byte);
+		p->port.icount.tx++;
+	}
 	return ret;
 }
 
-- 
2.49.0

