From: Ilya Zykov <ilya@ilyx.ru>
Subject: [PATCH -next 2/2] tty: Correct tty buffer flush.
Date: Wed, 05 Dec 2012 12:48:22 +0400
Message-ID: <50BF0A56.9050209@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

tty: Correct tty buffer flush.

Signed-off-by: Ilya Zykov <ilya@ilyx.ru>
---
 drivers/tty/tty_buffer.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 7602df8..8a3333d 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -119,11 +119,14 @@ static void __tty_buffer_flush(struct tty_port *port)
 	struct tty_bufhead *buf = &port->buf;
 	struct tty_buffer *thead;
 
-	while ((thead = buf->head) != NULL) {
-		buf->head = thead->next;
-		tty_buffer_free(port, thead);
+	if (unlikely(buf->head == NULL))
+		return;
+	while ((thead = buf->head->next) != NULL) {
+		tty_buffer_free(port, buf->head);
+		buf->head = thead;
 	}
-	buf->tail = NULL;
+	WARN_ON(buf->head != buf->tail);
+	buf->head->read = buf->head->commit;
 }
 
 /**
