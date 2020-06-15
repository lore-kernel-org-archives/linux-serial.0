Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AB6C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F622067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgFOHuN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:50:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbgFOHtU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5C146B03E;
        Mon, 15 Jun 2020 07:49:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 23/38] vt: synchronize types and use min in csi_X
Date:   Mon, 15 Jun 2020 09:48:55 +0200
Message-Id: <20200615074910.19267-23-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

All the types are unsinged ints -- even the vpar passed to the function.
So unify them and use min() to compute count instead of explicit
comparison.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4686f8b9251d..b1fdbf119755 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1582,13 +1582,15 @@ static void csi_K(struct vc_data *vc, int vpar)
 		do_update_region(vc, (unsigned long)(start + offset), count);
 }
 
-static void csi_X(struct vc_data *vc, int vpar) /* erase the following vpar positions */
+/* erase the following vpar positions */
+static void csi_X(struct vc_data *vc, unsigned int vpar)
 {					  /* not vt100? */
-	int count;
+	unsigned int count;
 
 	if (!vpar)
 		vpar++;
-	count = (vpar > vc->vc_cols - vc->state.x) ? (vc->vc_cols - vc->state.x) : vpar;
+
+	count = min(vpar, vc->vc_cols - vc->state.x);
 
 	vc_uniscr_clear_line(vc, vc->state.x, count);
 	scr_memsetw((unsigned short *)vc->vc_pos, vc->vc_video_erase_char, 2 * count);
-- 
2.27.0

