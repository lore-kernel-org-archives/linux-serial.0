Return-Path: <SRS0=C9ms=DX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8FC433E7
	for <linux-serial@archiver.kernel.org>; Fri, 16 Oct 2020 12:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16FAE2083B
	for <linux-serial@archiver.kernel.org>; Fri, 16 Oct 2020 12:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407464AbgJPMYO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Oct 2020 08:24:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:40124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407462AbgJPMYO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Oct 2020 08:24:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0D4BAD20;
        Fri, 16 Oct 2020 12:24:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minh Yuan <yuanmingbuaa@gmail.com>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/3] vt: keyboard, simplify vt_kdgkbsent
Date:   Fri, 16 Oct 2020 14:24:11 +0200
Message-Id: <20201016122412.31767-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016122412.31767-1-jslaby@suse.cz>
References: <20201016122412.31767-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Use 'strlen' of the string, add one for NUL and simply do 'copy_to_user'
instead of the explicit 'for' loop. This makes the KDGKBSENT case more
compact.

The only thing we need to take care about is NULL 'from'.

The original check for overflow could never trigger as the func_buf
(called 'from' here) strings are always shorter or equal to struct
kbsentry's.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/keyboard.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index d8e2452da1bd..68f9f6a62d02 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1995,9 +1995,7 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
 	char *kbs;
-	char *p;
 	u_char *q;
-	u_char __user *up;
 	int sz, fnw_sz;
 	int delta;
 	char *first_free, *fj, *fnw;
@@ -2014,20 +2012,15 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	i = array_index_nospec(i, MAX_NR_FUNC);
 
 	switch (cmd) {
-	case KDGKBSENT:
-		/* sz should have been a struct member */
-		sz = sizeof_field(struct kbsentry, kb_string) - 1;
-		up = user_kdgkb->kb_string;
-		p = func_table[i];
-		if(p)
-			for ( ; *p && sz; p++, sz--)
-				if (put_user(*p, up++))
-					return -EFAULT;
-
-		if (put_user('\0', up))
+	case KDGKBSENT: {
+		/* size should have been a struct member */
+		unsigned char *from = func_table[i] ? : "";
+
+		if (copy_to_user(user_kdgkb->kb_string, from, strlen(from) + 1))
 			return -EFAULT;
 
-		return ((p && *p) ? -EOVERFLOW : 0);
+		return 0;
+	}
 	case KDSKBSENT:
 		if (!perm)
 			return -EPERM;
-- 
2.28.0

