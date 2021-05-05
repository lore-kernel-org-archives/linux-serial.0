Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01BAC43616
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B763B613F0
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhEEJUl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232385AbhEEJUb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C672B271;
        Wed,  5 May 2021 09:19:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/35] n_gsm: use goto-failpaths in gsm_init
Date:   Wed,  5 May 2021 11:19:08 +0200
Message-Id: <20210505091928.22010-16-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use the classic failpath handling using gotos in gsm_init. That way,
tty_unregister_ldisc needs not be repeated on two places.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 654e439ff6c8..cce2ef04caeb 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3252,9 +3252,9 @@ static int __init gsm_init(void)
 
 	gsm_tty_driver = alloc_tty_driver(256);
 	if (!gsm_tty_driver) {
-		tty_unregister_ldisc(N_GSM0710);
 		pr_err("gsm_init: tty allocation failed.\n");
-		return -EINVAL;
+		status = -ENOMEM;
+		goto err_unreg_ldisc;
 	}
 	gsm_tty_driver->driver_name	= "gsmtty";
 	gsm_tty_driver->name		= "gsmtty";
@@ -3270,14 +3270,18 @@ static int __init gsm_init(void)
 	tty_set_operations(gsm_tty_driver, &gsmtty_ops);
 
 	if (tty_register_driver(gsm_tty_driver)) {
-		put_tty_driver(gsm_tty_driver);
-		tty_unregister_ldisc(N_GSM0710);
 		pr_err("gsm_init: tty registration failed.\n");
-		return -EBUSY;
+		status = -EBUSY;
+		goto err_put_driver;
 	}
 	pr_debug("gsm_init: loaded as %d,%d.\n",
 			gsm_tty_driver->major, gsm_tty_driver->minor_start);
 	return 0;
+err_put_driver:
+	put_tty_driver(gsm_tty_driver);
+err_unreg_ldisc:
+	tty_unregister_ldisc(N_GSM0710);
+	return status;
 }
 
 static void __exit gsm_exit(void)
-- 
2.31.1

