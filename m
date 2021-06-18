Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE20C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E9C61154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhFRGSe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46936 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbhFRGRr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:47 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 42C521FE03;
        Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/38fEl8txuzOsFqhCfY5k/ViYG1VHu/lJH5AUM9cEJI=;
        b=ktBvDYAg7rQKKi1XWXmouxAfT8gilnfpqpNDSilD/ysLSW7H2E54HA/IvQ+l0oy4Mz/SkS
        IEnKoT9w/6+hb47bmoyujWKrGdUAOgZq3a06JsXgJ/AfYbRrcm0jHpaTQS5/o80Lwn1qcc
        8L2xQOxgQ08FCduV+1iriEg4cy13nvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/38fEl8txuzOsFqhCfY5k/ViYG1VHu/lJH5AUM9cEJI=;
        b=c0nG0RcWkILrf33sVaLQOSvoXwjefiap6a2FqTMnz6KRfogrXIpCsWIn1NqaFwwjmVRL4m
        ze6ngA1zR/vUIkAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 197E6A3B9E;
        Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 38/70] mxser: extract mxser_ioctl_op_mode
Date:   Fri, 18 Jun 2021 08:14:44 +0200
Message-Id: <20210618061516.662-39-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This ioctl code sets RS232, RS422 or RS485 mode. Move the code to a
separate function (mxser_ioctl_op_mode) with a note that these
mxser-special ioctls should be likely replaced eventually by TIOCGRS485
and TIOCSRS485.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 83 ++++++++++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 2a8bbce790f3..4a584db09494 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1407,6 +1407,48 @@ static int mxser_cflags_changed(struct mxser_port *info, unsigned long arg,
 	return ret;
 }
 
+/* We should likely switch to TIOCGRS485/TIOCSRS485. */
+static int mxser_ioctl_op_mode(struct mxser_port *port, int index, bool set,
+		int __user *u_opmode)
+{
+	static const unsigned char ModeMask[] = { 0xfc, 0xf3, 0xcf, 0x3f };
+	int opmode, p = index % 4;
+	int shiftbit = p * 2;
+	unsigned char val, mask;
+
+	if (port->board->must_hwid != MOXA_MUST_MU860_HWID)
+		return -EFAULT;
+
+	if (set) {
+		if (get_user(opmode, u_opmode))
+			return -EFAULT;
+
+		if (opmode != RS232_MODE && opmode != RS485_2WIRE_MODE &&
+				opmode != RS422_MODE &&
+				opmode != RS485_4WIRE_MODE)
+			return -EFAULT;
+
+		mask = ModeMask[p];
+
+		spin_lock_irq(&port->slock);
+		val = inb(port->opmode_ioaddr);
+		val &= mask;
+		val |= (opmode << shiftbit);
+		outb(val, port->opmode_ioaddr);
+		spin_unlock_irq(&port->slock);
+	} else {
+		spin_lock_irq(&port->slock);
+		opmode = inb(port->opmode_ioaddr) >> shiftbit;
+		spin_unlock_irq(&port->slock);
+
+		opmode &= OP_MODE_MASK;
+		if (put_user(opmode, u_opmode))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int mxser_ioctl(struct tty_struct *tty,
 		unsigned int cmd, unsigned long arg)
 {
@@ -1415,44 +1457,9 @@ static int mxser_ioctl(struct tty_struct *tty,
 	unsigned long flags;
 	void __user *argp = (void __user *)arg;
 
-	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE) {
-		int p;
-		unsigned long opmode;
-		static unsigned char ModeMask[] = { 0xfc, 0xf3, 0xcf, 0x3f };
-		int shiftbit;
-		unsigned char val, mask;
-
-		if (info->board->must_hwid != MOXA_MUST_MU860_HWID)
-			return -EFAULT;
-
-		p = tty->index % 4;
-		if (cmd == MOXA_SET_OP_MODE) {
-			if (get_user(opmode, (int __user *) argp))
-				return -EFAULT;
-			if (opmode != RS232_MODE &&
-					opmode != RS485_2WIRE_MODE &&
-					opmode != RS422_MODE &&
-					opmode != RS485_4WIRE_MODE)
-				return -EFAULT;
-			mask = ModeMask[p];
-			shiftbit = p * 2;
-			spin_lock_irq(&info->slock);
-			val = inb(info->opmode_ioaddr);
-			val &= mask;
-			val |= (opmode << shiftbit);
-			outb(val, info->opmode_ioaddr);
-			spin_unlock_irq(&info->slock);
-		} else {
-			shiftbit = p * 2;
-			spin_lock_irq(&info->slock);
-			opmode = inb(info->opmode_ioaddr) >> shiftbit;
-			spin_unlock_irq(&info->slock);
-			opmode &= OP_MODE_MASK;
-			if (put_user(opmode, (int __user *)argp))
-				return -EFAULT;
-		}
-		return 0;
-	}
+	if (cmd == MOXA_SET_OP_MODE || cmd == MOXA_GET_OP_MODE)
+		return mxser_ioctl_op_mode(info, tty->index,
+				cmd == MOXA_SET_OP_MODE, argp);
 
 	if (cmd != TIOCMIWAIT && tty_io_error(tty))
 		return -EIO;
-- 
2.32.0

