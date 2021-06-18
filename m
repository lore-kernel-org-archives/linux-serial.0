Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CBEC49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE6D6120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhFRGSh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59074 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhFRGRs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 935B321B6A;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+EellicTsqi+obK/4cr/ZZtT3Qc7mWagnt2gFZfGkg=;
        b=y/XpAbF5eS34fnY2R3wGtmn3D+WZ1w1qnzUK3tH5rMyW7znjkeYmSbcD/K4T74OGWBiTB2
        BQCdMHE0f/hlyFrDOJpjmNCR3JOWKhp76f3Xe/GDUFHwy36HwQpNvNuj2Z3IKlRrqpRoNN
        /Wvcit1Uh4L/6CYtN9ErCd3UiW0UQXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+EellicTsqi+obK/4cr/ZZtT3Qc7mWagnt2gFZfGkg=;
        b=Z8qkJrGQisnRe4HvL05ZE14smd8QPMt4B6sXqZyHPfU/axV/FPyABu0WH7/I0A8wnTEPwZ
        J9cwpYOE5ho0NEBA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6E54CA3B9D;
        Fri, 18 Jun 2021 06:15:27 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 49/70] mxser: cleanup mxser_process_txrx_fifo
Date:   Fri, 18 Jun 2021 08:14:55 +0200
Message-Id: <20210618061516.662-50-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rename process_txrx_fifo to mxser_process_txrx_fifo and:
* remove useless parentheses
* return from the 'if's true branch and process the rest in normal code
  flow (shift the code one level left)

All this to make the code more readable.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index bb4110d466cb..1e54e94a7ca6 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -398,22 +398,24 @@ static enum mxser_must_hwid mxser_must_get_hwid(unsigned long io)
 	return MOXA_OTHER_UART;
 }
 
-static void process_txrx_fifo(struct mxser_port *info)
+static void mxser_process_txrx_fifo(struct mxser_port *info)
 {
-	int i;
+	unsigned int i;
 
-	if ((info->type == PORT_16450) || (info->type == PORT_8250)) {
+	if (info->type == PORT_16450 || info->type == PORT_8250) {
 		info->rx_high_water = 1;
 		info->rx_low_water = 1;
 		info->xmit_fifo_size = 1;
-	} else
-		for (i = 0; i < UART_INFO_NUM; i++)
-			if (info->board->must_hwid == Gpci_uart_info[i].type) {
-				info->rx_low_water = Gpci_uart_info[i].rx_low_water;
-				info->rx_high_water = Gpci_uart_info[i].rx_high_water;
-				info->xmit_fifo_size = Gpci_uart_info[i].fifo_size;
-				break;
-			}
+		return;
+	}
+
+	for (i = 0; i < UART_INFO_NUM; i++)
+		if (info->board->must_hwid == Gpci_uart_info[i].type) {
+			info->rx_low_water = Gpci_uart_info[i].rx_low_water;
+			info->rx_high_water = Gpci_uart_info[i].rx_high_water;
+			info->xmit_fifo_size = Gpci_uart_info[i].fifo_size;
+			break;
+		}
 }
 
 static int mxser_carrier_raised(struct tty_port *port)
@@ -1149,7 +1151,7 @@ static int mxser_set_serial_info(struct tty_struct *tty,
 
 		info->type = ss->type;
 
-		process_txrx_fifo(info);
+		mxser_process_txrx_fifo(info);
 	}
 
 	if (tty_port_initialized(port)) {
@@ -1895,7 +1897,7 @@ static void mxser_initbrd(struct mxser_board *brd, bool high_baud)
 
 		info->type = PORT_16550A;
 
-		process_txrx_fifo(info);
+		mxser_process_txrx_fifo(info);
 
 		info->port.close_delay = 5 * HZ / 10;
 		info->port.closing_wait = 30 * HZ;
-- 
2.32.0

