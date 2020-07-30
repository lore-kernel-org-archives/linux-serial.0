Return-Path: <SRS0=Qe6r=BJ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCB7C433E0
	for <linux-serial@archiver.kernel.org>; Thu, 30 Jul 2020 10:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F51207F5
	for <linux-serial@archiver.kernel.org>; Thu, 30 Jul 2020 10:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgG3Kzy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Jul 2020 06:55:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:53494 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgG3Kzx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Jul 2020 06:55:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F056FB676;
        Thu, 30 Jul 2020 10:56:03 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>, Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] tty: keyboard, do not speculate on func_table index
Date:   Thu, 30 Jul 2020 12:55:46 +0200
Message-Id: <20200730105546.24268-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It is very unlikely for processor to speculate on the func_table index.
The index is uchar and func_table is of size 256. So the compiler would
need to screw up and generate a really bad code.

But to stay on the safe side, forbid speculation on this user passed
index.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Kosina <jikos@kernel.org>
---
 drivers/tty/vt/keyboard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index f80199984ee0..0db53b5b3acf 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -32,6 +32,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/mm.h>
+#include <linux/nospec.h>
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -2019,7 +2020,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		goto reterr;
 	}
 	kbs->kb_string[sizeof(kbs->kb_string)-1] = '\0';
-	i = kbs->kb_func;
+	i = array_index_nospec(kbs->kb_func, MAX_NR_FUNC);
 
 	switch (cmd) {
 	case KDGKBSENT:
-- 
2.28.0

