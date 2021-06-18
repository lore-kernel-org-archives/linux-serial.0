Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B309C49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E18861154
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhFRGRk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46122 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhFRGR2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 352651FDF9;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlzE/tA9A15bP1cWf8FYAk8DbHjAkzpq3AYHbd5gsZU=;
        b=thmBdbrpC58fo7iZ/NFXjdGX+q+5Z6cWWqWAFVAFjTpHbvzg22EXui42j0wOD3hcoe8zKH
        xZ4Hh5ZMaQgo/YKDZBzPgvh8VmrGhcNvE1FHIRYDC+FTvL+p01TOW9R2hWtA2/3CEIyAOz
        EXjD8n+rRhfHacteXC52bsYfYN0KuoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996918;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlzE/tA9A15bP1cWf8FYAk8DbHjAkzpq3AYHbd5gsZU=;
        b=8fa06ir51Tc2gcZM0wcy828rw3Rd0Zfqub7lMcZWrvFrli45wel4t2S91VqwAsVJnsSTfv
        9TvuQp1zRTbu1hCQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0E89AA3B99;
        Fri, 18 Jun 2021 06:15:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/70] mxser: cleanup Gpci_uart_info struct
Date:   Fri, 18 Jun 2021 08:14:11 +0200
Message-Id: <20210618061516.662-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Gpci_uart_info structure contains up to tripled information and
chose weird types for the members. Deduplicate the members and choose
proper types for the data -- everything can be u8 except baud rate.
There, we use speed_t, which is used in this context.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 0c779559f978..3b3f0da9ea64 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -200,18 +200,15 @@
 #define MXSER_HIGHBAUD	1
 
 static const struct {
-	int type;
-	int tx_fifo;
-	int rx_fifo;
-	int xmit_fifo_size;
-	int rx_high_water;
-	int rx_trigger;
-	int rx_low_water;
-	long max_baud;
+	u8 type;
+	u8 fifo_size;
+	u8 rx_high_water;
+	u8 rx_low_water;
+	speed_t max_baud;
 } Gpci_uart_info[] = {
-	{MOXA_OTHER_UART, 16, 16, 16, 14, 14, 1, 921600L},
-	{MOXA_MUST_MU150_HWID, 64, 64, 64, 48, 48, 16, 230400L},
-	{MOXA_MUST_MU860_HWID, 128, 128, 128, 96, 96, 32, 921600L}
+	{ MOXA_OTHER_UART,	 16, 14,  1, 921600 },
+	{ MOXA_MUST_MU150_HWID,	 64, 48, 16, 230400 },
+	{ MOXA_MUST_MU860_HWID, 128, 96, 32, 921600 }
 };
 #define UART_INFO_NUM	ARRAY_SIZE(Gpci_uart_info)
 
@@ -331,11 +328,10 @@ struct mxser_port {
 
 	unsigned long ioaddr;
 	unsigned long opmode_ioaddr;
-	int max_baud;
+	speed_t max_baud;
 
-	int rx_high_water;
-	int rx_trigger;		/* Rx fifo trigger level */
-	int rx_low_water;
+	u8 rx_high_water;
+	u8 rx_low_water;
 	int baud_base;		/* max. speed */
 	int type;		/* UART type */
 
@@ -354,7 +350,7 @@ struct mxser_port {
 
 	int read_status_mask;
 	int ignore_status_mask;
-	unsigned int xmit_fifo_size;
+	u8 xmit_fifo_size;
 	int xmit_head;
 	int xmit_tail;
 	int xmit_cnt;
@@ -470,9 +466,9 @@ static void mxser_set_must_fifo_value(struct mxser_port *info)
 	efr |= MOXA_MUST_EFR_BANK1;
 
 	outb(efr, info->ioaddr + MOXA_MUST_EFR_REGISTER);
-	outb((u8)info->rx_high_water, info->ioaddr + MOXA_MUST_RBRTH_REGISTER);
-	outb((u8)info->rx_trigger, info->ioaddr + MOXA_MUST_RBRTI_REGISTER);
-	outb((u8)info->rx_low_water, info->ioaddr + MOXA_MUST_RBRTL_REGISTER);
+	outb(info->rx_high_water, info->ioaddr + MOXA_MUST_RBRTH_REGISTER);
+	outb(info->rx_high_water, info->ioaddr + MOXA_MUST_RBRTI_REGISTER);
+	outb(info->rx_low_water, info->ioaddr + MOXA_MUST_RBRTL_REGISTER);
 	outb(oldlcr, info->ioaddr + UART_LCR);
 }
 
@@ -615,17 +611,15 @@ static void process_txrx_fifo(struct mxser_port *info)
 	int i;
 
 	if ((info->type == PORT_16450) || (info->type == PORT_8250)) {
-		info->rx_trigger = 1;
 		info->rx_high_water = 1;
 		info->rx_low_water = 1;
 		info->xmit_fifo_size = 1;
 	} else
 		for (i = 0; i < UART_INFO_NUM; i++)
 			if (info->board->chip_flag == Gpci_uart_info[i].type) {
-				info->rx_trigger = Gpci_uart_info[i].rx_trigger;
 				info->rx_low_water = Gpci_uart_info[i].rx_low_water;
 				info->rx_high_water = Gpci_uart_info[i].rx_high_water;
-				info->xmit_fifo_size = Gpci_uart_info[i].xmit_fifo_size;
+				info->xmit_fifo_size = Gpci_uart_info[i].fifo_size;
 				break;
 			}
 }
@@ -667,7 +661,7 @@ static void mxser_dtr_rts(struct tty_port *port, int on)
 	spin_unlock_irqrestore(&mp->slock, flags);
 }
 
-static int mxser_set_baud(struct tty_struct *tty, long newspd)
+static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 {
 	struct mxser_port *info = tty->driver_data;
 	unsigned int quot = 0, baud;
@@ -793,7 +787,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 			fcr |= MOXA_MUST_FCR_GDA_MODE_ENABLE;
 			mxser_set_must_fifo_value(info);
 		} else {
-			switch (info->rx_trigger) {
+			switch (info->rx_high_water) {
 			case 1:
 				fcr |= UART_FCR_TRIGGER_1;
 				break;
-- 
2.32.0

