Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49527144B;
	Thu, 14 Aug 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156307; cv=none; b=NLszEGzkic7rlaLminwkhSl1YAh6mCqRNdp52EIwZIWALpFP7Id/+/kveZSWfZNl+fPFwW6fLOctUWrjmemPY6/9AXtZOOxAE9oRSRpDMPlzpZidyFusHkVenzeXSxpaAAA7aeot62suOe5iKN2dzTGaMXhJih3qFn/LXYZ4K94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156307; c=relaxed/simple;
	bh=kC3z4by0bJrRY2ZjoNP1w9v8ZFnzCAUJjUUBpcBSsFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jvR3KEf5hI0xmoXW8jAW3/2yypWXvHy9JLA+NmRVQiaiupwIparF0BEok29f5wcoVQJS0XmNBOo1hCzsW13RBcKvvMF9PJg4d0Kki8Dkm6xK2oBICmCHoGPY7Ub7dgQyvHt+MfGYq7FoWneKYi0e3w1gV9jIm8KRgLoK4hEzYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXTxqlJX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXTxqlJX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0467AC4CEEF;
	Thu, 14 Aug 2025 07:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156307;
	bh=kC3z4by0bJrRY2ZjoNP1w9v8ZFnzCAUJjUUBpcBSsFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXTxqlJXtLDonjIRTzcB+QRMd3YBE7u2yuZ9aPAkNjcR79Epp83uoxvKPtIEglBSJ
	 jdy4wWe8fPJRIbGJwIBmrRaZDIqBbkau5hcGGZUZYdPABHbsBnsK2bv3Ea4exFcL+S
	 Ba8lpe97RGwwn9d+V4d9e8AHdD/yAEI2VyjOgnJL26Tp4kZz/zZKU1Qy75l0FGI5p/
	 h+Y0OyO+gQfdLfW3xCPJsGQVXFR3nhpdubOVVR5ZnVrztgtDaHLXlM5wqOwta5Xx0S
	 k3oRnHd7hou3vhNsaBBnX5ubgMXHpmqJL/Zlv+su4bCV5Rs1q2oO17ciNAjcFA9q1l
	 gTV4xvqUiQ5Mw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/16] tty: tty_port: use guard()s
Date: Thu, 14 Aug 2025 09:24:45 +0200
Message-ID: <20250814072456.182853-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814072456.182853-1-jirislaby@kernel.org>
References: <20250814072456.182853-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Having all the new guards, use them in the tty_port code. This improves
readability, makes error handling easier, and marks locked portions of
code explicit.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_port.c | 168 ++++++++++++++++++-----------------------
 1 file changed, 74 insertions(+), 94 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 5b4d5fb99a59..fe67c5cb0a3f 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -63,12 +63,8 @@ static void tty_port_default_lookahead_buf(struct tty_port *port, const u8 *p,
 
 static void tty_port_default_wakeup(struct tty_port *port)
 {
-	struct tty_struct *tty = tty_port_tty_get(port);
-
-	if (tty) {
-		tty_wakeup(tty);
-		tty_kref_put(tty);
-	}
+	scoped_guard(tty_port_tty, port)
+		tty_wakeup(scoped_tty());
 }
 
 const struct tty_port_client_operations tty_port_default_client_ops = {
@@ -225,26 +221,27 @@ EXPORT_SYMBOL_GPL(tty_port_unregister_device);
 int tty_port_alloc_xmit_buf(struct tty_port *port)
 {
 	/* We may sleep in get_zeroed_page() */
-	mutex_lock(&port->buf_mutex);
-	if (port->xmit_buf == NULL) {
-		port->xmit_buf = (u8 *)get_zeroed_page(GFP_KERNEL);
-		if (port->xmit_buf)
-			kfifo_init(&port->xmit_fifo, port->xmit_buf, PAGE_SIZE);
-	}
-	mutex_unlock(&port->buf_mutex);
+	guard(mutex)(&port->buf_mutex);
+
+	if (port->xmit_buf)
+		return 0;
+
+	port->xmit_buf = (u8 *)get_zeroed_page(GFP_KERNEL);
 	if (port->xmit_buf == NULL)
 		return -ENOMEM;
+
+	kfifo_init(&port->xmit_fifo, port->xmit_buf, PAGE_SIZE);
+
 	return 0;
 }
 EXPORT_SYMBOL(tty_port_alloc_xmit_buf);
 
 void tty_port_free_xmit_buf(struct tty_port *port)
 {
-	mutex_lock(&port->buf_mutex);
+	guard(mutex)(&port->buf_mutex);
 	free_page((unsigned long)port->xmit_buf);
 	port->xmit_buf = NULL;
 	INIT_KFIFO(port->xmit_fifo);
-	mutex_unlock(&port->buf_mutex);
 }
 EXPORT_SYMBOL(tty_port_free_xmit_buf);
 
@@ -301,13 +298,8 @@ EXPORT_SYMBOL(tty_port_put);
  */
 struct tty_struct *tty_port_tty_get(struct tty_port *port)
 {
-	unsigned long flags;
-	struct tty_struct *tty;
-
-	spin_lock_irqsave(&port->lock, flags);
-	tty = tty_kref_get(port->tty);
-	spin_unlock_irqrestore(&port->lock, flags);
-	return tty;
+	guard(spinlock_irqsave)(&port->lock);
+	return tty_kref_get(port->tty);
 }
 EXPORT_SYMBOL(tty_port_tty_get);
 
@@ -321,12 +313,9 @@ EXPORT_SYMBOL(tty_port_tty_get);
  */
 void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&port->lock, flags);
+	guard(spinlock_irqsave)(&port->lock);
 	tty_kref_put(port->tty);
 	port->tty = tty_kref_get(tty);
-	spin_unlock_irqrestore(&port->lock, flags);
 }
 EXPORT_SYMBOL(tty_port_tty_set);
 
