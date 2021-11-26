Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D373C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359463AbhKZIVk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:40 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50440 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359411AbhKZIT0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0F38C21958;
        Fri, 26 Nov 2021 08:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWI22Gk1PMdJ270vS0GCU9bXH96dYtAmv3LRD9/1GPs=;
        b=gqVSGMMGfjnPqLOJHUT/g3JEiLLti9kKaH/SOPKZ+qbj4MD0fDpWRGSUHIcNUgsysh6ZPw
        rrPP3rUS/3nVnMUCKufkb5RLm9oLqVWu0Yi/O2gGqYevVFm41hRxx+2ZYNQMy547kx4bZT
        B1pdqRmviHN61W8NxzjRfPCOJWkAibg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWI22Gk1PMdJ270vS0GCU9bXH96dYtAmv3LRD9/1GPs=;
        b=AKuFIKj6aA2mAZwrFsfgO776MqALfW1He9kTBOvNxbIjI8++TdKWK4ELUEyPGbPOA97LGO
        jTFGTB46uDcgnmBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D0D62A3B83;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/23] tty: add kernel-doc for tty_operations
Date:   Fri, 26 Nov 2021 09:15:52 +0100
Message-Id: <20211126081611.11001-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_operations structure was already documented in a standalone comment
in the header beginning.

Move it right before the structure and reformat it so it complies to
kernel-doc. That way, we can include it in Documentation/ later in this
series.

