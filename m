Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A5BC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8FF60EC0
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhIVIBM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:01:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34546 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbhIVIBK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 04:01:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C5A2B1FCA1;
        Wed, 22 Sep 2021 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632297578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XshP/bWtOUXN+bdR2fSY2t4cSl+4ai60bPafAzhx2L0=;
        b=uRFyBBOpu9a9dtr2sTYEVbtGmrYBZiTpVLZVKSLgRCQK1rScvS8wdD2ZYWOPUcfVtvAKkQ
        eHj4z/jv5N8CBCrSSClrQ6H0AH5wboRAE76QuGiQFYyM3WuQsCcl4cxfg436lINVAOMIn7
        K2SxftcdOyxoDVDIyh+gknfU384BPcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632297578;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=XshP/bWtOUXN+bdR2fSY2t4cSl+4ai60bPafAzhx2L0=;
        b=8DbI4HgysLiMRc85U+aRJM7qcvdBottrD+Tf+8UnPj6CRSmxexuQJUrTCWh5FFXX00vh8H
        IxGswof9N+S2AqAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9AA62A3B8B;
        Wed, 22 Sep 2021 07:59:38 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/7] mxser: restore baud rate if its setting fails
Date:   Wed, 22 Sep 2021 09:59:32 +0200
Message-Id: <20210922075938.31390-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

If a user tries to set a too high rate, it fails due to check in
mxser_set_baud(). But the high rate remains set in termios, so the user
might think everything went smooth. Restore the baud rate from the
old_termios if this happens, so that user knows nothing was changed in
fact.

It used to behave the correct way many years ago, but somehow the
restoration vanished with commit 1c45607ad3eb (Char: mxser, remove it)
-- the commit removed mxser's older clone.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 1216f3985e18..b9cc41782ce1 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -559,14 +559,20 @@ static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
  * This routine is called to set the UART divisor registers to match
  * the specified baud rate for a serial port.
  */
-static void mxser_change_speed(struct tty_struct *tty)
+static void mxser_change_speed(struct tty_struct *tty, struct ktermios *old_termios)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned cflag, cval, fcr;
 
 	cflag = tty->termios.c_cflag;
 
-	mxser_set_baud(tty, tty_get_baud_rate(tty));
+	if (mxser_set_baud(tty, tty_get_baud_rate(tty))) {
+		/* Use previous rate on a failure */
+		if (old_termios) {
+			speed_t baud = tty_termios_baud_rate(old_termios);
+			tty_encode_baud_rate(tty, baud, baud);
+		}
+	}
 
 	/* byte size and parity */
 	switch (cflag & CSIZE) {
@@ -791,7 +797,7 @@ static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
 	/*
 	 * and set the speed of the serial port
 	 */
-	mxser_change_speed(tty);
+	mxser_change_speed(tty, NULL);
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	return 0;
@@ -1119,7 +1125,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 	if (tty_port_initialized(port)) {
 		if (old_speed != (port->flags & ASYNC_SPD_MASK)) {
 			spin_lock_irqsave(&info->slock, sl_flags);
-			mxser_change_speed(tty);
+			mxser_change_speed(tty, NULL);
 			spin_unlock_irqrestore(&info->slock, sl_flags);
 		}
 	} else {
@@ -1425,7 +1431,7 @@ static void mxser_set_termios(struct tty_struct *tty, struct ktermios *old_termi
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->slock, flags);
-	mxser_change_speed(tty);
+	mxser_change_speed(tty, old_termios);
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
-- 
2.33.0

