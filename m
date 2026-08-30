Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24F22DCBE3;
	Sun, 30 Aug 2026 07:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788076189; cv=none; b=aUegJCT2XySVZIF9uB5gS1X2dAP+declLTb+pt4ijWiv2jsiIKsywqWfIRR1QAnyxTRk5GcqQ9lH3HKmqVpiN+o5gMX5hF17BemK3/zXopKvzQ5lde1fvaQ7FacLOyVbEITmnwbzgtd9PFUkcEpPP9olP3ZfCz5hpJ/Zpv94V0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788076189; c=relaxed/simple;
	bh=O/9D3i0yjW7F9MwQbqTEGPDer68/Li3+jkIE0WXY+vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K0mfr4Hzv3u37/du6M1UcSvvD2Z/M4eucuYHJWCkr9plLSeqvfJ1gcvilVeSVoRi41yKyOJDaNVPzCkuX5KwyMPLOKdJLKB8/68zFNjBgY+S4RAd8UzLphBEu+9slgIFgO39Ah8myMsXvMPmkMcOAlyeuMjdx/bf5606PRNkP+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVy5RuRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVy5RuRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B737E1F000E9;
	Sun, 30 Aug 2026 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788076188;
	bh=4NrSsuZV29xVILt7z5sekPgPcSUlhKVhvtPvsz1aJgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YVy5RuRDJhrAG9c9gOgOtGUONheY/iIyUzWDRWv4Ew/lBNFR2qwEW4yd4oaDrr5n/
	 ONEHQvjB4UNd/jUu/xSPGX5HSptOA+Zv8L1WrwK96G/KfXj9zRlAahVclZBId1k47T
	 lu7s+qxucogiX331Q7G5Mq8iYxh9JFuYhsgXOPuxWpwL255qmpQN50FiRZ9z1L0G9r
	 iTxxgTzu2cJEZ/3s+yUxOfX7guIl1bnaVpdBuj+JvDPJaCr+E4v/9r8CEkMKbHt/yn
	 9i1BIw3vxI6BOUmb6freBYrww0vm7Zks6+Nh0UGsIZ4XbBivpp0GYRrQecwsn5cYVb
	 zGErJk3Yo/SKg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 30 Aug 2026 10:49:38 +0300
Subject: [PATCH 2/3] serial: core: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tty-v1-2-0cbe6170649b@kernel.org>
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

uart_alloc_xmit_buf() allocates the transmit buffer of a serial port. The
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

While on it, make the local variable holding the buffer a pointer to get
rid of the casts.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Assisted-by: copilot:claude-opus
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/tty/serial/serial_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..f12ce7d190fe 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -247,29 +247,29 @@ static int uart_alloc_xmit_buf(struct tty_port *port)
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
 	unsigned long flags;
-	unsigned long page;
+	unsigned char *buf;
 
 	/*
 	 * Initialise and allocate the transmit and temporary
 	 * buffer.
 	 */
-	page = get_zeroed_page(GFP_KERNEL);
-	if (!page)
+	buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
 	uport = uart_port_ref_lock(state, &flags);
 	if (!state->port.xmit_buf) {
-		state->port.xmit_buf = (unsigned char *)page;
+		state->port.xmit_buf = buf;
 		kfifo_init(&state->port.xmit_fifo, state->port.xmit_buf,
 				PAGE_SIZE);
 		uart_port_unlock_deref(uport, flags);
 	} else {
 		uart_port_unlock_deref(uport, flags);
 		/*
-		 * Do not free() the page under the port lock, see
+		 * Do not free() the buffer under the port lock, see
 		 * uart_free_xmit_buf().
 		 */
-		free_page(page);
+		kfree(buf);
 	}
 
 	return 0;
@@ -283,7 +283,7 @@ static void uart_free_xmit_buf(struct tty_port *port)
 	char *xmit_buf;
 
 	/*
-	 * Do not free() the transmit buffer page under the port lock since
+	 * Do not free() the transmit buffer under the port lock since
 	 * this can create various circular locking scenarios. For instance,
 	 * console driver may need to allocate/free a debug object, which
 	 * can end up in printk() recursion.
@@ -294,7 +294,7 @@ static void uart_free_xmit_buf(struct tty_port *port)
 	INIT_KFIFO(port->xmit_fifo);
 	uart_port_unlock_deref(uport, flags);
 
-	free_page((unsigned long)xmit_buf);
+	kfree(xmit_buf);
 }
 
 /*

-- 
2.53.0

