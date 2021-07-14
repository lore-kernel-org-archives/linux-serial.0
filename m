Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B780C11F66
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B8261396
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhGNJQP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35506 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbhGNJQJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 75342229F0;
        Wed, 14 Jul 2021 09:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9IRLed4cwkWvChLvlKSVseSM5swjBmObAmAEV28Zhc=;
        b=owSuuX2qgX8YRWLwR45yco4eU2wq1OrmEeV+Ay2dx58bSqOTZk4ijswiprdKIbVdpqAhMW
        jgevYT+A+e7DcmnBOTaIUqTbM79t6KD3PxUMQ97Q1uV8Bzbn8WjQJ8dMQYU94hRgudgXqv
        /7xdaWDLczCiEJu5MPpXhu5Nivs5rhk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253997;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l9IRLed4cwkWvChLvlKSVseSM5swjBmObAmAEV28Zhc=;
        b=56/NxJ2uhkhxUstbVTVB3BxFIrNlQpyoVkClVC3NbRN2u0aR6W/y/zoPdhy+XY1tu0cI/e
        3PHH/1Id5kkDmaAQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4DBECA3B85;
        Wed, 14 Jul 2021 09:13:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 10/11] amiserial: switch rs_table to a single state
Date:   Wed, 14 Jul 2021 11:13:13 +0200
Message-Id: <20210714091314.8292-10-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

amiserial deals only with a single serial, so drop the rs_table array
and NR_PORTS and define a single non-array serial_state for simplicity
instead.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 0a76e70a0b96..dffaff5a587a 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -97,9 +97,7 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout);
 
 
-static struct serial_state rs_table[1];
-
-#define NR_PORTS ARRAY_SIZE(rs_table)
+static struct serial_state serial_state;
 
 /* some serial hardware definitions */
 #define SDR_OVRUN   (1<<15)
@@ -1424,7 +1422,7 @@ static inline void line_info(struct seq_file *m, int line,
 static int rs_proc_show(struct seq_file *m, void *v)
 {
 	seq_printf(m, "serinfo:1.0 driver:4.30\n");
-	line_info(m, 0, &rs_table[0]);
+	line_info(m, 0, &serial_state);
 	return 0;
 }
 
@@ -1494,11 +1492,11 @@ static const struct tty_port_operations amiga_port_ops = {
  */
 static int __init amiga_serial_probe(struct platform_device *pdev)
 {
+	struct serial_state *state = &serial_state;
 	unsigned long flags;
-	struct serial_state * state;
 	int error;
 
-	serial_driver = alloc_tty_driver(NR_PORTS);
+	serial_driver = alloc_tty_driver(1);
 	if (!serial_driver)
 		return -ENOMEM;
 
@@ -1516,7 +1514,6 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	serial_driver->flags = TTY_DRIVER_REAL_RAW;
 	tty_set_operations(serial_driver, &serial_ops);
 
-	state = rs_table;
 	memset(state, 0, sizeof(*state));
 	state->port = (int)&amiga_custom.serdatr; /* Just to give it a value */
 	tty_port_init(&state->tport);
-- 
2.32.0

