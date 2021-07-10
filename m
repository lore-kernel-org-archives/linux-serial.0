Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427ABC07E95
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jul 2021 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222DA613AB
	for <linux-serial@archiver.kernel.org>; Sat, 10 Jul 2021 14:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhGJOJl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 10 Jul 2021 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhGJOJl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 10 Jul 2021 10:09:41 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4C6C0613DD;
        Sat, 10 Jul 2021 07:06:56 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h4so13000278pgp.5;
        Sat, 10 Jul 2021 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=URDqb9zjYQ7mZTdIlVsIzvmo/ii4zncZrJ90YneZcyY=;
        b=gqqMCxij/XjH4AyVVdem0KOcqKv0gqzjpC2t8bb0/eaPaw3t51jkERWQT+uCPrXf7p
         pVmgTVQHCaWoEg5FuQ4EH3ydf682GFo2ZTvzM3S4pbNI8+K1KeU14ZnBiokcnB+xU7Fo
         cm001Py37h6vG8zeroxIj7mlpg+rnqrlvLfPTISPWPWS0hCtwhsWRdmzAw8rwWXV6FfC
         qUfr1IDYKBC2xv/oFJSLPqB2vmXaBqNpibJ8A48o4SNZ16qPxriXdqkymYCSL9ufkZwG
         gx8Htt0FRzK4/u3iMeGRzs4jPWBCj9ZwafXe9BFhFAx+7FWSsjMYpIMgptIDYPjS6LAv
         Efgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=URDqb9zjYQ7mZTdIlVsIzvmo/ii4zncZrJ90YneZcyY=;
        b=PtFcHI0cDBJX8du9AwsqM0zAPSYYGFHyXzRRcB0F9j7ZcfvDFTPPp3Y1vndL04OKYD
         Du4DQRbN4Q2FGYYazKCV4iRX80K3SMTekSNKYHs7Jn34xYZDYYvBApJ52yfW7hNms0O/
         kCDUanXX3FqavLa4qyx5/nUOEQC/0Gc22llO+sMVXSej9+AL9FsbZBzk6ml1xeEBh8QA
         Fs9cs0rjLVFfncm3IDr2pldc2ZIenifvMh48CeVULE85n2CweYRKZc0IlXUCXTlVqwg5
         Em2yu3ZOz3ahCA9olshPRdPpMXWi1E5Y1NoLGIKwlnKoo0IQj6/AuPRBjleGMcRJ0FXi
         5xmg==
X-Gm-Message-State: AOAM530+uEvov+Frc8L4IHyHt9X1EZPqtrWi4IY99sLKi4w2rCiEXelm
        oPOY5HSlNKqh93K6qLRQUw==
X-Google-Smtp-Source: ABdhPJyLW1CP6LcdW3Chz1lwiQWjy8RLz86QjeEOnRG+SGlLWTfw64NhqIDEPSBqHHRstWoIafFOzA==
X-Received: by 2002:a62:86c5:0:b029:328:e1fb:8332 with SMTP id x188-20020a6286c50000b0290328e1fb8332mr8205621pfd.35.1625926015353;
        Sat, 10 Jul 2021 07:06:55 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id l12sm9734123pff.105.2021.07.10.07.06.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jul 2021 07:06:54 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        rclemsmith@gmail.com
Cc:     zheyuma97@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: jsm: hold port lock when reporting modem line changes
Date:   Sat, 10 Jul 2021 14:05:59 +0000
Message-Id: <1625925959-11086-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_handle_dcd_change() requires a port lock to be held and will emit a
warning when lockdep is enabled.

Held corresponding lock to fix warnings.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/tty/serial/jsm/jsm_neo.c | 2 ++
 drivers/tty/serial/jsm/jsm_tty.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index bf0e2a4cb0ce..c6f927a76c3b 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -815,7 +815,9 @@ static void neo_parse_isr(struct jsm_board *brd, u32 port)
 		/* Parse any modem signal changes */
 		jsm_dbg(INTR, &ch->ch_bd->pci_dev,
 			"MOD_STAT: sending to parse_modem_sigs\n");
+		spin_lock_irqsave(&ch->uart_port.lock, lock_flags);
 		neo_parse_modem(ch, readb(&ch->ch_neo_uart->msr));
+		spin_unlock_irqrestore(&ch->uart_port.lock, lock_flags);
 	}
 }
 
diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 8e42a7682c63..d74cbbbf33c6 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -187,6 +187,7 @@ static void jsm_tty_break(struct uart_port *port, int break_state)
 
 static int jsm_tty_open(struct uart_port *port)
 {
+	unsigned long lock_flags;
 	struct jsm_board *brd;
 	struct jsm_channel *channel =
 		container_of(port, struct jsm_channel, uart_port);
@@ -240,6 +241,7 @@ static int jsm_tty_open(struct uart_port *port)
 	channel->ch_cached_lsr = 0;
 	channel->ch_stops_sent = 0;
 
+	spin_lock_irqsave(&port->lock, lock_flags);
 	termios = &port->state->port.tty->termios;
 	channel->ch_c_cflag	= termios->c_cflag;
 	channel->ch_c_iflag	= termios->c_iflag;
@@ -259,6 +261,7 @@ static int jsm_tty_open(struct uart_port *port)
 	jsm_carrier(channel);
 
 	channel->ch_open_count++;
+	spin_unlock_irqrestore(&port->lock, lock_flags);
 
 	jsm_dbg(OPEN, &channel->ch_bd->pci_dev, "finish\n");
 	return 0;
-- 
2.17.6

