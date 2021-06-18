Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D18C48BE8
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40A22611CD
	for <linux-serial@archiver.kernel.org>; Fri, 18 Jun 2021 06:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhFRGSF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Jun 2021 02:18:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59716 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbhFRGRl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Jun 2021 02:17:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B86D721B5E;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623996922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYd3N3c0Aw6LBISi1oYuZ2lsGo9Y+aGBzcnY+yVesZs=;
        b=rFtrd/0VFTjGwJxaH0LkrQWHdgy1rWCOzKKZhXIhdhvQQIHT0ccw/1bcyZB0+X4uIGtO51
        DlWfwfqryhADJrpy5/8xz7PX8VG5toM5s6BYRg7r6ygHnXSQKvIpJx8ROfdkuDOlt7C3eY
        3RF/Z3XK4Pz8JpPSX6HFeR4Ymea0bXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623996922;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DYd3N3c0Aw6LBISi1oYuZ2lsGo9Y+aGBzcnY+yVesZs=;
        b=ap5IW0VkrkJgSQAREDwHCSh72fYx/TLfmgXl1dPDqMQN1m/4zfVdYaz7Mim0c1oSVscfYV
        R1V7I75BbxahvcAg==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 90161A3BBA;
        Fri, 18 Jun 2021 06:15:22 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 26/70] mxser: remove MOXA_CHKPORTENABLE ioctl
Date:   Fri, 18 Jun 2021 08:14:32 +0200
Message-Id: <20210618061516.662-27-jslaby@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618061516.662-1-jslaby@suse.cz>
References: <20210618061516.662-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

1) MOXA_CHKPORTENABLE is broken at least since commit ecbbfd44a08f (TTY:
   move tty buffers to tty_port) in 2012.
2) The ioctl definition was never exposed to userspace, so noone should
   actually be reliably using this.
3) It's not even mentioned in any of the mxser utilities.

Provided the above, remove this mxser-special ioctl.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/mxser.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 38e12ff17529..ebe657426636 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -51,7 +51,6 @@
 
 #define MOXA			0x400
 #define MOXA_GETDATACOUNT	(MOXA + 23)
-#define MOXA_CHKPORTENABLE	(MOXA + 60)
 #define MOXA_HighSpeedOn	(MOXA + 61)
 #define MOXA_GETMSTATUS		(MOXA + 65)
 #define MOXA_SET_OP_MODE	(MOXA + 66)
@@ -1430,18 +1429,11 @@ static int mxser_ioctl_special(unsigned int cmd, void __user *argp)
 	struct mxser_port *ip;
 	struct tty_port *port;
 	struct tty_struct *tty;
-	int result, status;
+	int status;
 	unsigned int i, j;
 	int ret = 0;
 
 	switch (cmd) {
-	case MOXA_CHKPORTENABLE:
-		result = 0;
-		for (i = 0; i < MXSER_BOARDS; i++)
-			for (j = 0; j < MXSER_PORTS_PER_BOARD; j++)
-				if (mxser_boards[i].ports[j].ioaddr)
-					result |= (1 << i);
-		return put_user(result, (unsigned long __user *)argp);
 	case MOXA_GETDATACOUNT:
 		/* The receive side is locked by port->slock but it isn't
 		   clear that an exact snapshot is worth copying here */
-- 
2.32.0

