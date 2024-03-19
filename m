Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160D7FBB1;
	Tue, 19 Mar 2024 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842026; cv=none; b=T+FqTZ9enPxlvphMAYYTOZB4sQOjxrg+SV37/Dxrux2ID07i5knYz8Oj9/B4asSll/AeQY+xrbkjgEsEcwHU672TAxI1y7XI4cGYJ/UmPK/Sl8W1A4GaHhk7wD9hTcLd6O1TQkY3d5m7ZJXoSMXDqi17vS9lc4SgiQvipOn8x1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842026; c=relaxed/simple;
	bh=wKzRdXC2CGMBk+yjNkNCtzVfVM9PNiFuCla4o//SuBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxnAi6NyXk2IGTzQ1Wwno+so8+nx/y4dzXjW1c48mwp6oDBZYH0qyikUPCILri/Jz2IlFhvVf2xHyGrHnsHSQmIbVaCVhP7RNQaY95r7pf9FQMxQmguFlPz0QV8UrApOBYoO8VQq/moydrPbdp1c8yOZOjpF6SC3qcT3A85ctOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8O5Oava; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8O5Oava"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0FCC433C7;
	Tue, 19 Mar 2024 09:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842025;
	bh=wKzRdXC2CGMBk+yjNkNCtzVfVM9PNiFuCla4o//SuBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f8O5OavaKbe48Cwfe30+zoZzglhaJ1CyFuUEnxzTjmjaRkhWtYtchg12yT4duUx2q
	 dcbW3jsB/aEZiAiSjHy++0PPpJvyIHAi8iNH7BtLFjEoo+2UBRKU0WbOavTOS0c5FB
	 Vx4lbiLziNGTEnd07/fSzTq+uKTLy4dJvOoFqlICe1Nspmpu00rT4mwI/KB3+Djx+9
	 sdPP/hCW/KGiqhtsPmdEYF6mnwADCgCUIoQjZLatHU+F/tLCz1ugB2fCgFXcxKRCcf
	 nnOX2NBiVqn5jylkAmpzLRM9aksnXmuRnhAeam3Up5ofLSgvxhPmbety5ERwolMb8E
	 3kBCdCQua2Plg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [RFT 09/15] tty: 8250_dma: use dmaengine_prep_slave_sg()
Date: Tue, 19 Mar 2024 10:53:09 +0100
Message-ID: <20240319095315.27624-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
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