@@ -342,24 +331,24 @@ EXPORT_SYMBOL(tty_port_tty_set);
  */
 static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 {
-	mutex_lock(&port->mutex);
+	guard(mutex)(&port->mutex);
+
 	if (port->console)
-		goto out;
+		return;
 
-	if (tty_port_initialized(port)) {
-		tty_port_set_initialized(port, false);
-		/*
-		 * Drop DTR/RTS if HUPCL is set. This causes any attached
-		 * modem to hang up the line.
-		 */
-		if (tty && C_HUPCL(tty))
-			tty_port_lower_dtr_rts(port);
+	if (!tty_port_initialized(port))
+		return;
 
-		if (port->ops->shutdown)
-			port->ops->shutdown(port);
-	}
-out:
-	mutex_unlock(&port->mutex);
+	tty_port_set_initialized(port, false);
+	/*
+	 * Drop DTR/RTS if HUPCL is set. This causes any attached
+	 * modem to hang up the line.
+	 */
+	if (tty && C_HUPCL(tty))
+		tty_port_lower_dtr_rts(port);
+
+	if (port->ops->shutdown)
+		port->ops->shutdown(port);
 }
 
 /**
@@ -374,15 +363,15 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 void tty_port_hangup(struct tty_port *port)
 {
 	struct tty_struct *tty;
-	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
-	port->count = 0;
-	tty = port->tty;
-	if (tty)
-		set_bit(TTY_IO_ERROR, &tty->flags);
-	port->tty = NULL;
-	spin_unlock_irqrestore(&port->lock, flags);
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		port->count = 0;
+		tty = port->tty;
+		if (tty)
+			set_bit(TTY_IO_ERROR, &tty->flags);
+		port->tty = NULL;
+	}
+
 	tty_port_set_active(port, false);
 	tty_port_shutdown(port, tty);
 	tty_kref_put(tty);
@@ -393,15 +382,16 @@ EXPORT_SYMBOL(tty_port_hangup);
 
 void __tty_port_tty_hangup(struct tty_port *port, bool check_clocal, bool async)
 {
-	struct tty_struct *tty = tty_port_tty_get(port);
+	scoped_guard(tty_port_tty, port) {
+		struct tty_struct *tty = scoped_tty();
 
-	if (tty && (!check_clocal || !C_CLOCAL(tty))) {
-		if (async)
-			tty_hangup(tty);
-		else
-			tty_vhangup(tty);
+		if (!check_clocal || !C_CLOCAL(tty)) {
+			if (async)
+				tty_hangup(tty);
+			else
+				tty_vhangup(tty);
+		}
 	}
-	tty_kref_put(tty);
 }
 EXPORT_SYMBOL_GPL(__tty_port_tty_hangup);
 
@@ -490,7 +480,6 @@ int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
 	int do_clocal = 0, retval;
-	unsigned long flags;
 	DEFINE_WAIT(wait);
 
 	/* if non-blocking mode is set we can pass directly to open unless
@@ -519,10 +508,10 @@ int tty_port_block_til_ready(struct tty_port *port,
 	retval = 0;
 
 	/* The port lock protects the port counts */
