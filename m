Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7363CC07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 05:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564F5613B6
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 05:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237984AbhGNF40 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 01:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbhGNF40 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 01:56:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DF2C0613DD;
        Tue, 13 Jul 2021 22:53:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3014081pjx.1;
        Tue, 13 Jul 2021 22:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FcWz93B3TY2NaEB6A00DYMs3rnSUlD4JI48Qjj+1dto=;
        b=I6dUFLht6XEJWdXKzQSNpt8coqO8492xaA25/5tMPw5iCpQnwB4fWPN5qNIi6+TsWC
         4Yx/Nx4YAvxsa6jEcXtzipX1qDevkNk56obKp/XH2BiIgp9achR1cuKPZSgXbo0cRs+M
         P6R35psBXBseb34/aTufJH1uUccG9KLwuCvwPV6OdB/psTLtJBbLSS9+u9eR4K7TZ6K1
         ze76dsl/bjZXoD2t4oGNx99sp9GzELsovZeB+CSelTPOeJ2ZcW2s6LVvHVbJm02adi/r
         USf13g11MyOKMdHUB/cAT9Z2g+2KwbXqd+UTP2Fvlblh0kmnrpJcAlpPzYfjLcJE0b7q
         56sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FcWz93B3TY2NaEB6A00DYMs3rnSUlD4JI48Qjj+1dto=;
        b=jaLivzZ1yli5t9BcJxY8cONcm+gxDT9HSOgQCOT7mEVWPjhvTMgP8kYehK7169IA6r
         VlFWJpul9+LyvEhtxdcXp07qcW64HlCpVWTLHAjekEhBYyu3oDA5+KWB27Q+I3eSgyxW
         rcubYK9mJKCI4HrG18KE165TU9t23ObLqK0icezI0z/1AOPydUEJKI0F0tNF80wgP9mf
         tuRCPMKuDq6BjPwamSifKOiZVCmQuph2lH4USBWLoflQeqZx+DJj1keqT0H15gU2TLXR
         oPFB81CuyaRYeQk+LaGXKD+aD7tLyIopwHW8n3FkHWSVBsrpdcTDucgC/03BTa676oPa
         k45g==
X-Gm-Message-State: AOAM531mKOfCyOoXtT6/ZXhALgpNV6CqCaVp4PSML2kw2pJyUIOuVP2M
        5F5KIc5Pjh5SZtu9fq70sQ==
X-Google-Smtp-Source: ABdhPJxpcAXRl+b1TV9SBrV8jdbj55m3TVAZEPwCuDwd44O866ldbFvfB5dIc51IGFv1oqgWqD817Q==
X-Received: by 2002:a17:90a:b284:: with SMTP id c4mr8180136pjr.213.1626242014991;
        Tue, 13 Jul 2021 22:53:34 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id c11sm1143812pfp.0.2021.07.13.22.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jul 2021 22:53:34 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        rclemsmith@gmail.com
Cc:     zheyuma97@gmail.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] tty: serial: jsm: hold port lock when reporting modem line changes
Date:   Wed, 14 Jul 2021 05:53:23 +0000
Message-Id: <1626242003-3809-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

uart_handle_dcd_change() requires a port lock to be held and will emit a
warning when lockdep is enabled.

Held corresponding lock to fix the following warnings.

[  132.528648] WARNING: CPU: 5 PID: 11600 at drivers/tty/serial/serial_core.c:3046 uart_handle_dcd_change+0xf4/0x120
[  132.530482] Modules linked in:
[  132.531050] CPU: 5 PID: 11600 Comm: jsm Not tainted 5.14.0-rc1-00003-g7fef2edf7cc7-dirty #31
[  132.535268] RIP: 0010:uart_handle_dcd_change+0xf4/0x120
[  132.557100] Call Trace:
[  132.557562]  ? __free_pages+0x83/0xb0
[  132.558213]  neo_parse_modem+0x156/0x220
[  132.558897]  neo_param+0x399/0x840
[  132.559495]  jsm_tty_open+0x12f/0x2d0
[  132.560131]  uart_startup.part.18+0x153/0x340
[  132.560888]  ? lock_is_held_type+0xe9/0x140
[  132.561660]  uart_port_activate+0x7f/0xe0
[  132.562351]  ? uart_startup.part.18+0x340/0x340
[  132.563003]  tty_port_open+0x8d/0xf0
[  132.563523]  ? uart_set_options+0x1e0/0x1e0
[  132.564125]  uart_open+0x24/0x40
[  132.564604]  tty_open+0x15c/0x630

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
Changes in v2:
    - Attach an excerpt from the warning
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

