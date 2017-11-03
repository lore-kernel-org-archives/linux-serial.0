From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] tty: fix tty_ldisc_receive_buf() documentation
Date: Fri,  3 Nov 2017 15:18:05 +0100
Message-ID: <20171103141805.20292-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

The tty_ldisc_receive_buf() helper returns the number of bytes
processed so drop the bogus "not" from the kernel doc comment.

Fixes: 8d082cd300ab ("tty: Unify receive_buf() code paths")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index f8eba1c5412f..677fa99b7747 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -446,7 +446,7 @@ EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
  *	Callers other than flush_to_ldisc() need to exclude the kworker
  *	from concurrent use of the line discipline, see paste_selection().
  *
- *	Returns the number of bytes not processed
+ *	Returns the number of bytes processed
  */
 int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 			  char *f, int count)
-- 
2.15.0
