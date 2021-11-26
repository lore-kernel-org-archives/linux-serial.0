Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8246C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359684AbhKZIXg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:36 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33064 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359349AbhKZIV1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DA6811FE02;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZA4TBupCC8UMnNo/P/APYTyOqXkB94D9R2KQO3yypo=;
        b=RntoN/B2+tbl3wzh1+Z06s7PNhrtVOZsKOdf+qVUBQSsi2O86cx3tiXfh5O3fsqA1VMzYX
        68n80f6umCuozXmLKfw/9oDiQFLPScH+QJqCB2xV0Y7JGfuQcLUZJOUxTkBi27wADZRmKt
        7lHzv9sFs1/1a0FFwN4+X7sv9r3z48g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/ZA4TBupCC8UMnNo/P/APYTyOqXkB94D9R2KQO3yypo=;
        b=7gYXdTrY+cPoCGBuJzw6iOO5nYjsjg9JT4WefGMTJsr5IvANCsTGDE2Y2hUA/H3Ji/mdgE
        OOXZ4iCpiICz6SDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B08D9A3B81;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 13/23] tty: reformat kernel-doc in tty_ldisc.c
Date:   Fri, 26 Nov 2021 09:16:01 +0100
Message-Id: <20211126081611.11001-14-jslaby@suse.cz>
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
 drivers/tty/tty_ldisc.c | 292 ++++++++++++++++++----------------------
 1 file changed, 132 insertions(+), 160 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 3e4e0b20b4bb..776d8a62f77c 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -47,17 +47,14 @@ static DEFINE_RAW_SPINLOCK(tty_ldiscs_lock);
 static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
 
 /**
- *	tty_register_ldisc	-	install a line discipline
- *	@new_ldisc: pointer to the ldisc object
+ * tty_register_ldisc	-	install a line discipline
+ * @new_ldisc: pointer to the ldisc object
  *
- *	Installs a new line discipline into the kernel. The discipline
- *	is set up as unreferenced and then made available to the kernel
- *	from this point onwards.
+ * Installs a new line discipline into the kernel. The discipline is set up as
+ * unreferenced and then made available to the kernel from this point onwards.
  *
- *	Locking:
- *		takes tty_ldiscs_lock to guard against ldisc races
+ * Locking: takes %tty_ldiscs_lock to guard against ldisc races
  */
-
 int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc)
 {
 	unsigned long flags;
@@ -75,14 +72,13 @@ int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc)
 EXPORT_SYMBOL(tty_register_ldisc);
 
 /**
- *	tty_unregister_ldisc	-	unload a line discipline
- *	@ldisc: ldisc number
+ * tty_unregister_ldisc	-	unload a line discipline
+ * @ldisc: ldisc number
  *
- *	Remove a line discipline from the kernel providing it is not
- *	currently in use.
+ * Remove a line discipline from the kernel providing it is not currently in
+ * use.
  *
- *	Locking:
- *		takes tty_ldiscs_lock to guard against ldisc races
+ * Locking: takes %tty_ldiscs_lock to guard against ldisc races
  */
 
 void tty_unregister_ldisc(struct tty_ldisc_ops *ldisc)
@@ -122,27 +118,25 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 }
 
 static int tty_ldisc_autoload = IS_BUILTIN(CONFIG_LDISC_AUTOLOAD);
+
 /**
- *	tty_ldisc_get		-	take a reference to an ldisc
- *	@tty: tty device
- *	@disc: ldisc number
- *
- *	Takes a reference to a line discipline. Deals with refcounts and
- *	module locking counts.
- *
- *	Returns: -EINVAL if the discipline index is not [N_TTY..NR_LDISCS] or
- *			 if the discipline is not registered
- *		 -EAGAIN if request_module() failed to load or register the
- *			 discipline
- *		 -ENOMEM if allocation failure
- *
- *		 Otherwise, returns a pointer to the discipline and bumps the
- *		 ref count
- *
- *	Locking:
- *		takes tty_ldiscs_lock to guard against ldisc races
+ * tty_ldisc_get	-	take a reference to an ldisc
+ * @tty: tty device
+ * @disc: ldisc number
+ *
+ * Takes a reference to a line discipline. Deals with refcounts and module
+ * locking counts. If the discipline is not available, its module loaded, if
+ * possible.
+ *
+ * Returns:
+ * * -%EINVAL if the discipline index is not [%N_TTY .. %NR_LDISCS] or if the
+ *   discipline is not registered
+ * * -%EAGAIN if request_module() failed to load or register the discipline
+ * * -%ENOMEM if allocation failure
+ * * Otherwise, returns a pointer to the discipline and bumps the ref count
+ *
+ * Locking: takes %tty_ldiscs_lock to guard against ldisc races
  */
