Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1166FC001E0
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHPK7S (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244348AbjHPK67 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 06:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC70C212B;
        Wed, 16 Aug 2023 03:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0B9A665B6;
        Wed, 16 Aug 2023 10:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25994C433C7;
        Wed, 16 Aug 2023 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183510;
        bh=CJX8SlHepZCFBu+LS4vVyP3RzICxchrVKsWPVGHPYpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQLi/dKO5eDtAfQ7NVObJGr/IZ+Iotd+HqX4/aGsyHk2O0kQ4dDH6zzWMaPUjDRBD
         K0Th3GCYdX5aBtiER4f9of3EHKdGUtqj0BtEvYbsY5PQPSn8hAKlzfot7WMVH/4Iln
         67XMxEu1Cn9tPWaN8p/vqAOEQpJnEEsfwogR89/xBO3GK//mDSYFSZLqpdm742B0WU
         IJXZKafNxAw6z5osoWHLtKu3KVtClME8PkStSlQ7X+POnhoaxLQC/JnPXXqNdimrU5
         eaCBgzWpixwvcHQ4BiyM6HKoXlQ+IqFs2WqckIePwPazNoSaBPjnN3qL3uXqyosN+Y
         6GdKvJO02Vxww==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 2/4] n_tty: simplify and sanitize zero_buffer()
Date:   Wed, 16 Aug 2023 12:58:07 +0200
Message-ID: <20230816105822.3685-4-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Make 'tty' parameter const as we only look at tty flags here.
* Make 'size' parameter of size_t type as everyone passes that and
  memset() (the consumer) expects size_t too. So be consistent.
* Remove redundant local variables, place the content directly to the
  'if'.
* Use 0 instead of 0x00 in memset(). The former is more obvious.

No functional changes expected.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 1599012f20c8..c1859ae263eb 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -158,13 +158,10 @@ static inline unsigned char *echo_buf_addr(struct n_tty_data *ldata, size_t i)
 }
 
 /* If we are not echoing the data, perhaps this is a secret so erase it */
-static void zero_buffer(struct tty_struct *tty, u8 *buffer, int size)
+static void zero_buffer(const struct tty_struct *tty, u8 *buffer, size_t size)
 {
-	bool icanon = !!L_ICANON(tty);
-	bool no_echo = !L_ECHO(tty);
-
-	if (icanon && no_echo)
-		memset(buffer, 0x00, size);
+	if (L_ICANON(tty) && !L_ECHO(tty))
+		memset(buffer, 0, size);
 }
 
 static void tty_copy(struct tty_struct *tty, void *to, size_t tail, size_t n)
-- 
2.41.0

