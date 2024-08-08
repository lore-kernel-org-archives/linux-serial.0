Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179E18C924;
	Thu,  8 Aug 2024 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113363; cv=none; b=LzBZ1ZEEzkqjvDwvpDkKMTTSMjW0kCwdqKH+wl2CnUuwyRb5eImz4gXtgjUa4CFxFJtq6r0Ugx+eaSK44evNrK08YKgD4+7kl6+aoVVBPfOdzcg1ahnLg0CkZk2KUQCX0nNtAPwejYh0WyA7WErNQIdStCRUzMhIHbLlq97pzzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113363; c=relaxed/simple;
	bh=XWddVIUVs64O2VaGFdrKd+syIozG4HiWv3XzURvonsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCOfP0Eq2tP+CMdYvnzOsTFC5OnuevdWMnR6Fm3hksURLNPDdolxjDVyiGQELUfJsxppToDkp1uGaIULXaS0v45ljFIcKw3ZTMGHiuKBBQhfX2m3VlOTsWIT6cykRPxhhdzEbL7tDdnsqImMJsH9lOMz5e1IGpcrVqKY3YGjsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWt9A5u0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWt9A5u0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9E5C4AF09;
	Thu,  8 Aug 2024 10:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723113363;
	bh=XWddVIUVs64O2VaGFdrKd+syIozG4HiWv3XzURvonsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWt9A5u05MmzjOnl6yls5dC7en3fGxavqAhc7HUdEHE08sqWWSwWYpmve60+lnxD8
	 bLNtvyufrtHnY1mKYMGxmHbh28XzpGoYTEZZgRalF0xRx1dK5AF7nlBaVYcUO14yEK
	 HM5aOC+J+Vaj2EVD4mKKPjmKrpmpdTRI/G1H62hwpLhBJ/W32Ef0rUheP7VrJ13JJm
	 SbcQ3cJCzpVOxh+SZ3S/8gP8RYugG/m5NLwAnMqMqaZDzNu4zB6cbKu6aUXCup8EMS
	 VVZ2wayV85ORKh3vGZKl9+AzgjYRl0DLNDZYlzgr76qLpVckCK2MnplsajXjrQ3GPC
	 kZYC0gtuHrz/A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	linux-usb@vger.kernel.org
Subject: [PATCH v2 05/11] xhci: dbgtty: use kfifo from tty_port struct
Date: Thu,  8 Aug 2024 12:35:41 +0200
Message-ID: <20240808103549.429349-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240808103549.429349-1-jirislaby@kernel.org>
References: <20240808103549.429349-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to define one in a custom structure. The tty_port one
is free to use.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/host/xhci-dbgcap.h |  1 -
 drivers/usb/host/xhci-dbgtty.c | 17 +++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgcap.h b/drivers/usb/host/xhci-dbgcap.h
index 0118c6288a3c..eab59d921e22 100644
--- a/drivers/usb/host/xhci-dbgcap.h
+++ b/drivers/usb/host/xhci-dbgcap.h
@@ -110,7 +110,6 @@ struct dbc_port {
 	struct tasklet_struct		push;
 
 	struct list_head		write_pool;
-	struct kfifo			write_fifo;
 
 	bool				registered;
 };
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 64ea96494997..881f5a7e6e0e 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -36,7 +36,7 @@ static int dbc_start_tx(struct dbc_port *port)
 
 	while (!list_empty(pool)) {
 		req = list_entry(pool->next, struct dbc_request, list_pool);
-		len = kfifo_out(&port->write_fifo, req->buf, DBC_MAX_PACKET);
+		len = kfifo_out(&port->port.xmit_fifo, req->buf, DBC_MAX_PACKET);
 		if (len == 0)
 			break;
 		do_tty_wake = true;
@@ -203,7 +203,7 @@ static ssize_t dbc_tty_write(struct tty_struct *tty, const u8 *buf,
 
 	spin_lock_irqsave(&port->port_lock, flags);
 	if (count)
-		count = kfifo_in(&port->write_fifo, buf, count);
+		count = kfifo_in(&port->port.xmit_fifo, buf, count);
 	dbc_start_tx(port);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
@@ -217,7 +217,7 @@ static int dbc_tty_put_char(struct tty_struct *tty, u8 ch)
 	int			status;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	status = kfifo_put(&port->write_fifo, ch);
+	status = kfifo_put(&port->port.xmit_fifo, ch);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return status;
@@ -240,7 +240,7 @@ static unsigned int dbc_tty_write_room(struct tty_struct *tty)
 	unsigned int		room;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	room = kfifo_avail(&port->write_fifo);
+	room = kfifo_avail(&port->port.xmit_fifo);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return room;
@@ -253,7 +253,7 @@ static unsigned int dbc_tty_chars_in_buffer(struct tty_struct *tty)
 	unsigned int		chars;
 
 	spin_lock_irqsave(&port->port_lock, flags);
-	chars = kfifo_len(&port->write_fifo);
+	chars = kfifo_len(&port->port.xmit_fifo);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return chars;
@@ -411,7 +411,8 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 		goto err_idr;
 	}
 
-	ret = kfifo_alloc(&port->write_fifo, DBC_WRITE_BUF_SIZE, GFP_KERNEL);
+	ret = kfifo_alloc(&port->port.xmit_fifo, DBC_WRITE_BUF_SIZE,
+			  GFP_KERNEL);
 	if (ret)
 		goto err_exit_port;
 
@@ -440,7 +441,7 @@ static int xhci_dbc_tty_register_device(struct xhci_dbc *dbc)
 	xhci_dbc_free_requests(&port->read_pool);
 	xhci_dbc_free_requests(&port->write_pool);
 err_free_fifo:
-	kfifo_free(&port->write_fifo);
+	kfifo_free(&port->port.xmit_fifo);
 err_exit_port:
 	idr_remove(&dbc_tty_minors, port->minor);
 err_idr:
@@ -465,7 +466,7 @@ static void xhci_dbc_tty_unregister_device(struct xhci_dbc *dbc)
 	idr_remove(&dbc_tty_minors, port->minor);
 	mutex_unlock(&dbc_tty_minors_lock);
 
-	kfifo_free(&port->write_fifo);
+	kfifo_free(&port->port.xmit_fifo);
 	xhci_dbc_free_requests(&port->read_pool);
 	xhci_dbc_free_requests(&port->read_queue);
 	xhci_dbc_free_requests(&port->write_pool);
-- 
2.46.0

