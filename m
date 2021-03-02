Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E07C4361B
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E1C64E7A
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbhCCCOs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:14:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:39600 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835873AbhCBGYS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3113FAC24;
        Tue,  2 Mar 2021 06:22:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 21/44] tty: jsm_tty, make char+error handling readable
Date:   Tue,  2 Mar 2021 07:21:51 +0100
Message-Id: <20210302062214.29627-21-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The code for char+error handling in jsm_input was complete mess of
letters. Introduce 3 new local variables and use them with care.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/jsm/jsm_tty.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/jsm/jsm_tty.c b/drivers/tty/serial/jsm/jsm_tty.c
index 512b77195e9f..8e42a7682c63 100644
--- a/drivers/tty/serial/jsm/jsm_tty.c
+++ b/drivers/tty/serial/jsm/jsm_tty.c
@@ -603,18 +603,22 @@ void jsm_input(struct jsm_channel *ch)
 
 		if (I_PARMRK(tp) || I_BRKINT(tp) || I_INPCK(tp)) {
 			for (i = 0; i < s; i++) {
+				u8 chr   = ch->ch_rqueue[tail + i];
+				u8 error = ch->ch_equeue[tail + i];
+				char flag = TTY_NORMAL;
+
 				/*
-				 * Give the Linux ld the flags in the
-				 * format it likes.
+				 * Give the Linux ld the flags in the format it
+				 * likes.
 				 */
-				if (*(ch->ch_equeue + tail + i) & UART_LSR_BI)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i),  TTY_BREAK);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_PE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_PARITY);
-				else if (*(ch->ch_equeue +tail +i) & UART_LSR_FE)
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_FRAME);
-				else
-					tty_insert_flip_char(port, *(ch->ch_rqueue +tail +i), TTY_NORMAL);
+				if (error & UART_LSR_BI)
+					flag = TTY_BREAK;
+				else if (error & UART_LSR_PE)
+					flag = TTY_PARITY;
+				else if (error & UART_LSR_FE)
+					flag = TTY_FRAME;
+
+				tty_insert_flip_char(port, chr, flag);
 			}
 		} else {
 			tty_insert_flip_string(port, ch->ch_rqueue + tail, s);
-- 
2.30.1