Note that we named proc_show's parameters, so that we can reference
them in the text.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_driver.h | 398 ++++++++++++++++++++++---------------
 1 file changed, 241 insertions(+), 157 deletions(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 3622404a678d..5611992ab26a 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -2,248 +2,332 @@
 #ifndef _LINUX_TTY_DRIVER_H
 #define _LINUX_TTY_DRIVER_H
 
-/*
- * This structure defines the interface between the low-level tty
- * driver and the tty routines.  The following routines can be
- * defined; unless noted otherwise, they are optional, and can be
- * filled in with a null pointer.
+#include <linux/export.h>
+#include <linux/fs.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/cdev.h>
+#include <linux/termios.h>
+#include <linux/seq_file.h>
+
+struct tty_struct;
+struct tty_driver;
+struct serial_icounter_struct;
+struct serial_struct;
+
+/**
+ * struct tty_operations -- interface between driver and tty
  *
- * struct tty_struct * (*lookup)(struct tty_driver *self, struct file *, int idx)
+ * @lookup: ``struct tty_struct *()(struct tty_driver *self, struct file *,
+ *				    int idx)``
  *
- *	Return the tty device corresponding to idx, NULL if there is not
- *	one currently in use and an ERR_PTR value on error. Called under
- *	tty_mutex (for now!)
+ *	Return the tty device corresponding to @idx, %NULL if there is not
+ *	one currently in use and an %ERR_PTR value on error. Called under
+ *	%tty_mutex (for now!)
  *
- *	Optional method. Default behaviour is to use the ttys array
+ *	Optional method. Default behaviour is to use the @self->ttys array.
  *
- * int (*install)(struct tty_driver *self, struct tty_struct *tty)
+ * @install: ``int ()(struct tty_driver *self, struct tty_struct *tty)``
  *
- *	Install a new tty into the tty driver internal tables. Used in
- *	conjunction with lookup and remove methods.
+ *	Install a new @tty into the @self's internal tables. Used in
+ *	conjunction with @lookup and @remove methods.
  *
- *	Optional method. Default behaviour is to use the ttys array
+ *	Optional method. Default behaviour is to use the @self->ttys array.
  *
- * void (*remove)(struct tty_driver *self, struct tty_struct *tty)
+ * @remove: ``void ()(struct tty_driver *self, struct tty_struct *tty)``
  *
- *	Remove a closed tty from the tty driver internal tables. Used in
- *	conjunction with lookup and remove methods.
+ *	Remove a closed @tty from the @self's internal tables. Used in
+ *	conjunction with @lookup and @remove methods.
  *
- *	Optional method. Default behaviour is to use the ttys array
+ *	Optional method. Default behaviour is to use the @self->ttys array.
  *
- * int  (*open)(struct tty_struct * tty, struct file * filp);
+ * @open: ``int ()(struct tty_struct *tty, struct file *)``
  *
- * 	This routine is called when a particular tty device is opened.
- * 	This routine is mandatory; if this routine is not filled in,
- * 	the attempted open will fail with ENODEV.
+ *	This routine is called when a particular @tty device is opened. This
+ *	routine is mandatory; if this routine is not filled in, the attempted
+ *	open will fail with %ENODEV.
  *
  *	Required method. Called with tty lock held.
  *
- * void (*close)(struct tty_struct * tty, struct file * filp);
+ * @close: ``void ()(struct tty_struct *tty, struct file *)``
  *
- * 	This routine is called when a particular tty device is closed.
- *	Note: called even if the corresponding open() failed.
+ *	This routine is called when a particular @tty device is closed.
+ *
+ *	Remark: called even if the corresponding @open() failed.
  *
  *	Required method. Called with tty lock held.
  *
- * void (*shutdown)(struct tty_struct * tty);
+ * @shutdown: ``void ()(struct tty_struct *tty)``
  *
- * 	This routine is called under the tty lock when a particular tty device
- *	is closed for the last time. It executes before the tty resources
- *	are freed so may execute while another function holds a tty kref.
+ *	This routine is called under the tty lock when a particular @tty device
+ *	is closed for the last time. It executes before the @tty resources
+ *	are freed so may execute while another function holds a @tty kref.
  *
- * void (*cleanup)(struct tty_struct * tty);
+ * @cleanup: ``void ()(struct tty_struct *tty)``
  *
- *	This routine is called asynchronously when a particular tty device
+ *	This routine is called asynchronously when a particular @tty device
  *	is closed for the last time freeing up the resources. This is
  *	actually the second part of shutdown for routines that might sleep.
  *
+ * @write: ``int ()(struct tty_struct *tty, const unsigned char *buf,
+ *		    int count)``
  *
- * int (*write)(struct tty_struct * tty,
- * 		 const unsigned char *buf, int count);
- *
- * 	This routine is called by the kernel to write a series of
- * 	characters to the tty device.  The characters may come from
- * 	user space or kernel space.  This routine will return the
+ *	This routine is called by the kernel to write a series (@count) of
+ *	characters (@buf) to the @tty device. The characters may come from
+ *	user space or kernel space.  This routine will return the
  *	number of characters actually accepted for writing.
  *
  *	Optional: Required for writable devices.
  *
- * int (*put_char)(struct tty_struct *tty, unsigned char ch);
+ * @put_char: ``int ()(struct tty_struct *tty, unsigned char ch)``
  *
- * 	This routine is called by the kernel to write a single
- * 	character to the tty device.  If the kernel uses this routine,
- * 	it must call the flush_chars() routine (if defined) when it is
- * 	done stuffing characters into the driver.  If there is no room
- * 	in the queue, the character is ignored.
+ *	This routine is called by the kernel to write a single character @ch to
+ *	the @tty device. If the kernel uses this routine, it must call the
+ *	@flush_chars() routine (if defined) when it is done stuffing characters
+ *	into the driver. If there is no room in the queue, the character is
+ *	ignored.
  *
- *	Optional: Kernel will use the write method if not provided.
+ *	Optional: Kernel will use the @write method if not provided. Do not
+ *	call this function directly, call tty_put_char().
  *
- *	Note: Do not call this function directly, call tty_put_char
+ * @flush_chars: ``void ()(struct tty_struct *tty)``
  *
- * void (*flush_chars)(struct tty_struct *tty);
+ *	This routine is called by the kernel after it has written a
+ *	series of characters to the tty device using @put_char().
  *
- * 	This routine is called by the kernel after it has written a
- * 	series of characters to the tty device using put_char().  
+ *	Optional. Do not call this function directly, call
+ *	tty_driver_flush_chars().
  *
- *	Optional:
+ * @write_room: ``unsigned int ()(struct tty_struct *tty)``
  *
- *	Note: Do not call this function directly, call tty_driver_flush_chars
- * 
- * unsigned int  (*write_room)(struct tty_struct *tty);
- *
- * 	This routine returns the numbers of characters the tty driver
- * 	will accept for queuing to be written.  This number is subject
- * 	to change as output buffers get emptied, or if the output flow
+ *	This routine returns the numbers of characters the @tty driver
+ *	will accept for queuing to be written.  This number is subject
+ *	to change as output buffers get emptied, or if the output flow
  *	control is acted.
  *
- *	Required if write method is provided else not needed.
+ *	Required if @write method is provided else not needed. Do not call this
+ *	function directly, call tty_write_room()
  *
- *	Note: Do not call this function directly, call tty_write_room
- * 
- * int  (*ioctl)(struct tty_struct *tty, unsigned int cmd, unsigned long arg);
+ * @chars_in_buffer: ``unsigned int ()(struct tty_struct *tty)``
  *
- * 	This routine allows the tty driver to implement
- *	device-specific ioctls.  If the ioctl number passed in cmd
- * 	is not recognized by the driver, it should return ENOIOCTLCMD.
+ *	This routine returns the number of characters in the device private
+ *	output queue. Used in tty_wait_until_sent() and for poll()
+ *	implementation.
  *
- *	Optional
+ *	Optional: if not provided, it is assumed there is no queue on the
+ *	device. Do not call this function directly, call tty_chars_in_buffer().
  *
- * long (*compat_ioctl)(struct tty_struct *tty,,
- * 	                unsigned int cmd, unsigned long arg);
+ * @ioctl: ``int ()(struct tty_struct *tty, unsigned int cmd,
+ *		    unsigned long arg)``
  *
- * 	implement ioctl processing for 32 bit process on 64 bit system
+ *	This routine allows the @tty driver to implement device-specific
+ *	ioctls. If the ioctl number passed in @cmd is not recognized by the
+ *	driver, it should return %ENOIOCTLCMD.
  *
- *	Optional
- * 
- * void (*set_termios)(struct tty_struct *tty, struct ktermios * old);
+ *	Optional.
  *
- * 	This routine allows the tty driver to be notified when
- * 	device's termios settings have changed.
+ * @compat_ioctl: ``long ()(struct tty_struct *tty, unsigned int cmd,
+ *			  unsigned long arg)``
  *
- *	Optional: Called under the termios lock
+ *	Implement ioctl processing for 32 bit process on 64 bit system.
  *
+ *	Optional.
  *
- * void (*set_ldisc)(struct tty_struct *tty);
+ * @set_termios: ``void ()(struct tty_struct *tty, struct ktermios *old)``
  *
- * 	This routine allows the tty driver to be notified when the
- * 	device's termios settings have changed.
+ *	This routine allows the @tty driver to be notified when device's
+ *	termios settings have changed.
  *
- *	Optional: Called under BKL (currently)
- * 
- * void (*throttle)(struct tty_struct * tty);
+ *	Optional: Called under the @tty->termios_rwsem.
  *
- * 	This routine notifies the tty driver that input buffers for
- * 	the line discipline are close to full, and it should somehow
- * 	signal that no more characters should be sent to the tty.
+ * @set_ldisc: ``void ()(struct tty_struct *tty)``
  *
- *	Optional: Always invoke via tty_throttle_safe(), called under the
- *	termios lock.
- * 
- * void (*unthrottle)(struct tty_struct * tty);
+ *	This routine allows the @tty driver to be notified when the device's
+ *	line discipline is being changed.
  *
- * 	This routine notifies the tty drivers that it should signals
- * 	that characters can now be sent to the tty without fear of
- * 	overrunning the input buffers of the line disciplines.
- * 
- *	Optional: Always invoke via tty_unthrottle(), called under the
- *	termios lock.
+ *	Optional. Called under the @tty->ldisc_sem and @tty->termios_rwsem.
  *
- * void (*stop)(struct tty_struct *tty);
+ * @throttle: ``void ()(struct tty_struct *tty)``
  *
- * 	This routine notifies the tty driver that it should stop
- * 	outputting characters to the tty device.  
+ *	This routine notifies the @tty driver that input buffers for the line
+ *	discipline are close to full, and it should somehow signal that no more
+ *	characters should be sent to the @tty.
  *
- *	Called with ->flow.lock held. Serialized with start() method.
+ *	Optional: Always invoke via tty_throttle_safe(). Called under the
+ *	@tty->termios_rwsem.
  *
- *	Optional:
+ * @unthrottle: ``void ()(struct tty_struct *tty)``
  *
- *	Note: Call stop_tty not this method.
- * 
- * void (*start)(struct tty_struct *tty);
+ *	This routine notifies the @tty driver that it should signal that
+ *	characters can now be sent to the @tty without fear of overrunning the
+ *	input buffers of the line disciplines.
  *
- * 	This routine notifies the tty driver that it resume sending
+ *	Optional. Always invoke via tty_unthrottle(). Called under the
+ *	@tty->termios_rwsem.
+ *
+ * @stop: ``void ()(struct tty_struct *tty)``
+ *
+ *	This routine notifies the @tty driver that it should stop outputting
  *	characters to the tty device.
  *
- *	Called with ->flow.lock held. Serialized with stop() method.
+ *	Called with @tty->flow.lock held. Serialized with @start() method.
  *
- *	Optional:
+ *	Optional. Always invoke via stop_tty().
  *
- *	Note: Call start_tty not this method.
- * 
- * void (*hangup)(struct tty_struct *tty);
+ * @start: ``void ()(struct tty_struct *tty)``
  *
- * 	This routine notifies the tty driver that it should hang up the
- * 	tty device.
+ *	This routine notifies the @tty driver that it resumed sending
+ *	characters to the @tty device.
  *
- *	Optional:
+ *	Called with @tty->flow.lock held. Serialized with stop() method.
  *
- *	Called with tty lock held.
+ *	Optional. Always invoke via start_tty().
  *
- * int (*break_ctl)(struct tty_struct *tty, int state);
+ * @hangup: ``void ()(struct tty_struct *tty)``
  *
- * 	This optional routine requests the tty driver to turn on or
- * 	off BREAK status on the RS-232 port.  If state is -1,
- * 	then the BREAK status should be turned on; if state is 0, then
- * 	BREAK should be turned off.
+ *	This routine notifies the @tty driver that it should hang up the @tty
+ *	device.
  *
- * 	If this routine is implemented, the high-level tty driver will
- * 	handle the following ioctls: TCSBRK, TCSBRKP, TIOCSBRK,
- * 	TIOCCBRK.
+ *	Optional. Called with tty lock held.
  *
- *	If the driver sets TTY_DRIVER_HARDWARE_BREAK then the interface
- *	will also be called with actual times and the hardware is expected
- *	to do the delay work itself. 0 and -1 are still used for on/off.
+ * @break_ctl: ``int ()(struct tty_struct *tty, int state)``
  *
- *	Optional: Required for TCSBRK/BRKP/etc handling.
+ *	This optional routine requests the @tty driver to turn on or off BREAK
+ *	status on the RS-232 port. If @state is -1, then the BREAK status
+ *	should be turned on; if @state is 0, then BREAK should be turned off.
  *
- * void (*wait_until_sent)(struct tty_struct *tty, int timeout);
- * 
- * 	This routine waits until the device has written out all of the
- * 	characters in its transmitter FIFO.
+ *	If this routine is implemented, the high-level tty driver will handle
+ *	the following ioctls: %TCSBRK, %TCSBRKP, %TIOCSBRK, %TIOCCBRK.
+ *
+ *	If the driver sets %TTY_DRIVER_HARDWARE_BREAK in tty_alloc_driver(),
+ *	then the interface will also be called with actual times and the
+ *	hardware is expected to do the delay work itself. 0 and -1 are still
+ *	used for on/off.
+ *
+ *	Optional: Required for %TCSBRK/%BRKP/etc. handling.
+ *
+ * @flush_buffer: ``void ()(struct tty_struct *tty)``
+ *
+ *	This routine discards device private output buffer. Invoked on close,
+ *	hangup, to implement %TCOFLUSH ioctl and similar.
+ *
+ *	Optional: if not provided, it is assumed there is no queue on the
+ *	device. Do not call this function directly, call
+ *	tty_driver_flush_buffer().
+ *
+ * @wait_until_sent: ``void ()(struct tty_struct *tty, int timeout)``
+ *
+ *	This routine waits until the device has written out all of the
+ *	characters in its transmitter FIFO. Or until @timeout (in jiffies) is
+ *	reached.
+ *
+ *	Optional: If not provided, the device is assumed to have no FIFO.
+ *	Usually correct to invoke via tty_wait_until_sent().
+ *
+ * @send_xchar: ``void ()(struct tty_struct *tty, char ch)``
+ *
+ *	This routine is used to send a high-priority XON/XOFF character (@ch)
+ *	to the @tty device.
  *
- *	Optional: If not provided the device is assumed to have no FIFO
+ *	Optional: If not provided, then the @write method is called under
+ *	the @tty->atomic_write_lock to keep it serialized with the ldisc.
  *
- *	Note: Usually correct to call tty_wait_until_sent
+ * @tiocmget: ``int ()(struct tty_struct *tty)``
  *
- * void (*send_xchar)(struct tty_struct *tty, char ch);
+ *	This routine is used to obtain the modem status bits from the @tty
+ *	driver.
  *
- * 	This routine is used to send a high-priority XON/XOFF
- * 	character to the device.
+ *	Optional: If not provided, then %ENOTTY is returned from the %TIOCMGET
+ *	ioctl. Do not call this function directly, call tty_tiocmget().
  *
- *	Optional: If not provided then the write method is called under
- *	the atomic write lock to keep it serialized with the ldisc.
+ * @tiocmset: ``int ()(struct tty_struct *tty,
+ *		       unsigned int set, unsigned int clear)``
  *
- * int (*resize)(struct tty_struct *tty, struct winsize *ws)
+ *	This routine is used to set the modem status bits to the @tty driver.
+ *	First, @clear bits should be cleared, then @set bits set.
  *
- *	Called when a termios request is issued which changes the
- *	requested terminal geometry.
+ *	Optional: If not provided, then %ENOTTY is returned from the %TIOCMSET
+ *	ioctl. Do not call this function directly, call tty_tiocmset().
+ *
+ * @resize: ``int ()(struct tty_struct *tty, struct winsize *ws)``
+ *
+ *	Called when a termios request is issued which changes the requested
+ *	terminal geometry to @ws.
  *
  *	Optional: the default action is to update the termios structure
  *	without error. This is usually the correct behaviour. Drivers should
- *	not force errors here if they are not resizable objects (eg a serial
+ *	not force errors here if they are not resizable objects (e.g. a serial
  *	line). See tty_do_resize() if you need to wrap the standard method
- *	in your own logic - the usual case.
+ *	in your own logic -- the usual case.
+ *
+ * @get_icount: ``int ()(struct tty_struct *tty,
+ *			 struct serial_icounter *icount)``
+ *
+ *	Called when the @tty device receives a %TIOCGICOUNT ioctl. Passed a
+ *	kernel structure @icount to complete.
+ *
+ *	Optional: called only if provided, otherwise %ENOTTY will be returned.
+ *
+ * @get_serial: ``int ()(struct tty_struct *tty, struct serial_struct *p)``
+ *
+ *	Called when the @tty device receives a %TIOCGSERIAL ioctl. Passed a
+ *	kernel structure @p (&struct serial_struct) to complete.
+ *
+ *	Optional: called only if provided, otherwise %ENOTTY will be returned.
+ *	Do not call this function directly, call tty_tiocgserial().
+ *
+ * @set_serial: ``int ()(struct tty_struct *tty, struct serial_struct *p)``
+ *
+ *	Called when the @tty device receives a %TIOCSSERIAL ioctl. Passed a
+ *	kernel structure @p (&struct serial_struct) to set the values from.
+ *
+ *	Optional: called only if provided, otherwise %ENOTTY will be returned.
+ *	Do not call this function directly, call tty_tiocsserial().
+ *
+ * @show_fdinfo: ``void ()(struct tty_struct *tty, struct seq_file *m)``
+ *
+ *	Called when the @tty device file descriptor receives a fdinfo request
+ *	from VFS (to show in /proc/<pid>/fdinfo/). @m should be filled with
+ *	information.
+ *
+ *	Optional: called only if provided, otherwise nothing is written to @m.
+ *	Do not call this function directly, call tty_show_fdinfo().
+ *
+ * @poll_init: ``int ()(struct tty_driver *driver, int line, char *options)``
+ *
+ *	kgdboc support (Documentation/dev-tools/kgdb.rst). This routine is
+ *	called to initialize the HW for later use by calling @poll_get_char or
+ *	@poll_put_char.
+ *
+ *	Optional: called only if provided, otherwise skipped as a non-polling
+ *	driver.
+ *
+ * @poll_get_char: ``int ()(struct tty_driver *driver, int line)``
+ *
+ *	kgdboc support (see @poll_init). @driver should read a character from a
+ *	tty identified by @line and return it.
+ *
+ *	Optional: called only if @poll_init provided.
  *
- * int (*get_icount)(struct tty_struct *tty, struct serial_icounter *icount);
+ * @poll_put_char: ``void ()(struct tty_driver *driver, int line, char ch)``
  *
- *	Called when the device receives a TIOCGICOUNT ioctl. Passed a kernel
- *	structure to complete. This method is optional and will only be called
- *	if provided (otherwise ENOTTY will be returned).
+ *	kgdboc support (see @poll_init). @driver should write character @ch to
+ *	a tty identified by @line.
+ *
+ *	Optional: called only if @poll_init provided.
+ *
+ * @proc_show: ``int ()(struct seq_file *m, void *driver)``
+ *
+ *	Driver @driver (cast to &struct tty_driver) can show additional info in
+ *	/proc/tty/driver/<driver_name>. It is enough to fill in the information
+ *	into @m.
+ *
+ *	Optional: called only if provided, otherwise no /proc entry created.
+ *
+ * This structure defines the interface between the low-level tty driver and
+ * the tty routines. These routines can be defined. Unless noted otherwise,
+ * they are optional, and can be filled in with a %NULL pointer.
  */
-
-#include <linux/export.h>
-#include <linux/fs.h>
-#include <linux/kref.h>
-#include <linux/list.h>
-#include <linux/cdev.h>
-#include <linux/termios.h>
-#include <linux/seq_file.h>
-
-struct tty_struct;
-struct tty_driver;
-struct serial_icounter_struct;
-struct serial_struct;
-
 struct tty_operations {
 	struct tty_struct * (*lookup)(struct tty_driver *driver,
 			struct file *filp, int idx);
@@ -288,7 +372,7 @@ struct tty_operations {
 	int (*poll_get_char)(struct tty_driver *driver, int line);
 	void (*poll_put_char)(struct tty_driver *driver, int line, char ch);
 #endif
-	int (*proc_show)(struct seq_file *, void *);
+	int (*proc_show)(struct seq_file *m, void *driver);
 } __randomize_layout;
 
 /**
-- 
2.34.0

