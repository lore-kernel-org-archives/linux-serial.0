Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DBC433E3
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBFA2067C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 08:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHRI5o (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:57:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:37998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgHRI5M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 04:57:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C8FDB048;
        Tue, 18 Aug 2020 08:57:34 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/16] vc_screen: extract vcs_read_buf_header
Date:   Tue, 18 Aug 2020 10:57:05 +0200
Message-Id: <20200818085706.12163-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818085706.12163-1-jslaby@suse.cz>
References: <20200818085706.12163-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The attribute header handling is terrible in vcs_read_buf. Separate it
to a new function and simply do memmove (of up to 4 bytes) to the start
of the con_buf -- if user seeked.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vc_screen.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index c178a1611223..9d68c6b36ddf 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -297,6 +297,22 @@ static void vcs_read_buf_noattr(const struct vc_data *vc, char *con_buf,
 	}
 }
 
+static unsigned int vcs_read_buf_header(const struct vc_data *vc, char *con_buf,
+		unsigned int pos, unsigned int count)
+{
+	count = min(HEADER_SIZE - pos, count);
+
+	/* clamp header values if they don't fit */
+	con_buf[0] = min(vc->vc_rows, 0xFFu);
+	con_buf[1] = min(vc->vc_cols, 0xFFu);
+	getconsxy(vc, con_buf + 2);
+
+	if (pos)
+		memmove(con_buf, con_buf + pos, count);
+
+	return count;
+}
+
 static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
 		unsigned int pos, unsigned int count, bool viewed,
 		unsigned int *skip)
@@ -306,22 +322,11 @@ static unsigned int vcs_read_buf(const struct vc_data *vc, char *con_buf,
 	unsigned int filled = count;
 
 	if (pos < HEADER_SIZE) {
-		/* clamp header values if they don't fit */
-		con_buf[0] = min(vc->vc_rows, 0xFFu);
-		con_buf[1] = min(vc->vc_cols, 0xFFu);
-		getconsxy(vc, con_buf + 2);
-
-		*skip += pos;
-		count += pos;
-		if (count > CON_BUF_SIZE) {
-			count = CON_BUF_SIZE;
-			filled = count - pos;
-		}
+		count -= vcs_read_buf_header(vc, con_buf, pos, count);
 
-		/* Advance state pointers and move on. */
-		count -= min(HEADER_SIZE, count);
 		pos = HEADER_SIZE;
 		con_buf += HEADER_SIZE;
+
 		/* If count >= 0, then pos is even... */
 	} else if (pos & 1) {
 		/*
-- 
2.28.0

