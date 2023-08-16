Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9BAC001E0
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 11:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbjHPK7u (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 06:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244379AbjHPK7n (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 06:59:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD95826A4;
        Wed, 16 Aug 2023 03:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8EE7665D2;
        Wed, 16 Aug 2023 10:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B8CC433C9;
        Wed, 16 Aug 2023 10:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183513;
        bh=Qb5Il4Ai3jz4ymmAYs7Bq9ZdwscdsCLE+1C9yMaXeVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GrSm/WmfbVi/RjZAQ+F65TpE1G9+20bqki8WXVq1uUiTd9oepusYwFFXGDl3pIj+z
         XiS7y4Ijfg35W3rGb49FBs5TZAK89GthxmsgrtKwlnTSRI3fPjeVL2liVXBwxoRHtD
         KrfIuqWxPAEzXg0jByJR308GhivZU9VKkzx2DsOhZqT6ww4YtMJ4RWmSEU95Cbgbgj
         TJrHN8JOWg36tTpDfwTSCZSjjL/ZQnisFXdDrWJRGU2doPMvHXOS/jNepBHf/0pIjn
         ABNrnRdIuFfGB4JmJeqQxqtSVGtiFPO1UTT2n8aefSb+4F+jjZsATUcCpQUpuQlOjt
         H4Bir487qzwgg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 3/4] n_tty: pass ldata to canon_skip_eof() directly
Date:   Wed, 16 Aug 2023 12:58:09 +0200
Message-ID: <20230816105822.3685-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

'tty' is not needed in canon_skip_eof(), so we can pass 'ldata' directly
instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index c1859ae263eb..bab7005ef520 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2053,9 +2053,8 @@ static bool canon_copy_from_read_buf(struct tty_struct *tty,
  * EOF (special EOL character that's a __DISABLED_CHAR)
  * in the stream, silently eat the EOF.
  */
-static void canon_skip_eof(struct tty_struct *tty)
+static void canon_skip_eof(struct n_tty_data *ldata)
 {
-	struct n_tty_data *ldata = tty->disc_data;
 	size_t tail, canon_head;
 
 	canon_head = smp_load_acquire(&ldata->canon_head);
@@ -2153,7 +2152,7 @@ static ssize_t n_tty_read(struct tty_struct *tty, struct file *file,
 			 * releasing the lock and returning done.
 			 */
 			if (!nr)
-				canon_skip_eof(tty);
+				canon_skip_eof(ldata);
 			else if (canon_copy_from_read_buf(tty, &kb, &nr))
 				return kb - kbuf;
 		} else {
-- 
2.41.0

