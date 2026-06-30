Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AEA34251B;
	Tue, 30 Jun 2026 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813251; cv=none; b=L5ZGCHTIdIyRuHtd5QhQuea525bXz8rOinDgxuH5JWUcGKkiaXL9K+Etmnxj8NcSn52FPF1uyWrvOJoD0CuujEyicpvjMR1eiwDXglkNZMYng6X59ShSmR9MoZfXiDCj5arvzH+w805eKLcQNoHx+vlAgojzSWuqM3cAXGcVFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813251; c=relaxed/simple;
	bh=0HKiVV38ywilrDzdIKuYhO16iYPpB1InZS7L3uHwFW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yo1SKvp90TSt05ONQux7BgcqHAZXt+NOdtAmeT29KSL3+VQNH1L3i+uBSs5+xgDjFXP5Ad+wFapAUPNmrxXyN4qCWZu8AEFxJa9ounPdZag/iLXa2ibSUYzHf4mPWAyZePimvs2qvAGZkarj9Oog+YRhV9+VyJaGB2AvJvA0mwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq7GrQsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq7GrQsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361A01F00A3A;
	Tue, 30 Jun 2026 09:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782813250;
	bh=ZJKL9JkQxNTf1bngWq8d1w440OVqBAHr3cl1Tbqc2Ns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gq7GrQsdAIvf8OlFzgPzvGNXV5ZZ5Ot4/4Ej7JU/TFVUyuIDKzMwp8B/iG9lam3bm
	 qOuGRPWOa5Fgs5wI+IzWwR1HRReJ95kH0mDBUzwxv+MdJMPYC1fFxRuOUx+sI+wMUB
	 DQ7a2EARJs6naD+scvRNybc2Z97UpUWAsJE2zzTPi/yMNGp125i9WMO4gjXh8VLbL2
	 7fnNOr0MTVQ39Mcyh73FhzYo7fqWPubFbOfNXDRF4VFWVjC39FoeEY+YR2HNMwOubg
	 VLBszS1Y7EAgO1614H6OJspiEfIFnhgQBTpnlK1h2p/QzsR1J2WSdox49rFEC1XXZI
	 OnXId6JipgNcg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 12:54:03 +0300
Subject: [PATCH v3 1/4] serial: pch: replace __get_free_page() with
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-tty-v3-1-a8476c66c582@kernel.org>
References: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
In-Reply-To: <20260630-b4-tty-v3-0-a8476c66c582@kernel.org>
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
index 80e31c4d9536..5f7f073f285e 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1662,7 +1662,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 	if (priv == NULL)
 		goto init_port_alloc_err;
 
-	rxbuf = (unsigned char *)__get_free_page(GFP_KERNEL);
+	rxbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!rxbuf)
 		goto init_port_free_txbuf;
 
@@ -1735,7 +1735,7 @@ static struct eg20t_port *pch_uart_init_port(struct pci_dev *pdev,
 #ifdef CONFIG_SERIAL_PCH_UART_CONSOLE
 	pch_uart_ports[board->line_no] = NULL;
 #endif
-	free_page((unsigned long)rxbuf);
+	kfree(rxbuf);
 init_port_free_txbuf:
 	kfree(priv);
 init_port_alloc_err:
@@ -1750,7 +1750,7 @@ static void pch_uart_exit_port(struct eg20t_port *priv)
 	snprintf(name, sizeof(name), "uart%d_regs", priv->port.line);
 	debugfs_lookup_and_remove(name, NULL);
 	uart_remove_one_port(&pch_uart_driver, &priv->port);
-	free_page((unsigned long)priv->rxbuf.buf);
+	kfree(priv->rxbuf.buf);
 }
 
 static void pch_uart_pci_remove(struct pci_dev *pdev)

-- 
2.53.0

