Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAD9C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359303AbhKZIV0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:26 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50432 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbhKZIT0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C77572193C;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dm/g6WW4tMZURcXdQRMJxb71OJLGhA+Y7gnt6w4hANA=;
        b=JE1W3/f1Cay+Iezun81szuZJHGWw6gxgdc7HTQ4Y/4LV2Z1XJ0UcuTRejqvUtCOJPLSX/w
        2uqnbKWvdzBCkKM9x/VLpYRC1FHp281QcgPGuz+UdSDBVIRLZ5V78wwkWq+fgfH+lQrkhr
        7amA+l40hFYbnIVrEsGRnLmvSo0/Pw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914572;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dm/g6WW4tMZURcXdQRMJxb71OJLGhA+Y7gnt6w4hANA=;
        b=EY+l6HxFgAbURW/uomTN/r+Hry/7Onmpnz44k4/wgoqD9ufkF4w7NXKXtUdp/Aqjz9VlxV
        DzRuqhVTEEYXD8CA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A0DA0A3B81;
        Fri, 26 Nov 2021 08:16:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/23] tty: add kernel-doc for tty_driver
Date:   Fri, 26 Nov 2021 09:15:51 +0100
Message-Id: <20211126081611.11001-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_driver used to have only short comments along its members. Convert
them into proper kernel-doc comments in front of the structure. And add
some more explanation to them where needed.

The whole structure handling is documented at the end too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_driver.h | 62 ++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 12 deletions(-)

diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 795b94ccdeb6..3622404a678d 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -291,23 +291,61 @@ struct tty_operations {
 	int (*proc_show)(struct seq_file *, void *);
 } __randomize_layout;
 
+/**
+ * struct tty_driver -- driver for TTY devices
+ *
+ * @magic: set to %TTY_DRIVER_MAGIC in __tty_alloc_driver()
+ * @kref: reference counting. Reaching zero frees all the internals and the
+ *	  driver.
+ * @cdevs: allocated/registered character /dev devices
+ * @owner: modules owning this driver. Used drivers cannot be rmmod'ed.
+ *	   Automatically set by tty_alloc_driver().
+ * @driver_name: name of the driver used in /proc/tty
+ * @name: used for constructing /dev node name
+ * @name_base: used as a number base for constructing /dev node name
+ * @major: major /dev device number (zero for autoassignment)
+ * @minor_start: the first minor /dev device number
+ * @num: number of devices allocated
+ * @type: type of tty driver (%TTY_DRIVER_TYPE_)
+ * @subtype: subtype of tty driver (%SYSTEM_TYPE_, %PTY_TYPE_, %SERIAL_TYPE_)
+ * @init_termios: termios to set to each tty initially (e.g. %tty_std_termios)
+ * @flags: tty driver flags (%TTY_DRIVER_)
+ * @proc_entry: proc fs entry, used internally
+ * @other: driver of the linked tty; only used for the PTY driver
+ * @ttys: array of active &struct tty_struct, set by tty_standard_install()
+ * @ports: array of &struct tty_port; can be set during initialization by
+ *	   tty_port_link_device() and similar
+ * @termios: storage for termios at each TTY close for the next open
+ * @driver_state: pointer to driver's arbitrary data
+ * @ops: driver hooks for TTYs. Set them using tty_set_operations(). Use &struct
+ *	 tty_port helpers in them as much as possible.
+ * @tty_drivers: used internally to link tty_drivers together
+ *
+ * The usual handling of &struct tty_driver is to allocate it by
+ * tty_alloc_driver(), set up all the necessary members, and register it by
+ * tty_register_driver(). At last, the driver is torn down by calling
+ * tty_unregister_driver() followed by tty_driver_kref_put().
+ *
+ * The fields required to be set before calling tty_register_driver() include
+ * @driver_name, @name, @type, @subtype, @init_termios, and @ops.
+ */
 struct tty_driver {
-	int	magic;		/* magic number for this structure */
-	struct kref kref;	/* Reference management */
+	int	magic;
+	struct kref kref;
 	struct cdev **cdevs;
 	struct module	*owner;
 	const char	*driver_name;
 	const char	*name;
-	int	name_base;	/* offset of printed name */
-	int	major;		/* major device number */
-	int	minor_start;	/* start of minor device number */
-	unsigned int	num;	/* number of devices allocated */
-	short	type;		/* type of tty driver */
-	short	subtype;	/* subtype of tty driver */
-	struct ktermios init_termios; /* Initial termios */
-	unsigned long	flags;		/* tty driver flags */
-	struct proc_dir_entry *proc_entry; /* /proc fs entry */
-	struct tty_driver *other; /* only used for the PTY driver */
+	int	name_base;
+	int	major;
+	int	minor_start;
+	unsigned int	num;
+	short	type;
+	short	subtype;
+	struct ktermios init_termios;
+	unsigned long	flags;
+	struct proc_dir_entry *proc_entry;
+	struct tty_driver *other;
 
 	/*
 	 * Pointer to the tty data structures
-- 
2.34.0

