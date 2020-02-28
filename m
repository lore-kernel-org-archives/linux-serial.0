Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E7C3F2D2
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C57246AF
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1LyJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:54:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:34700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgB1LyJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 06:54:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 247C8AFF0;
        Fri, 28 Feb 2020 11:54:07 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/2] vt: selection, push console lock down
Date:   Fri, 28 Feb 2020 12:54:05 +0100
Message-Id: <20200228115406.5735-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We need to nest the console lock in sel_lock, so we have to push it down
a bit. Fortunately, the callers of set_selection_* just lock the console
lock around the function call. So moving it down is easy.

In the next patch, we switch the order.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/staging/speakup/selection.c |  2 --
 drivers/tty/vt/selection.c          | 13 ++++++++++++-
 drivers/tty/vt/vt.c                 |  2 --
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/speakup/selection.c b/drivers/staging/speakup/selection.c
index a8b4d0c5ab7e..032f3264fba1 100644
--- a/drivers/staging/speakup/selection.c
+++ b/drivers/staging/speakup/selection.c
@@ -51,9 +51,7 @@ static void __speakup_set_selection(struct work_struct *work)
 		goto unref;
 	}
 
-	console_lock();
 	set_selection_kernel(&sel, tty);
-	console_unlock();
 
 unref:
 	tty_kref_put(tty);
diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 714992693974..5b0b897396eb 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -186,7 +186,7 @@ int set_selection_user(const struct tiocl_selection __user *sel,
 	return set_selection_kernel(&v, tty);
 }
 
-int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
+static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 {
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int new_sel_start, new_sel_end, spc;
@@ -348,6 +348,17 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 	mutex_unlock(&sel_lock);
 	return ret;
 }
+
+int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
+{
+	int ret;
+
+	console_lock();
+	ret = __set_selection_kernel(v, tty);
+	console_unlock();
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(set_selection_kernel);
 
 /* Insert the contents of the selection buffer into the
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 8fa059ec6cc8..c4d75edde923 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3047,10 +3047,8 @@ int tioclinux(struct tty_struct *tty, unsigned long arg)
 	switch (type)
 	{
 		case TIOCL_SETSEL:
-			console_lock();
 			ret = set_selection_user((struct tiocl_selection
 						 __user *)(p+1), tty);
-			console_unlock();
 			break;
 		case TIOCL_PASTESEL:
 			ret = paste_selection(tty);
-- 
2.25.1

