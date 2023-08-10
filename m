Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB3AC04A94
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 09:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjHJJRP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjHJJQq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 05:16:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9316D3C14;
        Thu, 10 Aug 2023 02:16:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F3C654DE;
        Thu, 10 Aug 2023 09:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7991DC433C8;
        Thu, 10 Aug 2023 09:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658966;
        bh=euey0Vwb3a38bJF9s54Px8Eo2t3YYbZQXNTfdlimNNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SYhUujNShSvPoCZg1A330pYO2y4KLWg5zUF3UcFqDQmKRIZTIsQfouWQ2XgN+Osh+
         gLqXYroH9rJg0QVfOx7VKkGW+ef0ShuK5cACEGRusmkaXeZKJcu/RQrx6ihWI3D17B
         mApX9X8IYDdfYThdoAdG5AXkNsYif78felO1kF3BsSHBBcNh4wA7dc87Y82dWrLdle
         EVfekKLhcBD3ZREvf0g4tsr/bIap01iGz/wSjRrBL0TWO+oLkpkp6/XQidgeIuk1Wy
         ZopyOwELptjcTzsCcmXWN8ei4DrElJI2SZ2S1gjCl+W1t/VWJD6x5OqEOCLassN10N
         IEhjc9eNafX0g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 22/36] tty: rename and de-inline do_tty_write()
Date:   Thu, 10 Aug 2023 11:14:56 +0200
Message-ID: <20230810091510.13006-23-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Make do_tty_write()'s name sound similar to iterate_tty_read(). They
both do similar things, so there is no reason for so distinct names. The
new name is therefore iterate_tty_write().

Drop the unnedeed inline modifier too. Let the compiler decide.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index ea5041fbbf28..846460c02c58 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -961,8 +961,8 @@ int tty_write_lock(struct tty_struct *tty, bool ndelay)
  * Split writes up in sane blocksizes to avoid
  * denial-of-service type attacks
  */
-static inline ssize_t do_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
-				   struct file *file, struct iov_iter *from)
+static ssize_t iterate_tty_write(struct tty_ldisc *ld, struct tty_struct *tty,
+				 struct file *file, struct iov_iter *from)
 {
 	size_t count = iov_iter_count(from);
 	ssize_t ret, written = 0;
@@ -1090,7 +1090,7 @@ static ssize_t file_tty_write(struct file *file, struct kiocb *iocb, struct iov_
 	if (!ld->ops->write)
 		ret = -EIO;
 	else
-		ret = do_tty_write(ld, tty, file, from);
+		ret = iterate_tty_write(ld, tty, file, from);
 	tty_ldisc_deref(ld);
 	return ret;
 }
-- 
2.41.0

