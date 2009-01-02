From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 06/75] n_tty: Fix loss of echoed characters and remove bkl
	from n_tty
Date: Fri, 02 Jan 2009 13:40:53 +0000
Message-ID: <20090102134050.13472.13797.stgit@localhost.localdomain>
References: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:60281 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754719AbZABNkl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:40:41 -0500
In-Reply-To: <20090102133822.13472.53912.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

From: Joe Peterson <joe@skyrush.com>

Fixes the loss of echoed (and other ldisc-generated characters) when
the tty is stopped or when the driver output buffer is full (happens
frequently for input during continuous program output, such as ^C)
and removes the Big Kernel Lock from the N_TTY line discipline.

Adds an "echo buffer" to the N_TTY line discipline that handles all
ldisc-generated output (including echoed characters).  Along with the
loss of characters, this also fixes the associated loss of sync between
tty output and the ldisc state when characters cannot be immediately
written to the tty driver.

The echo buffer stores (in addition to characters) state operations that need
to be done at the time of character output (like management of the column
position).  This allows echo to cooperate correctly with program output,
since the ldisc state remains consistent with actual characters written.

Since the echo buffer code now isolates the tty column state code
to the process_out* and process_echoes functions, we can remove the
Big Kernel Lock (BKL) and replace it with mutex locks.

Highlights are:

* Handles echo (and other ldisc output) when tty driver buffer is full
  - continuous program output can block echo
* Saves echo when tty is in stopped state (e.g. ^S)
  - (e.g.: ^Q will correctly cause held characters to be released for output)
* Control character pairs (e.g. "^C") are treated atomically and not
  split up by interleaved program output
* Line discipline state is kept consistent with characters sent to
  the tty driver
* Remove the big kernel lock (BKL) from N_TTY line discipline

Signed-off-by: Joe Peterson <joe@skyrush.com>
Signed-off-by: Alan Cox <alan@redhat.com>
---

 drivers/char/n_tty.c  |  736 +++++++++++++++++++++++++++++++++++++++----------
 drivers/char/tty_io.c |    6 
 drivers/char/vt.c     |    2 
 include/linux/tty.h   |    6 
 4 files changed, 594 insertions(+), 156 deletions(-)


diff --git a/drivers/char/n_tty.c b/drivers/char/n_tty.c
index efbfe96..a9bc576 100644
--- a/drivers/char/n_tty.c
+++ b/drivers/char/n_tty.c
@@ -62,6 +62,17 @@
 #define TTY_THRESHOLD_THROTTLE		128 /* now based on remaining room */
 #define TTY_THRESHOLD_UNTHROTTLE 	128
 
