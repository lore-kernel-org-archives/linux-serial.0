Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C90C49EA4
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54909611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhFRGRt (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhFRGRa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4B17321B58;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGhI4h+9UkpEWdcFqpCM9ilg01EZuzFHbZ8KsYHILQ0=;
        b=GOGw5O+Sb1wOT27GYD+gGvcFZa0/j9tLNiFHsRRNym7sz+DuJgAbfWAujDZsYe8TsAvOBY
        4jorbwcXGvvxZKPg8RNI99Uh51OxYPGCGPC4WBRJPwn3GEF+9oO2f7iH5pK8MiWbSoRHcD
        gyY+5Ok7Jc+mnWRAWRXaEd1OknEBDQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996920;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NGhI4h+9UkpEWdcFqpCM9ilg01EZuzFHbZ8KsYHILQ0=;
        b=gw66omFvBB85BJBIhFCb9vPx7TNCZ89BheJ6zNfyRF06IW4GfeFtxHVZlm/hgBti0s11kJ
        wlZF0ydpz7Q1mnCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2AA8BA3BCB;
        Fri, 18 Jun 2021 06:15:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/70] mxser: extract mxser_receive_chars_new
Date:   Fri, 18 Jun 2021 08:14:21 +0200
Message-Id: <20210618061516.662-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Extract the new handling of receive chars (using the MUST chip
enhancements) into a separate function. This eliminates the need for the
intr_old label and makes the code of mxser_receive_chars more compact.
In the next step, we will extract the old handling too.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 60 +++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index df59ca88acab..a321aba24d58 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -2055,10 +2055,41 @@ static int mxser_rs_break(struct tty_struct *tty, int break_state)
 	return 0;
 }
 
+static bool mxser_receive_chars_new(struct tty_struct *tty,
+		struct mxser_port *port, u8 status, int *cnt)
+{
+	enum mxser_must_hwid hwid = port->board->must_hwid;
+	u8 gdl;
+
+	if (hwid == MOXA_OTHER_UART)
+		return false;
+	if (status & UART_LSR_SPECIAL)
+		return false;
+	if (hwid == MOXA_MUST_MU860_HWID && (status & MOXA_MUST_LSR_RERR))
+		return false;
+	if (status & MOXA_MUST_LSR_RERR)
+		return false;
+
+	gdl = inb(port->ioaddr + MOXA_MUST_GDL_REGISTER);
+	if (hwid == MOXA_MUST_MU150_HWID)
+		gdl &= MOXA_MUST_GDL_MASK;
+
+	if (gdl >= tty->receive_room && !port->ldisc_stop_rx)
+		mxser_stoprx(tty);
+
+	while (gdl--) {
+		u8 ch = inb(port->ioaddr + UART_RX);
+		tty_insert_flip_char(&port->port, ch, 0);
+		(*cnt)++;
+	}
+
+	return true;
+}
+
 static u8 mxser_receive_chars(struct tty_struct *tty,
 		struct mxser_port *port, u8 status)
 {
-	unsigned char ch, gdl;
+	unsigned char ch;
 	int ignored = 0;
 	int cnt = 0;
 	int recv_room;
@@ -2067,32 +2098,9 @@ static u8 mxser_receive_chars(struct tty_struct *tty,
 	recv_room = tty->receive_room;
 	if (recv_room == 0 && !port->ldisc_stop_rx)
 		mxser_stoprx(tty);
-	if (port->board->must_hwid != MOXA_OTHER_UART) {
-
-		if (status & UART_LSR_SPECIAL)
-			goto intr_old;
-		if (port->board->must_hwid == MOXA_MUST_MU860_HWID &&
-				(status & MOXA_MUST_LSR_RERR))
-			goto intr_old;
-		if (status & MOXA_MUST_LSR_RERR)
-			goto intr_old;
-
-		gdl = inb(port->ioaddr + MOXA_MUST_GDL_REGISTER);
-
-		if (port->board->must_hwid == MOXA_MUST_MU150_HWID)
-			gdl &= MOXA_MUST_GDL_MASK;
-		if (gdl >= recv_room) {
-			if (!port->ldisc_stop_rx)
-				mxser_stoprx(tty);
-		}
-		while (gdl--) {
-			ch = inb(port->ioaddr + UART_RX);
-			tty_insert_flip_char(&port->port, ch, 0);
-			cnt++;
-		}
+
+	if (mxser_receive_chars_new(tty, port, status, &cnt))
 		goto end_intr;
-	}
-intr_old:
 
 	do {
 		if (max-- < 0)
-- 
2.32.0

