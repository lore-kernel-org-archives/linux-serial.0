Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E44FC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8872067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFOHty (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgFOHtV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1805BB090;
        Mon, 15 Jun 2020 07:49:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 33/38] vt_ioctl: move vt_setactivate out of vt_ioctl
Date:   Mon, 15 Jun 2020 09:49:05 +0200
Message-Id: <20200615074910.19267-33-jslaby@suse.cz>
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
 drivers/tty/vt/vt_ioctl.c | 74 +++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 35 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 978c33ad6619..e8bcfcdbedbb 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -633,6 +633,44 @@ static int vt_io_ioctl(struct vc_data *vc, unsigned int cmd, void __user *up,
 	return 0;
 }
 
+static int vt_setactivate(struct vt_setactivate __user *sa)
+{
+	struct vt_setactivate vsa;
+	struct vc_data *nvc;
+	int ret;
+
+	if (copy_from_user(&vsa, sa, sizeof(vsa)))
+		return -EFAULT;
+	if (vsa.console == 0 || vsa.console > MAX_NR_CONSOLES)
+		return -ENXIO;
+
+	vsa.console = array_index_nospec(vsa.console, MAX_NR_CONSOLES + 1);
+	vsa.console--;
+	console_lock();
+	ret = vc_allocate(vsa.console);
+	if (ret) {
+		console_unlock();
+		return ret;
+	}
+
+	/*
+	 * This is safe providing we don't drop the console sem between
+	 * vc_allocate and finishing referencing nvc.
+	 */
+	nvc = vc_cons[vsa.console].d;
+	nvc->vt_mode = vsa.mode;
+	nvc->vt_mode.frsig = 0;
+	put_pid(nvc->vt_pid);
+	nvc->vt_pid = get_pid(task_pid(current));
+	console_unlock();
+
+	/* Commence switch and lock */
+	/* Review set_console locks */
+	set_console(vsa.console);
+
+	return 0;
+}
+
 /* deallocate a single console, if possible (leave 0) */
 static int vt_disallocate(unsigned int vc_num)
 {
@@ -797,44 +835,10 @@ int vt_ioctl(struct tty_struct *tty,
 		break;
 
 	case VT_SETACTIVATE:
-	{
-		struct vt_setactivate vsa;
-		struct vc_data *nvc;
-
 		if (!perm)
 			return -EPERM;
 
-		if (copy_from_user(&vsa, (struct vt_setactivate __user *)arg,
-					sizeof(struct vt_setactivate)))
-			return -EFAULT;
-		if (vsa.console == 0 || vsa.console > MAX_NR_CONSOLES)
-			return -ENXIO;
-
-		vsa.console = array_index_nospec(vsa.console,
-						 MAX_NR_CONSOLES + 1);
-		vsa.console--;
-		console_lock();
-		ret = vc_allocate(vsa.console);
-		if (ret) {
-			console_unlock();
-			return ret;
-		}
-
-		/* This is safe providing we don't drop the
-		   console sem between vc_allocate and
-		   finishing referencing nvc */
-		nvc = vc_cons[vsa.console].d;
-		nvc->vt_mode = vsa.mode;
-		nvc->vt_mode.frsig = 0;
-		put_pid(nvc->vt_pid);
-		nvc->vt_pid = get_pid(task_pid(current));
-		console_unlock();
-
-		/* Commence switch and lock */
-		/* Review set_console locks */
-		set_console(vsa.console);
-		break;
-	}
+		return vt_setactivate(up);
 
 	/*
 	 * wait until the specified VT has been activated
-- 
2.27.0

