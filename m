Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51139C433FE
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359400AbhKZIXe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50586 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359335AbhKZIV1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 98C6921B47;
        Fri, 26 Nov 2021 08:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ol2+pDhVwPGBw0SMtw3vPSaiWmFBfA0wG/MYHsaDc9k=;
        b=ynwYzuiE6JmHOYVerJc2RB/aGXVSQw6Zb+taphmL5BRvsQHvzMQekIaGtPyVishfJW7rNs
        2G3yCbE47oBia7pTHLmEITgTqFQlk0PiKbLncPnHRK52pGKmK/dI2ivkfPE6ybX8nvuVHa
        M2oyP3Ef16uu7WpoEqdu15zWYMCaKJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914575;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ol2+pDhVwPGBw0SMtw3vPSaiWmFBfA0wG/MYHsaDc9k=;
        b=3BjwRVkS0UqRHEMkKG90dFUz6eQrAmjBHMnl8XvkmLVfZ/kZ73xNfErqZVdRqdh9smD44c
        vQf29NeGrR8205Ag==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 61A90A3B83;
        Fri, 26 Nov 2021 08:16:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/23] tty: reformat kernel-doc in n_tty.c
Date:   Fri, 26 Nov 2021 09:16:04 +0100
Message-Id: <20211126081611.11001-17-jslaby@suse.cz>
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
 drivers/tty/n_tty.c | 671 +++++++++++++++++++++-----------------------
 1 file changed, 316 insertions(+), 355 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 538bd968a23d..8933ef1f83c0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -186,17 +186,16 @@ static void tty_copy(struct tty_struct *tty, void *to, size_t tail, size_t n)
 }
 
 /**
- *	n_tty_kick_worker - start input worker (if required)
- *	@tty: terminal
+ * n_tty_kick_worker - start input worker (if required)
+ * @tty: terminal
  *
- *	Re-schedules the flip buffer work if it may have stopped
+ * Re-schedules the flip buffer work if it may have stopped.
  *
- *	Caller holds exclusive termios_rwsem
- *	   or
- *	n_tty_read()/consumer path:
- *		holds non-exclusive termios_rwsem
+ * Locking:
+ *  * Caller holds exclusive %termios_rwsem, or
+ *  * n_tty_read()/consumer path:
+ *	holds non-exclusive %termios_rwsem
  */
