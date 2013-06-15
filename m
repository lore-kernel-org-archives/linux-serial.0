From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 03/16] tty: Factor flip buffer initialization into helper function
Date: Sat, 15 Jun 2013 09:36:03 -0400
Message-ID: <1371303376-5028-4-git-send-email-peter@hurleysoftware.com>
References: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
 <1371303376-5028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371303376-5028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Factor shared code; prepare for adding 0-sized sentinel flip buffer.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_buffer.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index a5e3962..56d4602 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -22,6 +22,15 @@
 #define MIN_TTYB_SIZE	256
 #define TTYB_ALIGN_MASK	255
 
+static void tty_buffer_reset(struct tty_buffer *p, size_t size)
+{
+	p->used = 0;
+	p->size = size;
+	p->next = NULL;
+	p->commit = 0;
+	p->read = 0;
+}
+
 /**
  *	tty_buffer_free_all		-	free buffers used by a tty
  *	@tty: tty to free from
@@ -70,11 +79,8 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 	p = kmalloc(sizeof(struct tty_buffer) + 2 * size, GFP_ATOMIC);
 	if (p == NULL)
 		return NULL;
-	p->used = 0;
-	p->size = size;
-	p->next = NULL;
-	p->commit = 0;
-	p->read = 0;
+
+	tty_buffer_reset(p, size);
 	port->buf.memory_used += size;
 	return p;
 }
@@ -185,10 +191,7 @@ static struct tty_buffer *tty_buffer_find(struct tty_port *port, size_t size)
 			struct tty_buffer *t = *tbh;
 
 			*tbh = t->next;
-			t->next = NULL;
-			t->used = 0;
-			t->commit = 0;
-			t->read = 0;
+			tty_buffer_reset(t, t->size);
 			port->buf.memory_used += t->size;
 			return t;
 		}
-- 
1.8.1.2
