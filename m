Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D8AC433B4
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A556613E9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhEEJU2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232184AbhEEJU1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDD9CB231;
        Wed,  5 May 2021 09:19:29 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 02/35] n_tty: remove n_tty_receive_char wrapper
Date:   Wed,  5 May 2021 11:18:55 +0200
Message-Id: <20210505091928.22010-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The wrapper was meant as an optimization in commits eb3e4668bd9e (n_tty:
Un-inline slow-path n_tty_receive_char()) and e60d27c4d8b3 (n_tty:
Factor LNEXT processing from per-char i/o path). But the current
compiler (gcc 10) inlines it anyway (as expected). Actually, I'm not
sure it ever didn't. It would need to be marked with the noinline
attribute.

So remove this useless wrapper.

And if we ever introduce something similar, we need confirming numbers
first.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 9686c5d10571..0a8c9440f5d2 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1401,7 +1401,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 }
 
 static inline void
-n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
+n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1423,11 +1423,6 @@ n_tty_receive_char_inline(struct tty_struct *tty, unsigned char c)
 	put_tty_queue(c, ldata);
 }
 
-static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
-{
-	n_tty_receive_char_inline(tty, c);
-}
-
 static inline void
 n_tty_receive_char_fast(struct tty_struct *tty, unsigned char c)
 {
@@ -1577,7 +1572,7 @@ n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
 				continue;
 			}
 			if (!test_bit(c, ldata->char_map))
-				n_tty_receive_char_inline(tty, c);
+				n_tty_receive_char(tty, c);
 			else if (n_tty_receive_char_special(tty, c) && count) {
 				if (fp)
 					flag = *fp++;
-- 
2.31.1

