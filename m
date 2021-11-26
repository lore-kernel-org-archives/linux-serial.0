Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083BAC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359399AbhKZIVc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32866 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359414AbhKZIT1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AAAA41FDFE;
        Fri, 26 Nov 2021 08:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgxhHQ3dKkHy7h9iTeNZBULkFs0/E6WZKRxH1d6Tsdc=;
        b=KtIwc2yTctQVUnRR+GvJo4NialMYWeFFQtc4ToHVldLzPdhA3TruORyJFSi2HJBg7BlCCl
        nSuniXN1K/V95fiS0p/lOqH83zmwhEd9Wqno42Co0g7EJ6wjYxKxWWQnRIl8NE7/InM+mO
        v608nIGJII+mfwkRQLIF2hj5c6PamOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgxhHQ3dKkHy7h9iTeNZBULkFs0/E6WZKRxH1d6Tsdc=;
        b=FCkEA6WSYV+EYSZ+D+tXull0YouorhuHNu3JFyl2kJ6e4PDWMcU8IxqPkcTxoys53Vu9z5
        f9UQoxL7gzoD+pCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7CE97A3B81;
        Fri, 26 Nov 2021 08:16:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/23] tty: combine tty_operations triple docs into kernel-doc
Date:   Fri, 26 Nov 2021 09:15:55 +0100
Message-Id: <20211126081611.11001-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In Documentation/driver-api/serial/tty.rst, there are triplicated texts
about some struct tty_operations' hooks. Combine them into existing
kernel-doc comments of struct tty_operations and drop them from the
Documentation/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 Documentation/driver-api/serial/tty.rst | 134 +-----------------------
 include/linux/tty_driver.h              |  36 +++++--
 2 files changed, 29 insertions(+), 141 deletions(-)

diff --git a/Documentation/driver-api/serial/tty.rst b/Documentation/driver-api/serial/tty.rst
index 4b709f392713..f7ef10c6f458 100644
--- a/Documentation/driver-api/serial/tty.rst
+++ b/Documentation/driver-api/serial/tty.rst
@@ -132,74 +132,8 @@ dcd_change()		Report to the tty line the current DCD pin status
 Driver Access
 ^^^^^^^^^^^^^
 
-Line discipline methods can call the following methods of the underlying
-hardware driver through the function pointers within the tty->driver
-structure:
-
-======================= =======================================================
-write()			Write a block of characters to the tty device.
-			Returns the number of characters accepted. The
-			character buffer passed to this method is already
-			in kernel space.
-
-put_char()		Queues a character for writing to the tty device.
-			If there is no room in the queue, the character is
-			ignored.
-
-flush_chars()		(Optional) If defined, must be called after
-			queueing characters with put_char() in order to
-			start transmission.
-
-write_room()		Returns the numbers of characters the tty driver
-			will accept for queueing to be written.
-
-ioctl()			Invoke device specific ioctl.
-			Expects data pointers to refer to userspace.
-			Returns ENOIOCTLCMD for unrecognized ioctl numbers.
-
-set_termios()		Notify the tty driver that the device's termios
-			settings have changed. New settings are in
-			tty->termios. Previous settings should be passed in
-			the "old" argument.
-
-			The API is defined such that the driver should return
-			the actual modes selected. This means that the
-			driver function is responsible for modifying any
-			bits in the request it cannot fulfill to indicate
-			the actual modes being used. A device with no
-			hardware capability for change (e.g. a USB dongle or
-			virtual port) can provide NULL for this method.
-
-throttle()		Notify the tty driver that input buffers for the
-			line discipline are close to full, and it should
-			somehow signal that no more characters should be
-			sent to the tty.
-
-unthrottle()		Notify the tty driver that characters can now be
-			sent to the tty without fear of overrunning the
-			input buffers of the line disciplines.
-
-stop()			Ask the tty driver to stop outputting characters
-			to the tty device.
-
-start()			Ask the tty driver to resume sending characters
-			to the tty device.
-
-hangup()		Ask the tty driver to hang up the tty device.
-
-break_ctl()		(Optional) Ask the tty driver to turn on or off
-			BREAK status on the RS-232 port.  If state is -1,
-			then the BREAK status should be turned on; if
-			state is 0, then BREAK should be turned off.
-			If this routine is not implemented, use ioctls
-			TIOCSBRK / TIOCCBRK instead.
-
-wait_until_sent()	Waits until the device has written out all of the
-			characters in its transmitter FIFO.
-
-send_xchar()		Send a high-priority XON/XOFF character to the device.
-======================= =======================================================
-
+Line discipline methods can call the methods of the underlying hardware driver.
+These are documented as a part of struct tty_operations.
 
 Flags
 ^^^^^
@@ -262,67 +196,3 @@ A caution: The ldisc->open(), ldisc->close() and driver->set_ldisc
 functions are called with the ldisc unavailable. Thus tty_ldisc_ref will
 fail in this situation if used within these functions. Ldisc and driver
 code calling its own functions must be careful in this case.
