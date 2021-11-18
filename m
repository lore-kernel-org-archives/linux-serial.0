Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3D8C4332F
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FE261A3A
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 07:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbhKRHWT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 02:22:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46106 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243373AbhKRHWN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 02:22:13 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1CD7621763;
        Thu, 18 Nov 2021 07:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637219952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxkeirm3vtQg7y+EbhYx1J5Iih2mj/0gKMcvO2CRnFA=;
        b=efe16Wk/sM5dhSkkH5hwEGvdV7tYwQ4rYca0AG0jXU8slUw+gl37+B37jBclu07xd4Gb8T
        7oGQ40d1FrXHDxf0q6/9PjKObrqbmxTJmxMJZhV2jXsdr2Gschv3vDOH9A06TaZN8pB1S8
        8TsLmYuhaVVUNh32t1VheJyGv4p2wS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637219952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fxkeirm3vtQg7y+EbhYx1J5Iih2mj/0gKMcvO2CRnFA=;
        b=Rerx/pYqbd7r+UgZDByx1JF9+VGiHZbcdr4j6NEc5Fok7If43ZQhj23Ncib4NdF+Yi1W4F
        xKAHFJjt1kpRDfCw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E9F49A3B83;
        Thu, 18 Nov 2021 07:19:11 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/4] tty: remove tty NULL check from __do_SAK()
Date:   Thu, 18 Nov 2021 08:19:09 +0100
Message-Id: <20211118071911.12059-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118071911.12059-1-jslaby@suse.cz>
References: <20211118071911.12059-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Both do_SAK_work() and vc_SAK() provide a valid tty to __do_SAK(), so
remove the check.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 829944dfaf48..8e653bb4d7c7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3033,9 +3033,6 @@ void __do_SAK(struct tty_struct *tty)
 	int		i;
 	unsigned long flags;
 
-	if (!tty)
-		return;
-
 	spin_lock_irqsave(&tty->ctrl.lock, flags);
 	session = get_pid(tty->ctrl.session);
 	spin_unlock_irqrestore(&tty->ctrl.lock, flags);
-- 
2.33.1

