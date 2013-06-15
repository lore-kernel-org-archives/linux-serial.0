From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 05/16] tty: Use generic names for flip buffer list cursors
Date: Sat, 15 Jun 2013 09:36:05 -0400
Message-ID: <1371303376-5028-6-git-send-email-peter@hurleysoftware.com>
References: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
 <1371303376-5028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371303376-5028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_buffer.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index a428fa2..0259a76 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -44,15 +44,15 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 void tty_buffer_free_all(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
-	struct tty_buffer *thead;
+	struct tty_buffer *p;
 
-	while ((thead = buf->head) != NULL) {
-		buf->head = thead->next;
-		kfree(thead);
+	while ((p = buf->head) != NULL) {
+		buf->head = p->next;
+		kfree(p);
 	}
-	while ((thead = buf->free) != NULL) {
-		buf->free = thead->next;
-		kfree(thead);
+	while ((p = buf->free) != NULL) {
+		buf->free = p->next;
+		kfree(p);
 	}
 	buf->tail = NULL;
 	buf->memory_used = 0;
@@ -143,13 +143,13 @@ static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
 static void __tty_buffer_flush(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
-	struct tty_buffer *thead;
+	struct tty_buffer *next;
 
 	if (unlikely(buf->head == NULL))
 		return;
-	while ((thead = buf->head->next) != NULL) {
+	while ((next = buf->head->next) != NULL) {
 		tty_buffer_free(port, buf->head);
-		buf->head = thead;
+		buf->head = next;
 	}
 	WARN_ON(buf->head != buf->tail);
 	buf->head->read = buf->head->commit;
-- 
1.8.1.2
