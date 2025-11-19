Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B931349AE9;
	Wed, 19 Nov 2025 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546512; cv=none; b=Ch4zZeOM1FG1zM3saeqAwB66w2S8NqnYUcXxFNptdNH/llpwnM0Tz5XaEVAcErom8iYtiYeJmf1SbBlnNlL7I3VHXoCeYtaHMd/QvBIw0P7ZXWXta1roeHL//BJG8CuENv5IhM3GeM/zJE3pn58e8e1pU4kq7PVNuyxEJ6EzoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546512; c=relaxed/simple;
	bh=cSE1bgc/A5b3+eoo1rQhSQWurH3UJYa01QLJN+44l/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rX81DaXqMI5Go65TQzeFfa2oRvOffhfgYa6MAxe0jaym3fmdg0K8t1qKfGTxbSASAPPMDW1ys4Kkt7GzkXR67HP+0Co5lDV41e1SuNzBAGHZaoRoh2mZ/rjrwd8UgcT5HYGnokKwMuXVyrR334/r/edoJthaZMykRa2ybid3fuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/fhpU+y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/fhpU+y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848C8C4CEF5;
	Wed, 19 Nov 2025 10:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763546511;
	bh=cSE1bgc/A5b3+eoo1rQhSQWurH3UJYa01QLJN+44l/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/fhpU+yvSO4iZphSI6puKLlx4b+ro10iKejfVz+b7eCczlfeLXw+ntm0R5hZBngu
	 C7zOFCzEia5nGJIzk6wArj1/gB14kwRRtlULvd3XkrBD7hZWeaLO/hrgjDBmyrFd8b
	 5hsCWFxUb2V+hoQdW8sQCeMo9y+K/VRULWZxrVhlZlGmx8OCtScsjcDw7j7lVch7HZ
	 CiTY+gySYo78ZZRidhunSYKsiAWHTs7J1UBPOIUiQsFRpShBUSB0Aiid6x/WPNsxWI
	 MbeCRZjnKvlGnHz4hTD8Q8JV/yd8Q3e1QAmeju7iJ1OvffXOm7gesVEEvrndyq2e0P
	 30vBJMECtg6mQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/10] tty: n_hdlc: use guard()s
