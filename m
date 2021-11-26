Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB105C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359665AbhKZIXc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:32 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33060 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359336AbhKZIV1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 650D41FE01;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKFsA8aTHyyZ5APZQVLJwo5qT13eN12hLC5ddPWGH8w=;
        b=zdOD8Z3Prigm59WoLV12Q5RC4yHdwYPPugfRwkv7j8hlZwhoZtL0VXi5M/m4iAoBqggY6U
        aQseOyTMW4eqT2dsC44xspDeEXjCeI02mZ6FG/oA7dTlRKviXDzydRWFyuXNH0jVUArdBD
        Ah3o4A+xooEUHYZwvDfbnF6NWhU25MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914574;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bKFsA8aTHyyZ5APZQVLJwo5qT13eN12hLC5ddPWGH8w=;
        b=LQz05hvL3eIoWzTw93JeDj8K6tNyikaiKvnTbU6yFxW7WfHdXfzZEXT5o+zGSkY81450FC
        eG62qhpbiFRQBJCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A268A3B81;
        Fri, 26 Nov 2021 08:16:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 11/23] tty: reformat kernel-doc in tty_port.c
Date:   Fri, 26 Nov 2021 09:15:59 +0100
Message-Id: <20211126081611.11001-12-jslaby@suse.cz>
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

2) Remove newlines before parameters description. This was not wrong per
   se, only inconsistent with the rest of the file.

3) Add periods to the end of sentences where appropriate.

4) Use recognized "Note" instead of "NB" (nota bene).

5) Add "()" to function names and "%" to constants, so that they are
   properly highlighted.

By the above, this patch also unifies these docs with the other
kernel-doc's in this file.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_port.c | 161 ++++++++++++++++++++++-------------------
 1 file changed, 88 insertions(+), 73 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 2f1061a9d926..ebb441ee92d5 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -82,9 +82,9 @@ EXPORT_SYMBOL(tty_port_init);
  * @index: index of the tty
  *
  * Provide the tty layer with a link from a tty (specified by @index) to a
- * tty_port (@port). Use this only if neither tty_port_register_device nor
- * tty_port_install is used in the driver. If used, this has to be called before
- * tty_register_driver.
+ * tty_port (@port). Use this only if neither tty_port_register_device() nor
+ * tty_port_install() is used in the driver. If used, this has to be called
+ * before tty_register_driver().
  */
 void tty_port_link_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index)
@@ -102,9 +102,9 @@ EXPORT_SYMBOL_GPL(tty_port_link_device);
  * @index: index of the tty
  * @device: parent if exists, otherwise NULL
  *
