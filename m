Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0A0C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359686AbhKZIXo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33062 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359338AbhKZIV1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1804F1FE03;
        Fri, 26 Nov 2021 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AiwwZafpgK+lZQ2/Vffdt6wjrWmatT6diHc/MH/85w=;
        b=vBUV/jmn+ZXKXX2ggROYX9FaE5PqfEZRgpqkICmuHVlmPs/QlwYF8kUpfmCZggWViGNnen
        NxHkKe9cssfCIwc9fdmrO09IF7upuxXaZBthMSrOJh7RjplSrPYA9Yy6YbNv1VIBH+Ehqd
        i/XwTavRTOLIcUKnzynGIR2swQ8404U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4AiwwZafpgK+lZQ2/Vffdt6wjrWmatT6diHc/MH/85w=;
        b=DnETIUTkkNTbE/TcIU/o+hFfADqt6axBsvDkQyxeJnFgmSvs8s5M8tMofRnUPIfZmoD6Ec
        W/DZed5zFmot5yAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2265A3B84;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 14/23] tty: reformat kernel-doc in tty_buffer.c
Date:   Fri, 26 Nov 2021 09:16:02 +0100
Message-Id: <20211126081611.11001-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Kernel-doc is a bit strict about some formatting. So fix these:
1) When there is a tab in comments, it thinks the line is a continuation
   one. So the description of the functions end up as descriptions of
   the last parameter described. Remove the tabs.

2) Remove newlines before parameters description and after the comments.
   This was not wrong per se, only inconsistent with the rest of the
   file.

3) Add periods to the end of sentences where appropriate.

4) Add "()" to function names and "%" to constants, so that they are
   properly highlighted.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_buffer.c | 251 +++++++++++++++++++--------------------
 1 file changed, 124 insertions(+), 127 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 5b6875057ce2..646510476c30 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -39,20 +39,15 @@
 #define TTY_BUFFER_PAGE	(((PAGE_SIZE - sizeof(struct tty_buffer)) / 2) & ~0xFF)
 
 /**
- *	tty_buffer_lock_exclusive	-	gain exclusive access to buffer
- *	tty_buffer_unlock_exclusive	-	release exclusive access
+ * tty_buffer_lock_exclusive	-	gain exclusive access to buffer
+ * @port: tty port owning the flip buffer
  *
- *	@port: tty port owning the flip buffer
+ * Guarantees safe use of the &tty_ldisc_ops.receive_buf() method by excluding
+ * the buffer work and any pending flush from using the flip buffer. Data can
+ * continue to be added concurrently to the flip buffer from the driver side.
  *
- *	Guarantees safe use of the line discipline's receive_buf() method by
- *	excluding the buffer work and any pending flush from using the flip
- *	buffer. Data can continue to be added concurrently to the flip buffer
- *	from the driver side.
- *
- *	On release, the buffer work is restarted if there is data in the
- *	flip buffer
+ * See also tty_buffer_unlock_exclusive().
  */
-
 void tty_buffer_lock_exclusive(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -62,6 +57,14 @@ void tty_buffer_lock_exclusive(struct tty_port *port)
 }
 EXPORT_SYMBOL_GPL(tty_buffer_lock_exclusive);
 
