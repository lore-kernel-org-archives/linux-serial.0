Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC1DC34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDA624670
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgBSIuV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:50:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:49746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgBSItx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:49:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C38E8AD06;
        Wed, 19 Feb 2020 08:49:51 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/10] n_gsm: add missing __user annotations
Date:   Wed, 19 Feb 2020 09:49:44 +0100
Message-Id: <20200219084949.28074-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

sparse warns about incorrect types:
n_gsm.c:2638:35: warning: incorrect type in argument 1 (different address spaces)
n_gsm.c:2638:35:    expected void [noderef] <asn:1> *to
n_gsm.c:2638:35:    got void *

The ioctl handler casts its `arg' to (void *) without __user. Add that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_gsm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 82e3d88c1f3f..d866884c105b 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2638,11 +2638,11 @@ static int gsmld_ioctl(struct tty_struct *tty, struct file *file,
 	switch (cmd) {
 	case GSMIOC_GETCONF:
 		gsm_copy_config_values(gsm, &c);
-		if (copy_to_user((void *)arg, &c, sizeof(c)))
+		if (copy_to_user((void __user *)arg, &c, sizeof(c)))
 			return -EFAULT;
 		return 0;
 	case GSMIOC_SETCONF:
-		if (copy_from_user(&c, (void *)arg, sizeof(c)))
+		if (copy_from_user(&c, (void __user *)arg, sizeof(c)))
 			return -EFAULT;
 		return gsm_config(gsm, &c);
 	case GSMIOC_GETFIRST:
-- 
2.25.0