- * It is the same as tty_register_device except the provided @port is linked to
- * a concrete tty specified by @index. Use this or tty_port_install (or both).
- * Call tty_port_link_device as a last resort.
+ * It is the same as tty_register_device() except the provided @port is linked
+ * to a concrete tty specified by @index. Use this or tty_port_install() (or
+ * both). Call tty_port_link_device() as a last resort.
  */
 struct device *tty_port_register_device(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
@@ -123,9 +123,9 @@ EXPORT_SYMBOL_GPL(tty_port_register_device);
  * @drvdata: Driver data to be set to device.
  * @attr_grp: Attribute group to be set on device.
  *
- * It is the same as tty_register_device_attr except the provided @port is
- * linked to a concrete tty specified by @index. Use this or tty_port_install
- * (or both). Call tty_port_link_device as a last resort.
+ * It is the same as tty_register_device_attr() except the provided @port is
+ * linked to a concrete tty specified by @index. Use this or tty_port_install()
+ * (or both). Call tty_port_link_device() as a last resort.
  */
 struct device *tty_port_register_device_attr(struct tty_port *port,
 		struct tty_driver *driver, unsigned index,
@@ -240,9 +240,9 @@ EXPORT_SYMBOL(tty_port_free_xmit_buf);
  * tty_port_destroy -- destroy inited port
  * @port: tty port to be destroyed
  *
- * When a port was initialized using tty_port_init, one has to destroy the
- * port by this function. Either indirectly by using tty_port refcounting
- * (tty_port_put) or directly if refcounting is not used.
+ * When a port was initialized using tty_port_init(), one has to destroy the
+ * port by this function. Either indirectly by using &tty_port refcounting
+ * (tty_port_put()) or directly if refcounting is not used.
  */
 void tty_port_destroy(struct tty_port *port)
 {
@@ -275,11 +275,11 @@ void tty_port_put(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_put);
 
 /**
- *	tty_port_tty_get	-	get a tty reference
- *	@port: tty port
+ * tty_port_tty_get	-	get a tty reference
+ * @port: tty port
  *
- *	Return a refcount protected tty instance or NULL if the port is not
- *	associated with a tty (eg due to close or hangup)
+ * Return a refcount protected tty instance or %NULL if the port is not
+ * associated with a tty (eg due to close or hangup).
  */
 struct tty_struct *tty_port_tty_get(struct tty_port *port)
 {
@@ -294,12 +294,12 @@ struct tty_struct *tty_port_tty_get(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_tty_get);
 
 /**
- *	tty_port_tty_set	-	set the tty of a port
- *	@port: tty port
- *	@tty: the tty
+ * tty_port_tty_set	-	set the tty of a port
+ * @port: tty port
+ * @tty: the tty
  *
- *	Associate the port and tty pair. Manages any internal refcounts.
- *	Pass NULL to deassociate a port
+ * Associate the port and tty pair. Manages any internal refcounts. Pass %NULL
+ * to deassociate a port.
  */
 void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 {
@@ -335,13 +335,13 @@ static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 }
 
 /**
- *	tty_port_hangup		-	hangup helper
- *	@port: tty port
+ * tty_port_hangup		-	hangup helper
+ * @port: tty port
  *
- *	Perform port level tty hangup flag and count changes. Drop the tty
- *	reference.
+ * Perform port level tty hangup flag and count changes. Drop the tty
+ * reference.
  *
- *	Caller holds tty lock.
+ * Caller holds tty lock.
  */
 void tty_port_hangup(struct tty_port *port)
 {
@@ -365,9 +365,8 @@ EXPORT_SYMBOL(tty_port_hangup);
 
 /**
  * tty_port_tty_hangup - helper to hang up a tty
- *
  * @port: tty port
- * @check_clocal: hang only ttys with CLOCAL unset?
+ * @check_clocal: hang only ttys with %CLOCAL unset?
  */
 void tty_port_tty_hangup(struct tty_port *port, bool check_clocal)
 {
@@ -381,7 +380,6 @@ EXPORT_SYMBOL_GPL(tty_port_tty_hangup);
 
 /**
  * tty_port_tty_wakeup - helper to wake up a tty
- *
  * @port: tty port
  */
 void tty_port_tty_wakeup(struct tty_port *port)
@@ -391,12 +389,12 @@ void tty_port_tty_wakeup(struct tty_port *port)
 EXPORT_SYMBOL_GPL(tty_port_tty_wakeup);
 
 /**
- *	tty_port_carrier_raised	-	carrier raised check
- *	@port: tty port
+ * tty_port_carrier_raised	-	carrier raised check
+ * @port: tty port
  *
- *	Wrapper for the carrier detect logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the carrier detect logic. For the moment this is used
+ * to hide some internal details. This will eventually become entirely
+ * internal to the tty port.
  */
 int tty_port_carrier_raised(struct tty_port *port)
 {
@@ -407,12 +405,12 @@ int tty_port_carrier_raised(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_carrier_raised);
 
 /**
- *	tty_port_raise_dtr_rts	-	Raise DTR/RTS
- *	@port: tty port
+ * tty_port_raise_dtr_rts	-	Raise DTR/RTS
+ * @port: tty port
  *
- *	Wrapper for the DTR/RTS raise logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the DTR/RTS raise logic. For the moment this is used to hide
+ * some internal details. This will eventually become entirely internal to the
+ * tty port.
  */
 void tty_port_raise_dtr_rts(struct tty_port *port)
 {
@@ -422,12 +420,12 @@ void tty_port_raise_dtr_rts(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_raise_dtr_rts);
 
 /**
- *	tty_port_lower_dtr_rts	-	Lower DTR/RTS
- *	@port: tty port
+ * tty_port_lower_dtr_rts	-	Lower DTR/RTS
+ * @port: tty port
  *
- *	Wrapper for the DTR/RTS raise logic. For the moment this is used
- *	to hide some internal details. This will eventually become entirely
- *	internal to the tty port.
+ * Wrapper for the DTR/RTS raise logic. For the moment this is used to hide
+ * some internal details. This will eventually become entirely internal to the
+ * tty port.
  */
 void tty_port_lower_dtr_rts(struct tty_port *port)
 {
@@ -437,28 +435,29 @@ void tty_port_lower_dtr_rts(struct tty_port *port)
 EXPORT_SYMBOL(tty_port_lower_dtr_rts);
 
 /**
- *	tty_port_block_til_ready	-	Waiting logic for tty open
- *	@port: the tty port being opened
- *	@tty: the tty device being bound
- *	@filp: the file pointer of the opener or NULL
+ * tty_port_block_til_ready	-	Waiting logic for tty open
+ * @port: the tty port being opened
+ * @tty: the tty device being bound
+ * @filp: the file pointer of the opener or %NULL
+ *
+ * Implement the core POSIX/SuS tty behaviour when opening a tty device.
+ * Handles:
  *
- *	Implement the core POSIX/SuS tty behaviour when opening a tty device.
- *	Handles:
- *		- hangup (both before and during)
- *		- non blocking open
- *		- rts/dtr/dcd
- *		- signals
- *		- port flags and counts
+ *	- hangup (both before and during)
+ *	- non blocking open
+ *	- rts/dtr/dcd
+ *	- signals
+ *	- port flags and counts
  *
- *	The passed tty_port must implement the carrier_raised method if it can
- *	do carrier detect and the dtr_rts method if it supports software
- *	management of these lines. Note that the dtr/rts raise is done each
- *	iteration as a hangup may have previously dropped them while we wait.
+ * The passed @port must implement the @port->ops->carrier_raised method if it
+ * can do carrier detect and the @port->ops->dtr_rts method if it supports
+ * software management of these lines. Note that the dtr/rts raise is done each
+ * iteration as a hangup may have previously dropped them while we wait.
  *
- *	Caller holds tty lock.
+ * Caller holds tty lock.
  *
- *      NB: May drop and reacquire tty lock when blocking, so tty and tty_port
- *      may have changed state (eg., may have been hung up).
+ * Note: May drop and reacquire tty lock when blocking, so @tty and @port may
+ * have changed state (eg., may have been hung up).
  */
 int tty_port_block_til_ready(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
@@ -628,10 +627,18 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 }
 EXPORT_SYMBOL(tty_port_close_end);
 
-/*
- * tty_port_close
+/**
+ * tty_port_close - generic tty->ops->close handler
+ * @port: tty_port of the device
+ * @tty: tty being closed
+ * @filp: passed file pointer
+ *
+ * It is a generic helper to be used in driver's @tty->ops->close. It wraps a
+ * sequence of tty_port_close_start(), tty_port_shutdown(), and
+ * tty_port_close_end(). The latter two are called only if this is the last
+ * close. See the respective functions for the details.
  *
- * Caller holds tty lock
+ * Locking: Caller holds tty lock
  */
 void tty_port_close(struct tty_port *port, struct tty_struct *tty,
 							struct file *filp)
@@ -652,9 +659,9 @@ EXPORT_SYMBOL(tty_port_close);
  * @driver: tty_driver for this device
  * @tty: tty to be installed
  *
- * It is the same as tty_standard_install except the provided @port is linked
- * to a concrete tty specified by @tty. Use this or tty_port_register_device
- * (or both). Call tty_port_link_device as a last resort.
+ * It is the same as tty_standard_install() except the provided @port is linked
+ * to a concrete tty specified by @tty. Use this or tty_port_register_device()
+ * (or both). Call tty_port_link_device() as a last resort.
  */
 int tty_port_install(struct tty_port *port, struct tty_driver *driver,
 		struct tty_struct *tty)
@@ -664,13 +671,21 @@ int tty_port_install(struct tty_port *port, struct tty_driver *driver,
 }
 EXPORT_SYMBOL_GPL(tty_port_install);
 
-/*
- * tty_port_open
+/**
+ * tty_port_open - generic tty->ops->open handler
+ * @port: tty_port of the device
+ * @tty: tty to be opened
+ * @filp: passed file pointer
  *
- * Caller holds tty lock.
+ * It is a generic helper to be used in driver's @tty->ops->open. It activates
+ * the devices using @port->ops->activate if not active already. And waits for
+ * the device to be ready using tty_port_block_til_ready() (e.g.  raises
+ * DTR/CTS and waits for carrier).
+ *
+ * Locking: Caller holds tty lock.
  *
- * NB: may drop and reacquire tty lock (in tty_port_block_til_ready()) so
- * tty and tty_port may have changed state (eg., may be hung up now)
+ * Note: may drop and reacquire tty lock (in tty_port_block_til_ready()) so
+ * @tty and @port may have changed state (eg., may be hung up now).
  */
 int tty_port_open(struct tty_port *port, struct tty_struct *tty,
 							struct file *filp)
-- 
2.34.0

