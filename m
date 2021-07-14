Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1423C07E9A
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D113A61396
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhGNJQP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35498 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbhGNJQJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B07ED22956;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRuxLge5AlteoYV78vj+gK2JV6c4ueR9dyNLk8YVtp0=;
        b=hLPE1mj9Wb+baFimqyPiaH43oTWtDaYfZhHz/RfBo4chvZGCmnJMBbDZVonWRhmiohIycg
        Bq17Ju+RdFpKmaZ7Af9ak+0t5nEyce+hz1/sxggHZ7Mqr1uqdXds5zcft4dpHCO/dAylCQ
        KTA8POAh8S/Ctd/rW3lzusdC8XmHTGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRuxLge5AlteoYV78vj+gK2JV6c4ueR9dyNLk8YVtp0=;
        b=TApkWDT7B7gFbYU6eT2typgLDwmgRiy0CX8uijuwOcRXQuoF9HgYbHEZOYi+TJzwBKvPxd
        9Z0uRLMarNKj3sCg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8840BA3B81;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 06/11] amiserial: use memset to zero serial_state
Date:   Wed, 14 Jul 2021 11:13:09 +0200
Message-Id: <20210714091314.8292-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Zeroing each member of struct serial_state in probe is fragile and
overly complicated. Do one memset for them all.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 68f8cee389ec..558c77653e21 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1527,13 +1527,8 @@ static int __init amiga_serial_probe(struct platform_device *pdev)
 	tty_set_operations(serial_driver, &serial_ops);
 
 	state = rs_table;
+	memset(state, 0, sizeof(*state));
 	state->port = (int)&custom.serdatr; /* Just to give it a value */
-	state->custom_divisor = 0;
-	state->icount.cts = state->icount.dsr = 
-	  state->icount.rng = state->icount.dcd = 0;
-	state->icount.rx = state->icount.tx = 0;
-	state->icount.frame = state->icount.parity = 0;
-	state->icount.overrun = state->icount.brk = 0;
 	tty_port_init(&state->tport);
 	state->tport.ops = &amiga_port_ops;
 	tty_port_link_device(&state->tport, serial_driver, 0);
-- 
2.32.0

