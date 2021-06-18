Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ABC49361
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C970611CE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhFRGR4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:17:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58982 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbhFRGRl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1C00721B5F;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Ykax/pYw7bUj0ENSPbb5NBsEbkcLkScyR9oddj30dc=;
        b=BDxZgjYUqESFCIfxJ94XxdKcIdjDEwDaZieHE9en8MYC3880rvn1UHuFVwCo5pqODeNJ+A
        cJomuLimQL2zgqOW5GVQnKpLYnpHZLTC5Q194MmGgN7OqSLBVydT+r74un1D5IFJe6lx88
        786EQrxyVLkIKyo+ystAcAKIuUvNAoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Ykax/pYw7bUj0ENSPbb5NBsEbkcLkScyR9oddj30dc=;
        b=D8S5aMoF7LqEFAbejKqZ4L62hM3SRc+Rjpf2Pf9rFfGlqlj0JpYqNskdiWtV7ZI9vnbp8n
        CKB5SewwTAno3CDg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EA3D7A3BBA;
        Fri, 18 Jun 2021 06:15:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 23/70] mxser: remove MOXA_SET_BAUD_METHOD ioctl
Date:   Fri, 18 Jun 2021 08:14:29 +0200
Message-Id: <20210618061516.662-24-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

1) The semantics are defined exactly nowhere.
2) The ioctl definition was never exposed to userspace, so noone should
   actually be reliably using this.
3) It's not even mentioned in any of the mxser utilities.

Provided the above, remove this mxser-special ioctl.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index a55b20f98cb3..cf3b8f9f7e1e 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -68,7 +68,6 @@
 #define MOXA_ASPP_MON		(MOXA + 73)
 #define MOXA_ASPP_LSTATUS	(MOXA + 74)
 #define MOXA_ASPP_MON_EXT	(MOXA + 75)
-#define MOXA_SET_BAUD_METHOD	(MOXA + 76)
 
 /* --------------------------------------------------- */
 
@@ -381,7 +380,6 @@ struct mxser_mstatus {
 static struct mxser_board mxser_boards[MXSER_BOARDS];
 static struct tty_driver *mxvar_sdriver;
 static struct mxser_log mxvar_log;
-static int mxser_set_baud_method[MXSER_PORTS + 1];
 
 static void mxser_enable_must_enchance_mode(unsigned long baseio)
 {
@@ -738,8 +736,7 @@ static void mxser_change_speed(struct tty_struct *tty)
 	if (!info->ioaddr)
 		return;
 
-	if (mxser_set_baud_method[tty->index] == 0)
-		mxser_set_baud(tty, tty_get_baud_rate(tty));
+	mxser_set_baud(tty, tty_get_baud_rate(tty));
 
 	/* byte size and parity */
 	switch (cflag & CSIZE) {
@@ -1788,14 +1785,6 @@ static int mxser_ioctl(struct tty_struct *tty,
 		info->err_shadow = 0;
 		return 0;
 	}
-	case MOXA_SET_BAUD_METHOD: {
-		int method;
-
-		if (get_user(method, (int __user *)argp))
-			return -EFAULT;
-		mxser_set_baud_method[tty->index] = method;
-		return put_user(method, (int __user *)argp);
-	}
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.32.0

