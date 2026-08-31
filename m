Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E63D3339;
	Mon, 31 Aug 2026 08:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164875; cv=none; b=a3TOaagXhCXqy+wu3hfD/SfabnGbRWrLP2nWMhNysesUKBHuiiQaOp8/aksQqwR6yQVqEA+JBkWDD4ddPD09/T79GRAM1AngX6KRyBvzdsyI50wKvHDbUFz5elHy4AnMx/zC5GLflgAxVaO4Zlt8i2EbiZJjKx+FutNTLI4lQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164875; c=relaxed/simple;
	bh=58GC55K4PTU0lG/TonzKg5LuLABgL12Qb9j4kXVrRNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=agHTUsp54P2jTU/NrFTvivdVNzJ24D8I1zPY9NdwXYBBXAIsdX2P/QvQb1ZC0aHSIDycHaqfoqVJgtBAZavuHzbV7DfFpdxFjjpWJH95lDHjCCMmKPp4PiL9CANCZfkzyh8wxTI3dJ7IhnWK3N47hsOGiSXFxgQFYjbTmgofch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBOjheqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBOjheqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396651F00A3D;
	Mon, 31 Aug 2026 08:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788164873;
	bh=Y4bH+/WtPEyRU+oBNZLJOMfju4/GbiOfv2EYcWlAxs4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PBOjheqgZU2//8wt0aikBUBXJMoEdiXNgcruw0QaK+0mHSMz2A20L9Y+wS1TTqm2a
	 cB8k9NDiAwOE3FQpU0Wtkxhy3pX5eP8uV5RGROxVtznX4ozJ+fAOLG5A4gsGTtqEKV
	 2UX8sigBGUWxIVY2UXRFD645QP2a5kYSEjZbVx+BMbo4LUxTUoPDxH2heA4H95HwVw
	 TCUE9QXm/lvmvJMvNdEvR4thgz5vc19pAXHDblSxIDmsO3hr4ILc8mb/dhEX4njQst
	 xfZu6qdT+dVUxHz88Xxdx6uh7GVre1GhlxHhvGcHq48YCNkqtgmkg4M8cHiIDZDg7j
	 ujirBHwtexgYw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Mon, 31 Aug 2026 11:27:43 +0300
Subject: [PATCH v2 1/3] tty: port: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-tty-v2-1-88cd58c3c640@kernel.org>
References: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
In-Reply-To: <20260831-tty-v2-0-88cd58c3c640@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
 Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailer: b4 0.17-dev

tty_port_alloc_xmit_buf() allocates the transmit buffer of a tty port. The
buffer only backs the port's kfifo, the data being sent is copied in and
out of it.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/tty_port.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 54359310e293c..44122921fc45b 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -240,13 +240,13 @@ EXPORT_SYMBOL_GPL(tty_port_unregister_device);
 
 int tty_port_alloc_xmit_buf(struct tty_port *port)
 {
-	/* We may sleep in get_zeroed_page() */
+	/* We may sleep in kzalloc() */
 	guard(mutex)(&port->buf_mutex);
 
 	if (port->xmit_buf)
 		return 0;
 
-	port->xmit_buf = (u8 *)get_zeroed_page(GFP_KERNEL);
+	port->xmit_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (port->xmit_buf == NULL)
 		return -ENOMEM;
 
@@ -259,7 +259,7 @@ EXPORT_SYMBOL(tty_port_alloc_xmit_buf);
 void tty_port_free_xmit_buf(struct tty_port *port)
 {
 	guard(mutex)(&port->buf_mutex);
-	free_page((unsigned long)port->xmit_buf);
+	kfree(port->xmit_buf);
 	port->xmit_buf = NULL;
 	INIT_KFIFO(port->xmit_fifo);
 }
@@ -288,7 +288,7 @@ static void tty_port_destructor(struct kref *kref)
 	/* check if last port ref was dropped before tty release */
 	if (WARN_ON(port->itty))
 		return;
-	free_page((unsigned long)port->xmit_buf);
+	kfree(port->xmit_buf);
 	tty_port_destroy(port);
 	if (port->ops && port->ops->destruct)
 		port->ops->destruct(port);

-- 
2.53.0

