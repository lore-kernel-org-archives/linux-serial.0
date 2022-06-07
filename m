Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16154CCA47C
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 10:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiFGKvB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242318AbiFGKuK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C94F5D37;
        Tue,  7 Jun 2022 03:49:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A28E921AE4;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6rYC/CnQIfkHcFZ5s1nOOIXYEtc5snTgHSN/9EO6X8=;
        b=MlDWf9xx+1voFmpNAyLZFNYscerqOGUkUUZWVGG5ikkpe+aBHmCAwerktW4LZ8Gi/ovTZm
        jngLY3CJ8qwbco5HbGFaO1SEV15c0izvMKucGIa8KNFBzWazOfoYf9ewnVbUjcDZkCSLHJ
        18zGgEbUcMFdVRk8Jeoe56rsKdl28dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598992;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y6rYC/CnQIfkHcFZ5s1nOOIXYEtc5snTgHSN/9EO6X8=;
        b=KQHyuMVzSQB1ubNYs/Icy/HFPpdig+T1oRG4Hy559MBvNvzCXvELPDPzR9nOfLOmWsYGFR
        mpTC0rTKeoyBRACg==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7B1E82C141;
        Tue,  7 Jun 2022 10:49:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 15/36] tty/vt: consolemap: make p1 increment less confusing in con_get_unimap()
Date:   Tue,  7 Jun 2022 12:49:25 +0200
Message-Id: <20220607104946.18710-15-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607104946.18710-1-jslaby@suse.cz>
References: <20220607104946.18710-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

p2 is already incremented like this few lines below, so do the same for
p1. This makes the code easier to follow.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 84c8043a36d0..831450f2bfd1 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -793,8 +793,8 @@ int con_get_unimap(struct vc_data *vc, ushort ct, ushort __user *uct,
 		if (!p1)
 			continue;
 
-		for (j = 0; j < UNI_DIR_ROWS; j++) {
-			p2 = *(p1++);
+		for (j = 0; j < UNI_DIR_ROWS; j++, p1++) {
+			p2 = *p1;
 			if (!p2)
 				continue;
 
-- 
2.36.1

