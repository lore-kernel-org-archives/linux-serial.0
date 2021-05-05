Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1177C433ED
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A732B613E9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhEEJUn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:41674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232414AbhEEJUd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 298D6B269;
        Wed,  5 May 2021 09:19:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 19/35] tty: return void from tty_unregister_ldisc
Date:   Wed,  5 May 2021 11:19:12 +0200
Message-Id: <20210505091928.22010-20-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that noone checks the return value of tty_unregister_ldisc, make the
function return 'void'.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_ldisc.c | 4 +---
 include/linux/tty.h     | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 98e8316fd28a..8edd73ab9148 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -86,15 +86,13 @@ EXPORT_SYMBOL(tty_register_ldisc);
  *		takes tty_ldiscs_lock to guard against ldisc races
  */
 
-int tty_unregister_ldisc(struct tty_ldisc_ops *ldisc)
+void tty_unregister_ldisc(struct tty_ldisc_ops *ldisc)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave(&tty_ldiscs_lock, flags);
 	tty_ldiscs[ldisc->num] = NULL;
 	raw_spin_unlock_irqrestore(&tty_ldiscs_lock, flags);
-
-	return 0;
 }
 EXPORT_SYMBOL(tty_unregister_ldisc);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 6a72d0ff6391..e18a4f1ac39d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -637,7 +637,7 @@ static inline int tty_port_users(struct tty_port *port)
 }
 
 extern int tty_register_ldisc(struct tty_ldisc_ops *new_ldisc);
-extern int tty_unregister_ldisc(struct tty_ldisc_ops *ldisc);
+extern void tty_unregister_ldisc(struct tty_ldisc_ops *ldisc);
 extern int tty_set_ldisc(struct tty_struct *tty, int disc);
 extern int tty_ldisc_receive_buf(struct tty_ldisc *ld, const unsigned char *p,
 				 const char *f, int count);
-- 
2.31.1

