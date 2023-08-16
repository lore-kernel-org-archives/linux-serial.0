Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF6FC04FE0
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 10:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbjHPK4H (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244002AbjHPKzl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A81984;
        Wed, 16 Aug 2023 03:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 281A06555F;
        Wed, 16 Aug 2023 10:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7381DC433C9;
        Wed, 16 Aug 2023 10:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183339;
        bh=Y8jrcsirIkNz5+yJ0roZSoi6QKBn7sM9JY7d66gE/H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWho2sN2qAh/5RsypM+m0TKtkt73PKKWl6h0liiAY3Q4ry4rRR7kk7wqPxJG8VL2S
         us+OiPmNypy9EmV0HMwTN0mz/+KS8c0IAI1HC5uapjZ1boINuv5NuHMWmx6d6+jmoC
         3xwnogGnK1Vbeu5y4qiw/lOMl34E/mLtLDcjWLFtWuG2in3/OmzI/BzJ9SmKW7Z5vD
         OuhoXZFxYQcpKBe9W/0V2AfxL0WWqFDEv4wOVcOaUE6Nr7wBFBdZPVIYuw+NLhCCEL
         a6HSNI956p6eDtvtYqOX8Q5+sX6LahZO8bId10bMMQ+xiovyTvgXjN3UrxPFLAgcew
         54W1tbse5r6wQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/10] tty: tty_buffer: warn if losing flags in __tty_insert_flip_string_flags()
Date:   Wed, 16 Aug 2023 12:55:24 +0200
Message-ID: <20230816105530.3335-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105530.3335-1-jirislaby@kernel.org>
References: <20230816105530.3335-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

And add a WARN_ON_ONCE(need_flags) to make sure we are not losing flags
in __tty_insert_flip_string_flags().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 94a88dc05a54..c101b4ab737e 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -325,6 +325,9 @@ int __tty_insert_flip_string_flags(struct tty_port *port, const u8 *chars,
 			flags += space;
 		} else if (tb->flags) {
 			memset(flag_buf_ptr(tb, tb->used), flags[0], space);
+		} else {
+			/* tb->flags should be available once requested */
+			WARN_ON_ONCE(need_flags);
 		}
 
 		tb->used += space;
-- 
2.41.0

