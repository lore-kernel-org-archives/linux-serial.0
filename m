Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF10C43214
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2130B60F36
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 10:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhGWJvR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:51:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:32860 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhGWJvP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 05:51:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 567DF1FF84;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627036308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvfuWWa8Q29M+KnvzRktxkgR1NNPgjOs/hpJkmi+ZBw=;
        b=Bl4BKdUfdxk7BC10LQ4eFmpSZ7WbjkjUZYy1yTIPxnweGNlsp6g+At9uMs6BBghwKlBDcw
        b93EIglXiOmdcVnqYZgDCewQ2rmAFA2XGhI4mTmPouQnYsQRGzGOpuoh2qz8jVshTEvyq8
        tWO2v0JAfFueGC21z8zJVUuPU2PSc/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627036308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvfuWWa8Q29M+KnvzRktxkgR1NNPgjOs/hpJkmi+ZBw=;
        b=OPeCReaeFEcDQGrI7YpFd9oOjewOy2pVuZRGcouhckvwhVMxW8hrtiKog/9d0p23cHx2Tu
        mxhyLEc9dYy4RUDQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A1FBA3B9E;
        Fri, 23 Jul 2021 10:31:48 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4/8] tty: include list & lockdep from tty_ldisc.h
Date:   Fri, 23 Jul 2021 12:31:43 +0200
Message-Id: <20210723103147.18250-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210723103147.18250-1-jslaby@suse.cz>
References: <20210723103147.18250-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We use structs list_head and lockdep_map as non-pointers in tty_ldisc.h.
So better have headers defining them explicitly included so that the
structs are always defined. Not only implicitly via random include
chains.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_ldisc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 62131bb9251f..b1d812e902aa 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -128,6 +128,8 @@ struct tty_struct;
 #include <linux/fs.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/seq_file.h>
 
 /*
-- 
2.32.0