+/**
+ * tty_buffer_unlock_exclusive	-	release exclusive access
+ * @port: tty port owning the flip buffer
+ *
+ * The buffer work is restarted if there is data in the flip buffer.
+ *
+ * See also tty_buffer_lock_exclusive().
+ */
 void tty_buffer_unlock_exclusive(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -77,17 +80,16 @@ void tty_buffer_unlock_exclusive(struct tty_port *port)
 EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
 /**
- *	tty_buffer_space_avail	-	return unused buffer space
- *	@port: tty port owning the flip buffer
+ * tty_buffer_space_avail	-	return unused buffer space
+ * @port: tty port owning the flip buffer
  *
- *	Returns the # of bytes which can be written by the driver without
- *	reaching the buffer limit.
+ * Returns: the # of bytes which can be written by the driver without reaching
+ * the buffer limit.
  *
- *	Note: this does not guarantee that memory is available to write
- *	the returned # of bytes (use tty_prepare_flip_string_xxx() to
- *	pre-allocate if memory guarantee is required).
+ * Note: this does not guarantee that memory is available to write the returned
+ * # of bytes (use tty_prepare_flip_string() to pre-allocate if memory
+ * guarantee is required).
  */
-
 unsigned int tty_buffer_space_avail(struct tty_port *port)
 {
 	int space = port->buf.mem_limit - atomic_read(&port->buf.mem_used);
@@ -107,13 +109,12 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 }
 
 /**
- *	tty_buffer_free_all		-	free buffers used by a tty
- *	@port: tty port to free from
+ * tty_buffer_free_all		-	free buffers used by a tty
+ * @port: tty port to free from
  *
- *	Remove all the buffers pending on a tty whether queued with data
- *	or in the free ring. Must be called when the tty is no longer in use
+ * Remove all the buffers pending on a tty whether queued with data or in the
+ * free ring. Must be called when the tty is no longer in use.
  */
-
 void tty_buffer_free_all(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -142,17 +143,17 @@ void tty_buffer_free_all(struct tty_port *port)
 }
 
 /**
- *	tty_buffer_alloc	-	allocate a tty buffer
- *	@port: tty port
- *	@size: desired size (characters)
- *
- *	Allocate a new tty buffer to hold the desired number of characters.
- *	We round our buffers off in 256 character chunks to get better
- *	allocation behaviour.
- *	Return NULL if out of memory or the allocation would exceed the
- *	per device queue
+ * tty_buffer_alloc	-	allocate a tty buffer
+ * @port: tty port
+ * @size: desired size (characters)
+ *
+ * Allocate a new tty buffer to hold the desired number of characters. We
+ * round our buffers off in 256 character chunks to get better allocation
+ * behaviour.
+ *
+ * Returns: %NULL if out of memory or the allocation would exceed the per
+ * device queue.
  */
-
 static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 {
 	struct llist_node *free;
@@ -185,14 +186,13 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 }
 
 /**
- *	tty_buffer_free		-	free a tty buffer
- *	@port: tty port owning the buffer
- *	@b: the buffer to free
+ * tty_buffer_free		-	free a tty buffer
+ * @port: tty port owning the buffer
+ * @b: the buffer to free
  *
- *	Free a tty buffer, or add it to the free list according to our
- *	internal strategy
+ * Free a tty buffer, or add it to the free list according to our internal
+ * strategy.
  */
-
 static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -207,17 +207,15 @@ static void tty_buffer_free(struct tty_port *port, struct tty_buffer *b)
 }
 
 /**
- *	tty_buffer_flush		-	flush full tty buffers
- *	@tty: tty to flush
- *	@ld:  optional ldisc ptr (must be referenced)
+ * tty_buffer_flush		-	flush full tty buffers
+ * @tty: tty to flush
+ * @ld: optional ldisc ptr (must be referenced)
  *
- *	flush all the buffers containing receive data. If ld != NULL,
- *	flush the ldisc input buffer.
+ * Flush all the buffers containing receive data. If @ld != %NULL, flush the
+ * ldisc input buffer.
  *
- *	Locking: takes buffer lock to ensure single-threaded flip buffer
- *		 'consumer'
+ * Locking: takes buffer lock to ensure single-threaded flip buffer 'consumer'.
  */
-
 void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	struct tty_port *port = tty->port;
@@ -244,17 +242,18 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 }
 
 /**
- *	__tty_buffer_request_room		-	grow tty buffer if needed
- *	@port: tty port
- *	@size: size desired
- *	@flags: buffer flags if new buffer allocated (default = 0)
+ * __tty_buffer_request_room	-	grow tty buffer if needed
+ * @port: tty port
+ * @size: size desired
+ * @flags: buffer flags if new buffer allocated (default = 0)
+ *
+ * Make at least @size bytes of linear space available for the tty buffer.
  *
- *	Make at least size bytes of linear space available for the tty
- *	buffer. If we fail return the size we managed to find.
+ * Will change over to a new buffer if the current buffer is encoded as
+ * %TTY_NORMAL (so has no flags buffer) and the new buffer requires a flags
+ * buffer.
  *
- *	Will change over to a new buffer if the current buffer is encoded as
- *	TTY_NORMAL (so has no flags buffer) and the new buffer requires
- *	a flags buffer.
+ * Returns: the size we managed to find.
  */
 static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 				     int flags)
