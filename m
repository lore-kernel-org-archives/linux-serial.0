Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA1DCCA47C
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jun 2022 07:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355410AbiFNH52 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355367AbiFNH5R (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jun 2022 03:57:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5395B3F324;
        Tue, 14 Jun 2022 00:57:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D15B921B69;
        Tue, 14 Jun 2022 07:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655193434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rIn6h6h5uHcb43OXoPbiLB2lbmYvqcmOWdOARchGwAk=;
        b=AJA9SfUqjJshhJWCR0VxjVrVBwtrYK7TJs/NLhLjGiS5drtqugki8SZ3TOriDhxLTsyBlp
        qgKhJOcwOCaG4xOPAwwqlwlb1KZCDq42WF0nTeWLFfVWjsm2/6FF6hfcK1YdniOqPpN3p+
        h04b5FaeagTnisNUgMAwOXtCoyheBLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655193434;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rIn6h6h5uHcb43OXoPbiLB2lbmYvqcmOWdOARchGwAk=;
        b=Vgjy/oRARPosOLsrqwr0vQJNqRcA2joOBXY3DazHh6dFPQRmxjmhuw1yIqFCv+F8SE0Rrp
        sK65Ooc5Wpp/yjAg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AA9A52C141;
        Tue, 14 Jun 2022 07:57:14 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/7] tty/vt: consolemap: use ARRAY_SIZE(), part II.
Date:   Tue, 14 Jun 2022 09:57:07 +0200
Message-Id: <20220614075713.32767-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The code still uses constants (macros) as bounds in loops after commit
17945d317a52 (tty/vt: consolemap: use ARRAY_SIZE()). The contants are at
least macros used also in the definition of the arrays. But use
ARRAY_SIZE() on two more places to ensure the loops never run out of
bounds even if the array definition change.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index fff97ae87e00..8aa7a48b3647 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -232,7 +232,7 @@ static void set_inverse_transl(struct vc_data *conp, struct uni_pagedict *p,
 	}
 	memset(q, 0, MAX_GLYPH);
 
-	for (j = 0; j < E_TABSZ; j++) {
+	for (j = 0; j < ARRAY_SIZE(translations[i]); j++) {
 		glyph = conv_uni_to_pc(conp, t[j]);
 		if (glyph >= 0 && glyph < MAX_GLYPH && q[glyph] < 32) {
 			/* prefer '-' above SHY etc. */
@@ -367,7 +367,7 @@ int con_get_trans_old(unsigned char __user * arg)
 	unsigned char outbuf[E_TABSZ];
 
 	console_lock();
-	for (i = 0; i < E_TABSZ ; i++)
+	for (i = 0; i < ARRAY_SIZE(outbuf); i++)
 	{
 		ch = conv_uni_to_pc(vc_cons[fg_console].d, p[i]);
 		outbuf[i] = (ch & ~0xff) ? 0 : ch;
-- 
2.36.1

