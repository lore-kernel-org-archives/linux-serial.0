Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6D3C3404D
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24820208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 07:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBSHjy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:39:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:41528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgBSHjx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 02:39:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7EC1FAF3D;
        Wed, 19 Feb 2020 07:39:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/9] vt: selection, remove 2 local variables from set_selection_kernel
Date:   Wed, 19 Feb 2020 08:39:45 +0100
Message-Id: <20200219073951.16151-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219073951.16151-1-jslaby@suse.cz>
References: <20200219073951.16151-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

multiplier and mode are not actually needed:
* multiplier is used only in kmalloc_array, so use "use_unicode ? 4 : 1"
  directly
* mode is used only to assign a bool in this manner:
  if (cond)
    x = true;
  else
    x = false;
  So do "x = cond" directly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/selection.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 714992693974..6541c09d8bba 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -191,9 +191,9 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 	struct vc_data *vc = vc_cons[fg_console].d;
 	int new_sel_start, new_sel_end, spc;
 	char *bp, *obp;
-	int i, ps, pe, multiplier;
+	int i, ps, pe;
 	u32 c;
-	int mode, ret = 0;
+	int ret = 0;
 
 	poke_blanked_console();
 
@@ -224,11 +224,7 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 		clear_selection();
 		sel_cons = vc_cons[fg_console].d;
 	}
-	mode = vt_do_kdgkbmode(fg_console);
-	if (mode == K_UNICODE)
-		use_unicode = 1;
-	else
-		use_unicode = 0;
+	use_unicode = vt_do_kdgkbmode(fg_console) == K_UNICODE;
 
 	switch (v->sel_mode)
 	{
@@ -312,8 +308,8 @@ int set_selection_kernel(struct tiocl_selection *v, struct tty_struct *tty)
 	sel_end = new_sel_end;
 
 	/* Allocate a new buffer before freeing the old one ... */
-	multiplier = use_unicode ? 4 : 1;  /* chars can take up to 4 bytes */
-	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, multiplier,
+	/* chars can take up to 4 bytes with unicode */
+	bp = kmalloc_array((sel_end - sel_start) / 2 + 1, use_unicode ? 4 : 1,
 			   GFP_KERNEL);
 	if (!bp) {
 		printk(KERN_WARNING "selection: kmalloc() failed\n");
-- 
2.25.0

