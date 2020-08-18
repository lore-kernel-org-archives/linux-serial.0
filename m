Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83689C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655342067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHRI5N (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:37986 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgHRI5L (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5400B038;
        Tue, 18 Aug 2020 08:57:33 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 09/16] vc_screen: eliminate ifdefs from vcs_write_buf
Date:   Tue, 18 Aug 2020 10:56:59 +0200
Message-Id: <20200818085706.12163-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Introduce a new inline function called vc_compile_le16 and do the shifts
and ORs there. Depending on LE x BE.

I tried cpu_to_le16, but it ends up with worse assembly on BE for
whatever reason -- the compiler seems to be unable to optimize the swap.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 10a26fd5f1b7..36b967825f68 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -481,6 +481,19 @@ static u16 *vcs_write_buf_noattr(struct vc_data *vc, const char *con_buf,
 	return org;
 }
 
+/*
+ * Compilers (gcc 10) are unable to optimize the swap in cpu_to_le16. So do it
+ * the poor man way.
+ */
+static inline u16 vc_compile_le16(u8 hi, u8 lo)
+{
+#ifdef __BIG_ENDIAN
+	return (lo << 8u) | hi;
+#else
+	return (hi << 8u) | lo;
+#endif
+}
+
 static u16 *vcs_write_buf(struct vc_data *vc, const char *con_buf,
 		unsigned int pos, unsigned int count, bool viewed, u16 **org0)
 {
@@ -513,13 +526,8 @@ static u16 *vcs_write_buf(struct vc_data *vc, const char *con_buf,
 	if (pos & 1) {
 		count--;
 		c = *con_buf++;
-#ifdef __BIG_ENDIAN
-		vcs_scr_writew(vc, c |
-		     (vcs_scr_readw(vc, org) & 0xff00), org);
-#else
-		vcs_scr_writew(vc, (c << 8) |
-		     (vcs_scr_readw(vc, org) & 0xff), org);
-#endif
+		vcs_scr_writew(vc, vc_compile_le16(c, vcs_scr_readw(vc, org)),
+				org);
 		org++;
 		pos++;
 		if (++col == maxcol) {
@@ -551,11 +559,8 @@ static u16 *vcs_write_buf(struct vc_data *vc, const char *con_buf,
 
 	/* odd pos -- the remaining character */
 	c = *con_buf++;
-#ifdef __BIG_ENDIAN
-	vcs_scr_writew(vc, (vcs_scr_readw(vc, org) & 0xff) | (c << 8), org);
-#else
-	vcs_scr_writew(vc, (vcs_scr_readw(vc, org) & 0xff00) | c, org);
-#endif
+	vcs_scr_writew(vc, vc_compile_le16(vcs_scr_readw(vc, org) >> 8, c),
+				org);
 
 	return org;
 }
-- 
2.28.0