-
 static void n_tty_kick_worker(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -230,14 +229,12 @@ static ssize_t chars_in_buffer(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_write_wakeup	-	asynchronous I/O notifier
- *	@tty: tty device
+ * n_tty_write_wakeup	-	asynchronous I/O notifier
+ * @tty: tty device
  *
- *	Required for the ptys, serial driver etc. since processes
- *	that attach themselves to the master and rely on ASYNC
- *	IO must be woken up
+ * Required for the ptys, serial driver etc. since processes that attach
+ * themselves to the master and rely on ASYNC IO must be woken up.
  */
-
 static void n_tty_write_wakeup(struct tty_struct *tty)
 {
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -300,16 +297,16 @@ static void n_tty_check_unthrottle(struct tty_struct *tty)
 }
 
 /**
- *	put_tty_queue		-	add character to tty
- *	@c: character
- *	@ldata: n_tty data
+ * put_tty_queue		-	add character to tty
+ * @c: character
+ * @ldata: n_tty data
  *
- *	Add a character to the tty read_buf queue.
+ * Add a character to the tty read_buf queue.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
+ * Locking:
+ *  * n_tty_receive_buf()/producer path:
+ *	caller holds non-exclusive %termios_rwsem
  */
-
 static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
 {
 	*read_buf_addr(ldata, ldata->read_head) = c;
@@ -317,16 +314,16 @@ static inline void put_tty_queue(unsigned char c, struct n_tty_data *ldata)
 }
 
 /**
- *	reset_buffer_flags	-	reset buffer state
- *	@ldata: line disc data to reset
+ * reset_buffer_flags	-	reset buffer state
+ * @ldata: line disc data to reset
  *
- *	Reset the read buffer counters and clear the flags.
- *	Called from n_tty_open() and n_tty_flush_buffer().
+ * Reset the read buffer counters and clear the flags. Called from
+ * n_tty_open() and n_tty_flush_buffer().
  *
- *	Locking: caller holds exclusive termios_rwsem
- *		 (or locking is not required)
+ * Locking:
+ *  * caller holds exclusive %termios_rwsem, or
+ *  * (locking is not required)
  */
-
 static void reset_buffer_flags(struct n_tty_data *ldata)
 {
 	ldata->read_head = ldata->canon_head = ldata->read_tail = 0;
@@ -351,19 +348,18 @@ static void n_tty_packet_mode_flush(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_flush_buffer	-	clean input queue
- *	@tty:	terminal device
+ * n_tty_flush_buffer	-	clean input queue
+ * @tty: terminal device
  *
- *	Flush the input buffer. Called when the tty layer wants the
- *	buffer flushed (eg at hangup) or when the N_TTY line discipline
- *	internally has to clean the pending queue (for example some signals).
+ * Flush the input buffer. Called when the tty layer wants the buffer flushed
+ * (eg at hangup) or when the %N_TTY line discipline internally has to clean
+ * the pending queue (for example some signals).
  *
- *	Holds termios_rwsem to exclude producer/consumer while
- *	buffer indices are reset.
+ * Holds %termios_rwsem to exclude producer/consumer while buffer indices are
+ * reset.
  *
- *	Locking: ctrl.lock, exclusive termios_rwsem
+ * Locking: %ctrl.lock, exclusive %termios_rwsem
  */
-
 static void n_tty_flush_buffer(struct tty_struct *tty)
 {
 	down_write(&tty->termios_rwsem);
@@ -376,55 +372,50 @@ static void n_tty_flush_buffer(struct tty_struct *tty)
 }
 
 /**
- *	is_utf8_continuation	-	utf8 multibyte check
- *	@c: byte to check
+ * is_utf8_continuation	-	utf8 multibyte check
+ * @c: byte to check
  *
- *	Returns true if the utf8 character 'c' is a multibyte continuation
- *	character. We use this to correctly compute the on screen size
- *	of the character when printing
+ * Returns: true if the utf8 character @c is a multibyte continuation
+ * character. We use this to correctly compute the on-screen size of the
+ * character when printing.
  */
-
 static inline int is_utf8_continuation(unsigned char c)
 {
 	return (c & 0xc0) == 0x80;
 }
 
 /**
- *	is_continuation		-	multibyte check
- *	@c: byte to check
- *	@tty: terminal device
+ * is_continuation	-	multibyte check
+ * @c: byte to check
+ * @tty: terminal device
  *
- *	Returns true if the utf8 character 'c' is a multibyte continuation
- *	character and the terminal is in unicode mode.
+ * Returns: true if the utf8 character @c is a multibyte continuation character
+ * and the terminal is in unicode mode.
  */
-
 static inline int is_continuation(unsigned char c, struct tty_struct *tty)
 {
 	return I_IUTF8(tty) && is_utf8_continuation(c);
 }
 
 /**
- *	do_output_char			-	output one character
- *	@c: character (or partial unicode symbol)
- *	@tty: terminal device
- *	@space: space available in tty driver write buffer
+ * do_output_char	-	output one character
+ * @c: character (or partial unicode symbol)
+ * @tty: terminal device
+ * @space: space available in tty driver write buffer
  *
- *	This is a helper function that handles one output character
- *	(including special characters like TAB, CR, LF, etc.),
- *	doing OPOST processing and putting the results in the
- *	tty driver's write buffer.
+ * This is a helper function that handles one output character (including
+ * special characters like TAB, CR, LF, etc.), doing OPOST processing and
+ * putting the results in the tty driver's write buffer.
  *
- *	Note that Linux currently ignores TABDLY, CRDLY, VTDLY, FFDLY
- *	and NLDLY.  They simply aren't relevant in the world today.
- *	If you ever need them, add them here.
+ * Note that Linux currently ignores TABDLY, CRDLY, VTDLY, FFDLY and NLDLY.
+ * They simply aren't relevant in the world today. If you ever need them, add
+ * them here.
  *
- *	Returns the number of bytes of buffer space used or -1 if
- *	no space left.
+ * Returns: the number of bytes of buffer space used or -1 if no space left.
  *
- *	Locking: should be called under the output_lock to protect
- *		 the column state and space left in the buffer
+ * Locking: should be called under the %output_lock to protect the column state
+ * and space left in the buffer.
  */
-
 static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -487,19 +478,18 @@ static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 }
 
 /**
- *	process_output			-	output post processor
- *	@c: character (or partial unicode symbol)
- *	@tty: terminal device
+ * process_output	-	output post processor
+ * @c: character (or partial unicode symbol)
+ * @tty: terminal device
+ *
+ * Output one character with OPOST processing.
  *
- *	Output one character with OPOST processing.
- *	Returns -1 when the output device is full and the character
- *	must be retried.
+ * Returns: -1 when the output device is full and the character must be
+ * retried.
  *
- *	Locking: output_lock to protect column state and space left
- *		 (also, this is called from n_tty_write under the
- *		  tty layer write lock)
+ * Locking: %output_lock to protect column state and space left (also, this is
+ *called from n_tty_write() under the tty layer write lock).
  */
-
 static int process_output(unsigned char c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -518,24 +508,23 @@ static int process_output(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	process_output_block		-	block post processor
- *	@tty: terminal device
- *	@buf: character buffer
- *	@nr: number of bytes to output
- *
- *	Output a block of characters with OPOST processing.
- *	Returns the number of characters output.
- *
- *	This path is used to speed up block console writes, among other
- *	things when processing blocks of output data. It handles only
- *	the simple cases normally found and helps to generate blocks of
- *	symbols for the console driver and thus improve performance.
- *
- *	Locking: output_lock to protect column state and space left
- *		 (also, this is called from n_tty_write under the
- *		  tty layer write lock)
+ * process_output_block	-	block post processor
+ * @tty: terminal device
+ * @buf: character buffer
+ * @nr: number of bytes to output
+ *
+ * Output a block of characters with OPOST processing.
+ *
+ * This path is used to speed up block console writes, among other things when
+ * processing blocks of output data. It handles only the simple cases normally
+ * found and helps to generate blocks of symbols for the console driver and
+ * thus improve performance.
+ *
+ * Returns: the number of characters output.
+ *
+ * Locking: %output_lock to protect column state and space left (also, this is
+ * called from n_tty_write() under the tty layer write lock).
  */
-
 static ssize_t process_output_block(struct tty_struct *tty,
 				    const unsigned char *buf, unsigned int nr)
 {
@@ -596,28 +585,26 @@ static ssize_t process_output_block(struct tty_struct *tty,
 }
 
 /**
- *	__process_echoes	-	write pending echo characters
- *	@tty: terminal device
+ * __process_echoes	-	write pending echo characters
+ * @tty: terminal device
  *
- *	Write previously buffered echo (and other ldisc-generated)
- *	characters to the tty.
+ * Write previously buffered echo (and other ldisc-generated) characters to the
+ * tty.
  *
- *	Characters generated by the ldisc (including echoes) need to
- *	be buffered because the driver's write buffer can fill during
- *	heavy program output.  Echoing straight to the driver will
- *	often fail under these conditions, causing lost characters and
- *	resulting mismatches of ldisc state information.
+ * Characters generated by the ldisc (including echoes) need to be buffered
+ * because the driver's write buffer can fill during heavy program output.
+ * Echoing straight to the driver will often fail under these conditions,
+ * causing lost characters and resulting mismatches of ldisc state information.
  *
- *	Since the ldisc state must represent the characters actually sent
- *	to the driver at the time of the write, operations like certain
- *	changes in column state are also saved in the buffer and executed
- *	here.
+ * Since the ldisc state must represent the characters actually sent to the
+ * driver at the time of the write, operations like certain changes in column
+ * state are also saved in the buffer and executed here.
  *
- *	A circular fifo buffer is used so that the most recent characters
- *	are prioritized.  Also, when control characters are echoed with a
- *	prefixed "^", the pair is treated atomically and thus not separated.
+ * A circular fifo buffer is used so that the most recent characters are
+ * prioritized. Also, when control characters are echoed with a prefixed "^",
+ * the pair is treated atomically and thus not separated.
  *
- *	Locking: callers must hold output_lock
+ * Locking: callers must hold %output_lock.
  */
 static size_t __process_echoes(struct tty_struct *tty)
 {
@@ -827,13 +814,12 @@ static void flush_echoes(struct tty_struct *tty)
 }
 
 /**
- *	add_echo_byte	-	add a byte to the echo buffer
- *	@c: unicode byte to echo
- *	@ldata: n_tty data
+ * add_echo_byte	-	add a byte to the echo buffer
+ * @c: unicode byte to echo
+ * @ldata: n_tty data
  *
- *	Add a character or operation byte to the echo buffer.
+ * Add a character or operation byte to the echo buffer.
  */
-
 static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
 {
 	*echo_buf_addr(ldata, ldata->echo_head) = c;
@@ -842,12 +828,11 @@ static inline void add_echo_byte(unsigned char c, struct n_tty_data *ldata)
 }
 
 /**
- *	echo_move_back_col	-	add operation to move back a column
- *	@ldata: n_tty data
+ * echo_move_back_col	-	add operation to move back a column
+ * @ldata: n_tty data
  *
- *	Add an operation to the echo buffer to move back one column.
+ * Add an operation to the echo buffer to move back one column.
  */
-
 static void echo_move_back_col(struct n_tty_data *ldata)
 {
 	add_echo_byte(ECHO_OP_START, ldata);
@@ -855,13 +840,12 @@ static void echo_move_back_col(struct n_tty_data *ldata)
 }
 
 /**
- *	echo_set_canon_col	-	add operation to set the canon column
- *	@ldata: n_tty data
+ * echo_set_canon_col	-	add operation to set the canon column
+ * @ldata: n_tty data
  *
- *	Add an operation to the echo buffer to set the canon column
- *	to the current column.
+ * Add an operation to the echo buffer to set the canon column to the current
+ * column.
  */
-
 static void echo_set_canon_col(struct n_tty_data *ldata)
 {
 	add_echo_byte(ECHO_OP_START, ldata);
@@ -869,20 +853,18 @@ static void echo_set_canon_col(struct n_tty_data *ldata)
 }
 
 /**
- *	echo_erase_tab	-	add operation to erase a tab
- *	@num_chars: number of character columns already used
- *	@after_tab: true if num_chars starts after a previous tab
- *	@ldata: n_tty data
- *
- *	Add an operation to the echo buffer to erase a tab.
- *
- *	Called by the eraser function, which knows how many character
- *	columns have been used since either a previous tab or the start
- *	of input.  This information will be used later, along with
- *	canon column (if applicable), to go back the correct number
- *	of columns.
+ * echo_erase_tab	-	add operation to erase a tab
+ * @num_chars: number of character columns already used
+ * @after_tab: true if num_chars starts after a previous tab
+ * @ldata: n_tty data
+ *
+ * Add an operation to the echo buffer to erase a tab.
+ *
+ * Called by the eraser function, which knows how many character columns have
+ * been used since either a previous tab or the start of input. This
+ * information will be used later, along with canon column (if applicable), to
+ * go back the correct number of columns.
  */
-
 static void echo_erase_tab(unsigned int num_chars, int after_tab,
 			   struct n_tty_data *ldata)
 {
@@ -900,16 +882,15 @@ static void echo_erase_tab(unsigned int num_chars, int after_tab,
 }
 
 /**
- *	echo_char_raw	-	echo a character raw
- *	@c: unicode byte to echo
- *	@ldata: line disc data
+ * echo_char_raw	-	echo a character raw
+ * @c: unicode byte to echo
+ * @ldata: line disc data
  *
- *	Echo user input back onto the screen. This must be called only when
- *	L_ECHO(tty) is true. Called from the driver receive_buf path.
+ * Echo user input back onto the screen. This must be called only when
+ * L_ECHO(tty) is true. Called from the &tty_driver.receive_buf() path.
  *
- *	This variant does not treat control characters specially.
+ * This variant does not treat control characters specially.
  */
-
 static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
 {
 	if (c == ECHO_OP_START) {
@@ -921,17 +902,16 @@ static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
 }
 
 /**
- *	echo_char	-	echo a character
- *	@c: unicode byte to echo
- *	@tty: terminal device
+ * echo_char		-	echo a character
+ * @c: unicode byte to echo
+ * @tty: terminal device
  *
- *	Echo user input back onto the screen. This must be called only when
- *	L_ECHO(tty) is true. Called from the driver receive_buf path.
+ * Echo user input back onto the screen. This must be called only when
+ * L_ECHO(tty) is true. Called from the &tty_driver.receive_buf() path.
  *
- *	This variant tags control characters to be echoed as "^X"
- *	(where X is the letter representing the control char).
+ * This variant tags control characters to be echoed as "^X" (where X is the
+ * letter representing the control char).
  */
-
 static void echo_char(unsigned char c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -947,10 +927,9 @@ static void echo_char(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	finish_erasing		-	complete erase
- *	@ldata: n_tty data
+ * finish_erasing	-	complete erase
+ * @ldata: n_tty data
  */
-
 static inline void finish_erasing(struct n_tty_data *ldata)
 {
 	if (ldata->erasing) {
@@ -960,18 +939,17 @@ static inline void finish_erasing(struct n_tty_data *ldata)
 }
 
 /**
- *	eraser		-	handle erase function
- *	@c: character input
- *	@tty: terminal device
+ * eraser		-	handle erase function
+ * @c: character input
+ * @tty: terminal device
  *
- *	Perform erase and necessary output when an erase character is
- *	present in the stream from the driver layer. Handles the complexities
- *	of UTF-8 multibyte symbols.
+ * Perform erase and necessary output when an erase character is present in the
+ * stream from the driver layer. Handles the complexities of UTF-8 multibyte
+ * symbols.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
+ * Locking: n_tty_receive_buf()/producer path:
+ *	caller holds non-exclusive %termios_rwsem
  */
-
 static void eraser(unsigned char c, struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1101,18 +1079,18 @@ static void __isig(int sig, struct tty_struct *tty)
 }
 
 /**
- *	isig		-	handle the ISIG optio
- *	@sig: signal
- *	@tty: terminal
+ * isig			-	handle the ISIG optio
+ * @sig: signal
+ * @tty: terminal
  *
- *	Called when a signal is being sent due to terminal input.
- *	Called from the driver receive_buf path so serialized.
+ * Called when a signal is being sent due to terminal input. Called from the
+ * &tty_driver.receive_buf() path, so serialized.
  *
- *	Performs input and output flush if !NOFLSH. In this context, the echo
- *	buffer is 'output'. The signal is processed first to alert any current
- *	readers or writers to discontinue and exit their i/o loops.
+ * Performs input and output flush if !NOFLSH. In this context, the echo
+ * buffer is 'output'. The signal is processed first to alert any current
+ * readers or writers to discontinue and exit their i/o loops.
  *
- *	Locking: ctrl.lock
+ * Locking: %ctrl.lock
  */
 static void isig(int sig, struct tty_struct *tty)
 {
@@ -1150,18 +1128,17 @@ static void isig(int sig, struct tty_struct *tty)
 }
 
 /**
- *	n_tty_receive_break	-	handle break
- *	@tty: terminal
+ * n_tty_receive_break	-	handle break
+ * @tty: terminal
  *
- *	An RS232 break event has been hit in the incoming bitstream. This
- *	can cause a variety of events depending upon the termios settings.
+ * An RS232 break event has been hit in the incoming bitstream. This can cause
+ * a variety of events depending upon the termios settings.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
+ * Locking: n_tty_receive_buf()/producer path:
+ *	caller holds non-exclusive termios_rwsem
  *
- *	Note: may get exclusive termios_rwsem if flushing input buffer
+ * Note: may get exclusive %termios_rwsem if flushing input buffer
  */
-
 static void n_tty_receive_break(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1180,18 +1157,15 @@ static void n_tty_receive_break(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_receive_overrun	-	handle overrun reporting
- *	@tty: terminal
+ * n_tty_receive_overrun	-	handle overrun reporting
+ * @tty: terminal
  *
- *	Data arrived faster than we could process it. While the tty
- *	driver has flagged this the bits that were missed are gone
- *	forever.
+ * Data arrived faster than we could process it. While the tty driver has
+ * flagged this the bits that were missed are gone forever.
  *
- *	Called from the receive_buf path so single threaded. Does not
- *	need locking as num_overrun and overrun_time are function
- *	private.
+ * Called from the receive_buf path so single threaded. Does not need locking
+ * as num_overrun and overrun_time are function private.
  */
-
 static void n_tty_receive_overrun(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1206,15 +1180,15 @@ static void n_tty_receive_overrun(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_receive_parity_error	-	error notifier
- *	@tty: terminal device
- *	@c: character
+ * n_tty_receive_parity_error	-	error notifier
+ * @tty: terminal device
+ * @c: character
  *
- *	Process a parity error and queue the right data to indicate
- *	the error case if necessary.
+ * Process a parity error and queue the right data to indicate the error case
+ * if necessary.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
+ * Locking: n_tty_receive_buf()/producer path:
+ * 	caller holds non-exclusive %termios_rwsem
  */
 static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
 {
@@ -1381,17 +1355,16 @@ static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 }
 
 /**
- *	n_tty_receive_char	-	perform processing
- *	@tty: terminal device
- *	@c: character
+ * n_tty_receive_char	-	perform processing
+ * @tty: terminal device
+ * @c: character
  *
- *	Process an individual character of input received from the driver.
- *	This is serialized with respect to itself by the rules for the
- *	driver above.
+ * Process an individual character of input received from the driver.  This is
+ * serialized with respect to itself by the rules for the driver above.
  *
- *	n_tty_receive_buf()/producer path:
- *		caller holds non-exclusive termios_rwsem
- *		publishes canon_head if canonical mode is active
+ * Locking: n_tty_receive_buf()/producer path:
+ *	caller holds non-exclusive %termios_rwsem
+ *	publishes canon_head if canonical mode is active
  */
 static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
@@ -1593,38 +1566,37 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 }
 
 /**
- *	n_tty_receive_buf_common	-	process input
- *	@tty: device to receive input
- *	@cp: input chars
- *	@fp: flags for each char (if NULL, all chars are TTY_NORMAL)
- *	@count: number of input chars in @cp
- *	@flow: enable flow control
- *
- *	Called by the terminal driver when a block of characters has
- *	been received. This function must be called from soft contexts
- *	not from interrupt context. The driver is responsible for making
- *	calls one at a time and in order (or using flush_to_ldisc)
- *
- *	Returns the # of input chars from @cp which were processed.
- *
- *	In canonical mode, the maximum line length is 4096 chars (including
- *	the line termination char); lines longer than 4096 chars are
- *	truncated. After 4095 chars, input data is still processed but
- *	not stored. Overflow processing ensures the tty can always
- *	receive more input until at least one line can be read.
- *
- *	In non-canonical mode, the read buffer will only accept 4095 chars;
- *	this provides the necessary space for a newline char if the input
- *	mode is switched to canonical.
- *
- *	Note it is possible for the read buffer to _contain_ 4096 chars
- *	in non-canonical mode: the read buffer could already contain the
- *	maximum canon line of 4096 chars when the mode is switched to
- *	non-canonical.
- *
- *	n_tty_receive_buf()/producer path:
- *		claims non-exclusive termios_rwsem
- *		publishes commit_head or canon_head
+ * n_tty_receive_buf_common	-	process input
+ * @tty: device to receive input
+ * @cp: input chars
+ * @fp: flags for each char (if %NULL, all chars are %TTY_NORMAL)
+ * @count: number of input chars in @cp
+ * @flow: enable flow control
+ *
+ * Called by the terminal driver when a block of characters has been received.
+ * This function must be called from soft contexts not from interrupt context.
+ * The driver is responsible for making calls one at a time and in order (or
+ * using flush_to_ldisc()).
+ *
+ * Returns: the # of input chars from @cp which were processed.
+ *
+ * In canonical mode, the maximum line length is 4096 chars (including the line
+ * termination char); lines longer than 4096 chars are truncated. After 4095
+ * chars, input data is still processed but not stored. Overflow processing
+ * ensures the tty can always receive more input until at least one line can be
+ * read.
+ *
+ * In non-canonical mode, the read buffer will only accept 4095 chars; this
+ * provides the necessary space for a newline char if the input mode is
+ * switched to canonical.
+ *
+ * Note it is possible for the read buffer to _contain_ 4096 chars in
+ * non-canonical mode: the read buffer could already contain the maximum canon
+ * line of 4096 chars when the mode is switched to non-canonical.
+ *
+ * Locking: n_tty_receive_buf()/producer path:
+ *	claims non-exclusive %termios_rwsem
+ *	publishes commit_head or canon_head
  */
 static int
 n_tty_receive_buf_common(struct tty_struct *tty, const unsigned char *cp,
@@ -1709,19 +1681,17 @@ static int n_tty_receive_buf2(struct tty_struct *tty, const unsigned char *cp,
 }
 
 /**
- *	n_tty_set_termios	-	termios data changed
- *	@tty: terminal
- *	@old: previous data
+ * n_tty_set_termios	-	termios data changed
+ * @tty: terminal
+ * @old: previous data
  *
- *	Called by the tty layer when the user changes termios flags so
- *	that the line discipline can plan ahead. This function cannot sleep
- *	and is protected from re-entry by the tty layer. The user is
- *	guaranteed that this function will not be re-entered or in progress
- *	when the ldisc is closed.
+ * Called by the tty layer when the user changes termios flags so that the line
+ * discipline can plan ahead. This function cannot sleep and is protected from
+ * re-entry by the tty layer. The user is guaranteed that this function will
+ * not be re-entered or in progress when the ldisc is closed.
  *
- *	Locking: Caller holds tty->termios_rwsem
+ * Locking: Caller holds @tty->termios_rwsem
  */
-
 static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1807,15 +1777,13 @@ static void n_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 }
 
 /**
- *	n_tty_close		-	close the ldisc for this tty
- *	@tty: device
+ * n_tty_close		-	close the ldisc for this tty
+ * @tty: device
  *
- *	Called from the terminal layer when this line discipline is
- *	being shut down, either because of a close or becsuse of a
- *	discipline change. The function will not be called while other
- *	ldisc methods are in progress.
+ * Called from the terminal layer when this line discipline is being shut down,
+ * either because of a close or becsuse of a discipline change. The function
+ * will not be called while other ldisc methods are in progress.
  */
-
 static void n_tty_close(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1830,15 +1798,13 @@ static void n_tty_close(struct tty_struct *tty)
 }
 
 /**
- *	n_tty_open		-	open an ldisc
- *	@tty: terminal to open
+ * n_tty_open		-	open an ldisc
+ * @tty: terminal to open
  *
- *	Called when this line discipline is being attached to the
- *	terminal device. Can sleep. Called serialized so that no
- *	other events will occur in parallel. No further open will occur
- *	until a close.
+ * Called when this line discipline is being attached to the terminal device.
+ * Can sleep. Called serialized so that no other events will occur in parallel.
+ * No further open will occur until a close.
  */
-
 static int n_tty_open(struct tty_struct *tty)
 {
 	struct n_tty_data *ldata;
@@ -1873,24 +1839,23 @@ static inline int input_available_p(struct tty_struct *tty, int poll)
 }
 
 /**
- *	copy_from_read_buf	-	copy read data directly
- *	@tty: terminal device
- *	@kbp: data
- *	@nr: size of data
- *
- *	Helper function to speed up n_tty_read.  It is only called when
- *	ICANON is off; it copies characters straight from the tty queue.
+ * copy_from_read_buf	-	copy read data directly
+ * @tty: terminal device
+ * @kbp: data
+ * @nr: size of data
  *
- *	Called under the ldata->atomic_read_lock sem
+ * Helper function to speed up n_tty_read(). It is only called when %ICANON is
+ * off; it copies characters straight from the tty queue.
  *
- *	Returns true if it successfully copied data, but there is still
- *	more data to be had.
+ * Returns: true if it successfully copied data, but there is still more data
+ * to be had.
  *
- *	n_tty_read()/consumer path:
- *		caller holds non-exclusive termios_rwsem
+ * Locking:
+ *  * called under the @ldata->atomic_read_lock sem
+ *  * n_tty_read()/consumer path:
+ *		caller holds non-exclusive %termios_rwsem;
  *		read_tail published
  */
-
 static bool copy_from_read_buf(struct tty_struct *tty,
 				      unsigned char **kbp,
 				      size_t *nr)
@@ -1925,28 +1890,27 @@ static bool copy_from_read_buf(struct tty_struct *tty,
 }
 
 /**
- *	canon_copy_from_read_buf	-	copy read data in canonical mode
- *	@tty: terminal device
- *	@kbp: data
- *	@nr: size of data
- *
- *	Helper function for n_tty_read.  It is only called when ICANON is on;
- *	it copies one line of input up to and including the line-delimiting
- *	character into the result buffer.
- *
- *	NB: When termios is changed from non-canonical to canonical mode and
- *	the read buffer contains data, n_tty_set_termios() simulates an EOF
- *	push (as if C-d were input) _without_ the DISABLED_CHAR in the buffer.
- *	This causes data already processed as input to be immediately available
- *	as input although a newline has not been received.
- *
- *	Called under the atomic_read_lock mutex
- *
- *	n_tty_read()/consumer path:
- *		caller holds non-exclusive termios_rwsem
- *		read_tail published
+ * canon_copy_from_read_buf	-	copy read data in canonical mode
+ * @tty: terminal device
+ * @kbp: data
+ * @nr: size of data
+ *
+ * Helper function for n_tty_read(). It is only called when %ICANON is on; it
+ * copies one line of input up to and including the line-delimiting character
+ * into the result buffer.
+ *
+ * Note: When termios is changed from non-canonical to canonical mode and the
+ * read buffer contains data, n_tty_set_termios() simulates an EOF push (as if
+ * C-d were input) _without_ the %DISABLED_CHAR in the buffer. This causes data
+ * already processed as input to be immediately available as input although a
+ * newline has not been received.
+ *
+ * Locking:
+ *  * called under the %atomic_read_lock mutex
+ *  * n_tty_read()/consumer path:
+ *	caller holds non-exclusive %termios_rwsem;
+ *	read_tail published
  */
-
 static bool canon_copy_from_read_buf(struct tty_struct *tty,
 				     unsigned char **kbp,
 				     size_t *nr)
@@ -2014,19 +1978,19 @@ static bool canon_copy_from_read_buf(struct tty_struct *tty,
 }
 
 /**
- *	job_control		-	check job control
- *	@tty: tty
- *	@file: file handle
- *
- *	Perform job control management checks on this file/tty descriptor
- *	and if appropriate send any needed signals and return a negative
- *	error code if action should be taken.
- *
- *	Locking: redirected write test is safe
- *		 current->signal->tty check is safe
- *		 ctrl.lock to safely reference tty->ctrl.pgrp
+ * job_control		-	check job control
+ * @tty: tty
+ * @file: file handle
+ *
+ * Perform job control management checks on this @file/@tty descriptor and if
+ * appropriate send any needed signals and return a negative error code if
+ * action should be taken.
+ *
+ * Locking:
+ *  * redirected write test is safe
+ *  * current->signal->tty check is safe
+ *  * ctrl.lock to safely reference @tty->ctrl.pgrp
  */
-
 static int job_control(struct tty_struct *tty, struct file *file)
 {
 	/* Job control check -- must be done at start and after
@@ -2042,26 +2006,25 @@ static int job_control(struct tty_struct *tty, struct file *file)
 
 
 /**
- *	n_tty_read		-	read function for tty
- *	@tty: tty device
- *	@file: file object
- *	@kbuf: kernelspace buffer pointer
- *	@nr: size of I/O
- *	@cookie: if non-%NULL, this is a continuation read
- *	@offset: where to continue reading from (unused in n_tty)
- *
- *	Perform reads for the line discipline. We are guaranteed that the
- *	line discipline will not be closed under us but we may get multiple
- *	parallel readers and must handle this ourselves. We may also get
- *	a hangup. Always called in user context, may sleep.
- *
- *	This code must be sure never to sleep through a hangup.
- *
- *	n_tty_read()/consumer path:
- *		claims non-exclusive termios_rwsem
- *		publishes read_tail
+ * n_tty_read		-	read function for tty
+ * @tty: tty device
+ * @file: file object
+ * @kbuf: kernelspace buffer pointer
+ * @nr: size of I/O
+ * @cookie: if non-%NULL, this is a continuation read
+ * @offset: where to continue reading from (unused in n_tty)
+ *
+ * Perform reads for the line discipline. We are guaranteed that the line
+ * discipline will not be closed under us but we may get multiple parallel
+ * readers and must handle this ourselves. We may also get a hangup. Always
+ * called in user context, may sleep.
+ *
+ * This code must be sure never to sleep through a hangup.
+ *
+ * Locking: n_tty_read()/consumer path:
+ *	claims non-exclusive termios_rwsem;
+ *	publishes read_tail
  */
-
 static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			  unsigned char *kbuf, size_t nr,
 			  void **cookie, unsigned long offset)
@@ -2233,25 +2196,23 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 }
 
 /**
- *	n_tty_write		-	write function for tty
- *	@tty: tty device
- *	@file: file object
- *	@buf: userspace buffer pointer
- *	@nr: size of I/O
- *
- *	Write function of the terminal device.  This is serialized with
- *	respect to other write callers but not to termios changes, reads
- *	and other such events.  Since the receive code will echo characters,
- *	thus calling driver write methods, the output_lock is used in
- *	the output processing functions called here as well as in the
- *	echo processing function to protect the column state and space
- *	left in the buffer.
- *
- *	This code must be sure never to sleep through a hangup.
- *
- *	Locking: output_lock to protect column state and space left
- *		 (note that the process_output*() functions take this
- *		  lock themselves)
+ * n_tty_write		-	write function for tty
+ * @tty: tty device
+ * @file: file object
+ * @buf: userspace buffer pointer
+ * @nr: size of I/O
+ *
+ * Write function of the terminal device. This is serialized with respect to
+ * other write callers but not to termios changes, reads and other such events.
+ * Since the receive code will echo characters, thus calling driver write
+ * methods, the %output_lock is used in the output processing functions called
+ * here as well as in the echo processing function to protect the column state
+ * and space left in the buffer.
+ *
+ * This code must be sure never to sleep through a hangup.
+ *
+ * Locking: output_lock to protect column state and space left
+ *	 (note that the process_output*() functions take this lock themselves)
  */
 
 static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
@@ -2342,19 +2303,19 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 }
 
 /**
- *	n_tty_poll		-	poll method for N_TTY
- *	@tty: terminal device
- *	@file: file accessing it
- *	@wait: poll table
+ * n_tty_poll		-	poll method for N_TTY
+ * @tty: terminal device
+ * @file: file accessing it
+ * @wait: poll table
  *
- *	Called when the line discipline is asked to poll() for data or
- *	for special events. This code is not serialized with respect to
- *	other events save open/close.
+ * Called when the line discipline is asked to poll() for data or for special
+ * events. This code is not serialized with respect to other events save
+ * open/close.
  *
- *	This code must be sure never to sleep through a hangup.
- *	Called without the kernel lock held - fine
+ * This code must be sure never to sleep through a hangup.
+ *
+ * Locking: called without the kernel lock held -- fine.
  */
-
 static __poll_t n_tty_poll(struct tty_struct *tty, struct file *file,
 							poll_table *wait)
 {
-- 
2.34.0