+/*
+ * Special byte codes used in the echo buffer to represent operations
+ * or special handling of characters.  Bytes in the echo buffer that
+ * are not part of such special blocks are treated as normal character
+ * codes.
+ */
+#define ECHO_OP_START 0xff
+#define ECHO_OP_MOVE_BACK_COL 0x80
+#define ECHO_OP_SET_CANON_COL 0x81
+#define ECHO_OP_ERASE_TAB 0x82
+
 static inline unsigned char *alloc_buf(void)
 {
 	gfp_t prio = in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
@@ -169,6 +180,7 @@ static void check_unthrottle(struct tty_struct *tty)
  *
  *	Locking: tty_read_lock for read fields.
  */
+
 static void reset_buffer_flags(struct tty_struct *tty)
 {
 	unsigned long flags;
@@ -176,6 +188,11 @@ static void reset_buffer_flags(struct tty_struct *tty)
 	spin_lock_irqsave(&tty->read_lock, flags);
 	tty->read_head = tty->read_tail = tty->read_cnt = 0;
 	spin_unlock_irqrestore(&tty->read_lock, flags);
+
+	mutex_lock(&tty->echo_lock);
+	tty->echo_pos = tty->echo_cnt = tty->echo_overrun = 0;
+	mutex_unlock(&tty->echo_lock);
+
 	tty->canon_head = tty->canon_data = tty->erasing = 0;
 	memset(&tty->read_flags, 0, sizeof tty->read_flags);
 	n_tty_set_room(tty);
@@ -266,89 +283,116 @@ static inline int is_continuation(unsigned char c, struct tty_struct *tty)
 }
 
 /**
- *	opost			-	output post processor
+ *	do_output_char			-	output one character
  *	@c: character (or partial unicode symbol)
  *	@tty: terminal device
+ *	@space: space available in tty driver write buffer
  *
- *	Perform OPOST processing.  Returns -1 when the output device is
- *	full and the character must be retried. Note that Linux currently
- *	ignores TABDLY, CRDLY, VTDLY, FFDLY and NLDLY. They simply aren't
- *	relevant in the world today. If you ever need them, add them here.
+ *	This is a helper function that handles one output character
+ *	(including special characters like TAB, CR, LF, etc.),
+ *	putting the results in the tty driver's write buffer.
+ *
+ *	Note that Linux currently ignores TABDLY, CRDLY, VTDLY, FFDLY
+ *	and NLDLY.  They simply aren't relevant in the world today.
+ *	If you ever need them, add them here.
  *
- *	Called from both the receive and transmit sides and can be called
- *	re-entrantly. Relies on lock_kernel() for tty->column state.
+ *	Returns the number of bytes of buffer space used or -1 if
+ *	no space left.
+ *
+ *	Locking: should be called under the output_lock to protect
+ *		 the column state and space left in the buffer
  */
 
-static int opost(unsigned char c, struct tty_struct *tty)
+static int do_output_char(unsigned char c, struct tty_struct *tty, int space)
 {
-	int	space, spaces;
+	int	spaces;
 
-	space = tty_write_room(tty);
 	if (!space)
 		return -1;
-
-	lock_kernel();
-	if (O_OPOST(tty)) {
-		switch (c) {
-		case '\n':
-			if (O_ONLRET(tty))
-				tty->column = 0;
-			if (O_ONLCR(tty)) {
-				if (space < 2) {
-					unlock_kernel();
-					return -1;
-				}
-				tty_put_char(tty, '\r');
-				tty->column = 0;
-			}
-			tty->canon_column = tty->column;
-			break;
-		case '\r':
-			if (O_ONOCR(tty) && tty->column == 0) {
-				unlock_kernel();
-				return 0;
-			}
-			if (O_OCRNL(tty)) {
-				c = '\n';
-				if (O_ONLRET(tty))
-					tty->canon_column = tty->column = 0;
-				break;
-			}
+	
+	switch (c) {
+	case '\n':
+		if (O_ONLRET(tty))
+			tty->column = 0;
+		if (O_ONLCR(tty)) {
+			if (space < 2)
+				return -1;
 			tty->canon_column = tty->column = 0;
+			tty_put_char(tty, '\r');
+			tty_put_char(tty, c);
+			return 2;
+		}
+		tty->canon_column = tty->column;
+		break;
+	case '\r':
+		if (O_ONOCR(tty) && tty->column == 0)
+			return 0;
+		if (O_OCRNL(tty)) {
+			c = '\n';
+			if (O_ONLRET(tty))
+				tty->canon_column = tty->column = 0;
 			break;
-		case '\t':
-			spaces = 8 - (tty->column & 7);
-			if (O_TABDLY(tty) == XTABS) {
-				if (space < spaces) {
-					unlock_kernel();
-					return -1;
-				}
-				tty->column += spaces;
-				tty->ops->write(tty, "        ", spaces);
-				unlock_kernel();
-				return 0;
-			}
+		}
+		tty->canon_column = tty->column = 0;
+		break;
+	case '\t':
+		spaces = 8 - (tty->column & 7);
+		if (O_TABDLY(tty) == XTABS) {
+			if (space < spaces)
+				return -1;
 			tty->column += spaces;
-			break;
-		case '\b':
-			if (tty->column > 0)
-				tty->column--;
-			break;
-		default:
-			if (O_OLCUC(tty))
-				c = toupper(c);
-			if (!iscntrl(c) && !is_continuation(c, tty))
-				tty->column++;
-			break;
+			tty->ops->write(tty, "        ", spaces);
+			return spaces;
 		}
+		tty->column += spaces;
+		break;
+	case '\b':
+		if (tty->column > 0)
+			tty->column--;
+		break;
+	default:
+		if (O_OLCUC(tty))
+			c = toupper(c);
+		if (!iscntrl(c) && !is_continuation(c, tty))
+			tty->column++;
+		break;
 	}
+
 	tty_put_char(tty, c);
-	unlock_kernel();
-	return 0;
+	return 1;
+}
+
+/**
+ *	process_output			-	output post processor
+ *	@c: character (or partial unicode symbol)
+ *	@tty: terminal device
+ *
+ *	Perform OPOST processing.  Returns -1 when the output device is
+ *	full and the character must be retried.
+ *
+ *	Locking: output_lock to protect column state and space left
+ *		 (also, this is called from n_tty_write under the
+ *		  tty layer write lock)
+ */
+
+static int process_output(unsigned char c, struct tty_struct *tty)
+{
+	int	space, retval;
+
+	mutex_lock(&tty->output_lock);
+
+	space = tty_write_room(tty);
+	retval = do_output_char(c, tty, space);
+
+	mutex_unlock(&tty->output_lock);
+	if (retval < 0)
+		return -1;
+	else
+		return 0;
 }
 
 /**
- *	opost_block		-	block postprocess
+ *	process_output_block		-	block post processor
  *	@tty: terminal device
  *	@inbuf: user buffer
  *	@nr: number of bytes
@@ -358,24 +402,29 @@ static int opost(unsigned char c, struct tty_struct *tty)
  *	the simple cases normally found and helps to generate blocks of
  *	symbols for the console driver and thus improve performance.
  *
- *	Called from n_tty_write under the tty layer write lock. Relies
- *	on lock_kernel for the tty->column state.
+ *	Locking: output_lock to protect column state and space left
+ *		 (also, this is called from n_tty_write under the
+ *		  tty layer write lock)
  */
 
-static ssize_t opost_block(struct tty_struct *tty,
-		       const unsigned char *buf, unsigned int nr)
+static ssize_t process_output_block(struct tty_struct *tty,
+				    const unsigned char *buf, unsigned int nr)
 {
 	int	space;
 	int 	i;
 	const unsigned char *cp;
 
+	mutex_lock(&tty->output_lock);
+
 	space = tty_write_room(tty);
 	if (!space)
+	{
+		mutex_unlock(&tty->output_lock);
 		return 0;
+	}
 	if (nr > space)
 		nr = space;
 
-	lock_kernel();
 	for (i = 0, cp = buf; i < nr; i++, cp++) {
 		switch (*cp) {
 		case '\n':
@@ -407,46 +456,393 @@ static ssize_t opost_block(struct tty_struct *tty,
 		}
 	}
 break_out:
-	if (tty->ops->flush_chars)
-		tty->ops->flush_chars(tty);
 	i = tty->ops->write(tty, buf, i);
-	unlock_kernel();
+
+	mutex_unlock(&tty->output_lock);
 	return i;
 }
 
+/**
+ *	process_echoes	-	write pending echo characters
+ *	@tty: terminal device
+ *
+ *	Write previously buffered echo (and other ldisc-generated)
+ *	characters to the tty.
+ *
+ *	Characters generated by the ldisc (including echoes) need to
+ *	be buffered because the driver's write buffer can fill during
+ *	heavy program output.  Echoing straight to the driver will
+ *	often fail under these conditions, causing lost characters and
+ *	resulting mismatches of ldisc state information.
+ *
+ *	Since the ldisc state must represent the characters actually sent
+ *	to the driver at the time of the write, operations like certain
+ *	changes in column state are also saved in the buffer and executed
+ *	here.
+ *
+ *	A circular fifo buffer is used so that the most recent characters
+ *	are prioritized.  Also, when control characters are echoed with a
+ *	prefixed "^", the pair is treated atomically and thus not separated.
+ *
+ *	Locking: output_lock to protect column state and space left,
+ *		 echo_lock to protect the echo buffer
+ */
+
+static void process_echoes(struct tty_struct *tty)
+{
+	int	space, nr;
+	unsigned char c;
+	unsigned char *cp, *buf_end;
+
+	if (!tty->echo_cnt)
+		return;
+
+	mutex_lock(&tty->output_lock);
+	mutex_lock(&tty->echo_lock);
+
+	space = tty_write_room(tty);
+
+	buf_end = tty->echo_buf + N_TTY_BUF_SIZE;
+	cp = tty->echo_buf + tty->echo_pos;
+	nr = tty->echo_cnt;
+	while (nr > 0) {
+		c = *cp;
+		if (c == ECHO_OP_START) {
+			unsigned char op;
+			unsigned char *opp;
+			int no_space_left = 0;
+
+			/*
+			 * If the buffer byte is the start of a multi-byte
+			 * operation, get the next byte, which is either the
+			 * op code or a control character value.
+			 */
+			opp = cp + 1;
+			if (opp == buf_end)
+				opp -= N_TTY_BUF_SIZE;
+			op = *opp;
+			
+			switch (op) {
+				unsigned int num_chars, num_bs;
+
+			case ECHO_OP_ERASE_TAB:
+				if (++opp == buf_end)
+					opp -= N_TTY_BUF_SIZE;
+				num_chars = *opp;
+
+				/*
+				 * Determine how many columns to go back
+				 * in order to erase the tab.
+				 * This depends on the number of columns
+				 * used by other characters within the tab
+				 * area.  If this (modulo 8) count is from
+				 * the start of input rather than from a
+				 * previous tab, we offset by canon column.
+				 * Otherwise, tab spacing is normal.
+				 */
+				if (!(num_chars & 0x80))
+					num_chars += tty->canon_column;
+				num_bs = 8 - (num_chars & 7);
+
+				if (num_bs > space) {
+					no_space_left = 1;
+					break;
+				}
+				space -= num_bs;
+				while (num_bs--) {
+					tty_put_char(tty, '\b');
+					if (tty->column > 0)
+						tty->column--;
+				}
+				cp += 3;
+				nr -= 3;
+				break;
+
+			case ECHO_OP_SET_CANON_COL:
+				tty->canon_column = tty->column;
+				cp += 2;
+				nr -= 2;
+				break;
+
+			case ECHO_OP_MOVE_BACK_COL:
+				if (tty->column > 0)
+					tty->column--;
+				cp += 2;
+				nr -= 2;
+				break;
+
+			case ECHO_OP_START:
+				/* This is an escaped echo op start code */
+				if (!space) {
+					no_space_left = 1;
+					break;
+				}
+				tty_put_char(tty, ECHO_OP_START);
+				tty->column++;
+				space--;
+				cp += 2;
+				nr -= 2;
+				break;
+
+			default:
+				if (iscntrl(op)) {
+					if (L_ECHOCTL(tty)) {
+						/*
+						 * Ensure there is enough space
+						 * for the whole ctrl pair.
+						 */
+						if (space < 2) {
+							no_space_left = 1;
+							break;
+						}
+						tty_put_char(tty, '^');
+						tty_put_char(tty, op ^ 0100);
+						tty->column += 2;
+						space -= 2;
+					} else {
+						if (!space) {
+							no_space_left = 1;
+							break;
+						}
+						tty_put_char(tty, op);
+						space--;
+					}
+				}
+				/*
+				 * If above falls through, this was an
+				 * undefined op.
+				 */
+				cp += 2;
+				nr -= 2;
+			}
+
+			if (no_space_left)
+				break;
+		} else {
+			int retval;
+
+			if ((retval = do_output_char(c, tty, space)) < 0)
+				break;
+			space -= retval;
+			cp += 1;
+			nr -= 1;
+		}
+
+		/* When end of circular buffer reached, wrap around */
+		if (cp >= buf_end)
+			cp -= N_TTY_BUF_SIZE;
+	}
+
+	if (nr == 0) {
+		tty->echo_pos = 0;
+		tty->echo_cnt = 0;
+		tty->echo_overrun = 0;
+	} else {
+		int num_processed = tty->echo_cnt - nr;
+		tty->echo_pos += num_processed;
+		tty->echo_pos &= N_TTY_BUF_SIZE - 1;
+		tty->echo_cnt = nr;
+		if (num_processed > 0)
+			tty->echo_overrun = 0;
+	}
+
+	mutex_unlock(&tty->echo_lock);
+	mutex_unlock(&tty->output_lock);
+
+	if (tty->ops->flush_chars)
+		tty->ops->flush_chars(tty);
+}
+
+/**
+ *	add_echo_byte	-	add a byte to the echo buffer
+ *	@c: unicode byte to echo
+ *	@tty: terminal device
+ *
+ *	Add a character or operation byte to the echo buffer.
+ *
+ *	Should be called under the echo lock to protect the echo buffer.
+ */
+
+static void add_echo_byte(unsigned char c, struct tty_struct *tty)
+{
+	int	new_byte_pos;
+
+	if (tty->echo_cnt == N_TTY_BUF_SIZE) {
+		/* Circular buffer is already at capacity */
+		new_byte_pos = tty->echo_pos;
+
+		/*
+		 * Since the buffer start position needs to be advanced,
+		 * be sure to step by a whole operation byte group.
+		 */
+		if (tty->echo_buf[tty->echo_pos] == ECHO_OP_START)
+		{
+			if (tty->echo_buf[(tty->echo_pos + 1) &
+					  (N_TTY_BUF_SIZE - 1)] ==
+						ECHO_OP_ERASE_TAB) {
+				tty->echo_pos += 3;
+				tty->echo_cnt -= 2;
+			} else {
+				tty->echo_pos += 2;
+				tty->echo_cnt -= 1;
+			}
+		} else {
+			tty->echo_pos++;
+		}
+		tty->echo_pos &= N_TTY_BUF_SIZE - 1;
+
+		tty->echo_overrun = 1;
+	} else {
+		new_byte_pos = tty->echo_pos + tty->echo_cnt;
+		new_byte_pos &= N_TTY_BUF_SIZE - 1;
+		tty->echo_cnt++;
+	}
+
+	tty->echo_buf[new_byte_pos] = c;
+}
+
+/**
+ *	echo_move_back_col	-	add operation to move back a column
+ *	@tty: terminal device
+ *
+ *	Add an operation to the echo buffer to move back one column.
+ *
+ *	Locking: echo_lock to protect the echo buffer
+ */
+
+static void echo_move_back_col(struct tty_struct *tty)
+{
+	mutex_lock(&tty->echo_lock);
+
+	add_echo_byte(ECHO_OP_START, tty);
+	add_echo_byte(ECHO_OP_MOVE_BACK_COL, tty);
+
+	mutex_unlock(&tty->echo_lock);
+}
+
+/**
+ *	echo_set_canon_col	-	add operation to set the canon column
+ *	@tty: terminal device
+ *
+ *	Add an operation to the echo buffer to set the canon column
+ *	to the current column.
+ *
+ *	Locking: echo_lock to protect the echo buffer
+ */
+
+static void echo_set_canon_col(struct tty_struct *tty)
+{
+	mutex_lock(&tty->echo_lock);
+
+	add_echo_byte(ECHO_OP_START, tty);
+	add_echo_byte(ECHO_OP_SET_CANON_COL, tty);
+
+	mutex_unlock(&tty->echo_lock);
+}
+
+/**
+ *	echo_erase_tab	-	add operation to erase a tab
+ *	@num_chars: number of character columns already used
+ *	@after_tab: true if num_chars starts after a previous tab
+ *	@tty: terminal device
+ *
+ *	Add an operation to the echo buffer to erase a tab.
+ *
+ *	Called by the eraser function, which knows how many character
+ *	columns have been used since either a previous tab or the start
+ *	of input.  This information will be used later, along with
+ *	canon column (if applicable), to go back the correct number
+ *	of columns.
+ *
+ *	Locking: echo_lock to protect the echo buffer
+ */
+
+static void echo_erase_tab(unsigned int num_chars, int after_tab,
+			   struct tty_struct *tty)
+{
+	mutex_lock(&tty->echo_lock);
+
+	add_echo_byte(ECHO_OP_START, tty);
+	add_echo_byte(ECHO_OP_ERASE_TAB, tty);
+
+	/* We only need to know this modulo 8 (tab spacing) */
+	num_chars &= 7;
+
+	/* Set the high bit as a flag if num_chars is after a previous tab */
+	if (after_tab)
+		num_chars |= 0x80;
+	
+	add_echo_byte(num_chars, tty);
+
+	mutex_unlock(&tty->echo_lock);
+}
+
+/**
+ *	echo_char_raw	-	echo a character raw
+ *	@c: unicode byte to echo
+ *	@tty: terminal device
+ *
+ *	Echo user input back onto the screen. This must be called only when
+ *	L_ECHO(tty) is true. Called from the driver receive_buf path.
+ *
+ *	This variant does not treat control characters specially.
+ *
+ *	Locking: echo_lock to protect the echo buffer
+ */
+
+static void echo_char_raw(unsigned char c, struct tty_struct *tty)
+{
+	mutex_lock(&tty->echo_lock);
+
+	if (c == ECHO_OP_START) {
+		add_echo_byte(ECHO_OP_START, tty);
+		add_echo_byte(ECHO_OP_START, tty);
+	} else {
+		add_echo_byte(c, tty);
+	}
+
+	mutex_unlock(&tty->echo_lock);
+}
 
 /**
- *	echo_char	-	echo characters
+ *	echo_char	-	echo a character
  *	@c: unicode byte to echo
  *	@tty: terminal device
  *
  *	Echo user input back onto the screen. This must be called only when
  *	L_ECHO(tty) is true. Called from the driver receive_buf path.
  *
- *	Relies on BKL for tty column locking
+ *	This variant tags control characters to be possibly echoed as
+ *	as "^X" (where X is the letter representing the control char).
+ *
+ *	Locking: echo_lock to protect the echo buffer
  */
 
 static void echo_char(unsigned char c, struct tty_struct *tty)
 {
-	if (L_ECHOCTL(tty) && iscntrl(c) && c != '\t') {
-		tty_put_char(tty, '^');
-		tty_put_char(tty, c ^ 0100);
-		tty->column += 2;
-	} else
-		opost(c, tty);
+	mutex_lock(&tty->echo_lock);
+
+	if (c == ECHO_OP_START) {
+		add_echo_byte(ECHO_OP_START, tty);
+		add_echo_byte(ECHO_OP_START, tty);
+	} else {
+		if (iscntrl(c) && c != '\t')
+			add_echo_byte(ECHO_OP_START, tty);
+		add_echo_byte(c, tty);
+	}
+
+	mutex_unlock(&tty->echo_lock);
 }
 
 /**
- *	finsh_erasing		-	complete erase
+ *	finish_erasing		-	complete erase
  *	@tty: tty doing the erase
- *
- *	Relies on BKL for tty column locking
  */
+
 static inline void finish_erasing(struct tty_struct *tty)
 {
 	if (tty->erasing) {
-		tty_put_char(tty, '/');
-		tty->column++;
+		echo_char_raw('/', tty);
 		tty->erasing = 0;
 	}
 }
@@ -460,7 +856,7 @@ static inline void finish_erasing(struct tty_struct *tty)
  *	present in the stream from the driver layer. Handles the complexities
  *	of UTF-8 multibyte symbols.
  *
- *	Locking: read_lock for tty buffers, BKL for column/erasing state
+ *	Locking: read_lock for tty buffers
  */
 
 static void eraser(unsigned char c, struct tty_struct *tty)
@@ -471,7 +867,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 
 	/* FIXME: locking needed ? */
 	if (tty->read_head == tty->canon_head) {
-		/* opost('\a', tty); */		/* what do you think? */
+		/* echo_char_raw('\a', tty); */ /* what do you think? */
 		return;
 	}
 	if (c == ERASE_CHAR(tty))
@@ -497,7 +893,7 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 			echo_char(KILL_CHAR(tty), tty);
 			/* Add a newline if ECHOK is on and ECHOKE is off. */
 			if (L_ECHOK(tty))
-				opost('\n', tty);
+				echo_char_raw('\n', tty);
 			return;
 		}
 		kill_type = KILL;
@@ -533,67 +929,62 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 		if (L_ECHO(tty)) {
 			if (L_ECHOPRT(tty)) {
 				if (!tty->erasing) {
-					tty_put_char(tty, '\\');
-					tty->column++;
+					echo_char_raw('\\', tty);
 					tty->erasing = 1;
 				}
 				/* if cnt > 1, output a multi-byte character */
 				echo_char(c, tty);
 				while (--cnt > 0) {
 					head = (head+1) & (N_TTY_BUF_SIZE-1);
-					tty_put_char(tty, tty->read_buf[head]);
+					echo_char_raw(tty->read_buf[head], tty);
+					echo_move_back_col(tty);
 				}
 			} else if (kill_type == ERASE && !L_ECHOE(tty)) {
 				echo_char(ERASE_CHAR(tty), tty);
 			} else if (c == '\t') {
-				unsigned int col = tty->canon_column;
-				unsigned long tail = tty->canon_head;
-
-				/* Find the column of the last char. */
-				while (tail != tty->read_head) {
+				unsigned int num_chars = 0;
+				int after_tab = 0;
+				unsigned long tail = tty->read_head;
+
+				/*
+				 * Count the columns used for characters
+				 * since the start of input or after a
+				 * previous tab.
+				 * This info is used to go back the correct
+				 * number of columns.
+				 */
+				while (tail != tty->canon_head) {
+					tail = (tail-1) & (N_TTY_BUF_SIZE-1);
 					c = tty->read_buf[tail];
-					if (c == '\t')
-						col = (col | 7) + 1;
+					if (c == '\t') {
+						after_tab = 1;
+						break;
+					}
 					else if (iscntrl(c)) {
 						if (L_ECHOCTL(tty))
-							col += 2;
-					} else if (!is_continuation(c, tty))
-						col++;
-					tail = (tail+1) & (N_TTY_BUF_SIZE-1);
-				}
-
-				/* should never happen */
-				if (tty->column > 0x80000000)
-					tty->column = 0;
-
-				/* Now backup to that column. */
-				while (tty->column > col) {
-					/* Can't use opost here. */
-					tty_put_char(tty, '\b');
-					if (tty->column > 0)
-						tty->column--;
+							num_chars += 2;
+					} else if (!is_continuation(c, tty)) {
+						num_chars++;
+					}
 				}
+				echo_erase_tab(num_chars, after_tab, tty);
 			} else {
 				if (iscntrl(c) && L_ECHOCTL(tty)) {
-					tty_put_char(tty, '\b');
-					tty_put_char(tty, ' ');
-					tty_put_char(tty, '\b');
-					if (tty->column > 0)
-						tty->column--;
+					echo_char_raw('\b', tty);
+					echo_char_raw(' ', tty);
+					echo_char_raw('\b', tty);
 				}
 				if (!iscntrl(c) || L_ECHOCTL(tty)) {
-					tty_put_char(tty, '\b');
-					tty_put_char(tty, ' ');
-					tty_put_char(tty, '\b');
-					if (tty->column > 0)
-						tty->column--;
+					echo_char_raw('\b', tty);
+					echo_char_raw(' ', tty);
+					echo_char_raw('\b', tty);
 				}
 			}
 		}
 		if (kill_type == ERASE)
 			break;
 	}
-	if (tty->read_head == tty->canon_head)
+	if (tty->read_head == tty->canon_head && L_ECHO(tty))
 		finish_erasing(tty);
 }
 
@@ -724,14 +1115,18 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 		c=tolower(c);
 
 	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) &&
