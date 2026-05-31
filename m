Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD01349CEC;
	Sun, 31 May 2026 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210977; cv=none; b=NHRyQjH1/ZIYcfGaWiA/KJ/TiwILwBEMB27+ysjZRkiHiee03q/lE9DRPcgpyDj4Greiv/7rnXw+doQ2Qwww57ESXAhk8/9hcRUdHTyqM/7ad8An1boUeamW+uVl5LpUaSZEQOXQmhNstPCcccxNYxFcqSE/ESjgERdlPNMfoGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210977; c=relaxed/simple;
	bh=4MiRBebRs6Y5SmkFfaTp7Vg3w4xfpgK7oDddsGc5fbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0LYjUZjJFNWPdptrHEDCaY4QXKVgk3qmChCb6PUbAViEDLRAghnkNfJbHAkI/EaGws0GmswGfF+7GYCm+4fcRk6/4gEwARnKLtTPO6tT3dtpe6uJJ2c2DjOVyiU1x7tC0KIyECZdtz7/8aXHQ7br5XLC+l/Q8huGUcBWuuXiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ1T1otn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ1T1otn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65AE1F00898;
	Sun, 31 May 2026 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210976;
	bh=ta/0oVbpc6sVePm8yz332xjK9IjSZai84OyhZWx2wvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OZ1T1otnLRkDs0ffpBAEw9b3XUpvTWWqBD2U38Zz4oj0D6Z2ETTgN2WT1qH705yAx
	 B2wDGw90G5SsSh0dhUMoRty+4X67W6LncfovfyrLspv73cXJK4fYOzNpHig+1Ky/TV
	 0hfI+KxxFpf1v/vFljDN3c39yVsxtVee4zqoXewkKza589kJ8PztAiiKRedMOwstfJ
	 3IHTGJaqDjmI5EmDMpV9GBEhYy1/bika6roBH8yHZVhpj8t8l9om31jevfr0/DOHl2
	 gseA8oBCg5kkAl4e4q6IfLGdjYWotKZm73AArsCqJJPxtYfz8+AmceR9uXy5SksufL
	 GcziG3wM0jWRw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 10:02:47 +0300
Subject: [PATCH v2 1/4] serial: pch: replace __get_free_page() with
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-tty-v2-1-f7149947d4ef@kernel.org>
References: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
In-Reply-To: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
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