-
 static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
@@ -176,10 +170,11 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 	return ld;
 }
 
-/*
- *	tty_ldisc_put		-	release the ldisc
+/**
+ * tty_ldisc_put	-	release the ldisc
+ * @ld: lisdsc to release
  *
- *	Complement of tty_ldisc_get().
+ * Complement of tty_ldisc_get().
  */
 static void tty_ldisc_put(struct tty_ldisc *ld)
 {
@@ -226,25 +221,22 @@ const struct seq_operations tty_ldiscs_seq_ops = {
 };
 
 /**
- *	tty_ldisc_ref_wait	-	wait for the tty ldisc
- *	@tty: tty device
+ * tty_ldisc_ref_wait	-	wait for the tty ldisc
+ * @tty: tty device
  *
- *	Dereference the line discipline for the terminal and take a
- *	reference to it. If the line discipline is in flux then
- *	wait patiently until it changes.
+ * Dereference the line discipline for the terminal and take a reference to it.
+ * If the line discipline is in flux then wait patiently until it changes.
  *
- *	Returns: NULL if the tty has been hungup and not re-opened with
- *		 a new file descriptor, otherwise valid ldisc reference
+ * Returns: %NULL if the tty has been hungup and not re-opened with a new file
+ * descriptor, otherwise valid ldisc reference
  *
- *	Note 1: Must not be called from an IRQ/timer context. The caller
- *	must also be careful not to hold other locks that will deadlock
- *	against a discipline change, such as an existing ldisc reference
- *	(which we check for)
+ * Note 1: Must not be called from an IRQ/timer context. The caller must also
+ * be careful not to hold other locks that will deadlock against a discipline
+ * change, such as an existing ldisc reference (which we check for).
  *
- *	Note 2: a file_operations routine (read/poll/write) should use this
- *	function to wait for any ldisc lifetime events to finish.
+ * Note 2: a file_operations routine (read/poll/write) should use this function
+ * to wait for any ldisc lifetime events to finish.
  */
-
 struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld;
@@ -258,14 +250,13 @@ struct tty_ldisc *tty_ldisc_ref_wait(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_ldisc_ref_wait);
 
 /**
- *	tty_ldisc_ref		-	get the tty ldisc
- *	@tty: tty device
+ * tty_ldisc_ref	-	get the tty ldisc
+ * @tty: tty device
  *
- *	Dereference the line discipline for the terminal and take a
- *	reference to it. If the line discipline is in flux then
- *	return NULL. Can be called from IRQ and timer functions.
+ * Dereference the line discipline for the terminal and take a reference to it.
+ * If the line discipline is in flux then return %NULL. Can be called from IRQ
+ * and timer functions.
  */
-
 struct tty_ldisc *tty_ldisc_ref(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = NULL;
@@ -280,13 +271,12 @@ struct tty_ldisc *tty_ldisc_ref(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_ldisc_ref);
 
 /**
- *	tty_ldisc_deref		-	free a tty ldisc reference
- *	@ld: reference to free up
+ * tty_ldisc_deref	-	free a tty ldisc reference
+ * @ld: reference to free up
  *
- *	Undoes the effect of tty_ldisc_ref or tty_ldisc_ref_wait. May
- *	be called in IRQ context.
+ * Undoes the effect of tty_ldisc_ref() or tty_ldisc_ref_wait(). May be called
+ * in IRQ context.
  */
-
 void tty_ldisc_deref(struct tty_ldisc *ld)
 {
 	ldsem_up_read(&ld->tty->ldisc_sem);
@@ -386,13 +376,12 @@ static void tty_ldisc_unlock_pair(struct tty_struct *tty,
 }
 
 /**
- *	tty_ldisc_flush	-	flush line discipline queue
- *	@tty: tty
+ * tty_ldisc_flush		-	flush line discipline queue
+ * @tty: tty to flush ldisc for
  *
- *	Flush the line discipline queue (if any) and the tty flip buffers
- *	for this tty.
+ * Flush the line discipline queue (if any) and the tty flip buffers for this
+ * @tty.
  */
-
 void tty_ldisc_flush(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = tty_ldisc_ref(tty);
@@ -404,21 +393,18 @@ void tty_ldisc_flush(struct tty_struct *tty)
 EXPORT_SYMBOL_GPL(tty_ldisc_flush);
 
 /**
- *	tty_set_termios_ldisc		-	set ldisc field
- *	@tty: tty structure
- *	@disc: line discipline number
+ * tty_set_termios_ldisc	-	set ldisc field
+ * @tty: tty structure
+ * @disc: line discipline number
  *
- *	This is probably overkill for real world processors but
- *	they are not on hot paths so a little discipline won't do
- *	any harm.
+ * This is probably overkill for real world processors but they are not on hot
+ * paths so a little discipline won't do any harm.
  *
- *	The line discipline-related tty_struct fields are reset to
- *	prevent the ldisc driver from re-using stale information for
- *	the new ldisc instance.
+ * The line discipline-related tty_struct fields are reset to prevent the ldisc
+ * driver from re-using stale information for the new ldisc instance.
  *
- *	Locking: takes termios_rwsem
+ * Locking: takes termios_rwsem
  */
-
 static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
 {
 	down_write(&tty->termios_rwsem);
@@ -430,16 +416,14 @@ static void tty_set_termios_ldisc(struct tty_struct *tty, int disc)
 }
 
 /**
- *	tty_ldisc_open		-	open a line discipline
- *	@tty: tty we are opening the ldisc on
- *	@ld: discipline to open
+ * tty_ldisc_open		-	open a line discipline
+ * @tty: tty we are opening the ldisc on
+ * @ld: discipline to open
  *
- *	A helper opening method. Also a convenient debugging and check
- *	point.
+ * A helper opening method. Also a convenient debugging and check point.
  *
- *	Locking: always called with BTM already held.
+ * Locking: always called with BTM already held.
  */
-
 static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	WARN_ON(test_and_set_bit(TTY_LDISC_OPEN, &tty->flags));
@@ -457,14 +441,12 @@ static int tty_ldisc_open(struct tty_struct *tty, struct tty_ldisc *ld)
 }
 
 /**
- *	tty_ldisc_close		-	close a line discipline
- *	@tty: tty we are opening the ldisc on
- *	@ld: discipline to close
+ * tty_ldisc_close		-	close a line discipline
+ * @tty: tty we are opening the ldisc on
+ * @ld: discipline to close
  *
- *	A helper close method. Also a convenient debugging and check
- *	point.
+ * A helper close method. Also a convenient debugging and check point.
  */
-
 static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 {
 	lockdep_assert_held_write(&tty->ldisc_sem);
@@ -476,14 +458,13 @@ static void tty_ldisc_close(struct tty_struct *tty, struct tty_ldisc *ld)
 }
 
 /**
- *	tty_ldisc_failto	-	helper for ldisc failback
- *	@tty: tty to open the ldisc on
- *	@ld: ldisc we are trying to fail back to
+ * tty_ldisc_failto	-	helper for ldisc failback
+ * @tty: tty to open the ldisc on
+ * @ld: ldisc we are trying to fail back to
  *
- *	Helper to try and recover a tty when switching back to the old
- *	ldisc fails and we need something attached.
+ * Helper to try and recover a tty when switching back to the old ldisc fails
+ * and we need something attached.
  */
-
 static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 {
 	struct tty_ldisc *disc = tty_ldisc_get(tty, ld);
@@ -501,14 +482,13 @@ static int tty_ldisc_failto(struct tty_struct *tty, int ld)
 }
 
 /**
- *	tty_ldisc_restore	-	helper for tty ldisc change
- *	@tty: tty to recover
- *	@old: previous ldisc
+ * tty_ldisc_restore	-	helper for tty ldisc change
+ * @tty: tty to recover
+ * @old: previous ldisc
  *
- *	Restore the previous line discipline or N_TTY when a line discipline
- *	change fails due to an open error
+ * Restore the previous line discipline or %N_TTY when a line discipline change
+ * fails due to an open error
  */
-
 static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 {
 	/* There is an outstanding reference here so this is safe */
@@ -528,16 +508,15 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 }
 
 /**
- *	tty_set_ldisc		-	set line discipline
- *	@tty: the terminal to set
- *	@disc: the line discipline number
- *
- *	Set the discipline of a tty line. Must be called from a process
- *	context. The ldisc change logic has to protect itself against any
- *	overlapping ldisc change (including on the other end of pty pairs),
- *	the close of one side of a tty/pty pair, and eventually hangup.
+ * tty_set_ldisc		-	set line discipline
+ * @tty: the terminal to set
+ * @disc: the line discipline number
+ *
+ * Set the discipline of a tty line. Must be called from a process context. The
+ * ldisc change logic has to protect itself against any overlapping ldisc
+ * change (including on the other end of pty pairs), the close of one side of a
+ * tty/pty pair, and eventually hangup.
  */
-
 int tty_set_ldisc(struct tty_struct *tty, int disc)
 {
 	int retval;
@@ -613,10 +592,10 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
 EXPORT_SYMBOL_GPL(tty_set_ldisc);
 
 /**
- *	tty_ldisc_kill	-	teardown ldisc
- *	@tty: tty being released
+ * tty_ldisc_kill	-	teardown ldisc
+ * @tty: tty being released
  *
- *	Perform final close of the ldisc and reset tty->ldisc
+ * Perform final close of the ldisc and reset @tty->ldisc
  */
 static void tty_ldisc_kill(struct tty_struct *tty)
 {
@@ -633,12 +612,11 @@ static void tty_ldisc_kill(struct tty_struct *tty)
 }
 
 /**
- *	tty_reset_termios	-	reset terminal state
- *	@tty: tty to reset
+ * tty_reset_termios	-	reset terminal state
+ * @tty: tty to reset
  *
- *	Restore a terminal to the driver default state.
+ * Restore a terminal to the driver default state.
  */
-
 static void tty_reset_termios(struct tty_struct *tty)
 {
 	down_write(&tty->termios_rwsem);
@@ -650,19 +628,17 @@ static void tty_reset_termios(struct tty_struct *tty)
 
 
 /**
- *	tty_ldisc_reinit	-	reinitialise the tty ldisc
- *	@tty: tty to reinit
- *	@disc: line discipline to reinitialize
+ * tty_ldisc_reinit	-	reinitialise the tty ldisc
+ * @tty: tty to reinit
+ * @disc: line discipline to reinitialize
  *
- *	Completely reinitialize the line discipline state, by closing the
- *	current instance, if there is one, and opening a new instance. If
- *	an error occurs opening the new non-N_TTY instance, the instance
- *	is dropped and tty->ldisc reset to NULL. The caller can then retry
- *	with N_TTY instead.
+ * Completely reinitialize the line discipline state, by closing the current
+ * instance, if there is one, and opening a new instance. If an error occurs
+ * opening the new non-%N_TTY instance, the instance is dropped and @tty->ldisc
+ * reset to %NULL. The caller can then retry with %N_TTY instead.
  *
- *	Returns 0 if successful, otherwise error code < 0
+ * Returns: 0 if successful, otherwise error code < 0
  */
-
 int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 {
 	struct tty_ldisc *ld;
@@ -692,21 +668,20 @@ int tty_ldisc_reinit(struct tty_struct *tty, int disc)
 }
 
 /**
- *	tty_ldisc_hangup		-	hangup ldisc reset
- *	@tty: tty being hung up
- *	@reinit: whether to re-initialise the tty
+ * tty_ldisc_hangup	-	hangup ldisc reset
+ * @tty: tty being hung up
+ * @reinit: whether to re-initialise the tty
  *
- *	Some tty devices reset their termios when they receive a hangup
- *	event. In that situation we must also switch back to N_TTY properly
- *	before we reset the termios data.
+ * Some tty devices reset their termios when they receive a hangup event. In
+ * that situation we must also switch back to %N_TTY properly before we reset
+ * the termios data.
  *
- *	Locking: We can take the ldisc mutex as the rest of the code is
- *	careful to allow for this.
+ * Locking: We can take the ldisc mutex as the rest of the code is careful to
+ * allow for this.
  *
- *	In the pty pair case this occurs in the close() path of the
- *	tty itself so we must be careful about locking rules.
+ * In the pty pair case this occurs in the close() path of the tty itself so we
+ * must be careful about locking rules.
  */
-
 void tty_ldisc_hangup(struct tty_struct *tty, bool reinit)
 {
 	struct tty_ldisc *ld;
@@ -752,15 +727,14 @@ void tty_ldisc_hangup(struct tty_struct *tty, bool reinit)
 }
 
 /**
- *	tty_ldisc_setup			-	open line discipline
- *	@tty: tty being shut down
- *	@o_tty: pair tty for pty/tty pairs
+ * tty_ldisc_setup	-	open line discipline
+ * @tty: tty being shut down
+ * @o_tty: pair tty for pty/tty pairs
  *
- *	Called during the initial open of a tty/pty pair in order to set up the
- *	line disciplines and bind them to the tty. This has no locking issues
- *	as the device isn't yet active.
+ * Called during the initial open of a tty/pty pair in order to set up the line
+ * disciplines and bind them to the @tty. This has no locking issues as the
+ * device isn't yet active.
  */
-
 int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
 {
 	int retval = tty_ldisc_open(tty, tty->ldisc);
@@ -783,13 +757,12 @@ int tty_ldisc_setup(struct tty_struct *tty, struct tty_struct *o_tty)
 }
 
 /**
- *	tty_ldisc_release		-	release line discipline
- *	@tty: tty being shut down (or one end of pty pair)
+ * tty_ldisc_release	-	release line discipline
+ * @tty: tty being shut down (or one end of pty pair)
  *
- *	Called during the final close of a tty or a pty pair in order to shut
- *	down the line discpline layer. On exit, each tty's ldisc is NULL.
+ * Called during the final close of a tty or a pty pair in order to shut down
+ * the line discpline layer. On exit, each tty's ldisc is %NULL.
  */
-
 void tty_ldisc_release(struct tty_struct *tty)
 {
 	struct tty_struct *o_tty = tty->link;
@@ -814,13 +787,12 @@ void tty_ldisc_release(struct tty_struct *tty)
 }
 
 /**
- *	tty_ldisc_init		-	ldisc setup for new tty
- *	@tty: tty being allocated
+ * tty_ldisc_init	-	ldisc setup for new tty
+ * @tty: tty being allocated
  *
- *	Set up the line discipline objects for a newly allocated tty. Note that
- *	the tty structure is not completely set up when this call is made.
+ * Set up the line discipline objects for a newly allocated tty. Note that the
+ * tty structure is not completely set up when this call is made.
  */
-
 int tty_ldisc_init(struct tty_struct *tty)
 {
 	struct tty_ldisc *ld = tty_ldisc_get(tty, N_TTY);
@@ -832,11 +804,11 @@ int tty_ldisc_init(struct tty_struct *tty)
 }
 
 /**
- *	tty_ldisc_deinit	-	ldisc cleanup for new tty
- *	@tty: tty that was allocated recently
+ * tty_ldisc_deinit	-	ldisc cleanup for new tty
+ * @tty: tty that was allocated recently
  *
- *	The tty structure must not becompletely set up (tty_ldisc_setup) when
- *      this call is made.
+ * The tty structure must not be completely set up (tty_ldisc_setup()) when
+ * this call is made.
  */
 void tty_ldisc_deinit(struct tty_struct *tty)
 {
-- 
2.34.0

