Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A38C04FE0
	for <linux-serial@archiver.kernel.org>; Wed, 16 Aug 2023 11:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbjHPLAZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 16 Aug 2023 07:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244417AbjHPLAL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 16 Aug 2023 07:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD04B26A5;
        Wed, 16 Aug 2023 03:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E86B665C5;
        Wed, 16 Aug 2023 10:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B570AC433C7;
        Wed, 16 Aug 2023 10:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692183514;
        bh=EWGu7CcKLTWJELHIckUZyO75GIdPiiaKcoynO1yju/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3zqzKDWxtK9qSFeomM1q+EaTFAaq4ZueHb3+DC/M1VHfOu3SE4MPqglkHOeSlrB2
         gdQfg835K57wYNRN8yiJk4HIy0UgePSJw5r/999C0sZ0qMeTeKjAMK8nDGd6QZvfie
         Ka8NIVozbNs9D+BadhuhJv4GXRH/YQxKpJF93TX+4/IXwqBtd2q3uXPIGfi3dHC9kL
         8xAAeV9fzmyFtq2a1STn7BBbhyIwOZmocs/e0QM6mC8MMIEBtL+fVPQX9zf4XZt3CE
         /0PeTIMFhzl7FvzfLFWgwn1ZaveJoYWj3rGDDUZ3M3ds06ZnxNnUkda060vVCnEi9g
         YmWvCGESdleNg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/14] tty: n_tty: use 'retval' for writes' retvals
Date:   Wed, 16 Aug 2023 12:58:10 +0200
Message-ID: <20230816105822.3685-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816105822.3685-1-jirislaby@kernel.org>
References: <20230816105822.3685-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We have a separate misnomer 'c' to hold the retuned value from
tty->ops->write(). Instead, use already defined and properly typed
'retval'.

We have another variable 'num' to serve the same purpose in the OPOST
branch. We can use this 'retval' too. But just clear it in case of
EAGAIN.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index f6fa4dbdf78f..e293d87b5362 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -2335,7 +2335,6 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 {
 	const u8 *b = buf;
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
-	int c;
 	ssize_t retval = 0;
 
 	/* Job control check -- must be done at start (POSIX.1 7.1.1.4). */
@@ -2362,15 +2361,16 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 		}
 		if (O_OPOST(tty)) {
 			while (nr > 0) {
-				ssize_t num = process_output_block(tty, b, nr);
-				if (num < 0) {
-					if (num == -EAGAIN)
-						break;
-					retval = num;
-					goto break_out;
+				retval = process_output_block(tty, b, nr);
+				if (retval == -EAGAIN) {
+					retval = 0;
+					break;
 				}
-				b += num;
-				nr -= num;
+				if (retval < 0)
+					goto break_out;
+
+				b += retval;
+				nr -= retval;
 				if (nr == 0)
 					break;
 				if (process_output(*b, tty) < 0)
@@ -2384,16 +2384,14 @@ static ssize_t n_tty_write(struct tty_struct *tty, struct file *file,
 
 			while (nr > 0) {
 				mutex_lock(&ldata->output_lock);
-				c = tty->ops->write(tty, b, nr);
+				retval = tty->ops->write(tty, b, nr);
 				mutex_unlock(&ldata->output_lock);
-				if (c < 0) {
-					retval = c;
+				if (retval < 0)
 					goto break_out;
-				}
-				if (!c)
+				if (!retval)
 					break;
-				b += c;
-				nr -= c;
+				b += retval;
+				nr -= retval;
 			}
 		}
 		if (!nr)
-- 
2.41.0

