Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC5AC49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1F560FE6
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhFRGSy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFRGRz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7C67A21B6C;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GA4kF6z/rEgVCINRiWV6Ypf4/rhj630gX4Kxies8A/c=;
        b=NY/TTQL1vOUGePF/QNCiZ7vsIF13PHSXuvnzPs+QvuJqe0sp5jtSZesJ2oNXuZm0zl17K5
        IO0XLK2R8nNoojuyzhupIXFnINyxO0eM8n3JhA+0but5qKF0e7hNY9ORjiwH6YnZ/GKIZd
        v/yRzQ8veCSg6+CadKkZtTXJqjSr904=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GA4kF6z/rEgVCINRiWV6Ypf4/rhj630gX4Kxies8A/c=;
        b=ptUUVNaS5XtOb6Qy/ows4n1E0bLW6ScNIfm31lmXeWRizyLtbmkZ3nGG5jjpGUsXKgmpbO
        1CCs+DeF4Wj3rtDQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 61292A3B9F;
        Fri, 18 Jun 2021 06:15:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 58/70] mxser: extract and dedup CTS handling
Date:   Fri, 18 Jun 2021 08:15:04 +0200
Message-Id: <20210618061516.662-59-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

CTS is handled on two locations in mxser. Extract the code into
separation function mxser_handle_cts. And call it from the two
locations.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 87 +++++++++++++++++----------------------------
 1 file changed, 33 insertions(+), 54 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 52dbdd4282b2..00363d98277e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -506,6 +506,35 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 	return 0;
 }
 
+static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
+		u8 msr)
+{
+	bool cts = msr & UART_MSR_CTS;
+
+	if (tty->hw_stopped) {
+		if (cts) {
+			tty->hw_stopped = 0;
+
+			if (info->type != PORT_16550A &&
+					!info->board->must_hwid) {
+				outb(info->IER & ~UART_IER_THRI,
+					info->ioaddr + UART_IER);
+				info->IER |= UART_IER_THRI;
+				outb(info->IER, info->ioaddr + UART_IER);
+			}
+			tty_wakeup(tty);
+		}
+		return;
+	} else if (cts)
+		return;
+
+	tty->hw_stopped = 1;
+	if (info->type != PORT_16550A && !info->board->must_hwid) {
+		info->IER &= ~UART_IER_THRI;
+		outb(info->IER, info->ioaddr + UART_IER);
+	}
+}
+
 /*
  * This routine is called to set the UART divisor registers to match
  * the specified baud rate for a serial port.
@@ -514,7 +543,6 @@ static void mxser_change_speed(struct tty_struct *tty)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned cflag, cval, fcr;
-	unsigned char status;
 
 	cflag = tty->termios.c_cflag;
 
@@ -585,32 +613,8 @@ static void mxser_change_speed(struct tty_struct *tty)
 		if ((info->type == PORT_16550A) || (info->board->must_hwid)) {
 			info->MCR |= UART_MCR_AFE;
 		} else {
-			status = inb(info->ioaddr + UART_MSR);
-			if (tty->hw_stopped) {
-				if (status & UART_MSR_CTS) {
-					tty->hw_stopped = 0;
-					if (info->type != PORT_16550A &&
-							!info->board->must_hwid) {
-						outb(info->IER & ~UART_IER_THRI,
-							info->ioaddr +
-							UART_IER);
-						info->IER |= UART_IER_THRI;
-						outb(info->IER, info->ioaddr +
-								UART_IER);
-					}
-					tty_wakeup(tty);
-				}
-			} else {
-				if (!(status & UART_MSR_CTS)) {
-					tty->hw_stopped = 1;
-					if ((info->type != PORT_16550A) &&
-							(!info->board->must_hwid)) {
-						info->IER &= ~UART_IER_THRI;
-						outb(info->IER, info->ioaddr +
-								UART_IER);
-					}
-				}
-			}
+			mxser_handle_cts(tty, info,
+					inb(info->ioaddr + UART_MSR));
 		}
 	}
 	outb(info->MCR, info->ioaddr + UART_MCR);
@@ -679,33 +683,8 @@ static void mxser_check_modem_status(struct tty_struct *tty,
 			wake_up_interruptible(&port->port.open_wait);
 	}
 
-	if (tty_port_cts_enabled(&port->port)) {
-		if (tty->hw_stopped) {
-			if (status & UART_MSR_CTS) {
-				tty->hw_stopped = 0;
-
-				if ((port->type != PORT_16550A) &&
-						(!port->board->must_hwid)) {
-					outb(port->IER & ~UART_IER_THRI,
-						port->ioaddr + UART_IER);
-					port->IER |= UART_IER_THRI;
-					outb(port->IER, port->ioaddr +
-							UART_IER);
-				}
-				tty_wakeup(tty);
-			}
-		} else {
-			if (!(status & UART_MSR_CTS)) {
-				tty->hw_stopped = 1;
-				if (port->type != PORT_16550A &&
-						!port->board->must_hwid) {
-					port->IER &= ~UART_IER_THRI;
-					outb(port->IER, port->ioaddr +
-							UART_IER);
-				}
-			}
-		}
-	}
+	if (tty_port_cts_enabled(&port->port))
+		mxser_handle_cts(tty, port, status);
 }
 
 static int mxser_activate(struct tty_port *port, struct tty_struct *tty)
-- 
2.32.0

