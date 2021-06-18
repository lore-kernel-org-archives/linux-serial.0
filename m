Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D1DC49EA2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8957613C2
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhFRGRc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58890 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhFRGR1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CA44F21B42;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08gJWBTpAoie9gQ/mqnyJiGPBdl6ZbNG2vmUHjM+/xo=;
        b=ecJyI/2iVO0eNjSIJtb7EkTj6ZmlLM3ER5l01A+n2xYbSw9SNxZalcgzaauk3rf/v8o31G
        hAh4fgPlvNYT+zxAgNrKlhIG/2JxUCd948obkDIQPBETMvOg47dh1UnamDst/IserDe82P
        sK9a67dT0rkAPE2KLSP59UKAb5TJhcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996917;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=08gJWBTpAoie9gQ/mqnyJiGPBdl6ZbNG2vmUHjM+/xo=;
        b=ttoSj8P/vgbHJs5bnvwvV4zEI70Ty6SKYHz7HyMaON87ZYeOPvRYeABbnLdizVCnUgTmHg
        7Si9q8CCpYufC6Aw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9A4B5A3B99;
        Fri, 18 Jun 2021 06:15:17 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/70] mxser: remove info printout from init
Date:   Fri, 18 Jun 2021 08:14:09 +0200
Message-Id: <20210618061516.662-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There is no reason/desire to print module information upon module load.
Drop this printk (and a version define).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index ef539f084e55..d91f8e791aab 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -43,7 +43,6 @@
 
 #include "mxser.h"
 
-#define	MXSER_VERSION	"2.0.5"		/* 1.14 */
 #define	MXSERMAJOR	 174
 
 #define MXSER_BOARDS		4	/* Max. boards */
@@ -2427,9 +2426,6 @@ static int __init mxser_module_init(void)
 	if (!mxvar_sdriver)
 		return -ENOMEM;
 
-	printk(KERN_INFO "MOXA Smartio/Industio family driver version %s\n",
-		MXSER_VERSION);
-
 	/* Initialize the tty_driver structure */
 	mxvar_sdriver->name = "ttyMI";
 	mxvar_sdriver->major = ttymajor;
-- 
2.32.0

