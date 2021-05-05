Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93797C4361A
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A97A613E9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhEEJUn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:41684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232426AbhEEJUd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EE0CB26E;
        Wed,  5 May 2021 09:19:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 20/35] ti-st: use goto-failpath in st_core_init
Date:   Wed,  5 May 2021 11:19:13 +0200
Message-Id: <20210505091928.22010-21-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use the classic failpath handling using gotos in st_core_init. That way,
tty_unregister_ldisc needs not be repeated on two places.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/ti-st/st_core.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index 85315e726644..05c015140cad 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -872,9 +872,8 @@ int st_core_init(struct st_data_s **core_data)
 	st_gdata = kzalloc(sizeof(struct st_data_s), GFP_KERNEL);
 	if (!st_gdata) {
 		pr_err("memory allocation failed");
-		tty_unregister_ldisc(&st_ldisc_ops);
 		err = -ENOMEM;
-		return err;
+		goto err_unreg_ldisc;
 	}
 
 	/* Initialize ST TxQ and Tx waitQ queue head. All BT/FM/GPS module skb's
@@ -889,15 +888,18 @@ int st_core_init(struct st_data_s **core_data)
 	err = st_ll_init(st_gdata);
 	if (err) {
 		pr_err("error during st_ll initialization(%ld)", err);
-		kfree(st_gdata);
-		tty_unregister_ldisc(&st_ldisc_ops);
-		return err;
+		goto err_free_gdata;
 	}
 
 	INIT_WORK(&st_gdata->work_write_wakeup, work_fn_write_wakeup);
 
 	*core_data = st_gdata;
 	return 0;
+err_free_gdata:
+	kfree(st_gdata);
+err_unreg_ldisc:
+	tty_unregister_ldisc(&st_ldisc_ops);
+	return err;
 }
 
 void st_core_exit(struct st_data_s *st_gdata)
-- 
2.31.1

