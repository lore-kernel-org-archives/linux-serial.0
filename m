Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06608C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 10:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D666B6120D
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 10:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhKFKnq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 06:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhKFKnp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 06:43:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBA6C061570;
        Sat,  6 Nov 2021 03:41:05 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so5148849pjb.4;
        Sat, 06 Nov 2021 03:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDLHjXHgylqb+MPnHWavokSJXf5Zitf6xR+vNKKk64w=;
        b=KkX7ojqLTHG3tu8JhGZnyppF7EqmI5mQ3HVzpNrDEzvfDqvDp1V54IK6wWrFQaNoxj
         0YBrPtcAAZF8B1PUdH6hV5Pd5qf5yNUyxZcBEjCkRl3PJMip0u1v7RhW4GlywZLGXgv+
         J9cnQ3csYmaf4tADX476QMlV9Azs6B7qZ/PpQ2cYI/a/BVplPG7jFiROknBixasZpoUm
         fgZjd1fSIGKUeHDqbZnBWbjKmal/iRoBkUAgmS7l0GODALwI1gMmlfZcbtUMEwTIN173
         /+wgjuge3Hz8CCrN0EiHnAQEEX/QtILudfh3RJsjxHX/pfsHiJ2bGK/9MHMJ39VfFKYs
         nK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDLHjXHgylqb+MPnHWavokSJXf5Zitf6xR+vNKKk64w=;
        b=f+gQufmSVDWa2XIWfLaqCynXQuDERuObsGV6VbjAGMcSaeRi52KYLfQl5XpiQXvFzq
         niSjhRvBvLJxC5VfKbtrQrZMWN1zgxRzPNJVoK4IIbCjVi05zb9HV3iFRHeF8jFG/orw
         ftPyOR8+dI43fzGlYmWIU72yFY2THrpqf3EgEezxuq4ZFcpEWjpAu8JFQSFv0SS591bR
         xYbJooCM8Vzvr50nh5YkMxsvtZitO9U0HPqdLyFth+R0WV9suibhmfcNxMsgKy+e9Ao2
         p+0OA761zXgdjKwTtrPVNiUoijzFO+/jx7LrFHcHTk/C090wyZlROoYrYJBv38Wql4EO
         dNEg==
X-Gm-Message-State: AOAM532DAD9Ih1TAttkNeKazVNJ5WSpsjFXi6ELfSKWuukHXMxcLyMcJ
        GNj8BhjW6HkCAJGT4Ke6LqaPY07YJcA=
X-Google-Smtp-Source: ABdhPJz0LG+L2hxP/x+BxwGRPU6Zxekj+wVoU52l944N/vbOoyW4DIiVgbaNqn8LCd0mnbF31k5WMg==
X-Received: by 2002:a17:902:e550:b0:142:2673:d873 with SMTP id n16-20020a170902e55000b001422673d873mr19715297plf.5.1636195264147;
        Sat, 06 Nov 2021 03:41:04 -0700 (PDT)
Received: from host-x86-64.. ([122.161.244.211])
        by smtp.gmail.com with ESMTPSA id e15sm673368pfv.182.2021.11.06.03.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 03:41:03 -0700 (PDT)
From:   Ajay Garg <ajaygargnsit@gmail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ajay Garg <ajaygargnsit@gmail.com>
Subject: [PATCH v2] tty: vt: keyboard: initialize "kbs" so that kfree(kbs) runs fine even if kbs is not kmalloced.
Date:   Sat,  6 Nov 2021 16:10:53 +0530
Message-Id: <20211106104053.98761-1-ajaygargnsit@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


v1 patch at :
https://lore.kernel.org/linux-serial/YYZN30qfaKMskVwE@kroah.com/T/#t


Changes in v2 :

        * Changes as required by scripts/checkpatch.pl

        * Checking whether kbs is not NULL before kfree is not required,
          as kfree(NULL) is safe. So, dropped the check.


For brevity, here is the background :


In "vt_do_kdgkb_ioctl", kbs is kmalloced, if cmd is one of KDGKBSENT or 
KDSKBSENT. 

If cmd is none of the above, kbs is not kmalloced, and runs
direct to kfree(kbs).

Values of local-variables on the stack can take indeterminate values,
so we initialize kbs to NULL. Then, if kbs is not kmalloced, we have 
kfree(NULL) at the last.

Note that kfree(NULL) is safe.



Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dfef7de8a057..54155fc91cd2 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2049,7 +2049,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 {
 	unsigned char kb_func;
 	unsigned long flags;
-	char *kbs;
+	char *kbs = NULL;
 	int ret;
 
 	if (get_user(kb_func, &user_kdgkb->kb_func))
-- 
2.30.2