-	    ((I_IXANY(tty) && c != START_CHAR(tty) && c != STOP_CHAR(tty)) ||
-	     c == INTR_CHAR(tty) || c == QUIT_CHAR(tty) || c == SUSP_CHAR(tty)))
+	    I_IXANY(tty) && c != START_CHAR(tty) && c != STOP_CHAR(tty) &&
+	    c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) && c != SUSP_CHAR(tty)) {
 		start_tty(tty);
+		process_echoes(tty);
+	}
 
 	if (tty->closing) {
 		if (I_IXON(tty)) {
-			if (c == START_CHAR(tty))
+			if (c == START_CHAR(tty)) {
 				start_tty(tty);
+				process_echoes(tty);
+			}
 			else if (c == STOP_CHAR(tty))
 				stop_tty(tty);
 		}
@@ -745,17 +1140,20 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	 * up.
 	 */
 	if (!test_bit(c, tty->process_char_map) || tty->lnext) {
-		finish_erasing(tty);
 		tty->lnext = 0;
 		if (L_ECHO(tty)) {
+			finish_erasing(tty);
 			if (tty->read_cnt >= N_TTY_BUF_SIZE-1) {
-				tty_put_char(tty, '\a'); /* beep if no space */
+				/* beep if no space */
+				echo_char_raw('\a', tty);
+				process_echoes(tty);
 				return;
 			}
 			/* Record the column of first canon char. */
 			if (tty->canon_head == tty->read_head)
-				tty->canon_column = tty->column;
+				echo_set_canon_col(tty);
 			echo_char(c, tty);
+			process_echoes(tty);
 		}
 		if (I_PARMRK(tty) && c == (unsigned char) '\377')
 			put_tty_queue(c, tty);
@@ -766,6 +1164,7 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 	if (I_IXON(tty)) {
 		if (c == START_CHAR(tty)) {
 			start_tty(tty);
+			process_echoes(tty);
 			return;
 		}
 		if (c == STOP_CHAR(tty)) {
@@ -786,7 +1185,6 @@ static inline void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 		if (c == SUSP_CHAR(tty)) {
 send_signal:
 			/*
-			 * Echo character, and then send the signal.
 			 * Note that we do not use isig() here because we want
 			 * the order to be:
 			 * 1) flush, 2) echo, 3) signal
@@ -795,8 +1193,12 @@ send_signal:
 				n_tty_flush_buffer(tty);
 				tty_driver_flush_buffer(tty);
 			}
-			if (L_ECHO(tty))
+			if (I_IXON(tty))
+				start_tty(tty);
+			if (L_ECHO(tty)) {
 				echo_char(c, tty);
+				process_echoes(tty);
+			}
 			if (tty->pgrp)
 				kill_pgrp(tty->pgrp, signal, 1);
 			return;
@@ -815,6 +1217,7 @@ send_signal:
 		if (c == ERASE_CHAR(tty) || c == KILL_CHAR(tty) ||
 		    (c == WERASE_CHAR(tty) && L_IEXTEN(tty))) {
 			eraser(c, tty);
+			process_echoes(tty);
 			return;
 		}
 		if (c == LNEXT_CHAR(tty) && L_IEXTEN(tty)) {
@@ -822,8 +1225,9 @@ send_signal:
 			if (L_ECHO(tty)) {
 				finish_erasing(tty);
 				if (L_ECHOCTL(tty)) {
-					tty_put_char(tty, '^');
-					tty_put_char(tty, '\b');
+					echo_char_raw('^', tty);
+					echo_char_raw('\b', tty);
+					process_echoes(tty);
 				}
 			}
 			return;
@@ -834,18 +1238,20 @@ send_signal:
 
 			finish_erasing(tty);
 			echo_char(c, tty);
-			opost('\n', tty);
+			echo_char_raw('\n', tty);
 			while (tail != tty->read_head) {
 				echo_char(tty->read_buf[tail], tty);
 				tail = (tail+1) & (N_TTY_BUF_SIZE-1);
 			}
+			process_echoes(tty);
 			return;
 		}
 		if (c == '\n') {
 			if (L_ECHO(tty) || L_ECHONL(tty)) {
 				if (tty->read_cnt >= N_TTY_BUF_SIZE-1)
-					tty_put_char(tty, '\a');
-				opost('\n', tty);
+					echo_char_raw('\a', tty);
+				echo_char_raw('\n', tty);
+				process_echoes(tty);
 			}
 			goto handle_newline;
 		}
@@ -862,11 +1268,12 @@ send_signal:
 			 */
 			if (L_ECHO(tty)) {
 				if (tty->read_cnt >= N_TTY_BUF_SIZE-1)
-					tty_put_char(tty, '\a');
+					echo_char_raw('\a', tty);
 				/* Record the column of first canon char. */
 				if (tty->canon_head == tty->read_head)
-					tty->canon_column = tty->column;
+					echo_set_canon_col(tty);
 				echo_char(c, tty);
+				process_echoes(tty);
 			}
 			/*
 			 * XXX does PARMRK doubling happen for
@@ -889,20 +1296,23 @@ handle_newline:
 		}
 	}
 
-	finish_erasing(tty);
 	if (L_ECHO(tty)) {
+		finish_erasing(tty);
 		if (tty->read_cnt >= N_TTY_BUF_SIZE-1) {
-			tty_put_char(tty, '\a'); /* beep if no space */
+			/* beep if no space */
+			echo_char_raw('\a', tty);
+			process_echoes(tty);
 			return;
 		}
 		if (c == '\n')
-			opost('\n', tty);
+			echo_char_raw('\n', tty);
 		else {
 			/* Record the column of first canon char. */
 			if (tty->canon_head == tty->read_head)
-				tty->canon_column = tty->column;
+				echo_set_canon_col(tty);
 			echo_char(c, tty);
 		}
+		process_echoes(tty);
 	}
 
 	if (I_PARMRK(tty) && c == (unsigned char) '\377')
@@ -923,6 +1333,9 @@ handle_newline:
 
 static void n_tty_write_wakeup(struct tty_struct *tty)
 {
+	/* Write out any echoed characters that are still pending */
+	process_echoes(tty);
+	
 	if (tty->fasync) {
 		set_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 		kill_fasync(&tty->fasync, SIGIO, POLL_OUT);
@@ -1134,6 +1547,10 @@ static void n_tty_close(struct tty_struct *tty)
 		free_buf(tty->read_buf);
 		tty->read_buf = NULL;
 	}
+	if (tty->echo_buf) {
+		free_buf(tty->echo_buf);
+		tty->echo_buf = NULL;
+	}
 }
 
 /**
@@ -1151,13 +1568,19 @@ static int n_tty_open(struct tty_struct *tty)
 	if (!tty)
 		return -EINVAL;
 
-	/* This one is ugly. Currently a malloc failure here can panic */
+	/* These are ugly. Currently a malloc failure here can panic */
 	if (!tty->read_buf) {
 		tty->read_buf = alloc_buf();
 		if (!tty->read_buf)
 			return -ENOMEM;
 	}
+	if (!tty->echo_buf) {
+		tty->echo_buf = alloc_buf();
+		if (!tty->echo_buf)
+			return -ENOMEM;
+	}
 	memset(tty->read_buf, 0, N_TTY_BUF_SIZE);
+	memset(tty->echo_buf, 0, N_TTY_BUF_SIZE);
 	reset_buffer_flags(tty);
 	tty->column = 0;
 	n_tty_set_termios(tty, NULL);
@@ -1487,16 +1910,23 @@ do_it_again:
  *	@buf: userspace buffer pointer
  *	@nr: size of I/O
  *
- *	Write function of the terminal device. This is serialized with
+ *	Write function of the terminal device.  This is serialized with
  *	respect to other write callers but not to termios changes, reads
- *	and other such events. We must be careful with N_TTY as the receive
- *	code will echo characters, thus calling driver write methods.
+ *	and other such events.  Since the receive code will echo characters,
+ *	thus calling driver write methods, the output_lock is used in
+ *	the output processing functions called here as well as in the
+ *	echo processing function to protect the column state and space
+ *	left in the buffer.
  *
  *	This code must be sure never to sleep through a hangup.
+ *
+ *	Locking: output_lock to protect column state and space left
+ *		 (note that the process_output*() functions take this
+ *		  lock themselves)
  */
 
 static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
-			  const unsigned char *buf, size_t nr)
+			   const unsigned char *buf, size_t nr)
 {
 	const unsigned char *b = buf;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1510,6 +1940,9 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 			return retval;
 	}
 
+	/* Write out any echoed characters that are still pending */
+	process_echoes(tty);
+	
 	add_wait_queue(&tty->write_wait, &wait);
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
@@ -1523,7 +1956,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 		}
 		if (O_OPOST(tty) && !(test_bit(TTY_HW_COOK_OUT, &tty->flags))) {
 			while (nr > 0) {
-				ssize_t num = opost_block(tty, b, nr);
+				ssize_t num = process_output_block(tty, b, nr);
 				if (num < 0) {
 					if (num == -EAGAIN)
 						break;
@@ -1535,7 +1968,7 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 				if (nr == 0)
 					break;
 				c = *b;
-				if (opost(c, tty) < 0)
+				if (process_output(c, tty) < 0)
 					break;
 				b++; nr--;
 			}
@@ -1663,4 +2096,3 @@ struct tty_ldisc_ops tty_ldisc_N_TTY = {
 	.receive_buf     = n_tty_receive_buf,
 	.write_wakeup    = n_tty_write_wakeup
 };
-
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index db15f9b..d8d240c 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1111,9 +1111,7 @@ void tty_write_message(struct tty_struct *tty, char *msg)
  *		Locks the line discipline as required
  *		Writes to the tty driver are serialized by the atomic_write_lock
  *	and are then processed in chunks to the device. The line discipline
- *	write method will not be involked in parallel for each device
- *		The line discipline write method is called under the big
- *	kernel lock for historical reasons. New code should not rely on this.
+ *	write method will not be invoked in parallel for each device.
  */
 
 static ssize_t tty_write(struct file *file, const char __user *buf,
@@ -2785,6 +2783,8 @@ void initialize_tty_struct(struct tty_struct *tty,
 	INIT_WORK(&tty->hangup_work, do_tty_hangup);
 	mutex_init(&tty->atomic_read_lock);
 	mutex_init(&tty->atomic_write_lock);
+	mutex_init(&tty->output_lock);
+	mutex_init(&tty->echo_lock);
 	spin_lock_init(&tty->read_lock);
 	spin_lock_init(&tty->ctrl_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 008176e..639e126 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2679,7 +2679,7 @@ static int con_write_room(struct tty_struct *tty)
 {
 	if (tty->stopped)
 		return 0;
-	return 4096;		/* No limit, really; we're not buffering */
+	return 32768;		/* No limit, really; we're not buffering */
 }
 
 static int con_chars_in_buffer(struct tty_struct *tty)
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 3f4954c..dfc77de 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -253,6 +253,7 @@ struct tty_struct {
 	unsigned int column;
 	unsigned char lnext:1, erasing:1, raw:1, real_raw:1, icanon:1;
 	unsigned char closing:1;
+	unsigned char echo_overrun:1;
 	unsigned short minimum_to_wake;
 	unsigned long overrun_time;
 	int num_overrun;
@@ -262,11 +263,16 @@ struct tty_struct {
 	int read_tail;
 	int read_cnt;
 	unsigned long read_flags[N_TTY_BUF_SIZE/(8*sizeof(unsigned long))];
+	unsigned char *echo_buf;
+	unsigned int echo_pos;
+	unsigned int echo_cnt;
 	int canon_data;
 	unsigned long canon_head;
 	unsigned int canon_column;
 	struct mutex atomic_read_lock;
 	struct mutex atomic_write_lock;
+	struct mutex output_lock;
+	struct mutex echo_lock;
 	unsigned char *write_buf;
 	int write_cnt;
 	spinlock_t read_lock;

