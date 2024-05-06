Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEA714386B
	for <linux-serial@vger.kernel.org>; Mon,  6 May 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714995635; cv=none; b=Z2++vu8yvubhtqUScx3VxAyHfSI2rfNPvf8mpamKsr+Zbo9gb85TF3VGYo3rIJDEcNU2klbvTTQzV8eNcZk23J3QTztGy4WNJI+iEFN7Co5Bkvc+FGHBDA4m6BSVggU7/rTBpiiAPsy7QPZ+HZnHxg/Y6RHEmRHGMHguitffNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714995635; c=relaxed/simple;
	bh=vNn4nBjiHVHd0R6UykwuRVMBMzPNZgmYEEMVlqZiy8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6Q+LnsPHWZS0alwqfDhco0QiwTj3HVPr25MceqeyKgSs3AWRMhcg61IXxj12wmVvoxa+DS8pYKKUGQmYpZvofiNbUKbHR74Jdhjs1dSbGk3GkzU62n22Z1qcwEKhPK17Kbf0cO1ABvliUnQN3sGddH69W2ZUlKFP57Xn2jRHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=A0HdvaR4; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="A0HdvaR4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=1+/fXyDcdDYBqoMNsLyvP3kBF5cFDb+XEH2MDBafQ6s=; b=A0Hdva
	R4Xk+v0Nl+5IlgTd3GeGcGgRYHs9RVfJhjKzzMlm7hxYYsYhG+/FX9ryO3dU6M7z
	EKfBgP+lXcplr5BLSrmesb7C7AITCWwxe3PSqCZunflx8DhFLg/GLLY0coYuT4gt
	j7KvKaSTKYyNIrUxsJ9MBe29+sgFv9jD+paTkv14nD9tj5VSjAxhAKVSUkNjOmrR
	OhmPsUe8GAzKD0KEqzhq2HnLQhR7pUzijWpMl3X0vkTwWcUH7PRo6LCK+DkpUx5A
	keIlQMscFjFfnshbLNOgPMaCUNCWw2bWGceuE8CFweACgtmdk7y2tbzBR411UiAv
	f+3oiHXCe4lxbxdQ==
Received: (qmail 172868 invoked from network); 6 May 2024 13:40:31 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 6 May 2024 13:40:31 +0200
X-UD-Smtp-Session: l3s3148p1@gwJgiccXhLYgAwDPX0CuAO+oYiCi4tWm
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 3/4] serial: sh-sci: let timeout timer only run when DMA is scheduled
Date: Mon,  6 May 2024 13:40:19 +0200
Message-ID: <20240506114016.30498-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506114016.30498-6-wsa+renesas@sang-engineering.com>
References: <20240506114016.30498-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hrtimer for RXDMA timeout was unconditionally restarted in the RXDMA
complete handler ignoring the fact that setting up DMA may fail and PIO
is used instead. Explicitly stop the timer when DMA is completed and
only restart it when setting up DMA was successful. This makes the
intention of the timer much clearer, the driver easier to understand and
simplifies assumptions about the timer. The latter avoids race
conditions if these assumptions were not met or confused.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/tty/serial/sh-sci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 09eb0c824b10..7cc354ee6305 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1325,14 +1325,14 @@ static void sci_dma_rx_complete(void *arg)
 	dev_dbg(port->dev, "%s(%d) active cookie %d\n", __func__, port->line,
 		s->active_rx);
 
+	hrtimer_cancel(&s->rx_timer);
+
 	uart_port_lock_irqsave(port, &flags);
 
 	active = sci_dma_rx_find_active(s);
 	if (active >= 0)
 		count = sci_dma_rx_push(s, s->rx_buf[active], s->buf_len_rx);
 
-	start_hrtimer_us(&s->rx_timer, s->rx_timeout);
-
 	if (count)
 		tty_flip_buffer_push(&port->state->port);
 
@@ -1355,6 +1355,9 @@ static void sci_dma_rx_complete(void *arg)
 	uart_port_unlock_irqrestore(port, flags);
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[active], active, s->active_rx);
+
+	start_hrtimer_us(&s->rx_timer, s->rx_timeout);
+
 	return;
 
 fail:
-- 
2.43.0