Date: Wed, 19 Nov 2025 11:01:34 +0100
Message-ID: <20251119100140.830761-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119100140.830761-1-jirislaby@kernel.org>
References: <20251119100140.830761-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guards in the n_hdlc code. This improves readability, makes error
handling easier, and marks locked portions of code explicit. All that
while being sure the lock is unlocked.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_hdlc.c | 67 +++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 66bb8ce6ec40..3c9dcb0928c6 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -263,21 +263,18 @@ static int n_hdlc_tty_open(struct tty_struct *tty)
  */
 static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 {
-	unsigned long flags;
 	struct n_hdlc_buf *tbuf;
 	ssize_t actual;
 
 check_again:
-
-	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
-	if (n_hdlc->tbusy) {
-		n_hdlc->woke_up = true;
-		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
-		return;
+	scoped_guard(spinlock_irqsave, &n_hdlc->tx_buf_list.spinlock) {
+		if (n_hdlc->tbusy) {
+			n_hdlc->woke_up = true;
+			return;
+		}
+		n_hdlc->tbusy = true;
+		n_hdlc->woke_up = false;
 	}
-	n_hdlc->tbusy = true;
-	n_hdlc->woke_up = false;
-	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
 
 	tbuf = n_hdlc_buf_get(&n_hdlc->tx_buf_list);
 	while (tbuf) {
@@ -324,9 +321,8 @@ static void n_hdlc_send_frames(struct n_hdlc *n_hdlc, struct tty_struct *tty)
 		clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 
 	/* Clear the re-entry flag */
-	spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
-	n_hdlc->tbusy = false;
-	spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
+	scoped_guard(spinlock_irqsave, &n_hdlc->tx_buf_list.spinlock)
+		n_hdlc->tbusy = false;
 
 	if (n_hdlc->woke_up)
 		goto check_again;
@@ -585,7 +581,6 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 {
 	struct n_hdlc *n_hdlc = tty->disc_data;
 	int count;
-	unsigned long flags;
 	struct n_hdlc_buf *buf = NULL;
 
 	pr_debug("%s() called %d\n", __func__, cmd);
@@ -594,26 +589,26 @@ static int n_hdlc_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	case FIONREAD:
 		/* report count of read data available */
 		/* in next available frame (if any) */
-		spin_lock_irqsave(&n_hdlc->rx_buf_list.spinlock, flags);
-		buf = list_first_entry_or_null(&n_hdlc->rx_buf_list.list,
-						struct n_hdlc_buf, list_item);
-		if (buf)
-			count = buf->count;
-		else
-			count = 0;
-		spin_unlock_irqrestore(&n_hdlc->rx_buf_list.spinlock, flags);
+		scoped_guard(spinlock_irqsave, &n_hdlc->rx_buf_list.spinlock) {
+			buf = list_first_entry_or_null(&n_hdlc->rx_buf_list.list,
+						       struct n_hdlc_buf, list_item);
+			if (buf)
+				count = buf->count;
+			else
+				count = 0;
+		}
 		return put_user(count, (int __user *)arg);
 
 	case TIOCOUTQ:
 		/* get the pending tx byte count in the driver */
 		count = tty_chars_in_buffer(tty);
 		/* add size of next output frame in queue */
-		spin_lock_irqsave(&n_hdlc->tx_buf_list.spinlock, flags);
-		buf = list_first_entry_or_null(&n_hdlc->tx_buf_list.list,
-						struct n_hdlc_buf, list_item);
-		if (buf)
-			count += buf->count;
-		spin_unlock_irqrestore(&n_hdlc->tx_buf_list.spinlock, flags);
+		scoped_guard(spinlock_irqsave, &n_hdlc->tx_buf_list.spinlock) {
+			buf = list_first_entry_or_null(&n_hdlc->tx_buf_list.list,
+						       struct n_hdlc_buf, list_item);
+			if (buf)
+				count += buf->count;
+		}
 		return put_user(count, (int __user *)arg);
 
 	case TCFLSH:
@@ -720,14 +715,10 @@ static struct n_hdlc *n_hdlc_alloc(void)
 static void n_hdlc_buf_return(struct n_hdlc_buf_list *buf_list,
 						struct n_hdlc_buf *buf)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&buf_list->spinlock, flags);
+	guard(spinlock_irqsave)(&buf_list->spinlock);
 
 	list_add(&buf->list_item, &buf_list->list);
 	buf_list->count++;
-
-	spin_unlock_irqrestore(&buf_list->spinlock, flags);
 }
 
 /**
@@ -738,14 +729,10 @@ static void n_hdlc_buf_return(struct n_hdlc_buf_list *buf_list,
 static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
 			   struct n_hdlc_buf *buf)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&buf_list->spinlock, flags);
+	guard(spinlock_irqsave)(&buf_list->spinlock);
 
 	list_add_tail(&buf->list_item, &buf_list->list);
 	buf_list->count++;
-
-	spin_unlock_irqrestore(&buf_list->spinlock, flags);
 }	/* end of n_hdlc_buf_put() */
 
 /**
@@ -758,10 +745,9 @@ static void n_hdlc_buf_put(struct n_hdlc_buf_list *buf_list,
  */
 static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *buf_list)
 {
-	unsigned long flags;
 	struct n_hdlc_buf *buf;
 
-	spin_lock_irqsave(&buf_list->spinlock, flags);
+	guard(spinlock_irqsave)(&buf_list->spinlock);
 
 	buf = list_first_entry_or_null(&buf_list->list,
 						struct n_hdlc_buf, list_item);
@@ -770,7 +756,6 @@ static struct n_hdlc_buf *n_hdlc_buf_get(struct n_hdlc_buf_list *buf_list)
 		buf_list->count--;
 	}
 
-	spin_unlock_irqrestore(&buf_list->spinlock, flags);
 	return buf;
 }	/* end of n_hdlc_buf_get() */
 
-- 
2.51.1