-	spin_lock_irqsave(&port->lock, flags);
-	port->count--;
-	port->blocked_open++;
-	spin_unlock_irqrestore(&port->lock, flags);
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		port->count--;
+		port->blocked_open++;
+	}
 
 	while (1) {
 		/* Indicate we are open */
@@ -561,11 +550,11 @@ int tty_port_block_til_ready(struct tty_port *port,
 	/* Update counts. A parallel hangup will have set count to zero and
 	 * we must not mess that up further.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
-	if (!tty_hung_up_p(filp))
-		port->count++;
-	port->blocked_open--;
-	spin_unlock_irqrestore(&port->lock, flags);
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		if (!tty_hung_up_p(filp))
+			port->count++;
+		port->blocked_open--;
+	}
 	if (retval == 0)
 		tty_port_set_active(port, true);
 	return retval;
@@ -604,28 +593,24 @@ static void tty_port_drain_delay(struct tty_port *port, struct tty_struct *tty)
 int tty_port_close_start(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
-	unsigned long flags;
-
 	if (tty_hung_up_p(filp))
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
-	if (tty->count == 1 && port->count != 1) {
-		tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
-			 port->count);
-		port->count = 1;
-	}
-	if (--port->count < 0) {
-		tty_warn(tty, "%s: bad port count (%d)\n", __func__,
-			 port->count);
-		port->count = 0;
-	}
+	scoped_guard(spinlock_irqsave, &port->lock) {
+		if (tty->count == 1 && port->count != 1) {
+			tty_warn(tty, "%s: tty->count = 1 port count = %d\n", __func__,
+				 port->count);
+			port->count = 1;
+		}
+		if (--port->count < 0) {
+			tty_warn(tty, "%s: bad port count (%d)\n", __func__,
+				 port->count);
+			port->count = 0;
+		}
 
-	if (port->count) {
-		spin_unlock_irqrestore(&port->lock, flags);
-		return 0;
+		if (port->count)
+			return 0;
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
 
 	tty->closing = 1;
 
@@ -744,9 +729,8 @@ EXPORT_SYMBOL_GPL(tty_port_install);
 int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 							struct file *filp)
 {
-	spin_lock_irq(&port->lock);
-	++port->count;
-	spin_unlock_irq(&port->lock);
+	scoped_guard(spinlock_irq, &port->lock)
+		++port->count;
 	tty_port_tty_set(port, tty);
 
 	/*
@@ -755,21 +739,17 @@ int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 	 * port mutex.
 	 */
 
-	mutex_lock(&port->mutex);
-
-	if (!tty_port_initialized(port)) {
+	scoped_guard(mutex, &port->mutex) {
+		if (tty_port_initialized(port))
+			break;
 		clear_bit(TTY_IO_ERROR, &tty->flags);
 		if (port->ops->activate) {
 			int retval = port->ops->activate(port, tty);
-
-			if (retval) {
-				mutex_unlock(&port->mutex);
+			if (retval)
 				return retval;
-			}
 		}
 		tty_port_set_initialized(port, true);
 	}
-	mutex_unlock(&port->mutex);
 	return tty_port_block_til_ready(port, tty, filp);
 }
 EXPORT_SYMBOL(tty_port_open);
-- 
2.50.1

