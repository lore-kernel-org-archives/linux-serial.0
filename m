Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0A5C83F11
	for <linux-serial@archiver.kernel.org>; Sun, 27 Aug 2023 07:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjH0HmB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Aug 2023 03:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjH0Hlz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Aug 2023 03:41:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C59EFA;
        Sun, 27 Aug 2023 00:41:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C451A61CA0;
        Sun, 27 Aug 2023 07:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A0CC433C9;
        Sun, 27 Aug 2023 07:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122112;
        bh=T95JctfHZT39SXOoo11AV+Afx+roE8vO9hygVf6nGyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfNJRbqEhcCCHz1WnG96JbW+mSpZ+hnBypRe6xfHjn14cNeqL7RstDIKTQR1CW/x+
         ZqyCkomk68xLtQHKXMCirEcqgxjKXM01m1GDDrBxugKYzAJarJPnwoYKMoFwWqq3Sl
         JRJLNOGpBhyprAY2krphD1mRg975sM8VKWWYBKDxalMyHBaJQ6lJrjvZnvesuuGHbS
         UpitkuYzDzgZfdrtyVgip7AiHBN7zYIqujmxQqmE8LL/hJ0IYhkd7leaTNDJf6T26R
         1Zxn9O4sFaYsCiifL+gPgnR47cIlNEMNyugXd6B22LdLfw+OV7dDEGT109gMIwTMXI
         30BxEfDaLFPwA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 01/14] tty: n_tty: make flow of n_tty_receive_buf_common() a bool
Date:   Sun, 27 Aug 2023 09:41:34 +0200
Message-ID: <20230827074147.2287-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827074147.2287-1-jirislaby@kernel.org>
References: <20230827074147.2287-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The 'flow' parameter of n_tty_receive_buf_common() is meant to be a
boolean value. So use bool and alter call sites accordingly.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f44f38bb412e..8b2bacb3e40d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1665,7 +1665,7 @@ static void __receive_buf(struct tty_struct *tty, const u8 *cp, const u8 *fp,
  */
 static size_t
 n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
-			 int count, int flow)
+			 int count, bool flow)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t rcvd = 0;
@@ -1748,13 +1748,13 @@ n_tty_receive_buf_common(struct tty_struct *tty, const u8 *cp, const u8 *fp,
 static void n_tty_receive_buf(struct tty_struct *tty, const u8 *cp,
 			      const u8 *fp, size_t count)
 {
-	n_tty_receive_buf_common(tty, cp, fp, count, 0);
+	n_tty_receive_buf_common(tty, cp, fp, count, false);
 }
 
 static size_t n_tty_receive_buf2(struct tty_struct *tty, const u8 *cp,
 				 const u8 *fp, size_t count)
 {
-	return n_tty_receive_buf_common(tty, cp, fp, count, 1);
+	return n_tty_receive_buf_common(tty, cp, fp, count, true);
 }
 
 /**
-- 
2.42.0

