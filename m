Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CEBC43619
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461B7613F0
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhEEJUm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41352 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232400AbhEEJUc (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 51020B274;
        Wed,  5 May 2021 09:19:35 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 17/35] tty: drop tty_ldisc_ops::refcount
Date:   Wed,  5 May 2021 11:19:10 +0200
Message-Id: <20210505091928.22010-18-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The refcount is checked only in tty_unregister_ldisc and EBUSY returned
if it is nonzero. But none of the tty_unregister_ldisc callers act
anyhow if this (or any other) error is returned. So remove
tty_ldisc_ops::refcount completely and make tty_unregister_ldisc return
'void' in the next patches. That means we assume tty_unregister_ldisc is
not called while the ldisc might be in use. That relies on
try_module_get in get_ldops and module_put in put_ldops.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c       |  2 +-
 drivers/tty/tty_ldisc.c   | 14 +++-----------
 include/linux/tty_ldisc.h |  2 --
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 2fe27905c398..0ec93f1a61f5 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2450,7 +2450,7 @@ void n_tty_inherit_ops(struct tty_ldisc_ops *ops)
 {
 	*ops = n_tty_ops;
 	ops->owner = NULL;
-	ops->refcount = ops->flags = 0;
+	ops->flags = 0;
 }
 EXPORT_SYMBOL_GPL(n_tty_inherit_ops);
 
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index d02deeb5e584..98e8316fd28a 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -69,7 +69,6 @@ int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc)
 
 	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
 	tty_ldiscs[new_ldisc->num] = new_ldisc;
-	new_ldisc->refcount = 0;
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 
 	return ret;
@@ -90,16 +89,12 @@ EXPORT_SYMBOL(tty_register_ldisc);
 int tty_unregister_ldisc(struct tty_ldisc_ops *ldisc)
 {
 	unsigned long flags;
-	int ret = 0;
 
 	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
-	if (tty_ldiscs[ldisc->num]->refcount)
-		ret = -EBUSY;
-	else
-		tty_ldiscs[ldisc->num] = NULL;
+	tty_ldiscs[ldisc->num] = NULL;
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(tty_unregister_ldisc);
 
@@ -113,10 +108,8 @@ static struct tty_ldisc_ops *get_ldops(int disc)
 	ldops = tty_ldiscs[disc];
 	if (ldops) {
 		ret = ERR_PTR(-EAGAIN);
-		if (try_module_get(ldops->owner)) {
-			ldops->refcount++;
+		if (try_module_get(ldops->owner))
 			ret = ldops;
-		}
 	}
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 	return ret;
@@ -127,7 +120,6 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
-	ldops->refcount--;
 	module_put(ldops->owner);
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
 }
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index c20ca6a75b4c..fbe9de278629 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -208,8 +208,6 @@ struct tty_ldisc_ops {
 				const char *fp, int count);
 
 	struct  module *owner;
-
-	int refcount;
 };
 
 struct tty_ldisc {
-- 
2.31.1

