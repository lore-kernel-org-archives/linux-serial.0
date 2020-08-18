Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E879FC433E3
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5AE2078B
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgHRI6m (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:58:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:37702 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHRI47 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:56:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D5C6B02D;
        Tue, 18 Aug 2020 08:57:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/8] tty: fix kernel-doc
Date:   Tue, 18 Aug 2020 10:56:51 +0200
Message-Id: <20200818085655.12071-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085655.12071-1-jslaby@suse.cz>
References: <20200818085655.12071-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

With W=1, the kernel-doc checker complains quite a lot in the tty layer.
Over the time, many documented parameters were renamed, removed or
switched from tty to tty_port and similar. Some were mistyped in the doc
too.

So fix all these in the tty core. (But do not add the missing ones which
the checker complains about too. Not now.) The rest in the tty layer
will follow in the next patches.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/pty.c          |  2 +-
 drivers/tty/tty_baudrate.c |  6 +++---
 drivers/tty/tty_buffer.c   | 14 +++++++-------
 drivers/tty/tty_io.c       | 26 ++++++++++++--------------
 drivers/tty/tty_jobctrl.c  |  4 ++--
 drivers/tty/tty_ldisc.c    |  3 +--
 6 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/pty.c b/drivers/tty/pty.c
index 00099a8439d2..b6d8cc7f0f16 100644
--- a/drivers/tty/pty.c
+++ b/drivers/tty/pty.c
@@ -100,7 +100,7 @@ static void pty_unthrottle(struct tty_struct *tty)
  *	pty_write		-	write to a pty
  *	@tty: the tty we write from
  *	@buf: kernel buffer of data
- *	@count: bytes to write
+ *	@c: bytes to write
  *
  *	Our "hardware" write method. Data is coming from the ldisc which
  *	may be in a non sleeping state. We simply throw this at the other
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 40207cab3b2a..84fec3c62d6a 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -119,8 +119,8 @@ EXPORT_SYMBOL(tty_termios_input_baud_rate);
 /**
  *	tty_termios_encode_baud_rate
  *	@termios: ktermios structure holding user requested state
- *	@ispeed: input speed
- *	@ospeed: output speed
+ *	@ibaud: input speed
+ *	@obaud: output speed
  *
  *	Encode the speeds set into the passed termios structure. This is
  *	used as a library helper for drivers so that they can report back
@@ -223,7 +223,7 @@ EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
 /**
  *	tty_encode_baud_rate		-	set baud rate of the tty
  *	@ibaud: input baud rate
- *	@obad: output baud rate
+ *	@obaud: output baud rate
  *
  *	Update the current termios data for the tty with the new speed
  *	settings. The caller must hold the termios_rwsem for the tty in
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index ec145a59f199..bd2d91546e32 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -42,7 +42,7 @@
  *	tty_buffer_lock_exclusive	-	gain exclusive access to buffer
  *	tty_buffer_unlock_exclusive	-	release exclusive access
  *
- *	@port - tty_port owning the flip buffer
+ *	@port: tty port owning the flip buffer
  *
  *	Guarantees safe use of the line discipline's receive_buf() method by
  *	excluding the buffer work and any pending flush from using the flip
@@ -78,7 +78,7 @@ EXPORT_SYMBOL_GPL(tty_buffer_unlock_exclusive);
 
 /**
  *	tty_buffer_space_avail	-	return unused buffer space
- *	@port - tty_port owning the flip buffer
+ *	@port: tty port owning the flip buffer
  *
  *	Returns the # of bytes which can be written by the driver without
  *	reaching the buffer limit.
@@ -107,7 +107,7 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 
 /**
  *	tty_buffer_free_all		-	free buffers used by a tty
- *	@tty: tty to free from
+ *	@port: tty port to free from
  *
  *	Remove all the buffers pending on a tty whether queued with data
  *	or in the free ring. Must be called when the tty is no longer in use
@@ -142,7 +142,7 @@ void tty_buffer_free_all(struct tty_port *port)
 
 /**
  *	tty_buffer_alloc	-	allocate a tty buffer
- *	@tty: tty device
+ *	@port: tty port
  *	@size: desired size (characters)
  *
  *	Allocate a new tty buffer to hold the desired number of characters.
@@ -184,7 +184,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
 
 /**
  *	tty_buffer_free		-	free a tty buffer
- *	@tty: tty owning the buffer
+ *	@port: tty port owning the buffer
  *	@b: the buffer to free
  *
  *	Free a tty buffer, or add it to the free list according to our
@@ -243,7 +243,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
 
 /**
  *	tty_buffer_request_room		-	grow tty buffer if needed
- *	@tty: tty structure
+ *	@port: tty port
  *	@size: size desired
  *	@flags: buffer flags if new buffer allocated (default = 0)
  *
@@ -559,7 +559,7 @@ EXPORT_SYMBOL(tty_flip_buffer_push);
 
 /**
  *	tty_buffer_init		-	prepare a tty buffer structure
- *	@tty: tty to initialise
+ *	@port: tty port to initialise
  *
  *	Set up the initial state of the buffer management for a tty device.
  *	Must be called before the other tty buffer functions are used.
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ceed72c9a88f..7a4c02548fb3 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -307,7 +307,7 @@ static int check_tty_count(struct tty_struct *tty, const char *routine)
 
 /**
  *	get_tty_driver		-	find device of a tty
- *	@dev_t: device identifier
+ *	@device: device identifier
  *	@index: returns the index of the tty
  *
  *	This routine returns a tty driver structure, given a device number
@@ -544,7 +544,7 @@ EXPORT_SYMBOL_GPL(tty_wakeup);
 
 /**
  *	__tty_hangup		-	actual handler for hangup events
- *	@work: tty device
+ *	@tty: tty device
  *
  *	This can be called by a "kworker" kernel thread.  That is process
  *	synchronous but doesn't hold any locks, so we need to make sure we
@@ -1232,7 +1232,7 @@ static int tty_driver_install_tty(struct tty_driver *driver,
 /**
  *	tty_driver_remove_tty() - remove a tty from the driver tables
  *	@driver: the driver for the tty
- *	@idx:	 the minor number
+ *	@tty: tty to remove
  *
  *	Remvoe a tty object from the driver tables. The tty->index field
  *	will be set by the time this is called.
@@ -1247,9 +1247,9 @@ static void tty_driver_remove_tty(struct tty_driver *driver, struct tty_struct *
 		driver->ttys[tty->index] = NULL;
 }
 
-/*
- * 	tty_reopen()	- fast re-open of an open tty
- * 	@tty	- the tty to open
+/**
+ *	tty_reopen()	- fast re-open of an open tty
+ *	@tty: the tty to open
  *
  *	Return 0 on success, -errno on error.
  *	Re-opens on master ptys are not allowed and return -EIO.
@@ -1295,7 +1295,6 @@ static int tty_reopen(struct tty_struct *tty)
  *	tty_init_dev		-	initialise a tty device
  *	@driver: tty driver we are opening a device on
  *	@idx: device index
- *	@ret_tty: returned tty structure
  *
  *	Prepare a tty device. This may not be a "new" clean device but
  *	could also be an active device. The pty drivers require special
@@ -1313,6 +1312,8 @@ static int tty_reopen(struct tty_struct *tty)
  * failed open.  The new code protects the open with a mutex, so it's
  * really quite straightforward.  The mutex locking can probably be
  * relaxed for the (most common) case of reopening a tty.
+ *
+ *	Return: returned tty structure
  */
 
 struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx)
