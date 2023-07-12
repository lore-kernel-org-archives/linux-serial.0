Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74528C001DF
	for <linux-serial@archiver.kernel.org>; Wed, 12 Jul 2023 08:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGLIXe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Jul 2023 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGLIWr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jul 2023 04:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33564487;
        Wed, 12 Jul 2023 01:18:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5D576168A;
        Wed, 12 Jul 2023 08:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42503C433CA;
        Wed, 12 Jul 2023 08:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149896;
        bh=AnR6U7SNoPqjubiusL5iLkGLY4N6OAzOKEM7mQdl/ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJXJcRTDyCjTcjykoHcORmeLIiu1SQyvAzuB4QGFcbkFmsOKaBWT14DIkRTZcBYOe
         OiNGq/2iwCvqCI2myJFdd3YiGV3kBEEuhSgqiNS6/BhYPjL+bCig/mYx7ORJXW6pHB
         AhU7nG5PSdR2szqpsUcTX6oYPS2Qzkg3vyDZ0/+eN3YE4pjaK8zM9jE2fUi9+SDXZG
         DPrzJ4mG+T00swI5yaVrhe4fBSzGqtPcUfjmyXA3N4m0ly6+I2lXoscsUF0we18lgn
         oZMVOx7woNKa0INW/EyaVe1kcW6de4PuI00eo6unr/MZ1M8ObVXhHmhjJNjWQmeXXW
         66eUkeFC0umhw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/10] tty: sysrq: rename and re-type i in sysrq_handle_loglevel()
Date:   Wed, 12 Jul 2023 10:18:02 +0200
Message-ID: <20230712081811.29004-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712081811.29004-1-jirislaby@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

'i' is a too generic name for something which carries a 'loglevel'. Name
it as such and make it 'u8', the same as key will become in the next
patches.

Note that we are not stripping any high bits away, 'key' is given only
8bit values.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/sysrq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index e1df63a88aac..13465e4cca9b 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -100,12 +100,11 @@ __setup("sysrq_always_enabled", sysrq_always_enabled_setup);
 
 static void sysrq_handle_loglevel(int key)
 {
-	int i;
+	u8 loglevel = key - '0';
 
-	i = key - '0';
 	console_loglevel = CONSOLE_LOGLEVEL_DEFAULT;
-	pr_info("Loglevel set to %d\n", i);
-	console_loglevel = i;
+	pr_info("Loglevel set to %u\n", loglevel);
+	console_loglevel = loglevel;
 }
 static const struct sysrq_key_op sysrq_loglevel_op = {
 	.handler	= sysrq_handle_loglevel,
-- 
2.41.0

