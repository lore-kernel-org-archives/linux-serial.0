Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B723C43334
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jun 2022 10:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiFGKvZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242359AbiFGKuN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jun 2022 06:50:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC52F92713;
        Tue,  7 Jun 2022 03:49:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F27C621B94;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654598996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqOqmzhUBo2wSHvuFRli3HBY7pXAt9x2omkwDPctFWs=;
        b=UwAKwJJNX4qilhKp/JymHxO1waEh4pYphLeHstRXxd1B7b4tad2BY+4kCKJyzqhndHm3Jp
        jnV7Jp8KqhIBuy/ki4F/zVhgipCGrH4YsytoOonpzRGXnkgv83+kRqJTZ0O1WmrIwMuPU2
        26sVgPC5laKIN4VrFL1U6XrcxL2HV6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654598996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XqOqmzhUBo2wSHvuFRli3HBY7pXAt9x2omkwDPctFWs=;
        b=SjwBOjnWfAmtsJXSBBsZfqN8T9wd+xjAsMRkgHEiYqrpxVm/F9b2h6Xm3VW0xzva4R1yCV
        Aa278ZTOT+y40BCw==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9AAA2C143;
        Tue,  7 Jun 2022 10:49:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 36/36] tty/vt: consolemap: walk the buffer only once in con_set_trans_old()
Date:   Tue,  7 Jun 2022 12:49:46 +0200
Message-Id: <20220607104946.18710-36-jslaby@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607104946.18710-1-jslaby@suse.cz>
References: <20220607104946.18710-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Fetch the user data one by one (by get_user()) and fill in the local
buffer simultaneously. I.e. we no longer require to walk two buffers and
save thus 256 B from stack (whole ubuf).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/consolemap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index f97f7ee6268b..fff97ae87e00 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -343,15 +343,15 @@ static void update_user_maps(void)
  */
 int con_set_trans_old(unsigned char __user * arg)
 {
-	int i;
 	unsigned short inbuf[E_TABSZ];
-	unsigned char ubuf[E_TABSZ];
-
-	if (copy_from_user(ubuf, arg, E_TABSZ))
-		return -EFAULT;
+	unsigned int i;
+	unsigned char ch;
 
-	for (i = 0; i < E_TABSZ ; i++)
-		inbuf[i] = UNI_DIRECT_BASE | ubuf[i];
+	for (i = 0; i < ARRAY_SIZE(inbuf); i++) {
+		if (get_user(ch, &arg[i]))
+			return -EFAULT;
+		inbuf[i] = UNI_DIRECT_BASE | ch;
+	}
 
 	console_lock();
 	memcpy(translations[USER_MAP], inbuf, sizeof(inbuf));
-- 
2.36.1

