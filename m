Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1D9C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D497720707
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgFOHtx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgFOHtV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4674CB0B8;
        Mon, 15 Jun 2020 07:49:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 34/38] vt_ioctl: move vt_reldisp out of vt_ioctl
Date:   Mon, 15 Jun 2020 09:49:06 +0200
Message-Id: <20200615074910.19267-34-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's too long to be inlined.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt_ioctl.c | 88 ++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index e8bcfcdbedbb..cdb7f0370ca9 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -633,6 +633,42 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
 	return 0;
 }
 
+static int vt_reldisp(struct vc_data *vc, unsigned int swtch)
+{
+	int newvt, ret;
+
+	if (vc->vt_mode.mode != VT_PROCESS)
+		return -EINVAL;
+
+	/* Switched-to response */
+	if (vc->vt_newvt < 0) {
+		 /* If it's just an ACK, ignore it */
+		return swtch == VT_ACKACQ ? 0 : -EINVAL;
+	}
+
+	/* Switching-from response */
+	if (swtch == 0) {
+		/* Switch disallowed, so forget we were trying to do it. */
+		vc->vt_newvt = -1;
+		return 0;
+	}
+
+	/* The current vt has been released, so complete the switch. */
+	newvt = vc->vt_newvt;
+	vc->vt_newvt = -1;
+	ret = vc_allocate(newvt);
+	if (ret)
+		return ret;
+
+	/*
+	 * When we actually do the console switch, make sure we are atomic with
+	 * respect to other console switches..
+	 */
+	complete_change_console(vc_cons[newvt].d);
+
+	return 0;
+}
+
 static int vt_setactivate(struct vt_setactivate __user *sa)
 {
 	struct vt_setactivate vsa;
@@ -865,55 +901,11 @@ int vt_ioctl(struct tty_struct *tty,
 			return -EPERM;
 
 		console_lock();
-		if (vc->vt_mode.mode != VT_PROCESS) {
-			console_unlock();
-			return -EINVAL;
-		}
-		/*
-		 * Switching-from response
-		 */
-		if (vc->vt_newvt >= 0) {
-			if (arg == 0)
-				/*
-				 * Switch disallowed, so forget we were trying
-				 * to do it.
-				 */
-				vc->vt_newvt = -1;
-
-			else {
-				/*
-				 * The current vt has been released, so
-				 * complete the switch.
-				 */
-				int newvt;
-				newvt = vc->vt_newvt;
-				vc->vt_newvt = -1;
-				ret = vc_allocate(newvt);
-				if (ret) {
-					console_unlock();
-					return ret;
-				}
-				/*
-				 * When we actually do the console switch,
-				 * make sure we are atomic with respect to
-				 * other console switches..
-				 */
-				complete_change_console(vc_cons[newvt].d);
-			}
-		} else {
-			/*
-			 * Switched-to response
-			 */
-			/*
-			 * If it's just an ACK, ignore it
-			 */
-			if (arg != VT_ACKACQ) {
-				console_unlock();
-				return -EINVAL;
-			}
-		}
+		ret = vt_reldisp(vc, arg);
 		console_unlock();
-		break;
+
+		return ret;
+
 
 	 /*
 	  * Disallocate memory associated to VT (but leave VT1)
-- 
2.27.0

