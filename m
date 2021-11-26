Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37C2C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359396AbhKZIVb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:31 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:32884 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359417AbhKZIT1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AB6C1FE00;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HK0oJ5FqJIPZHcrsnj+Xfg5SNt0KXiBzCFulF+4icFU=;
        b=EYM2M2DV+8p4TeRshkFvz/oUYcHxZGMS7064fQqDWZuJcoL4q3aMbOqfaZdY83P9a4r4RV
        AaeQDs9+6DDa6mo7ZgJZG8FJ3NJDx2kCvYcaV0ZD1yflWdrP7kndIlHUOBBVbtb9WtXwGf
        jOS+e7lgbFY6HItRmqAx+ByUkZii7s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HK0oJ5FqJIPZHcrsnj+Xfg5SNt0KXiBzCFulF+4icFU=;
        b=/KV0/UTQuUauxWqS5PGR8uS45BugyB9p3V6XzNbMW+o6EwMLyR9i3gYJWwNvhWd6bbTPEe
        TfgInKdYTZtQggBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1C167A3B83;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/23] tty: reformat TTY_DRIVER_ flags into kernel-doc
Date:   Fri, 26 Nov 2021 09:15:58 +0100
Message-Id: <20211126081611.11001-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We want to reference TTY_DRIVER_* flags in Documentation/ later in this
series. But the current documentation in the TTY_DRIVER_*'s header does
not allow that. Reformat it to kernel-doc using "DOC" directive and
line-feeds, so that we can include it as it is.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_driver.h | 90 ++++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 43 deletions(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 41274d551e28..4841d8069c07 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -492,49 +492,53 @@ static inline void tty_set_operations(struct tty_driver *driver,
 /* tty driver magic number */
 #define TTY_DRIVER_MAGIC		0x5402
 
-/*
- * tty driver flags
- * 
- * TTY_DRIVER_RESET_TERMIOS --- requests the tty layer to reset the
- * 	termios setting when the last process has closed the device.
- * 	Used for PTY's, in particular.
- * 
- * TTY_DRIVER_REAL_RAW --- if set, indicates that the driver will
- * 	guarantee never to set any special character handling
- * 	flags if ((IGNBRK || (!BRKINT && !PARMRK)) && (IGNPAR ||
- * 	!INPCK)).  That is, if there is no reason for the driver to
- * 	send notifications of parity and break characters up to the
- * 	line driver, it won't do so.  This allows the line driver to
- *	optimize for this case if this flag is set.  (Note that there
- * 	is also a promise, if the above case is true, not to signal
- * 	overruns, either.)
- *
- * TTY_DRIVER_DYNAMIC_DEV --- if set, the individual tty devices need
- *	to be registered with a call to tty_register_device() when the
- *	device is found in the system and unregistered with a call to
- *	tty_unregister_device() so the devices will be show up
- *	properly in sysfs.  If not set, driver->num entries will be
- *	created by the tty core in sysfs when tty_register_driver() is
- *	called.  This is to be used by drivers that have tty devices
- *	that can appear and disappear while the main tty driver is
- *	registered with the tty core.
- *
- * TTY_DRIVER_DEVPTS_MEM -- don't use the standard arrays, instead
- *	use dynamic memory keyed through the devpts filesystem.  This
- *	is only applicable to the pty driver.
- *
- * TTY_DRIVER_HARDWARE_BREAK -- hardware handles break signals. Pass
- *	the requested timeout to the caller instead of using a simple
- *	on/off interface.
- *
- * TTY_DRIVER_DYNAMIC_ALLOC -- do not allocate structures which are
- *	needed per line for this driver as it would waste memory.
- *	The driver will take care.
- *
- * TTY_DRIVER_UNNUMBERED_NODE -- do not create numbered /dev nodes. In
- *	other words create /dev/ttyprintk and not /dev/ttyprintk0.
- *	Applicable only when a driver for a single tty device is
- *	being allocated.
+/**
+ * DOC: TTY Driver Flags
+ *
+ * TTY_DRIVER_RESET_TERMIOS
+ *	Requests the tty layer to reset the termios setting when the last
+ *	process has closed the device. Used for PTYs, in particular.
+ *
+ * TTY_DRIVER_REAL_RAW
+ *	Indicates that the driver will guarantee not to set any special
+ *	character handling flags if this is set for the tty:
+ *
+ *	``(IGNBRK || (!BRKINT && !PARMRK)) && (IGNPAR || !INPCK)``
+ *
+ *	That is, if there is no reason for the driver to
+ *	send notifications of parity and break characters up to the line
+ *	driver, it won't do so.  This allows the line driver to optimize for
+ *	this case if this flag is set.  (Note that there is also a promise, if
+ *	the above case is true, not to signal overruns, either.)
+ *
+ * TTY_DRIVER_DYNAMIC_DEV
+ *	The individual tty devices need to be registered with a call to
+ *	tty_register_device() when the device is found in the system and
+ *	unregistered with a call to tty_unregister_device() so the devices will
+ *	be show up properly in sysfs.  If not set, all &tty_driver.num entries
+ *	will be created by the tty core in sysfs when tty_register_driver() is
+ *	called.  This is to be used by drivers that have tty devices that can
+ *	appear and disappear while the main tty driver is registered with the
+ *	tty core.
+ *
+ * TTY_DRIVER_DEVPTS_MEM
+ *	Don't use the standard arrays (&tty_driver.ttys and
+ *	&tty_driver.termios), instead use dynamic memory keyed through the
+ *	devpts filesystem. This is only applicable to the PTY driver.
+ *
+ * TTY_DRIVER_HARDWARE_BREAK
+ *	Hardware handles break signals. Pass the requested timeout to the
+ *	&tty_operations.break_ctl instead of using a simple on/off interface.
+ *
+ * TTY_DRIVER_DYNAMIC_ALLOC
+ *	Do not allocate structures which are needed per line for this driver
+ *	(&tty_driver.ports) as it would waste memory. The driver will take
+ *	care. This is only applicable to the PTY driver.
+ *
+ * TTY_DRIVER_UNNUMBERED_NODE
+ *	Do not create numbered ``/dev`` nodes. For example, create
+ *	``/dev/ttyprintk`` and not ``/dev/ttyprintk0``. Applicable only when a
+ *	driver for a single tty device is being allocated.
  */
 #define TTY_DRIVER_INSTALLED		0x0001
 #define TTY_DRIVER_RESET_TERMIOS	0x0002
-- 
2.34.0

