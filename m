From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 1/6] tty: Keep the default buffering to sub-page units
Date: Thu, 18 Feb 2010 16:43:47 +0000
Message-ID: <20100218164343.31856.8374.stgit@localhost.localdomain>
References: <20100218164104.31856.89546.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33872 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753421Ab0BRRHr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Feb 2010 12:07:47 -0500
In-Reply-To: <20100218164104.31856.89546.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

We allocate during interrupts so while our buffering is normally diced up
small anyway on some hardware at speed we can pressure the VM excessively
for page pairs. We don't really need big buffers to be linear so don't try
so hard.

In order to make this work well we will tidy up excess callers to request_room,
which cannot itself enforce this break up.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/tty_buffer.c |    6 ++++--
 include/linux/tty.h       |   10 ++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)


diff --git a/drivers/char/tty_buffer.c b/drivers/char/tty_buffer.c
index 66fa4e1..f27c4d6 100644
--- a/drivers/char/tty_buffer.c
+++ b/drivers/char/tty_buffer.c
@@ -247,7 +247,8 @@ int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
 {
 	int copied = 0;
 	do {
-		int space = tty_buffer_request_room(tty, size - copied);
+		int goal = min(size - copied, TTY_BUFFER_PAGE);
+		int space = tty_buffer_request_room(tty, goal);
 		struct tty_buffer *tb = tty->buf.tail;
 		/* If there is no space then tb may be NULL */
 		if (unlikely(space == 0))
@@ -283,7 +284,8 @@ int tty_insert_flip_string_flags(struct tty_struct *tty,
 {
 	int copied = 0;
 	do {
-		int space = tty_buffer_request_room(tty, size - copied);
+		int goal = min(size - copied, TTY_BUFFER_PAGE);
+		int space = tty_buffer_request_room(tty, goal);
 		struct tty_buffer *tb = tty->buf.tail;
 		/* If there is no space then tb may be NULL */
 		if (unlikely(space == 0))
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 6abfcf5..d96e588 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -68,6 +68,16 @@ struct tty_buffer {
 	unsigned long data[0];
 };
 
+/*
+ * We default to dicing tty buffer allocations to this many characters
+ * in order to avoid multiple page allocations. We assume tty_buffer itself
+ * is under 256 bytes. See tty_buffer_find for the allocation logic this
+ * must match
+ */
+
+#define TTY_BUFFER_PAGE		((PAGE_SIZE  - 256) / 2)
+
+
 struct tty_bufhead {
 	struct delayed_work work;
 	spinlock_t lock;

