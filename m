From: Ilya Zykov <ilya@ilyx.ru>
Subject: [PATCH] tty: Correct tty buffer flushing.
Date: Wed, 28 Nov 2012 04:28:03 +0400
Message-ID: <50B55A93.4090900@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:50044 "EHLO
	95-31-19-74.broadband.corbina.ru" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753060Ab2K1A2Q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Nov 2012 19:28:16 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, ilya@ilyx.ru

CANCEL - [PATCH] tty: hold lock across tty buffer finding and buffer filling.
commit f8f72f047b96c6c8b13f6e3ba53fa6feb4266813

The commit above very dirty, has many degradation on SMP systems, because take
spinlock on long time, and not resolve problem with tty_prepare_string*()(Jiri Slaby).
We lose all advantage from the use of flip buffer.

The root of problem it use carelessly buffer flushing, then another thread can write to it.
This patch resolve this problem and doesn't let lose advantage from flip buffer use.
Before use need REVERT commit f8f72f047b96c6c8b13f6e3ba53fa6feb4266813.

Signed-off-by: Ilya Zykov <ilya@ilyx.ru>
---
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6c9b7cd..4f02f9c 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -114,11 +114,14 @@ static void __tty_buffer_flush(struct tty_struct *tty)
 {
 	struct tty_buffer *thead;
 
-	while ((thead = tty->buf.head) != NULL) {
-		tty->buf.head = thead->next;
-		tty_buffer_free(tty, thead);
+	if (tty->buf.head == NULL)
+		return;
+	while ((thead = tty->buf.head->next) != NULL) {
+		tty_buffer_free(tty, tty->buf.head);
+		tty->buf.head = thead;
 	}
-	tty->buf.tail = NULL;
+	WARN_ON(tty->buf.head != tty->buf.tail);
+	tty->buf.head->read = tty->buf.head->commit;
 }
 
 /**

