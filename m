Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B9FC433ED
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2535613F5
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhEEJUg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:41382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232345AbhEEJU2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23A81B151;
        Wed,  5 May 2021 09:19:31 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/35] n_tty: do only one cp dereference in n_tty_receive_buf_standard
Date:   Wed,  5 May 2021 11:19:01 +0200
Message-Id: <20210505091928.22010-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It might be confusing for readers: there are three distinct dereferences
and increments of 'cp' in n_tty_receive_buf_standard. Do it on a single
place, along with/before the 'fp' dereference.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index b8f981499465..e7c9dce14f88 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1531,17 +1531,17 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 	char flag = TTY_NORMAL;
 
 	while (count--) {
+		unsigned char c = *cp++;
+
 		if (fp)
 			flag = *fp++;
 
 		if (ldata->lnext) {
-			n_tty_receive_char_lnext(tty, *cp++, flag);
+			n_tty_receive_char_lnext(tty, c, flag);
 			continue;
 		}
 
 		if (likely(flag == TTY_NORMAL)) {
-			unsigned char c = *cp++;
-
 			if (I_ISTRIP(tty))
 				c &= 0x7f;
 			if (I_IUCLC(tty) && L_IEXTEN(tty))
@@ -1555,7 +1555,7 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 			else
 				n_tty_receive_char_special(tty, c);
 		} else
-			n_tty_receive_char_flagged(tty, *cp++, flag);
+			n_tty_receive_char_flagged(tty, c, flag);
 	}
 }
 
-- 
2.31.1

