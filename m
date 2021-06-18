Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BDCC49EA4
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FAC61396
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhFRGSH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46780 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbhFRGRn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 48FFD1FE04;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXYV3WoE6otUox1ZIh+NXdHRLbvXNs6Ix+bq974Czl8=;
        b=yGy7ptEiKurqWueVq9tpPftbQOr6gKfoM2UZj8odKMxN8Vvoj9uP8DZ4uxvARaWE8aLUEy
        q2xp151PxK0FoXp3N/Jb4jBpLzJ/hGZyK9tEg92HsTU+GhcfcUENG1KDgVA1+ip0UO6tYb
        B9HbgnKfi3qBFOKRd01I+lnBHkmgpbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996923;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXYV3WoE6otUox1ZIh+NXdHRLbvXNs6Ix+bq974Czl8=;
        b=ZFDXGMhtbB4pycwXbsmjBvWsp6eTz1awNbossJOdqcQFIzJOz+Ph3tGDaeRbOscwf5DK1o
        bwrLNcJm2jHZmJCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 24BA0A3BC2;
        Fri, 18 Jun 2021 06:15:23 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 29/70] mxser: remove MOXA_ASPP_OQUEUE ioctl
Date:   Fri, 18 Jun 2021 08:14:35 +0200
Message-Id: <20210618061516.662-30-jslaby@suse.cz>
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
 drivers/tty/mxser.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 1eb48141d6ca..ca417d9a03cf 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -60,8 +60,6 @@
 #define RS485_4WIRE_MODE	3
 #define OP_MODE_MASK		3
 
-#define MOXA_ASPP_OQUEUE	(MOXA + 70)
-
 /* --------------------------------------------------- */
 
 /*
@@ -1499,17 +1497,6 @@ static int mxser_ioctl(struct tty_struct *tty,
 				mxser_cflags_changed(info, arg, &cnow));
 	case MOXA_HighSpeedOn:
 		return put_user(info->baud_base != 115200 ? 1 : 0, (int __user *)argp);
-	case MOXA_ASPP_OQUEUE:{
-		int len, lsr;
-
-		len = mxser_chars_in_buffer(tty);
-		spin_lock_irq(&info->slock);
-		lsr = inb(info->ioaddr + UART_LSR) & UART_LSR_THRE;
-		spin_unlock_irq(&info->slock);
-		len += (lsr ? 0 : 1);
-
-		return put_user(len, (int __user *)argp);
-	}
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.32.0

