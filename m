From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 1/5] tty: Add a function to insert a string of characters with
	the same flag
Date: Wed, 17 Feb 2010 13:06:30 +0000
Message-ID: <20100217130604.16008.86393.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

The USB drivers often want to insert a series of bytes all with the same
flag set - provide a helper for this case.

Signed-off-by: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---

 drivers/char/tty_buffer.c |   12 +++++++-----
 include/linux/tty_flip.h  |    7 ++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)


diff --git a/drivers/char/tty_buffer.c b/drivers/char/tty_buffer.c
index 8402eda..af8d977 100644
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
@@ -242,18 +243,19 @@ EXPORT_SYMBOL_GPL(tty_buffer_request_room);
  *	Locking: Called functions may take tty->buf.lock
  */
 
-int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
-				size_t size)
+int tty_insert_flip_string_fixed_flag(struct tty_struct *tty,
+		const unsigned char *chars, char flag, size_t size)
 {
 	int copied = 0;
 	do {
+		int goal = min(size - copied, TTY_BUFFER_PAGE);
 		int space = tty_buffer_request_room(tty, goal);
 		struct tty_buffer *tb = tty->buf.tail;
 		/* If there is no space then tb may be NULL */
 		if (unlikely(space == 0))
 			break;
 		memcpy(tb->char_buf_ptr + tb->used, chars, space);
-		memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
+		memset(tb->flag_buf_ptr + tb->used, flag, space);
 		tb->used += space;
 		copied += space;
 		chars += space;
@@ -262,7 +264,7 @@ int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars,
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
