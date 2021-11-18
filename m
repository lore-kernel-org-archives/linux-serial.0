Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6732C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A16D96138F
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbhKRHUT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:20:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51848 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbhKRHUR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:20:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 077701FD37;
        Thu, 18 Nov 2021 07:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637219837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=SQ9Izf0aRRgIduyBEe8Mkfcip9lM9CfOfJa1x/AwxQg=;
        b=C+cTRv38ZZ2cYkZdkq2otOo8QFJXfS5eY/omwuVljy/7GpN6MANCZIl/sbqsySE8KqhR7S
        OTg2RkJSUfE17/pIveleBSgUiEnJyEd4regqNI+kkVmEuNeTCr8ytEH2wKXTlSRUhMwckp
        txak1c70XVQBqItKPpF+72jCBRZJlE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637219837;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=SQ9Izf0aRRgIduyBEe8Mkfcip9lM9CfOfJa1x/AwxQg=;
        b=mvLHc170sa0jDUL29ZvEL1IBJ1z3pyFYd6Q5EjLyRBAI/OHkJ0mz3SVTHgo0MGZ0rWF1Cf
        FmpLFc+RCDooz4CQ==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D0614A3B83;
        Thu, 18 Nov 2021 07:17:16 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] n_gsm: remove unused parameters from gsm_error()
Date:   Thu, 18 Nov 2021 08:17:16 +0100
Message-Id: <20211118071716.11984-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

data and flag are unused in gsm_error(), so remove them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 0b96b14bbfe1..68e6df27d2e3 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2074,8 +2074,6 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 /**
  *	gsm_error		-	handle tty error
  *	@gsm: ldisc data
- *	@data: byte received (may be invalid)
- *	@flag: error received
  *
  *	Handle an error in the receipt of data for a frame. Currently we just
  *	go back to hunting for a SOF.
@@ -2083,8 +2081,7 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
  *	FIXME: better diagnostics ?
  */
 
-static void gsm_error(struct gsm_mux *gsm,
-				unsigned char data, unsigned char flag)
+static void gsm_error(struct gsm_mux *gsm)
 {
 	gsm->state = GSM_SEARCH;
 	gsm->io_error++;
@@ -2504,7 +2501,7 @@ static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		case TTY_BREAK:
 		case TTY_PARITY:
 		case TTY_FRAME:
-			gsm_error(gsm, *cp, flags);
+			gsm_error(gsm);
 			break;
 		default:
 			WARN_ONCE(1, "%s: unknown flag %d\n",
-- 
2.33.1

