Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71E353A66;
	Sun, 30 Aug 2026 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076186; cv=none; b=dtaZICeJYzVUos30AjUYgRjpxW7uhLl0DFN++oSc5ctZGI1u1Y/uFXu+039fC/fHjcWGJp8u/O1hBGBOsfDAyIoOfEesDe0cLL7LH3jDWN0qVbzKm/ePJR24GmDV557ayg33lIIlzxfxmuujrYTLH3qLEjfa/GJ2ok4NpeXRIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076186; c=relaxed/simple;
	bh=zTl8OiVFVxNYXo376gqehjdrdDz/yA674wawIUBYEnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7vsjTbCesEpXFoYOLrdnVcIk63dfuRAsfD+xWVPWoWCOgkt1uL9ptdieZJyH1JWv/+ok7yt0E7Py3EAXU96yeV4ywecwwp2BEGkVhxXiGLs1qfLdmvpcVkUINN/P+ukDmJ4Xj+Eio/UxaoQK2/evwFYznfgThkTbU0945kB0j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOx4HGWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOx4HGWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE331F00A3D;
	Sun, 30 Aug 2026 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076185;
	bh=HuAQFZwiOZzqNfEaGbCIrZqTUyDwkDp9iUPeNuXnT0k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=NOx4HGWjxeuC3f34ZH/BvB1br+XJ+CJKR4IxRAwWAEqdxRYw7/ImwrMEVKFpf/Kg0
	 AJode0vDl1kcX4QqspysvvD+TJYk5aQ2GZl/ZwmXIH4gkQNWcny+xwYp37F7E40tsE
	 VZnpJUN/K56Pg2Z5AJJx004ORINtZRaC3nH+H0rGRd9gCkSx3EjnUeeYv0XriMDcT/
	 RGLuYELGfmmQBecnLFSat3U2/DheEczEzej8qj+W0u8KIizfDBNepX9Si2yzIuTW/+
	 bDbogz42uOCEB8zkoZB2xUXKnSPldxToGvEjFNMuL23yN7HZJdMzAwcACVYjzLamXF
	 XManrSAy5lqLA==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:49:37 +0300
Subject: [PATCH 1/3] tty: port: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tty-v1-1-0cbe6170649b@kernel.org>
References: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
In-Reply-To: <20260830-tty-v1-0-0cbe6170649b@kernel.org>
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
index 54359310e293..44122921fc45 100644
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

