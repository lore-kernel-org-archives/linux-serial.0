Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C7DC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1370560EC0
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 07:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhIVIBK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:01:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37408 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhIVIBK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 04:01:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D64522213;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632297579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAug7AGuSK/Yj33uaIVpKW2B50eLr6wUivZyV39RLjo=;
        b=TZoE7e4JlOYizEYGM6EN1cqODqEyLVnlm4NbV5h9QT0HA4k3s1keZXh8ZNkkbRjQYGSwHQ
        fIWJFXYHKOWJ+5qFN7RgGnjiKD1DCPELFgk/UFAVL5aVMvNqtg7jWYnXBppxt8fsFpaAlK
        gsDe2sJNGbo0g7gpnOxZVll6V2u7920=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632297579;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAug7AGuSK/Yj33uaIVpKW2B50eLr6wUivZyV39RLjo=;
        b=anICzS9w65AtqH7tx3l9mqexD/pNJx5OHOjx88ePVCKd/omEkk7y2z2fYndz/sWbH54uhj
        khK3CiUwE0EJvPAw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 14BA3A3B8B;
        Wed, 22 Sep 2021 07:59:39 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/7] mxser: make mxser_port::ldisc_stop_rx a bool
Date:   Wed, 22 Sep 2021 09:59:34 +0200
Message-Id: <20210922075938.31390-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922075938.31390-1-jslaby@suse.cz>
References: <20210922075938.31390-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's used only as a yes-no variable, so make it a bool and switch the
set values appropriately.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index f907de56e08b..309acf3f1ec3 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -250,7 +250,7 @@ struct mxser_port {
 	u8 IER;			/* Interrupt Enable Register */
 	u8 MCR;			/* Modem control register */
 
-	unsigned char ldisc_stop_rx;
+	bool ldisc_stop_rx;
 
 	struct async_icount icount; /* kernel counters for 4 input interrupts */
 	unsigned int timeout;
@@ -1341,7 +1341,7 @@ static void mxser_stoprx(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 
-	info->ldisc_stop_rx = 1;
+	info->ldisc_stop_rx = true;
 	if (I_IXOFF(tty)) {
 		if (info->board->must_hwid) {
 			info->IER &= ~MOXA_MUST_RECV_ISR;
@@ -1374,7 +1374,7 @@ static void mxser_unthrottle(struct tty_struct *tty)
 	struct mxser_port *info = tty->driver_data;
 
 	/* startrx */
-	info->ldisc_stop_rx = 0;
+	info->ldisc_stop_rx = false;
 	if (I_IXOFF(tty)) {
 		if (info->x_char)
 			info->x_char = 0;
@@ -1849,7 +1849,7 @@ static void mxser_initbrd(struct mxser_board *brd, bool high_baud)
 		tty_port_init(&info->port);
 		info->port.ops = &mxser_port_ops;
 		info->board = brd;
-		info->ldisc_stop_rx = 0;
+		info->ldisc_stop_rx = false;
 
 		/* Enhance mode enabled here */
 		if (brd->must_hwid != MOXA_OTHER_UART)
-- 
2.33.0

