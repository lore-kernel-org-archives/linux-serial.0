Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A019C48BDF
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42B776120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhFRGSB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58960 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbhFRGRl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8814721B55;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHjKP+37ZNlHo7geWY/DFBJLZgfC6j9WGmGs7MNQfoo=;
        b=aVa33LxlYYiknMOlmvgtv77TZyaBk2uSh31ze1Dkewa/gw5k0OH9DWTojEl6ScKRd9bR1h
        ykv8LO4JK1xiNu5xNF0N1eWjfxqrrLHTN9OwaulB3kw9ht/I6KTKhe+C09/KTBzdtolNS2
        acfnnKWZWivpI0UshYH0PXqwZ8dFkJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHjKP+37ZNlHo7geWY/DFBJLZgfC6j9WGmGs7MNQfoo=;
        b=WhQXtuYoASh10LzdIA493fueD0MVfhNUITyuirKInW7x8zyQshjHntHb8YK4k6RbrCnOWV
        SbFPLH9/P7uo8LBg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5EE6FA3BA2;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 25/70] mxser: remove MOXA_ASPP_LSTATUS ioctl
Date:   Fri, 18 Jun 2021 08:14:31 +0200
Message-Id: <20210618061516.662-26-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

1) The semantics are defined exactly nowhere.
2) The ioctl definition was never exposed to userspace, so noone should
   actually be reliably using this.
3) It's not even mentioned in any of the mxser utilities.

Provided the above, remove this mxser-special ioctl.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 68c2f2346dcf..38e12ff17529 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -64,16 +64,9 @@
 #define OP_MODE_MASK		3
 
 #define MOXA_ASPP_OQUEUE	(MOXA + 70)
-#define MOXA_ASPP_LSTATUS	(MOXA + 74)
 
 /* --------------------------------------------------- */
 
-#define NPPI_NOTIFY_PARITY	0x01
-#define NPPI_NOTIFY_FRAMING	0x02
-#define NPPI_NOTIFY_HW_OVERRUN	0x04
-#define NPPI_NOTIFY_SW_OVERRUN	0x08
-#define NPPI_NOTIFY_BREAK	0x10
-
 /*
  * Follow just what Moxa Must chip defines.
  *
@@ -304,7 +297,6 @@ struct mxser_port {
 	unsigned char ldisc_stop_rx;
 
 	int custom_divisor;
-	unsigned char err_shadow;
 
 	struct async_icount icount; /* kernel counters for 4 input interrupts */
 	unsigned int timeout;
@@ -1601,13 +1593,6 @@ static int mxser_ioctl(struct tty_struct *tty,
 
 		return put_user(len, (int __user *)argp);
 	}
-	case MOXA_ASPP_LSTATUS: {
-		if (put_user(info->err_shadow, (unsigned char __user *)argp))
-			return -EFAULT;
-
-		info->err_shadow = 0;
-		return 0;
-	}
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -2033,15 +2018,6 @@ static bool mxser_port_isr(struct mxser_port *port)
 
 	status = inb(port->ioaddr + UART_LSR);
 
-	if (status & UART_LSR_PE)
-		port->err_shadow |= NPPI_NOTIFY_PARITY;
-	if (status & UART_LSR_FE)
-		port->err_shadow |= NPPI_NOTIFY_FRAMING;
-	if (status & UART_LSR_OE)
-		port->err_shadow |= NPPI_NOTIFY_HW_OVERRUN;
-	if (status & UART_LSR_BI)
-		port->err_shadow |= NPPI_NOTIFY_BREAK;
-
 	if (port->board->must_hwid) {
 		if (iir == MOXA_MUST_IIR_GDA ||
 		    iir == MOXA_MUST_IIR_RDA ||
@@ -2172,7 +2148,6 @@ static int mxser_initbrd(struct mxser_board *brd)
 		info->port.close_delay = 5 * HZ / 10;
 		info->port.closing_wait = 30 * HZ;
 		info->normal_termios = mxvar_sdriver->init_termios;
-		info->err_shadow = 0;
 		spin_lock_init(&info->slock);
 
 		/* before set INT ISR, disable all int */
-- 
2.32.0

