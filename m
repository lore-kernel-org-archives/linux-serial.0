From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 16/16] tty: Remove private constant from global namespace
Date: Mon, 15 Apr 2013 11:26:07 -0400
Message-ID: <1366039567-8620-17-git-send-email-peter@hurleysoftware.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
 <1366039567-8620-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366039567-8620-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

TTY_BUFFER_PAGE is only used within drivers/tty/tty_buffer.c;
relocate to that file scope.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/tty_buffer.c | 10 ++++++++++
 include/linux/tty.h      | 11 -----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index f22e116..c043136f 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -28,6 +28,16 @@
  */
 #define TTYB_MEM_LIMIT	65536
 
+/*
+ * We default to dicing tty buffer allocations to this many characters
+ * in order to avoid multiple page allocations. We know the size of
+ * tty_buffer itself but it must also be taken into account that the
+ * the buffer is 256 byte aligned. See tty_buffer_find for the allocation
+ * logic this must match
+ */
+
+#define TTY_BUFFER_PAGE	(((PAGE_SIZE - sizeof(struct tty_buffer)) / 2) & ~0xFF)
+
 
 /**
  *	tty_buffer_lock_exclusive	-	gain exclusive access to buffer
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 0959a7b..747c9e2 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -53,17 +53,6 @@ static inline char *flag_buf_ptr(struct tty_buffer *b, int ofs)
 	return (char *)char_buf_ptr(b, ofs) + b->size;
 }
 
-/*
- * We default to dicing tty buffer allocations to this many characters
- * in order to avoid multiple page allocations. We know the size of
- * tty_buffer itself but it must also be taken into account that the
- * the buffer is 256 byte aligned. See tty_buffer_find for the allocation
- * logic this must match
- */
-
-#define TTY_BUFFER_PAGE	(((PAGE_SIZE - sizeof(struct tty_buffer)) / 2) & ~0xFF)
-
-
 struct tty_bufhead {
 	struct tty_buffer *head;	/* Queue head */
 	struct work_struct work;
-- 
1.8.1.2
