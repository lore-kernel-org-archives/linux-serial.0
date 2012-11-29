From: Ilya Zykov <ilya@ilyx.ru>
Subject: Fwd: [PATCH] tty: Correct tty buffer flushing.
Date: Thu, 29 Nov 2012 04:03:30 +0400
Message-ID: <50B6A652.9000107@ilyx.ru>
References: <50B55A93.4090900@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 95-31-19-74.broadband.corbina.ru ([95.31.19.74]:50764 "EHLO
	95-31-19-74.broadband.corbina.ru" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1945896Ab2K2ADp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Nov 2012 19:03:45 -0500
In-Reply-To: <50B55A93.4090900@ilyx.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Xiaobing Tu <xiaobing.tu@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Alek Du <alek.du@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ilya@ilyx.ru, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

This patch abolish:
[PATCH] tty: hold lock across tty buffer finding and buffer filling.
commit f8f72f047b96c6c8b13f6e3ba53fa6feb4266813

The commit f8f72f047 very dirty, has many degradation on SMP systems, because take
spinlock at long time, and it doesn't resolve problem with tty_prepare_string*().
We lose all advantage from the use of flip buffer. Can't write/read to/from buffer
without lock.

The root of problem it use carelessly buffer flushing, then another thread can write to it.
This patch resolves this problem and doesn't let lose advantage from flip buffer use.

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
