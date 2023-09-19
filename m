Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24494CD54A9
	for <linux-serial@archiver.kernel.org>; Tue, 19 Sep 2023 08:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjISIxL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Sep 2023 04:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjISIwa (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Sep 2023 04:52:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4985F1AE;
        Tue, 19 Sep 2023 01:52:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12243C433C8;
        Tue, 19 Sep 2023 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695113536;
        bh=cTOJR0Dck2nxt7xIAYORd0Xhd/MVeEmWc2jGAYFrfV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJuo1G1SiDN6HegTIOtr2woO7J+QX8f1E7O64ZLEZl3MD0Vb9zuGR9mX2V4RVoK9V
         flvNYviQUwSdSpVJ7YhHF605Rx0IMLuDyxATDCcyltkNIAIR3oT1b8Oui3fWcX9vfx
         pRiIkFLtd11hQfBJFixbZPR1xhpRQF2fPLRNis6x1n6wD6nSHEPZQ6dZE/pW7wkt56
         L2PTMG+y75blEFkRnfQNyWnpPcAFekSfBoT1BPkbSCASNCq9WFispJ97gxfSSj0rXv
         rpc16X1kpxDl/NartUz0FE0rOjWfb7A9iuTepcxcgXO2CTJ4RD8U5gMEm7qFVnJcT1
         10eIQ6R4L1M1w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 11/15] tty: tty_buffer: use bool for 'restart' in tty_buffer_unlock_exclusive()
Date:   Tue, 19 Sep 2023 10:51:52 +0200
Message-ID: <20230919085156.1578-12-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919085156.1578-1-jirislaby@kernel.org>
References: <20230919085156.1578-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

It's a boolean value, so no need for 'int' there.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_buffer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 5f6d0cf67571..f8883afbeeba 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -69,12 +69,11 @@ EXPORT_SYMBOL_GPL(tty_buffer_lock_exclusive);
 void tty_buffer_unlock_exclusive(struct tty_port *port)
 {
 	struct tty_bufhead *buf = &port->buf;
-	int restart;
-
-	restart = buf->head->commit != buf->head->read;
+	bool restart = buf->head->commit != buf->head->read;
 
 	atomic_dec(&buf->priority);
 	mutex_unlock(&buf->lock);
+
 	if (restart)
 		queue_work(system_unbound_wq, &buf->work);
 }
-- 
2.42.0

