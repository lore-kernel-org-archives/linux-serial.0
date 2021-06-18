Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1107CC49EA7
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2146120A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhFRGRo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46196 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhFRGR3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:29 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 59B221FDF6;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ2mcSDmaW4gVGU3JtmSCsP7pBY+lolL3WjN/NhU3ag=;
        b=Wl25uRgWqB4205P+UO3IdyWaa56YCd+00dy/FKyoY3DnISnEeSZSHzdihZp0OUm8FiH7Um
        S7RDKgetsBTYaUAjRngE0P132aK6zrYl+wLlMpIzjjCKb2eciurq9t1+khNimMEPq3moi1
        /VhMEViee36FYZYKm1qr6eyfD56npu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996919;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ2mcSDmaW4gVGU3JtmSCsP7pBY+lolL3WjN/NhU3ag=;
        b=NsleWod2HFFeKbucegV1fij0lDJFhuI03cafHh/yl9cCTvIJ0NFo+JppFHNGmdfNT5ORDP
        ntxdLUOHNfpCEjBw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 335A0A3B99;
        Fri, 18 Jun 2021 06:15:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/70] mxser: move max_baud from port to board
Date:   Fri, 18 Jun 2021 08:14:16 +0200
Message-Id: <20210618061516.662-11-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

mxser_port::max_baud is actually a board property, not port's. So move
it to mxser_board.

While at it, drop the printk informing about max baud rate during probe.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index a6121fea7a55..db594a64ff00 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -329,7 +329,6 @@ struct mxser_port {
 
 	unsigned long ioaddr;
 	unsigned long opmode_ioaddr;
-	speed_t max_baud;
 
 	u8 rx_high_water;
 	u8 rx_low_water;
@@ -372,6 +371,7 @@ struct mxser_board {
 	unsigned long vector_mask;
 
 	enum mxser_must_hwid must_hwid;
+	speed_t max_baud;
 
 	struct mxser_port ports[MXSER_PORTS_PER_BOARD];
 };
@@ -671,7 +671,7 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 	if (!info->ioaddr)
 		return -1;
 
-	if (newspd > info->max_baud)
+	if (newspd > info->board->max_baud)
 		return -1;
 
 	if (newspd == 134) {
@@ -2345,9 +2345,6 @@ static int mxser_initbrd(struct mxser_board *brd)
 	unsigned int i;
 	int retval;
 
-	printk(KERN_INFO "mxser: max. baud rate = %d bps\n",
-			brd->ports[0].max_baud);
-
 	for (i = 0; i < brd->info->nports; i++) {
 		info = &brd->ports[i];
 		tty_port_init(&info->port);
@@ -2455,17 +2452,14 @@ static int mxser_probe(struct pci_dev *pdev,
 	brd->must_hwid = mxser_must_get_hwid(brd->ports[0].ioaddr);
 	brd->vector_mask = 0;
 
-	for (i = 0; i < brd->info->nports; i++) {
-		for (j = 0; j < UART_INFO_NUM; j++) {
-			if (Gpci_uart_info[j].type == brd->must_hwid) {
-				brd->ports[i].max_baud =
-					Gpci_uart_info[j].max_baud;
-
-				/* exception....CP-102 */
-				if (brd->info->flags & MXSER_HIGHBAUD)
-					brd->ports[i].max_baud = 921600;
-				break;
-			}
+	for (j = 0; j < UART_INFO_NUM; j++) {
+		if (Gpci_uart_info[j].type == brd->must_hwid) {
+			brd->max_baud = Gpci_uart_info[j].max_baud;
+
+			/* exception....CP-102 */
+			if (brd->info->flags & MXSER_HIGHBAUD)
+				brd->max_baud = 921600;
+			break;
 		}
 	}
 
-- 
2.32.0