@@ -300,16 +299,17 @@ int tty_buffer_request_room(struct tty_port *port, size_t size)
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
 
 /**
- *	tty_insert_flip_string_fixed_flag - Add characters to the tty buffer
- *	@port: tty port
- *	@chars: characters
- *	@flag: flag value for each character
- *	@size: size
- *
- *	Queue a series of bytes to the tty buffering. All the characters
- *	passed are marked with the supplied flag. Returns the number added.
+ * tty_insert_flip_string_fixed_flag - add characters to the tty buffer
+ * @port: tty port
+ * @chars: characters
+ * @flag: flag value for each character
+ * @size: size
+ *
+ * Queue a series of bytes to the tty buffering. All the characters passed are
+ * marked with the supplied flag.
+ *
+ * Returns: the number added.
  */
-
 int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 		const unsigned char *chars, char flag, size_t size)
 {
@@ -338,17 +338,17 @@ int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 EXPORT_SYMBOL(tty_insert_flip_string_fixed_flag);
 
 /**
- *	tty_insert_flip_string_flags	-	Add characters to the tty buffer
- *	@port: tty port
- *	@chars: characters
- *	@flags: flag bytes
- *	@size: size
- *
- *	Queue a series of bytes to the tty buffering. For each character
- *	the flags array indicates the status of the character. Returns the
- *	number added.
+ * tty_insert_flip_string_flags	-	add characters to the tty buffer
+ * @port: tty port
+ * @chars: characters
+ * @flags: flag bytes
+ * @size: size
+ *
+ * Queue a series of bytes to the tty buffering. For each character the flags
+ * array indicates the status of the character.
+ *
+ * Returns: the number added.
  */
-
 int tty_insert_flip_string_flags(struct tty_port *port,
 		const unsigned char *chars, const char *flags, size_t size)
 {
@@ -376,13 +376,13 @@ int tty_insert_flip_string_flags(struct tty_port *port,
 EXPORT_SYMBOL(tty_insert_flip_string_flags);
 
 /**
- *	__tty_insert_flip_char   -	Add one character to the tty buffer
- *	@port: tty port
- *	@ch: character
- *	@flag: flag byte
+ * __tty_insert_flip_char   -	add one character to the tty buffer
+ * @port: tty port
+ * @ch: character
+ * @flag: flag byte
  *
- *	Queue a single byte to the tty buffering, with an optional flag.
- *	This is the slow path of tty_insert_flip_char.
+ * Queue a single byte @ch to the tty buffering, with an optional flag. This is
+ * the slow path of tty_insert_flip_char().
  */
 int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
 {
@@ -402,18 +402,19 @@ int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
 EXPORT_SYMBOL(__tty_insert_flip_char);
 
 /**
- *	tty_prepare_flip_string		-	make room for characters
- *	@port: tty port
- *	@chars: return pointer for character write area
- *	@size: desired size
- *
- *	Prepare a block of space in the buffer for data. Returns the length
- *	available and buffer pointer to the space which is now allocated and
- *	accounted for as ready for normal characters. This is used for drivers
- *	that need their own block copy routines into the buffer. There is no
- *	guarantee the buffer is a DMA target!
+ * tty_prepare_flip_string	-	make room for characters
+ * @port: tty port
+ * @chars: return pointer for character write area
+ * @size: desired size
+ *
+ * Prepare a block of space in the buffer for data.
+ *
+ * This is used for drivers that need their own block copy routines into the
+ * buffer. There is no guarantee the buffer is a DMA target!
+ *
+ * Returns: the length available and buffer pointer (@chars) to the space which
+ * is now allocated and accounted for as ready for normal characters.
  */
-
 int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 		size_t size)
 {
@@ -432,16 +433,16 @@ int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
 
 /**
- *	tty_ldisc_receive_buf		-	forward data to line discipline
- *	@ld:	line discipline to process input
- *	@p:	char buffer
- *	@f:	TTY_* flags buffer
- *	@count:	number of bytes to process
+ * tty_ldisc_receive_buf	-	forward data to line discipline
+ * @ld: line discipline to process input
+ * @p: char buffer
+ * @f: %TTY_NORMAL, %TTY_BREAK, etc. flags buffer
+ * @count: number of bytes to process
  *
- *	Callers other than flush_to_ldisc() need to exclude the kworker
- *	from concurrent use of the line discipline, see paste_selection().
+ * Callers other than flush_to_ldisc() need to exclude the kworker from
+ * concurrent use of the line discipline, see paste_selection().
  *
- *	Returns the number of bytes processed
+ * Returns: the number of bytes processed.
  */
 int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 			  const char *f, int count)
@@ -474,18 +475,16 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 }
 
 /**
- *	flush_to_ldisc
- *	@work: tty structure passed from work queue.
+ * flush_to_ldisc		-	flush data from buffer to ldisc
+ * @work: tty structure passed from work queue.
  *
- *	This routine is called out of the software interrupt to flush data
- *	from the buffer chain to the line discipline.
+ * This routine is called out of the software interrupt to flush data from the
+ * buffer chain to the line discipline.
  *
- *	The receive_buf method is single threaded for each tty instance.
+ * The receive_buf() method is single threaded for each tty instance.
  *
- *	Locking: takes buffer lock to ensure single-threaded flip buffer
- *		 'consumer'
+ * Locking: takes buffer lock to ensure single-threaded flip buffer 'consumer'.
  */
-
 static void flush_to_ldisc(struct work_struct *work)
 {
 	struct tty_port *port = container_of(work, struct tty_port, buf.work);
@@ -533,16 +532,15 @@ static void flush_to_ldisc(struct work_struct *work)
 }
 
 /**
- *	tty_flip_buffer_push	-	terminal
- *	@port: tty port to push
+ * tty_flip_buffer_push		-	push terminal buffers
+ * @port: tty port to push
  *
- *	Queue a push of the terminal flip buffers to the line discipline.
- *	Can be called from IRQ/atomic context.
+ * Queue a push of the terminal flip buffers to the line discipline. Can be
+ * called from IRQ/atomic context.
  *
- *	In the event of the queue being busy for flipping the work will be
- *	held off and retried later.
+ * In the event of the queue being busy for flipping the work will be held off
+ * and retried later.
  */
-
 void tty_flip_buffer_push(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -557,13 +555,12 @@ void tty_flip_buffer_push(struct tty_port *port)
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
 /**
- *	tty_buffer_init		-	prepare a tty buffer structure
- *	@port: tty port to initialise
+ * tty_buffer_init		-	prepare a tty buffer structure
+ * @port: tty port to initialise
  *
- *	Set up the initial state of the buffer management for a tty device.
- *	Must be called before the other tty buffer functions are used.
+ * Set up the initial state of the buffer management for a tty device. Must be
+ * called before the other tty buffer functions are used.
  */
-
 void tty_buffer_init(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
@@ -580,14 +577,14 @@ void tty_buffer_init(struct tty_port *port)
 }
 
 /**
- *	tty_buffer_set_limit	-	change the tty buffer memory limit
- *	@port: tty port to change
- *	@limit: memory limit to set
+ * tty_buffer_set_limit		-	change the tty buffer memory limit
+ * @port: tty port to change
+ * @limit: memory limit to set
+ *
+ * Change the tty buffer memory limit.
  *
- *	Change the tty buffer memory limit.
- *	Must be called before the other tty buffer functions are used.
+ * Must be called before the other tty buffer functions are used.
  */
-
 int tty_buffer_set_limit(struct tty_port *port, int limit)
 {
 	if (limit < MIN_TTYB_SIZE)
-- 
2.34.0

