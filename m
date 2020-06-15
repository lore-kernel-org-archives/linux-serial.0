Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D1EC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1ED42068E
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 07:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgFOHuO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:50:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:39996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgFOHtU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 03:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8F9FDB066;
        Mon, 15 Jun 2020 07:49:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 24/38] vt: whitespace and paren cleanup in add_softcursor
Date:   Mon, 15 Jun 2020 09:48:56 +0200
Message-Id: <20200615074910.19267-24-jslaby@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615074910.19267-1-jslaby@suse.cz>
References: <20200615074910.19267-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Format add_softcursor according to CodingStyle. Until now, it was a mess
of letters.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b1fdbf119755..f7d5a3c3845f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -866,14 +866,18 @@ static void add_softcursor(struct vc_data *vc)
 	int i = scr_readw((u16 *) vc->vc_pos);
 	u32 type = vc->vc_cursor_type;
 
-	if (! (type & 0x10)) return;
-	if (softcursor_original != -1) return;
+	if (!(type & 0x10))
+		return;
+	if (softcursor_original != -1)
+		return;
 	softcursor_original = i;
-	i |= ((type >> 8) & 0xff00 );
-	i ^= ((type) & 0xff00 );
-	if ((type & 0x20) && ((softcursor_original & 0x7000) == (i & 0x7000))) i ^= 0x7000;
-	if ((type & 0x40) && ((i & 0x700) == ((i & 0x7000) >> 4))) i ^= 0x0700;
-	scr_writew(i, (u16 *) vc->vc_pos);
+	i |= (type >> 8) & 0xff00;
+	i ^= type & 0xff00;
+	if ((type & 0x20) && (softcursor_original & 0x7000) == (i & 0x7000))
+		i ^= 0x7000;
+	if ((type & 0x40) && (i & 0x700) == ((i & 0x7000) >> 4))
+		i ^= 0x0700;
+	scr_writew(i, (u16 *)vc->vc_pos);
 	if (con_should_update(vc))
 		vc->vc_sw->con_putc(vc, i, vc->state.y, vc->state.x);
 }
-- 
2.27.0