-
-
-Driver Interface
-----------------
-
-======================= =======================================================
-open()			Called when a device is opened. May sleep
-
-close()			Called when a device is closed. At the point of
-			return from this call the driver must make no
-			further ldisc calls of any kind. May sleep
-
-write()			Called to write bytes to the device. May not
-			sleep. May occur in parallel in special cases.
-			Because this includes panic paths drivers generally
-			shouldn't try and do clever locking here.
-
-put_char()		Stuff a single character onto the queue. The
-			driver is guaranteed following up calls to
-			flush_chars.
-
-flush_chars()		Ask the kernel to write put_char queue
-
-write_room()		Return the number of characters that can be stuffed
-			into the port buffers without overflow (or less).
-			The ldisc is responsible for being intelligent
-			about multi-threading of write_room/write calls
-
-ioctl()			Called when an ioctl may be for the driver
-
-set_termios()		Called on termios change, serialized against
-			itself by a semaphore. May sleep.
-
-set_ldisc()		Notifier for discipline change. At the point this
-			is done the discipline is not yet usable. Can now
-			sleep (I think)
-
-throttle()		Called by the ldisc to ask the driver to do flow
-			control.  Serialization including with unthrottle
-			is the job of the ldisc layer.
-
-unthrottle()		Called by the ldisc to ask the driver to stop flow
-			control.
-
-stop()			Ldisc notifier to the driver to stop output. As with
-			throttle the serializations with start() are down
-			to the ldisc layer.
-
-start()			Ldisc notifier to the driver to start output.
-
-hangup()		Ask the tty driver to cause a hangup initiated
-			from the host side. [Can sleep ??]
-
-break_ctl()		Send RS232 break. Can sleep. Can get called in
-			parallel, driver must serialize (for now), and
-			with write calls.
-
-wait_until_sent()	Wait for characters to exit the hardware queue
-			of the driver. Can sleep
-
-send_xchar()	  	Send XON/XOFF and if possible jump the queue with
-			it in order to get fast flow control responses.
-			Cannot sleep ??
-======================= =======================================================
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 5611992ab26a..41274d551e28 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -47,15 +47,17 @@ struct serial_struct;
  *	routine is mandatory; if this routine is not filled in, the attempted
  *	open will fail with %ENODEV.
  *
- *	Required method. Called with tty lock held.
+ *	Required method. Called with tty lock held. May sleep.
  *
  * @close: ``void ()(struct tty_struct *tty, struct file *)``
  *
- *	This routine is called when a particular @tty device is closed.
+ *	This routine is called when a particular @tty device is closed. At the
+ *	point of return from this call the driver must make no further ldisc
+ *	calls of any kind.
  *
  *	Remark: called even if the corresponding @open() failed.
  *
- *	Required method. Called with tty lock held.
+ *	Required method. Called with tty lock held. May sleep.
  *
  * @shutdown: ``void ()(struct tty_struct *tty)``
  *
@@ -77,7 +79,10 @@ struct serial_struct;
  *	user space or kernel space.  This routine will return the
  *	number of characters actually accepted for writing.
  *
- *	Optional: Required for writable devices.
+ *	May occur in parallel in special cases. Because this includes panic
+ *	paths drivers generally shouldn't try and do clever locking here.
+ *
+ *	Optional: Required for writable devices. May not sleep.
  *
  * @put_char: ``int ()(struct tty_struct *tty, unsigned char ch)``
  *
@@ -105,6 +110,9 @@ struct serial_struct;
  *	to change as output buffers get emptied, or if the output flow
  *	control is acted.
  *
+ *	The ldisc is responsible for being intelligent about multi-threading of
+ *	write_room/write calls
+ *
  *	Required if @write method is provided else not needed. Do not call this
  *	function directly, call tty_write_room()
  *
@@ -136,14 +144,21 @@ struct serial_struct;
  * @set_termios: ``void ()(struct tty_struct *tty, struct ktermios *old)``
  *
  *	This routine allows the @tty driver to be notified when device's
- *	termios settings have changed.
+ *	termios settings have changed. New settings are in @tty->termios.
+ *	Previous settings are passed in the @old argument.
  *
- *	Optional: Called under the @tty->termios_rwsem.
+ *	The API is defined such that the driver should return the actual modes
+ *	selected. This means that the driver is responsible for modifying any
+ *	bits in @tty->termios it cannot fulfill to indicate the actual modes
+ *	being used.
+ *
+ *	Optional. Called under the @tty->termios_rwsem. May sleep.
  *
  * @set_ldisc: ``void ()(struct tty_struct *tty)``
  *
  *	This routine allows the @tty driver to be notified when the device's
- *	line discipline is being changed.
+ *	line discipline is being changed. At the point this is done the
+ *	discipline is not yet usable.
  *
  *	Optional. Called under the @tty->ldisc_sem and @tty->termios_rwsem.
  *
@@ -153,6 +168,9 @@ struct serial_struct;
  *	discipline are close to full, and it should somehow signal that no more
  *	characters should be sent to the @tty.
  *
+ *	Serialization including with @unthrottle() is the job of the ldisc
+ *	layer.
+ *
  *	Optional: Always invoke via tty_throttle_safe(). Called under the
  *	@tty->termios_rwsem.
  *
@@ -204,7 +222,7 @@ struct serial_struct;
  *	hardware is expected to do the delay work itself. 0 and -1 are still
  *	used for on/off.
  *
- *	Optional: Required for %TCSBRK/%BRKP/etc. handling.
+ *	Optional: Required for %TCSBRK/%BRKP/etc. handling. May sleep.
  *
  * @flush_buffer: ``void ()(struct tty_struct *tty)``
  *
@@ -222,7 +240,7 @@ struct serial_struct;
  *	reached.
  *
  *	Optional: If not provided, the device is assumed to have no FIFO.
- *	Usually correct to invoke via tty_wait_until_sent().
+ *	Usually correct to invoke via tty_wait_until_sent(). May sleep.
  *
  * @send_xchar: ``void ()(struct tty_struct *tty, char ch)``
  *
-- 
2.34.0

