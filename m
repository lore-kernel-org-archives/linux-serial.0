Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E5C433F5
	for <linux-serial@archiver.kernel.org>; Mon, 22 Nov 2021 11:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbhKVLT5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:19:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:54002 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbhKVLT5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Nov 2021 06:19:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E76F81FD58;
        Mon, 22 Nov 2021 11:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637579809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yr7E2cLUqQZsu+stJJqqPQi4eLd9GV9S0NfG2zZKR6k=;
        b=E5fw+h9esr7J+c7VVchchO2IZXa3UwLxkkg7iO7LVgkn+lscvYD0/jzEC+ca8g4erVHnlW
        G2e3ZKsgGo5XRLHfcbeW8D5q4Tjg3Iule+L1338SxJu++rTUjSwoN/dSLs8N/zBD8ZRVSG
        K4/oCpPb6m0m+zkalCWWMWHsb5CVVXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637579809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yr7E2cLUqQZsu+stJJqqPQi4eLd9GV9S0NfG2zZKR6k=;
        b=eBA6GKpjGI4leD8cekB9mKJMBMKdOhVBHEoVscBpzA9o2REj6b2suJatk5xR1/4eiPAhsJ
        R7kWfrEP7ZijR2DA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A8EC9A3B89;
        Mon, 22 Nov 2021 11:16:49 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan@kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 1/3] tty: drivers/tty/, stop using tty_schedule_flip()
Date:   Mon, 22 Nov 2021 12:16:46 +0100
Message-Id: <20211122111648.30379-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211122111648.30379-1-jslaby@suse.cz>
References: <20211122111648.30379-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
going to remove the latter (as it is used less), so call the former in
drivers/tty/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Vladimir Zapolskiy <vz@mleia.com>
---
 drivers/tty/goldfish.c          | 2 +-
 drivers/tty/moxa.c              | 4 ++--
 drivers/tty/serial/lpc32xx_hs.c | 2 +-
 drivers/tty/vt/keyboard.c       | 6 +++---
 drivers/tty/vt/vt.c             | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index d24af649a8bb..c01cd36dda41 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -151,7 +151,7 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 	address = (unsigned long)(void *)buf;
 	goldfish_tty_rw(qtty, address, count, 0);
 
-	tty_schedule_flip(&qtty->port);
+	tty_flip_buffer_push(&qtty->port);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index e37683e25055..f3c72ab1476c 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1683,7 +1683,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 		if (inited && !tty_throttled(tty) &&
 				MoxaPortRxQueue(p) > 0) { /* RX */
 			MoxaPortReadData(p);
-			tty_schedule_flip(&p->port);
+			tty_flip_buffer_push(&p->port);
 		}
 	} else {
 		clear_bit(EMPTYWAIT, &p->statusflags);
@@ -1708,7 +1708,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 
 	if (tty && (intr & IntrBreak) && !I_IGNBRK(tty)) { /* BREAK */
 		tty_insert_flip_char(&p->port, 0, TTY_BREAK);
-		tty_schedule_flip(&p->port);
+		tty_flip_buffer_push(&p->port);
 	}
 
 	if (intr & IntrLine)
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index b199d7859961..07c4161eb4cc 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -341,7 +341,7 @@ static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 		       LPC32XX_HSUART_IIR(port->membase));
 		port->icount.overrun++;
 		tty_insert_flip_char(tport, 0, TTY_OVERRUN);
-		tty_schedule_flip(tport);
+		tty_flip_buffer_push(tport);
 	}
 
 	/* Data received? */
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..3700cd057f27 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -324,13 +324,13 @@ int kbd_rate(struct kbd_repeat *rpt)
 static void put_queue(struct vc_data *vc, int ch)
 {
 	tty_insert_flip_char(&vc->port, ch, 0);
-	tty_schedule_flip(&vc->port);
+	tty_flip_buffer_push(&vc->port);
 }
 
 static void puts_queue(struct vc_data *vc, const char *cp)
 {
 	tty_insert_flip_string(&vc->port, cp, strlen(cp));
-	tty_schedule_flip(&vc->port);
+	tty_flip_buffer_push(&vc->port);
 }
 
 static void applkey(struct vc_data *vc, int key, char mode)
@@ -584,7 +584,7 @@ static void fn_inc_console(struct vc_data *vc)
 static void fn_send_intr(struct vc_data *vc)
 {
 	tty_insert_flip_char(&vc->port, 0, TTY_BREAK);
-	tty_schedule_flip(&vc->port);
+	tty_flip_buffer_push(&vc->port);
 }
 
 static void fn_scroll_forw(struct vc_data *vc)
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7359c3e80d63..f8c87c4d7399 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1833,7 +1833,7 @@ static void csi_m(struct vc_data *vc)
 static void respond_string(const char *p, size_t len, struct tty_port *port)
 {
 	tty_insert_flip_string(port, p, len);
-	tty_schedule_flip(port);
+	tty_flip_buffer_push(port);
 }
 
 static void cursor_report(struct vc_data *vc, struct tty_struct *tty)
-- 
2.33.1

