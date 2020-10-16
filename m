Return-Path: <SRS0=C9ms=DX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461E1C4363D
	for <linux-serial@archiver.kernel.org>; Fri, 16 Oct 2020 12:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB2B2073A
	for <linux-serial@archiver.kernel.org>; Fri, 16 Oct 2020 12:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407473AbgJPMYP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Oct 2020 08:24:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407463AbgJPMYO (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Oct 2020 08:24:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15102AD76;
        Fri, 16 Oct 2020 12:24:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minh Yuan <yuanmingbuaa@gmail.com>, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/3] vt: keyboard, extend func_buf_lock to readers
Date:   Fri, 16 Oct 2020 14:24:12 +0200
Message-Id: <20201016122412.31767-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016122412.31767-1-jslaby@suse.cz>
References: <20201016122412.31767-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Both read-side users of func_table/func_buf need locking. Without that,
one can easily confuse the code by repeatedly setting altering strings
like:
while (1)
	for (a = 0; a < 2; a++) {
		struct kbsentry kbs = {};
		strcpy((char *)kbs.kb_string, a ? ".\n" : "88888\n");
		ioctl(fd, KDSKBSENT, &kbs);
	}

When that program runs, one can get unexpected output by holding F1
(note the unxpected period on the last line):
.
88888
.8888

So protect all accesses to 'func_table' (and func_buf) by preexisting
'func_buf_lock'.

It is easy in 'k_fn' handler as 'puts_queue' is expected not to sleep.
On the other hand, KDGKBSENT needs a local (atomic) copy of the string
because copy_to_user can sleep.

Likely fixes CVE-2020-25656.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reported-by: Minh Yuan <yuanmingbuaa@gmail.com>
---
 drivers/tty/vt/keyboard.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 68f9f6a62d02..68b1acc0074c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -743,8 +743,13 @@ static void k_fn(struct vc_data *vc, unsigned char value, char up_flag)
 		return;
 
 	if ((unsigned)value < ARRAY_SIZE(func_table)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&func_buf_lock, flags);
 		if (func_table[value])
 			puts_queue(vc, func_table[value]);
+		spin_unlock_irqrestore(&func_buf_lock, flags);
+
 	} else
 		pr_err("k_fn called with value=%d\n", value);
 }
@@ -1991,7 +1996,7 @@ int vt_do_kdsk_ioctl(int cmd, struct kbentry __user *user_kbe, int perm,
 #undef s
 #undef v
 
-/* FIXME: This one needs untangling and locking */
+/* FIXME: This one needs untangling */
 int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
 	char *kbs;
@@ -2014,12 +2019,23 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	switch (cmd) {
 	case KDGKBSENT: {
 		/* size should have been a struct member */
-		unsigned char *from = func_table[i] ? : "";
+		char *func_copy;
+		ssize_t len = sizeof(user_kdgkb->kb_string);
 
-		if (copy_to_user(user_kdgkb->kb_string, from, strlen(from) + 1))
-			return -EFAULT;
+		func_copy = kmalloc(len, GFP_KERNEL);
+		if (!func_copy)
+			return -ENOMEM;
 
-		return 0;
+		spin_lock_irqsave(&func_buf_lock, flags);
+		len = strlcpy(func_copy, func_table[i] ? : "", len);
+		spin_unlock_irqrestore(&func_buf_lock, flags);
+
+		ret = copy_to_user(user_kdgkb->kb_string, func_copy, len + 1) ?
+			-EFAULT : 0;
+
+		kfree(func_copy);
+
+		return ret;
 	}
 	case KDSKBSENT:
 		if (!perm)
-- 
2.28.0

