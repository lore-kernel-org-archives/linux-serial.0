Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176E93B583C;
	Thu, 28 May 2026 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963871; cv=none; b=Vt0ZfFO7jbYPPZ9qrkgw7pgH1h8Gh6CVVR5UqXm01+bR7Cb4kxC59wCvVof6Qqk3GPiYG2l8q71mMq8y/R4e/hZNK1r2LEW0eQBeRjBUFmTL3DprxdZ0bOFu0O4VYd8ELOdNcS8k6o/I34i3J5vNbsXXcUu3KCTSHHCsA8ayQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963871; c=relaxed/simple;
	bh=4MiRBebRs6Y5SmkFfaTp7Vg3w4xfpgK7oDddsGc5fbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ssq8y3NErUMBVtkLq2/igzk4iOW4npcsiP2vPAlP/HjGpqClPloY+IQp1pjOIOi2791zHK5g/Zzn8nPieHzuvXfv/74apxNC9BlWDGCdIv5Sj1cmaFaYwbhEnRQZr5O6YmSamt+/cI6KugasS8Yl4jxADuOlU16mS0vna4weIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiIv7JJk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiIv7JJk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5371F00A3A;
	Thu, 28 May 2026 10:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779963869;
	bh=ta/0oVbpc6sVePm8yz332xjK9IjSZai84OyhZWx2wvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PiIv7JJkOzo4JdxeU72/oRH7u/AvKNGTepqd7rEsNwqs2sEgiVotsfsPfCSl1kp4J
	 pFv9jfRN6QLtISOs4+3nsHUhlRZqSgFl6jhnwvYWInaEI2OHUUjPLDeIauLt31M4Jd
	 05p6IYgNa++TupD1Pp2NDGZsxX4eaUMJYKDcI3VJ57J+wHbMdNlQM1Rh6mbh6EovKb
	 wMKS/gH1advcKG0SDDtytjl53TmADFG502oUgAzm288kR3wxbRutTJL/FssL6tgn+6
	 QXYHOvf2Si4sKSeXp59dW9EmAy8fnB+zd666bOHeIiLbxWv+mDWxmpymhQCzQBbIU7
	 hNUcg3QIKI+Yw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 13:24:17 +0300
Subject: [PATCH 1/4] serial: pch: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-tty-v1-1-9da9f7aec5f2@kernel.org>
References: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
In-Reply-To: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.15.2

pch_uart_init_port() allocates a staging buffer for non-DMA receive path
using __get_free_page().

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/serial/pch_uart.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6729d8e83c3c..07d8cdb58912 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1655,7 +1655,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	if (priv == NULL)
 		goto init_port_alloc_err;
 
-	rxbuf = (unsigned char *)__get_free_page(GFP_KERNEL);
+	rxbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!rxbuf)
 		goto init_port_free_txbuf;
 
@@ -1728,7 +1728,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 #ifdef CONFIG_SERIAL_PCH_UART_CONSOLE
 	pch_uart_ports[board->line_no] = NULL;
 #endif
-	free_page((unsigned long)rxbuf);
+	kfree(rxbuf);
 init_port_free_txbuf:
 	kfree(priv);
 init_port_alloc_err:
@@ -1743,7 +1743,7 @@ static void pch_uart_exit_port(struct eg20t_port *priv)
 	snprintf(name, sizeof(name), "uart%d_regs", priv->port.line);
 	debugfs_lookup_and_remove(name, NULL);
 	uart_remove_one_port(&pch_uart_driver, &priv->port);
-	free_page((unsigned long)priv->rxbuf.buf);
+	kfree(priv->rxbuf.buf);
 }
 
 static void pch_uart_pci_remove(struct pci_dev *pdev)

-- 
2.53.0

