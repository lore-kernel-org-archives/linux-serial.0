Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DEB364D6;
	Fri,  5 Apr 2024 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712297336; cv=none; b=TpPviBoU9Q89P1Le2SG9nETm1eAh1Jdp1MDWf69a31bJLlB9aZ6qzH16Fn16wxlxCjW3pd7tw3atvWSG2kS6QKPrYu30b3OMJJx0/41z6io3R6wcVa91ETE04Pry50HZfKJESEDJ0/FZ6RHfRxR6BWTlqTvObJ/QJc+dNx/QGxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712297336; c=relaxed/simple;
	bh=wKzRdXC2CGMBk+yjNkNCtzVfVM9PNiFuCla4o//SuBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH6ENtrZyvsB4DJjXclKFhREWjqumeId628n11zab2Sr7NQ59rsGtmfefqCAczGr3ybtaUBfihE0YPl/GetvQj8oim/ETTAU4k03kbsRO1GldW8AT7SdaVm7vrbg3k1uDPpgknQf34O4i1ByFSXPvZf/aiDNXyIDF+4hXzX/5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQCiKTp4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQCiKTp4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADCDC433F1;
	Fri,  5 Apr 2024 06:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712297335;
	bh=wKzRdXC2CGMBk+yjNkNCtzVfVM9PNiFuCla4o//SuBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQCiKTp4Nx5eAhn9e8KYYeoAJkkurUKLeQbIsyUmIAA5EK+V+p/eaDqVnXQhVTcVi
	 m3d/M7VivYlVryTTiKPr/DAsW6TVMBChauCYc5Azo2BUcRBpAh97VU0ist5CAM1n+O
	 z4ybF+GlHxZbwqJG+9/DVAXtbKaLzpeZrz0xlXa9wKaw16eDawY22eA0VKDMX9tldx
	 rsCVnZ6smPbm/5wmIbRnqGXhV4CM/H+HzHZrHMF6gkNVfd+HTWEgTqNF+VXIDVAHLb
	 HFf9YW4TGZQujv/6CjmoszOJ8fO9yV+yVbUQZvK7dwCSjPXqrHUPHATCOtjk46yc+z
	 jh4bHsraiAnkQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/15] tty: 8250_dma: use dmaengine_prep_slave_sg()
Date: Fri,  5 Apr 2024 08:08:20 +0200
Message-ID: <20240405060826.2521-10-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405060826.2521-1-jirislaby@kernel.org>
References: <20240405060826.2521-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a preparatory for the serial-to-kfifo switch. kfifo understands
only scatter-gatter approach, so switch to that.

No functional change intended, it's just dmaengine_prep_slave_single()
inline expanded.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/8250/8250_dma.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 8b30ca8fdd3f..8b2c3f478b17 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -89,6 +89,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	struct circ_buf			*xmit = &p->port.state->xmit;
 	struct dma_async_tx_descriptor	*desc;
 	struct uart_port		*up = &p->port;
+	struct scatterlist sg;
 	int ret;
 
 	if (dma->tx_running) {
@@ -111,10 +112,13 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 
 	serial8250_do_prepare_tx_dma(p);
 
-	desc = dmaengine_prep_slave_single(dma->txchan,
-					   dma->tx_addr + xmit->tail,
-					   dma->tx_size, DMA_MEM_TO_DEV,
-					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	sg_init_table(&sg, 1);
+	sg_dma_address(&sg) = dma->tx_addr + xmit->tail;
+	sg_dma_len(&sg) = dma->tx_size;
+
+	desc = dmaengine_prep_slave_sg(dma->txchan, &sg, 1,
+				       DMA_MEM_TO_DEV,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 	if (!desc) {
 		ret = -EBUSY;
 		goto err;
-- 
2.44.0

