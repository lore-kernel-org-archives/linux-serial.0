Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D89C433EF
	for <linux-serial@archiver.kernel.org>; Fri, 22 Jul 2022 06:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiGVGLm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Jul 2022 02:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVGLl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Jul 2022 02:11:41 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA722870A;
        Thu, 21 Jul 2022 23:11:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=yixingrui@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK4.lyy_1658470295;
Received: from localhost.localdomain(mailfrom:yixingrui@linux.alibaba.com fp:SMTPD_---0VK4.lyy_1658470295)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 14:11:36 +0800
From:   Xingrui Yi <yixingrui@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: [PATCH] vt: remove old FONT ioctls definitions in uapi
Date:   Fri, 22 Jul 2022 14:11:33 +0800
Message-Id: <20220722061133.7765-1-yixingrui@linux.alibaba.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

As was demonstrated by commit ff2047fb755d ("vt: drop old FONT ioctls"),
old font ioctls like PIO_FONT have been deleted and KDFONTOP ioctl is used
for years instead.

However, unused definitions of these ioctl numbers and "strut
consolefontdesc" still exist in a uapi header. They could have been removed
since no userspace was using them. Otherwise they will become a
misleading for users, and users will fail with ENOTTY with wrong call.

We are moving old font ioctl numbers definitions here to guide users to
use KDFONTOP.

Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
---
 include/uapi/linux/kd.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
index ee929ece4112..d739b17fc942 100644
--- a/include/uapi/linux/kd.h
+++ b/include/uapi/linux/kd.h
@@ -6,19 +6,6 @@
 
 /* 0x4B is 'K', to avoid collision with termios and vt */
 
-#define GIO_FONT	0x4B60	/* gets font in expanded form */
-#define PIO_FONT	0x4B61	/* use font in expanded form */
-
-#define GIO_FONTX	0x4B6B	/* get font using struct consolefontdesc */
-#define PIO_FONTX	0x4B6C	/* set font using struct consolefontdesc */
-struct consolefontdesc {
-	unsigned short charcount;	/* characters in font (256 or 512) */
-	unsigned short charheight;	/* scan lines per character (1-32) */
-	char __user *chardata;		/* font data in expanded form */
-};
-
-#define PIO_FONTRESET   0x4B6D	/* reset to default font */
-
 #define GIO_CMAP	0x4B70	/* gets colour palette on VGA+ */
 #define PIO_CMAP	0x4B71	/* sets colour palette on VGA+ */
 
-- 
2.27.0

