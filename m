Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355E9C49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20824611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhFRGSE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:04 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46746 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbhFRGRl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 227DD1FE02;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLTnXZ4QUq2WNtmjZk7+V0DJY7p/Dd8KBWBUwF3DW2E=;
        b=GCh9mPPhaT4PfeQscADxFeC70Ja7BMXkkmetzwe7cKuu3xIDzbRQTLOCCKi5j6PzQDlep3
        qCIOv/DDKltpuu3tJMLAdy6GLa13A3Bth7aVDDfzhn6OyEuUqM8bh+JJkiL8MNB+nwIZ80
        6c+BYy7oOfrJ22EKayz+9B5lj2wsCeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLTnXZ4QUq2WNtmjZk7+V0DJY7p/Dd8KBWBUwF3DW2E=;
        b=9DecCV8TBK6/tVI3lFR0deUT0Kgs93k6EQ62RkZQwAcAYYudmMhNjxO1tAOg+XGsH37pX+
        X20wkY8RvtpGL5BA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EFDC5A3B9E;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 28/70] mxser: remove MOXA_GETMSTATUS ioctl
Date:   Fri, 18 Jun 2021 08:14:34 +0200
Message-Id: <20210618061516.662-29-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

1) MOXA_GETMSTATUS is broken at least since commit ecbbfd44a08f (TTY:
   move tty buffers to tty_port) in 2012.
   Even though it's mentioned in the mon_pa moxa utility, obviously
   noone ever tried that in that timeframe.
2) The ioctl definition was never exposed to userspace, so noone
   should actually be reliably using this.

Provided the above, remove this mxser-special ioctl.

And remove the whole concept of mxser_ioctl_special as this was the last
ioctl in there.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 62 +--------------------------------------------
 1 file changed, 1 insertion(+), 61 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 9e241f8bd814..1eb48141d6ca 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -51,7 +51,6 @@
 
 #define MOXA			0x400
 #define MOXA_HighSpeedOn	(MOXA + 61)
-#define MOXA_GETMSTATUS		(MOXA + 65)
 #define MOXA_SET_OP_MODE	(MOXA + 66)
 #define MOXA_GET_OP_MODE	(MOXA + 67)
 
@@ -318,14 +317,6 @@ struct mxser_board {
 	struct mxser_port ports[MXSER_PORTS_PER_BOARD];
 };
 
-struct mxser_mstatus {
-	tcflag_t cflag;
-	int cts;
-	int dsr;
-	int ri;
-	int dcd;
-};
-
 static struct mxser_board mxser_boards[MXSER_BOARDS];
 static struct tty_driver *mxvar_sdriver;
 
@@ -1416,57 +1407,6 @@ static int mxser_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
-{
-	struct mxser_port *ip;
-	struct tty_port *port;
-	struct tty_struct *tty;
-	int status;
-	unsigned int i, j;
-
-	switch (cmd) {
-	case MOXA_GETMSTATUS: {
-		struct mxser_mstatus ms, __user *msu = argp;
-		for (i = 0; i < MXSER_BOARDS; i++)
-			for (j = 0; j < MXSER_PORTS_PER_BOARD; j++) {
-				ip = &mxser_boards[i].ports[j];
-				port = &ip->port;
-				memset(&ms, 0, sizeof(ms));
-
-				mutex_lock(&port->mutex);
-				if (!ip->ioaddr)
-					goto copy;
-				
-				tty = tty_port_tty_get(port);
-
-				if (!tty)
-					ms.cflag = ip->normal_termios.c_cflag;
-				else
-					ms.cflag = tty->termios.c_cflag;
-				tty_kref_put(tty);
-				spin_lock_irq(&ip->slock);
-				status = inb(ip->ioaddr + UART_MSR);
-				spin_unlock_irq(&ip->slock);
-				if (status & UART_MSR_DCD)
-					ms.dcd = 1;
-				if (status & UART_MSR_DSR)
-					ms.dsr = 1;
-				if (status & UART_MSR_CTS)
-					ms.cts = 1;
-			copy:
-				mutex_unlock(&port->mutex);
-				if (copy_to_user(msu, &ms, sizeof(ms)))
-					return -EFAULT;
-				msu++;
-			}
-		return 0;
-	}
-	default:
-		return -ENOIOCTLCMD;
-	}
-	return 0;
-}
-
 static int mxser_cflags_changed(struct mxser_port *info, unsigned long arg,
 		struct async_icount *cprev)
 {
@@ -1497,7 +1437,7 @@ static int mxser_ioctl(struct tty_struct *tty,
 	void __user *argp = (void __user *)arg;
 
 	if (tty->index == MXSER_PORTS)
-		return mxser_ioctl_special(cmd, argp);
+		return -ENOTTY;
 
 	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
 		int p;
-- 
2.32.0

