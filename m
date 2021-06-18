Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D948C48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465E460FE6
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhFRGSw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46730 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7986E1FE00;
        Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfkwiMcfVfUg3JuOVlfnbb/dw2b1Z6NVGhmaE+vMfEk=;
        b=bx3pi6UpkFLccnGnEPE1VSut3DpBwEr6IIvNLmzyKO6bJJxjyzP+QptnG0KlHne5ebQyJ5
        O0+d182PP9JptG9dVeYwj90CGNDwFjG9UjtyLM847q0NY5NVwDSE7uDXJOIke1qeAj72M4
        WIr/C6bLXG/rJeHIKLKdXHfu4gsCIhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996925;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfkwiMcfVfUg3JuOVlfnbb/dw2b1Z6NVGhmaE+vMfEk=;
        b=oTDMWreCzPtjO+kO3POvfCaV8qqntyPr0LiObDv84hPMUG9gzSxJtwMeRZF4n0l+DWp6Do
        GHNx86tGTJnz1DDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5181EA3B99;
        Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 39/70] mxser: simplify mxser_ioctl_op_mode
Date:   Fri, 18 Jun 2021 08:14:45 +0200
Message-Id: <20210618061516.662-40-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* ModeMask local array is just inverted OP_MODE_MASK shifted by shiftbit.
  Drop this array and use the value directly.
* return from the if's true branch and drop 'else' branch by moving the
  code completely outside the if.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 4a584db09494..e082ae055c39 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -1411,10 +1411,9 @@ static int mxser_cflags_changed(struct mxser_port *info, unsigned long arg,
 static int mxser_ioctl_op_mode(struct mxser_port *port, int index, bool set,
 		int __user *u_opmode)
 {
-	static const unsigned char ModeMask[] = { 0xfc, 0xf3, 0xcf, 0x3f };
 	int opmode, p = index % 4;
 	int shiftbit = p * 2;
-	unsigned char val, mask;
+	u8 val;
 
 	if (port->board->must_hwid != MOXA_MUST_MU860_HWID)
 		return -EFAULT;
@@ -1423,30 +1422,24 @@ static int mxser_ioctl_op_mode(struct mxser_port *port, int index, bool set,
 		if (get_user(opmode, u_opmode))
 			return -EFAULT;
 
-		if (opmode != RS232_MODE && opmode != RS485_2WIRE_MODE &&
-				opmode != RS422_MODE &&
-				opmode != RS485_4WIRE_MODE)
-			return -EFAULT;
-
-		mask = ModeMask[p];
+		if (opmode & ~OP_MODE_MASK)
+			return -EINVAL;
 
 		spin_lock_irq(&port->slock);
 		val = inb(port->opmode_ioaddr);
-		val &= mask;
+		val &= ~(OP_MODE_MASK << shiftbit);
 		val |= (opmode << shiftbit);
 		outb(val, port->opmode_ioaddr);
 		spin_unlock_irq(&port->slock);
-	} else {
-		spin_lock_irq(&port->slock);
-		opmode = inb(port->opmode_ioaddr) >> shiftbit;
-		spin_unlock_irq(&port->slock);
 
-		opmode &= OP_MODE_MASK;
-		if (put_user(opmode, u_opmode))
-			return -EFAULT;
+		return 0;
 	}
 
-	return 0;
+	spin_lock_irq(&port->slock);
+	opmode = inb(port->opmode_ioaddr) >> shiftbit;
+	spin_unlock_irq(&port->slock);
+
+	return put_user(opmode & OP_MODE_MASK, u_opmode);
 }
 
 static int mxser_ioctl(struct tty_struct *tty,
-- 
2.32.0

