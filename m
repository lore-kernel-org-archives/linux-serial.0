Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF5C433DF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0EF2067B
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgFOHuN (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:50:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:40180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbgFOHtU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE0E8AFD7;
        Mon, 15 Jun 2020 07:49:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 27/38] vt: remove superfluous parens in invert_screen and build_attr
Date:   Mon, 15 Jun 2020 09:48:59 +0200
Message-Id: <20200615074910.19267-27-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There were too many parentheses in invert_screen, remove them and align
the code in invert_screen a bit.

No functional change intended.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 2b9fc628f05b..3aff2e3cf5a6 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -730,7 +730,7 @@ static u8 build_attr(struct vc_data *vc, u8 _color,
 	else if (_intensity == VCI_HALF_BRIGHT)
 		a = (a & 0xf0) | vc->vc_halfcolor;
 	if (_reverse)
-		a = ((a) & 0x88) | ((((a) >> 4) | ((a) << 4)) & 0x77);
+		a = (a & 0x88) | (((a >> 4) | (a << 4)) & 0x77);
 	if (_blink)
 		a ^= 0x80;
 	if (_intensity == VCI_BOLD)
@@ -777,14 +777,18 @@ void invert_screen(struct vc_data *vc, int offset, int count, int viewed)
 		} else if (vc->vc_hi_font_mask == 0x100) {
 			while (cnt--) {
 				a = scr_readw(q);
-				a = ((a) & 0x11ff) | (((a) & 0xe000) >> 4) | (((a) & 0x0e00) << 4);
+				a = (a & 0x11ff) |
+				   ((a & 0xe000) >> 4) |
+				   ((a & 0x0e00) << 4);
 				scr_writew(a, q);
 				q++;
 			}
 		} else {
 			while (cnt--) {
 				a = scr_readw(q);
-				a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) | (((a) & 0x0700) << 4);
+				a = (a & 0x88ff) |
+				   ((a & 0x7000) >> 4) |
+				   ((a & 0x0700) << 4);
 				scr_writew(a, q);
 				q++;
 			}
-- 
2.27.0

