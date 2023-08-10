Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05675C001B0
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 09:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjHJJPo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjHJJPX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E577B2686;
        Thu, 10 Aug 2023 02:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C2E965495;
        Thu, 10 Aug 2023 09:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDF4C433CB;
        Thu, 10 Aug 2023 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658921;
        bh=XKVIv2YmP+dmiMJ0SFDrOHmUqgvfBZbXL5ufVXNwvG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOxn4Fx4TS4uskFH5mUnL54BEmuMh6VpgiFAzm96+N4yTDYfo5VWs2I9ZQtoOpY/e
         QLyDp9zp7dR7yiNAKqsFDfKIbB87QjGWT+NgvD3bKS7enA/BBPuV5QMkSuE0Xi+YOV
         DUvmDLP85kWSRdSkp9DuGDUVX3W86i/qm/dWbDTWI0Yw+NEugXhKOr5HkoNcTKikhX
         fcTFpF5Io47oXc6NOVmutvf8ZK+0x0LOEtlJrYiTHu1nH3v0MI7Icdp9UhGfbT+I4m
         Ziash61gLSHNRlMYL084iSmdDAy1Mm2y1GQuUcn6GEIoXMgWK7rlTMAoS8GwpD9rP9
         lgRcYfJnhf6bA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 04/36] tty: n_null: remove optional ldops
Date:   Thu, 10 Aug 2023 11:14:38 +0200
Message-ID: <20230810091510.13006-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Only tty_ldisc_ops::read() and ::write() of n_null behave differently than
the default ldops implementations. They return %EOPNOTSUPP instead of
%EIO. So keep only those two and remove the rest ldops as they are
superfluous.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_null.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
index f913b665af72..4a0d8bb2fb4c 100644
--- a/drivers/tty/n_null.c
+++ b/drivers/tty/n_null.c
@@ -10,15 +10,6 @@
  *  Copyright (C) Intel 2017
  */
 
-static int n_null_open(struct tty_struct *tty)
-{
-	return 0;
-}
-
-static void n_null_close(struct tty_struct *tty)
-{
-}
-
 static ssize_t n_null_read(struct tty_struct *tty, struct file *file,
 			   unsigned char *buf, size_t nr,
 			   void **cookie, unsigned long offset)
@@ -32,21 +23,12 @@ static ssize_t n_null_write(struct tty_struct *tty, struct file *file,
 	return -EOPNOTSUPP;
 }
 
-static void n_null_receivebuf(struct tty_struct *tty,
-				 const unsigned char *cp, const char *fp,
-				 int cnt)
-{
-}
-
 static struct tty_ldisc_ops null_ldisc = {
 	.owner		=	THIS_MODULE,
 	.num		=	N_NULL,
 	.name		=	"n_null",
-	.open		=	n_null_open,
-	.close		=	n_null_close,
 	.read		=	n_null_read,
 	.write		=	n_null_write,
-	.receive_buf	=	n_null_receivebuf
 };
 
 static int __init n_null_init(void)
-- 
2.41.0

