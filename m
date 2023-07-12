Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B56BEB64DD
	for <linux-serial@archiver.kernel.org>; Wed, 12 Jul 2023 08:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjGLIYW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Jul 2023 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjGLIXW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jul 2023 04:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEB42D79;
        Wed, 12 Jul 2023 01:19:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 475B2616F5;
        Wed, 12 Jul 2023 08:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E66BC433C7;
        Wed, 12 Jul 2023 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149906;
        bh=V1/NAcLOoOa408WI8W7uk/rZlfmxwm9QHIbOEt5OwRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orYkW1njU+RHfilaABGyP3E8fD2KCKvgMlwDZ/xaDUL61kCYDr5IJGu1yuTGgcUdS
         c8FS53v7/jFz+7J3sBg7e6wAJuRIF7Bs9PWsN0jH29ZRH+CpUUjiSUvgFFLhZo33Iw
         JL9mfrVzDgQ0LQJvxBwyIvdZHR65ES/qNNn1k65UmLGrqFanhSybws+xGmS0NtRZOS
         0csZKoT1L6PP2ybXfrD77GiEdpNoK0HgnKPc8PWv8SaIpmstBhyalJV9Kp8PIrDktX
         RX8AqE5I5FNNdzu3qcniAlfryHJ8VQ8j7GDn10CfL4IPRw42kEfPJcqfyX8B4poB+G
         hReKvcMeHEFWw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/10] tty: sysrq: use switch in sysrq_key_table_key2index()
Date:   Wed, 12 Jul 2023 10:18:05 +0200
Message-ID: <20230712081811.29004-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712081811.29004-1-jirislaby@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Using switch with range cases makes the code more aligned and readable.
Expand also that 36 as explicit addition of 10 + 26 to make the source
of the constant more obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/sysrq.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index ccf429ba348e..23198e3f1461 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -532,17 +532,16 @@ static const struct sysrq_key_op *sysrq_key_table[62] = {
 /* key2index calculation, -1 on invalid index */
 static int sysrq_key_table_key2index(u8 key)
 {
-	int retval;
-
-	if ((key >= '0') && (key <= '9'))
-		retval = key - '0';
-	else if ((key >= 'a') && (key <= 'z'))
-		retval = key + 10 - 'a';
-	else if ((key >= 'A') && (key <= 'Z'))
-		retval = key + 36 - 'A';
-	else
-		retval = -1;
-	return retval;
+	switch (key) {
+	case '0' ... '9':
+		return key - '0';
+	case 'a' ... 'z':
+		return key - 'a' + 10;
+	case 'A' ... 'Z':
+		return key - 'A' + 10 + 26;
+	default:
+		return -1;
+	}
 }
 
 /*
-- 
2.41.0

