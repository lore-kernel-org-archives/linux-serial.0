Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA5EC433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05EEB60295
	for <linux-serial@archiver.kernel.org>; Tue, 14 Sep 2021 09:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhINJMy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:12:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43304 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhINJMx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Sep 2021 05:12:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 627811FDD8;
        Tue, 14 Sep 2021 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Afy0W5Ch0lQc/0H0xlqzCO70rTwo6T7/zH/NeO0NZWg=;
        b=2cNPdCLAtMVIAkKoq0FDgNFwn4ZmVm1gWTGTRs+XObz68PyTXIiqa7jExCtfLRe+8mes9F
        BhDKlHxT0e0iMMcuvLepHcrIHOgb6dK3aBdjVWndB58eB47hdV2Z1vzSuJzYrFFcrqqoeu
        ekP3H96ovbeHBsZ8o5KRylb98dm/hSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610695;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Afy0W5Ch0lQc/0H0xlqzCO70rTwo6T7/zH/NeO0NZWg=;
        b=6Kk8lUvZjStigNV41t9A2eHz9fqTrTGEbBWNj6T4EvFXDg2khEPIgjrps7WZFo26THs+P+
        U3ovA/jZEYAoK+Bg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4667DA3B8E;
        Tue, 14 Sep 2021 09:11:35 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/16] tty: remove flags from struct tty_ldisc_ops
Date:   Tue, 14 Sep 2021 11:11:20 +0200
Message-Id: <20210914091134.17426-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091134.17426-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The last user was apparently removed by commit a352def21a64 (tty: Ldisc
revamp) in 2008. So remove the field completely, the only setter
(n_tty_inherit_ops) and also its only possible value
(LDISC_FLAG_DEFINED).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c       | 1 -
 include/linux/tty_ldisc.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0965793dfe4f..dcb5e6ef8747 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2450,7 +2450,6 @@ void n_tty_inherit_ops(struct tty_ldisc_ops *ops)
 {
 	*ops = n_tty_ops;
 	ops->owner = NULL;
-	ops->flags = 0;
 }
 EXPORT_SYMBOL_GPL(n_tty_inherit_ops);
 
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index b1d812e902aa..1f37184eee63 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -180,7 +180,6 @@ extern int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
 struct tty_ldisc_ops {
 	char	*name;
 	int	num;
-	int	flags;
 
 	/*
 	 * The following routines are called from above.
@@ -220,8 +219,6 @@ struct tty_ldisc {
 	struct tty_struct *tty;
 };
 
-#define LDISC_FLAG_DEFINED	0x00000001
-
 #define MODULE_ALIAS_LDISC(ldisc) \
 	MODULE_ALIAS("tty-ldisc-" __stringify(ldisc))
 
-- 
2.33.0

