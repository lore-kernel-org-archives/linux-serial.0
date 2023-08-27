Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125ABC83F1D
	for <linux-serial@archiver.kernel.org>; Sun, 27 Aug 2023 07:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjH0Hno (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 27 Aug 2023 03:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjH0HmF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 27 Aug 2023 03:42:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E26FA;
        Sun, 27 Aug 2023 00:42:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4767360B41;
        Sun, 27 Aug 2023 07:42:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A680DC433CA;
        Sun, 27 Aug 2023 07:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693122122;
        bh=EToxLJCP39lZaL9dsQPIiILiMg0DGQ3nleooSoLLiXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NdRuhoBWtk5ZS3DAvqI74CXzrLNvG+Q+XXfC6dfRwlUUY+kaPNF3B6+5dLL1XoTc0
         YmsuW9v+1AMF3Lt+1SKFRhIMgaKL9ghS2s2MgIAEiXdhau1VDKCTwS9mmK7sSCQFYX
         uiSwmaHoBqDNjm/Tyougb+4QKiOAt3f2566qOpTvZNkVcHpXKWqc2KlOuUS88vna9I
         70Zv+3pidvBYZwToDEFTIaqveoa2mmVxXfJhqeucJ55aUEpSExbz01BXIFrrvpq0A4
         5yD1xGHTNRe1mEZU5+VB2yGZ8b4gBH8xQvwvC7zBuka5cE1cEBYDjyY+Wj1RCxZ3Ys
         urHUjszGqxKRg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 08/14] tty: n_tty: move newline handling to a separate function
Date:   Sun, 27 Aug 2023 09:41:41 +0200
Message-ID: <20230827074147.2287-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230827074147.2287-1-jirislaby@kernel.org>
References: <20230827074147.2287-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Currently, n_tty handles the newline in a label in
n_tty_receive_char_canon(). That is invoked from two more places. Split
this code to a separate function and avoid the label in this case.

This makes the code flow more understandable.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0149dc9dd0b1..632516d7b487 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1262,6 +1262,17 @@ static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c
 	return true;
 }
 
+static void n_tty_receive_handle_newline(struct tty_struct *tty, u8 c)
+{
+	struct n_tty_data *ldata = tty->disc_data;
+
+	set_bit(MASK(ldata->read_head), ldata->read_flags);
+	put_tty_queue(c, ldata);
+	smp_store_release(&ldata->canon_head, ldata->read_head);
+	kill_fasync(&tty->fasync, SIGIO, POLL_IN);
+	wake_up_interruptible_poll(&tty->read_wait, EPOLLIN | EPOLLRDNORM);
+}
+
 static bool n_tty_receive_char_canon(struct tty_struct *tty, u8 c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
@@ -1308,12 +1319,16 @@ static bool n_tty_receive_char_canon(struct tty_struct *tty, u8 c)
 			echo_char_raw('\n', ldata);
 			commit_echoes(tty);
 		}
-		goto handle_newline;
+		n_tty_receive_handle_newline(tty, c);
+
+		return true;
 	}
 
 	if (c == EOF_CHAR(tty)) {
 		c = __DISABLED_CHAR;
-		goto handle_newline;
+		n_tty_receive_handle_newline(tty, c);
+
+		return true;
 	}
 
 	if ((c == EOL_CHAR(tty)) ||
@@ -1335,12 +1350,8 @@ static bool n_tty_receive_char_canon(struct tty_struct *tty, u8 c)
 		if (c == (unsigned char) '\377' && I_PARMRK(tty))
 			put_tty_queue(c, ldata);
 
-handle_newline:
-		set_bit(MASK(ldata->read_head), ldata->read_flags);
-		put_tty_queue(c, ldata);
-		smp_store_release(&ldata->canon_head, ldata->read_head);
-		kill_fasync(&tty->fasync, SIGIO, POLL_IN);
-		wake_up_interruptible_poll(&tty->read_wait, EPOLLIN | EPOLLRDNORM);
+		n_tty_receive_handle_newline(tty, c);
+
 		return true;
 	}
 
-- 
2.42.0

