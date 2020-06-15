Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F1EC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BAD20707
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgFOHtf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:49:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbgFOHtX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6D19AB07D;
        Mon, 15 Jun 2020 07:49:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 35/38] vt_ioctl: move vt_resizex out of vt_ioctl
Date:   Mon, 15 Jun 2020 09:49:07 +0200
Message-Id: <20200615074910.19267-35-jslaby@suse.cz>
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
 drivers/tty/vt/vt_ioctl.c | 100 +++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 45 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index cdb7f0370ca9..f671e94a94a9 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -746,6 +746,60 @@ static void vt_disallocate_all(void)
 	}
 }
 
+static int vt_resizex(struct vc_data *vc, struct vt_consize __user *cs)
+{
+	struct vt_consize v;
+	int i;
+
+	if (copy_from_user(&v, cs, sizeof(struct vt_consize)))
+		return -EFAULT;
+
+	/* FIXME: Should check the copies properly */
+	if (!v.v_vlin)
+		v.v_vlin = vc->vc_scan_lines;
+
+	if (v.v_clin) {
+		int rows = v.v_vlin / v.v_clin;
+		if (v.v_rows != rows) {
+			if (v.v_rows) /* Parameters don't add up */
+				return -EINVAL;
+			v.v_rows = rows;
+		}
+	}
+
+	if (v.v_vcol && v.v_ccol) {
+		int cols = v.v_vcol / v.v_ccol;
+		if (v.v_cols != cols) {
+			if (v.v_cols)
+				return -EINVAL;
+			v.v_cols = cols;
+		}
+	}
+
+	if (v.v_clin > 32)
+		return -EINVAL;
+
+	for (i = 0; i < MAX_NR_CONSOLES; i++) {
+		struct vc_data *vcp;
+
+		if (!vc_cons[i].d)
+			continue;
+		console_lock();
+		vcp = vc_cons[i].d;
+		if (vcp) {
+			if (v.v_vlin)
+				vcp->vc_scan_lines = v.v_vlin;
+			if (v.v_clin)
+				vcp->vc_font.height = v.v_clin;
+			vcp->vc_resize_user = 1;
+			vc_resize(vcp, v.v_cols, v.v_rows);
+		}
+		console_unlock();
+	}
+
+	return 0;
+}
+
 /*
  * We handle the console-specific ioctl's here.  We allow the
  * capability to modify any console, not just the fg_console.
@@ -947,54 +1001,10 @@ int vt_ioctl(struct tty_struct *tty,
 	}
 
 	case VT_RESIZEX:
-	{
-		struct vt_consize v;
 		if (!perm)
 			return -EPERM;
-		if (copy_from_user(&v, up, sizeof(struct vt_consize)))
-			return -EFAULT;
-		/* FIXME: Should check the copies properly */
-		if (!v.v_vlin)
-			v.v_vlin = vc->vc_scan_lines;
-		if (v.v_clin) {
-			int rows = v.v_vlin/v.v_clin;
-			if (v.v_rows != rows) {
-				if (v.v_rows) /* Parameters don't add up */
-					return -EINVAL;
-				v.v_rows = rows;
-			}
-		}
-		if (v.v_vcol && v.v_ccol) {
-			int cols = v.v_vcol/v.v_ccol;
-			if (v.v_cols != cols) {
-				if (v.v_cols)
-					return -EINVAL;
-				v.v_cols = cols;
-			}
-		}
 
-		if (v.v_clin > 32)
-			return -EINVAL;
-
-		for (i = 0; i < MAX_NR_CONSOLES; i++) {
-			struct vc_data *vcp;
-
-			if (!vc_cons[i].d)
-				continue;
-			console_lock();
-			vcp = vc_cons[i].d;
-			if (vcp) {
-				if (v.v_vlin)
-					vcp->vc_scan_lines = v.v_vlin;
-				if (v.v_clin)
-					vcp->vc_font.height = v.v_clin;
-				vcp->vc_resize_user = 1;
-				vc_resize(vcp, v.v_cols, v.v_rows);
-			}
-			console_unlock();
-		}
-		break;
-	}
+		return vt_resizex(vc, up);
 
 	case VT_LOCKSWITCH:
 		if (!capable(CAP_SYS_TTY_CONFIG))
-- 
2.27.0

