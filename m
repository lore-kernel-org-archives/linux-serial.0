Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC4CC4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0515060E8E
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 07:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbhGWHCq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:02:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55370 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhGWHCp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 03:02:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 823F2225FE;
        Fri, 23 Jul 2021 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627026198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZsjT25MItZUg98TG024pK66nz3/iaQg4oVcs7Iej4E0=;
        b=bfzaCdOogaiDAbtW4z1zQz5UVFz/XLAPo+YyWgET7dKerP2f54qVvT3jc5e7wZtxtkyvfV
        HU+D5G8kHTsJOQf1iIIIccbDrwT6+EZT1UMD6wfGzZZ3kTGBofUQVHP5owFgwCHeDviUQr
        D6PoKK4IjvvA2eYeqnS++PIUe9foK2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627026198;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZsjT25MItZUg98TG024pK66nz3/iaQg4oVcs7Iej4E0=;
        b=WllF+5DaOsITCb5p7LdrNyFd7tTT1TJqpJDPXot87iypQGp2EAWXXbaPq023qjZv/Gw5WP
        cgpTjbMm0gIQK6BA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1CDB1A3B87;
        Fri, 23 Jul 2021 07:43:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] hvsi: don't panic on tty_register_driver failure
Date:   Fri, 23 Jul 2021 09:43:11 +0200
Message-Id: <20210723074317.32690-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723074317.32690-1-jslaby@suse.cz>
References: <20210723074317.32690-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The alloc_tty_driver failure is handled gracefully in hvsi_init. But
tty_register_driver is not. panic is called if that one fails.

So handle the failure of tty_register_driver gracefully too. This will
keep at least the console functional as it was enabled earlier by
console_initcall in hvsi_console_init. Instead of shooting down the
whole system.

This means, we disable interrupts and restore hvsi_wait back to
poll_for_state().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/tty/hvc/hvsi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvsi.c b/drivers/tty/hvc/hvsi.c
index bfc15279d5bc..f0bc8e780051 100644
--- a/drivers/tty/hvc/hvsi.c
+++ b/drivers/tty/hvc/hvsi.c
@@ -1038,7 +1038,7 @@ static const struct tty_operations hvsi_ops = {
 
 static int __init hvsi_init(void)
 {
-	int i;
+	int i, ret;
 
 	hvsi_driver = alloc_tty_driver(hvsi_count);
 	if (!hvsi_driver)
@@ -1069,12 +1069,25 @@ static int __init hvsi_init(void)
 	}
 	hvsi_wait = wait_for_state; /* irqs active now */
 
-	if (tty_register_driver(hvsi_driver))
-		panic("Couldn't register hvsi console driver\n");
+	ret = tty_register_driver(hvsi_driver);
+	if (ret) {
+		pr_err("Couldn't register hvsi console driver\n");
+		goto err_free_irq;
+	}
 
 	printk(KERN_DEBUG "HVSI: registered %i devices\n", hvsi_count);
 
 	return 0;
+err_free_irq:
+	hvsi_wait = poll_for_state;
+	for (i = 0; i < hvsi_count; i++) {
+		struct hvsi_struct *hp = &hvsi_ports[i];
+
+		free_irq(hp->virq, hp);
+	}
+	tty_driver_kref_put(hvsi_driver);
+
+	return ret;
 }
 device_initcall(hvsi_init);
 
-- 
2.32.0

