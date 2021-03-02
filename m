Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D652AC28E80
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAB064E7A
	for <linux-serial@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348248AbhCCCRK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:17:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:39616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835900AbhCBGZX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Mar 2021 01:25:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71707B040;
        Tue,  2 Mar 2021 06:22:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 41/44] tty: n_gsm, remove duplicates of parameters
Date:   Tue,  2 Mar 2021 07:22:11 +0100
Message-Id: <20210302062214.29627-41-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dp, f, and i are only duplicates of gsmld_receive_buf's parameters. Use
the parameters directly (cp, fp, and count) and delete these local
variables.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b063bc608a8c..7e1d19805aa4 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2416,27 +2416,24 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			      char *fp, int count)
 {
 	struct gsm_mux *gsm = tty->disc_data;
-	const unsigned char *dp;
-	char *f;
-	int i;
 	char flags = TTY_NORMAL;
 
 	if (debug & 4)
 		print_hex_dump_bytes("gsmld_receive: ", DUMP_PREFIX_OFFSET,
 				     cp, count);
 
-	for (i = count, dp = cp, f = fp; i; i--, dp++) {
-		if (f)
-			flags = *f++;
+	for (; count; count--, cp++) {
+		if (fp)
+			flags = *fp++;
 		switch (flags) {
 		case TTY_NORMAL:
-			gsm->receive(gsm, *dp);
+			gsm->receive(gsm, *cp);
 			break;
 		case TTY_OVERRUN:
 		case TTY_BREAK:
 		case TTY_PARITY:
 		case TTY_FRAME:
-			gsm_error(gsm, *dp, flags);
+			gsm_error(gsm, *cp, flags);
 			break;
 		default:
 			WARN_ONCE(1, "%s: unknown flag %d\n",
-- 
2.30.1

