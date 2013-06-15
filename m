From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 12/16] tty: Avoid false-sharing flip buffer ptrs
Date: Sat, 15 Jun 2013 09:36:12 -0400
Message-ID: <1371303376-5028-13-git-send-email-peter@hurleysoftware.com>
References: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
 <1371303376-5028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371303376-5028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Separate the head and tail ptrs to avoid cache-line contention
(so called 'false-sharing') between concurrent threads.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/tty.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1d5bacc..b8e8adf 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -65,13 +65,13 @@ static inline char *flag_buf_ptr(struct tty_buffer *b, int ofs)
 
 
 struct tty_bufhead {
+	struct tty_buffer *head;	/* Queue head */
 	struct work_struct work;
 	struct mutex flush_mutex;
 	struct tty_buffer sentinel;
-	struct tty_buffer *head;	/* Queue head */
-	struct tty_buffer *tail;	/* Active buffer */
 	struct llist_head free;		/* Free queue head */
 	atomic_t	   memory_used; /* In-use buffers excluding free list */
+	struct tty_buffer *tail;	/* Active buffer */
 };
 /*
  * When a break, frame error, or parity error happens, these codes are
-- 
1.8.1.2
