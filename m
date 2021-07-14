Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546BAC11F68
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C3E61396
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 09:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhGNJQL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 05:16:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238587AbhGNJQI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 05:16:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 12DC22059A;
        Wed, 14 Jul 2021 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626253996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6vuQhixxlic1wj1A+Zwc8AxkLogGfuVvfR6Con3evs=;
        b=x5yAxngWsxIToN56K/iQp8C64PbrvtArHCgKbYrZQ/dyh2xX8/8KjLhXVboOBtd+EhpdXo
        1AaSKgAq+GLOBUPUOqB8yUY0qMP5hMwdiAoxiWh4rOvoN1Yo7HljIaZssisMiZvkHcjWn1
        3gKdwJZ3Bj2oaQA+tTpIVeB85h2dVq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626253996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6vuQhixxlic1wj1A+Zwc8AxkLogGfuVvfR6Con3evs=;
        b=UC5UNWdlcaXRRDJwwahOIwyRpP5qIkYYMxu9wMHOa9RmDrM/o9rCmvYQQ8ZAsIFEHdeSj2
        tcyCcYlg/03aiBBQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DED4BA3B8B;
        Wed, 14 Jul 2021 09:13:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/11] amiserial: remove stale comment
Date:   Wed, 14 Jul 2021 11:13:06 +0200
Message-Id: <20210714091314.8292-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210714091314.8292-1-jslaby@suse.cz>
References: <20210714091314.8292-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The comment about interrupt routines is stale at least since commit
41c28ff1635e (kill _INLINE_) from 2006. So remove the obsolete parts and
leave only "here they start...".

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/amiserial.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index b2ff5861ca78..6edd2de01f39 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -179,21 +179,8 @@ static void rs_start(struct tty_struct *tty)
 /*
  * ----------------------------------------------------------------------
  *
- * Here starts the interrupt handling routines.  All of the following
- * subroutines are declared as inline and are folded into
- * rs_interrupt().  They were separated out for readability's sake.
+ * Here start the interrupt handling routines.
  *
- * Note: rs_interrupt() is a "fast" interrupt, which means that it
- * runs with interrupts turned off.  People who may want to modify
- * rs_interrupt() should try to keep the interrupt handler as fast as
- * possible.  After you are done making modifications, it is not a bad
- * idea to do:
- * 
- * gcc -S -DKERNEL -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer serial.c
- *
- * and look at the resulting assemble code in serial.s.
- *
- * 				- Ted Ts'o (tytso@mit.edu), 7-Mar-93
  * -----------------------------------------------------------------------
  */
 
-- 
2.32.0

