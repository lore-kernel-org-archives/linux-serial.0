From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 2/6] tty: Add a function to insert a string of characters with
	the same flag
Date: Thu, 18 Feb 2010 16:43:54 +0000
Message-ID: <20100218164353.31856.92168.stgit@localhost.localdomain>
References: <20100218164104.31856.89546.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33876 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758009Ab0BRRHx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Feb 2010 12:07:53 -0500
In-Reply-To: <20100218164104.31856.89546.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

The USB drivers often want to insert a series of bytes all with the same
flag set - provide a helper for this case.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/tty_buffer.c |   11 ++++++-----
 include/linux/tty_flip.h  |    7 ++++++-
 2 files changed, 12 insertions(+), 6 deletions(-)


diff --git a/drivers/char/tty_buffer.c b/drivers/char/tty_buffer.c
index f27c4d6..af8d977 100644
--- a/drivers/char/tty_buffer.c
+++ b/drivers/char/tty_buffer.c
@@ -231,9 +231,10 @@ int tty_buffer_request_room(struct tty_struct *tty, size_t size)
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
 
 /**
- *	tty_insert_flip_string	-	Add characters to the tty buffer
+ *	tty_insert_flip_string_fixed_flag - Add characters to the tty buffer
  *	@tty: tty structure
  *	@chars: characters
+ *	@flag: flag value for each character
  *	@size: size
  *
  *	Queue a series of bytes to the tty buffering. All the characters
@@ -242,8 +243,8 @@ EXPORT_SYMBOL_GPL(tty_buffer_request_room);
  *	Locking: Called functions may take tty->buf.lock
  */
 
-int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
-				size_t size)
+int tty_insert_flip_string_fixed_flag(struct tty_struct *tty,
+		const unsigned char *chars, char flag, size_t size)
 {
 	int copied = 0;
 	do {
@@ -254,7 +255,7 @@ int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
 		if (unlikely(space == 0))
 			break;
 		memcpy(tb->char_buf_ptr + tb->used, chars, space);
-		memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
+		memset(tb->flag_buf_ptr + tb->used, flag, space);
 		tb->used += space;
 		copied += space;
 		chars += space;
@@ -263,7 +264,7 @@ int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
 	} while (unlikely(size > copied));
 	return copied;
 }
-EXPORT_SYMBOL(tty_insert_flip_string);
+EXPORT_SYMBOL(tty_insert_flip_string_fixed_flag);
 
 /**
  *	tty_insert_flip_string_flags	-	Add characters to the tty buffer
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index eb677cf..9239d03 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -2,8 +2,8 @@
 #define _LINUX_TTY_FLIP_H
 
 extern int tty_buffer_request_room(struct tty_struct *tty, size_t size);
-extern int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars, size_t size);
 extern int tty_insert_flip_string_flags(struct tty_struct *tty, const unsigned char *chars, const char *flags, size_t size);
+extern int tty_insert_flip_string_fixed_flag(struct tty_struct *tty, const unsigned char *chars, char flag, size_t size);
 extern int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars, size_t size);
 extern int tty_prepare_flip_string_flags(struct tty_struct *tty, unsigned char **chars, char **flags, size_t size);
 void tty_schedule_flip(struct tty_struct *tty);
@@ -20,4 +20,9 @@ static inline int tty_insert_flip_char(struct tty_struct *tty,
 	return tty_insert_flip_string_flags(tty, &ch, &flag, 1);
 }
 
+static inline int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars, size_t size)
+{
+	return tty_insert_flip_string_fixed_flag(tty, chars, TTY_NORMAL, size);
+}
+
 #endif /* _LINUX_TTY_FLIP_H */