@@ -1432,7 +1433,7 @@ static void tty_flush_works(struct tty_struct *tty)
 
 /**
  *	release_one_tty		-	release tty structure memory
- *	@kref: kref of tty we are obliterating
+ *	@work: work of tty we are obliterating
  *
  *	Releases memory associated with a tty structure, and clears out the
  *	driver table slots. This function is called when a device is no longer
@@ -1528,7 +1529,6 @@ static void release_tty(struct tty_struct *tty, int idx)
 /**
  *	tty_release_checks - check a tty before real release
  *	@tty: tty to check
- *	@o_tty: link of @tty (if any)
  *	@idx: index of the tty
  *
  *	Performs some paranoid checking before true release of the @tty.
@@ -2200,7 +2200,7 @@ static int tiocsti(struct tty_struct *tty, char __user *p)
 
 /**
  *	tiocgwinsz		-	implement window query ioctl
- *	@tty; tty
+ *	@tty: tty
  *	@arg: user buffer for result
  *
  *	Copies the kernel idea of the window size into the user buffer.
@@ -2223,8 +2223,7 @@ static int tiocgwinsz(struct tty_struct *tty, struct winsize __user *arg)
 /**
  *	tty_do_resize		-	resize event
  *	@tty: tty being resized
- *	@rows: rows (character)
- *	@cols: cols (character)
+ *	@ws: new dimensions
  *
  *	Update the termios variables and send the necessary signals to
  *	peform a terminal resize correctly
@@ -2254,7 +2253,7 @@ EXPORT_SYMBOL(tty_do_resize);
 
 /**
  *	tiocswinsz		-	implement window size set ioctl
- *	@tty; tty side of tty
+ *	@tty: tty side of tty
  *	@arg: user buffer for result
  *
  *	Copies the user idea of the window size to the kernel. Traditionally
@@ -2402,7 +2401,6 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 /**
  *	tty_tiocmget		-	get modem status
  *	@tty: tty device
- *	@file: user file pointer
  *	@p: pointer to result
  *
  *	Obtain the modem status bits from the tty driver if the feature
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index f8ed50a16848..28a23a0fef21 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -178,8 +178,8 @@ void session_clear_tty(struct pid *session)
 
 /**
  *	tty_signal_session_leader	- sends SIGHUP to session leader
- *	@tty		controlling tty
- *	@exit_session	if non-zero, signal all foreground group processes
+ *	@tty: controlling tty
+ *	@exit_session: if non-zero, signal all foreground group processes
  *
  *	Send SIGHUP and SIGCONT to the session leader and its process group.
  *	Optionally, signal all processes in the foreground process group.
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index ec1f6a48121e..fe37ec331289 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -79,7 +79,6 @@ EXPORT_SYMBOL(tty_register_ldisc);
 /**
  *	tty_unregister_ldisc	-	unload a line discipline
  *	@disc: ldisc number
- *	@new_ldisc: pointer to the ldisc object
  *
  *	Remove a line discipline from the kernel providing it is not
  *	currently in use.
@@ -542,7 +541,7 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 /**
  *	tty_set_ldisc		-	set line discipline
  *	@tty: the terminal to set
- *	@ldisc: the line discipline
+ *	@disc: the line discipline number
  *
  *	Set the discipline of a tty line. Must be called from a process
  *	context. The ldisc change logic has to protect itself against any
-- 
2.28.0

