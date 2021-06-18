Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97059C49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9F2613E1
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbhFRGSK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46778 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbhFRGRn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EECD01FD8F;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulMBa5/CPcYovSlxzGo2WYNtkunB+m2puMZs6xaGagU=;
        b=ndjwHJ59JYZSJArs0ohCI2qoBcULpz57wu2ur/Pbssl8xKXmtOJWAg1YMAqNkuC6vvy6r4
        WREWHldZHr+AABVSJ8a0lni4r/Vza6R6oPHAwBPU6jySlFRxOQ8fA+HbWSf4f98UulZ58+
        wZxqkJQoIcc6gexJJ96IAB5B0lS7yTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ulMBa5/CPcYovSlxzGo2WYNtkunB+m2puMZs6xaGagU=;
        b=B4buZe94Lq/VYxmZ1G5IvR2H8YqBRdpmmoEJySlpgQkqrn3/TQbOrPi1YssGHzkuJl0EDT
        LMd20oALhtBROLDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C690CA3B9E;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 32/70] mxser: don't allocate MXSER_PORTS + 1
Date:   Fri, 18 Jun 2021 08:14:38 +0200
Message-Id: <20210618061516.662-33-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The MXSER_PORTS's tty_device is never registered and neither its
tty_port instance exists. Hence, it's quite pointless to allocate it.

It used to be used for global information fetches via ioctls. We have
just removed these as non-existent tty_device+tty_port was exactly the
reason to remove the ioctls.

It would be peculiar to add this "virtual" port as we require a backing
tty_port since commit ecbbfd44a08f (TTY: move tty buffers to tty_port)
in 2012.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index d354c80083fd..007137c3b5c9 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1004,11 +1004,8 @@ static void mxser_shutdown_port(struct tty_port *port)
 static int mxser_open(struct tty_struct *tty, struct file *filp)
 {
 	struct mxser_port *info;
-	int line;
+	int line = tty->index;
 
-	line = tty->index;
-	if (line == MXSER_PORTS)
-		return 0;
 	info = &mxser_boards[line / MXSER_PORTS_PER_BOARD].ports[line % MXSER_PORTS_PER_BOARD];
 	if (!info->ioaddr)
 		return -ENODEV;
@@ -1077,7 +1074,7 @@ static void mxser_close(struct tty_struct *tty, struct file *filp)
 	struct mxser_port *info = tty->driver_data;
 	struct tty_port *port = &info->port;
 
-	if (tty->index == MXSER_PORTS || info == NULL)
+	if (info == NULL)
 		return;
 	if (tty_port_close_start(port, tty, filp) == 0)
 		return;
@@ -1216,9 +1213,6 @@ static int mxser_get_serial_info(struct tty_struct *tty,
 	struct tty_port *port = &info->port;
 	unsigned int closing_wait, close_delay;
 
-	if (tty->index == MXSER_PORTS)
-		return -ENOTTY;
-
 	mutex_lock(&port->mutex);
 
 	close_delay = jiffies_to_msecs(info->port.close_delay) / 10;
@@ -1249,8 +1243,6 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 	unsigned int flags, close_delay, closing_wait;
 	int retval = 0;
 
-	if (tty->index == MXSER_PORTS)
-		return -ENOTTY;
 	if (tty_io_error(tty))
 		return -EIO;
 
@@ -1354,9 +1346,6 @@ static int mxser_tiocmget(struct tty_struct *tty)
 	unsigned char control, status;
 	unsigned long flags;
 
-
-	if (tty->index == MXSER_PORTS)
-		return -ENOIOCTLCMD;
 	if (tty_io_error(tty))
 		return -EIO;
 
@@ -1381,9 +1370,6 @@ static int mxser_tiocmset(struct tty_struct *tty,
 	struct mxser_port *info = tty->driver_data;
 	unsigned long flags;
 
-
-	if (tty->index == MXSER_PORTS)
-		return -ENOIOCTLCMD;
 	if (tty_io_error(tty))
 		return -EIO;
 
@@ -1433,9 +1419,6 @@ static int mxser_ioctl(struct tty_struct *tty,
 	unsigned long flags;
 	void __user *argp = (void __user *)arg;
 
-	if (tty->index == MXSER_PORTS)
-		return -ENOTTY;
-
 	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
 		int p;
 		unsigned long opmode;
@@ -2211,7 +2194,7 @@ static int __init mxser_module_init(void)
 {
 	int retval;
 
-	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS + 1);
+	mxvar_sdriver = alloc_tty_driver(MXSER_PORTS);
 	if (!mxvar_sdriver)
 		return -ENOMEM;
 
-- 
2.32.0

