Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770BC04FE1
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 10:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbjHPK4J (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbjHPKzr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 06:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64261984;
        Wed, 16 Aug 2023 03:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F6EE63FBB;
        Wed, 16 Aug 2023 10:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC36C433C9;
        Wed, 16 Aug 2023 10:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183345;
        bh=gDvRR64IFGgEzqSspbkO9kJwr/Hf7Tn7Fvxm8rbBCB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hkGYpNqRHxbM+E6Ovm/uyjkJvUEkiJThsfg74hFdwDsp38j05x0Pwnp5qpZfYoOHL
         pFmv/EiEMngoI2fYL8OQfvhDa/Fds73rI217YwW3FUR4YDB0s37lvLjh65qmiU3v7s
         Gwux/QKuVdiFlGLUYfNi9QUX7V114HeU5MJs94kDB7bW4iYdci4yH1hNpbeQ7iZl+W
         oW/KfxCUv5fc5bgHCQZ8wN590xKlUi8oDnSn9o46Zv75Is9xNAVqrYt0BdGIp7xlBD
         qTQt0dUWOuz72E9iQ9aIMu/IQReg7cQGI8eY/DmbLH61qSXXnRbbhdnyDXpRj3Sz9n
         8AXXO0q8g6Iaw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/10] tty: tty_buffer: better types in __tty_buffer_request_room()
Date:   Wed, 16 Aug 2023 12:55:28 +0200
Message-ID: <20230816105530.3335-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105530.3335-1-jirislaby@kernel.org>
References: <20230816105530.3335-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* use bool for 'change' as it holds a result of a boolean.
* use size_t for 'left', so it is the same as 'size' which it is
  compared to. Both are supposed to contain an unsigned value.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index e162318d6c31..414bb7f9155f 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -263,7 +263,8 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 {
 	struct tty_bufhead *buf = &port->buf;
 	struct tty_buffer *b, *n;
-	int left, change;
+	size_t left;
+	bool change;
 
 	b = buf->tail;
 	if (!b->flags)
-- 
2.41.0

