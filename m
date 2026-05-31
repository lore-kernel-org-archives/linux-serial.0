Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C469532B122;
	Sun, 31 May 2026 07:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780210979; cv=none; b=FGpS+ODxcIO8SGqdkC2xz/NnLUKeSuY4YHS+KS9b9FxAwph6rgllvwYbo4UNlgj1IJ0LikovvnxlVWOiHW+61YAEEv/oX5eXPuJnc6crRPCSKOgHH17qoSMImIIK4cPr/lwKy3yVCWyMxenakDmaG44SLrgO7uUDzyAreTqpyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780210979; c=relaxed/simple;
	bh=VkqNABs6v1gE1CvlOs6Gfpl7VQbNNE60l61tqvcu6kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0RqceVEShhbPyKReS7OW7a+bJF0akYt8zVKRX+2Pfia72rU3vs07Z3CvEK28EzW/AcXnb1gtIiquoMSwiql0q2Xbs1JtOvHshKM7kja3n71+CI92XHNR0zeEsSRX6Rnr8mDqW6xTtr+FJ1b5Ctpk/9KHWYSpzjB8VC1fnUZYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJHQgCOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJHQgCOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E619C1F00893;
	Sun, 31 May 2026 07:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780210978;
	bh=Hba6xOKzIlLJw5sTi2ZReL79jUmA452phwmu2dxW8ao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XJHQgCOkc2ffB5Mm3D/Emh3q/0YrgxHxa/6NKeKvV3LlKHxB15du9+mG80y69j6Ie
	 2mGwmtRp7GEXHSwMsjCX0Mr58rNLbjH/9f5ALcz+O0MAH8ZlFfrwnkkOCVnhp2MqQE
	 E5GTfhwaggrQygApbI2xuXFtxeKQeG0y+2lZSUVZsVPNGhhZ/1dOCAZc14IAvDoXXs
	 UqDHyA4/nqjb3dLxqquM/+PEbehMuwQtCYl4vH5insW3WxwxVk/IOjGctF0PQO8Oig
	 gMm+t418m9nOHIX+b2TXBX+sq2KgOiRur4HxHomiEstv6DHcnN+Nyughee2W4q0bU+
	 ltDJcwrEEcb5g==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 10:02:48 +0300
Subject: [PATCH v2 2/4] tty: amiserial: replace get_zeroed_page() with
 kzalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-tty-v2-2-f7149947d4ef@kernel.org>
References: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
In-Reply-To: <20260531-b4-tty-v2-0-f7149947d4ef@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-serial@vger.kernel.org
X-Mailer: b4 0.15.2

rs_startup() allocates a transmit ring buffer that is used to buffer reads
and writes from/to serial data register.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/amiserial.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 81eaca751541..28af0fd98181 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -443,23 +443,23 @@ static int rs_startup(struct tty_struct *tty, struct serial_state *info)
 	struct tty_port *port = &info->tport;
 	unsigned long flags;
 	int	retval=0;
-	unsigned long page;
+	void *buffer;
 
-	page = get_zeroed_page(GFP_KERNEL);
-	if (!page)
+	buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buffer)
 		return -ENOMEM;
 
 	local_irq_save(flags);
 
 	if (tty_port_initialized(port)) {
-		free_page(page);
+		kfree(buffer);
 		goto errout;
 	}
 
 	if (info->xmit.buf)
-		free_page(page);
+		kfree(buffer);
 	else
-		info->xmit.buf = (unsigned char *) page;
+		info->xmit.buf = buffer;
 
 #ifdef SERIAL_DEBUG_OPEN
 	printk("starting up ttys%d ...", info->line);
@@ -537,7 +537,7 @@ static void rs_shutdown(struct tty_struct *tty, struct serial_state *info)
 	 */
 	free_irq(IRQ_AMIGA_VERTB, info);
 
-	free_page((unsigned long)info->xmit.buf);
+	kfree(info->xmit.buf);
 	info->xmit.buf = NULL;
 
 	info->IER = 0;

-- 
2.53.0

