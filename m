Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A9EC433F5
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 09:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6700A60EB4
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 09:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhKFJe4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 05:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhKFJey (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 05:34:54 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21022C061570;
        Sat,  6 Nov 2021 02:32:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso5083294pjo.3;
        Sat, 06 Nov 2021 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcaU65qRcXa83yubdN4O2QG/8/lJCd9hnha7LHqglvU=;
        b=LYNwwIyAdsCF/QxhwxGB4Gn8hR4NP8Bd+tAsVnbAIKqgt3B7RwJ06few0jDXoj/ZUg
         yRbY8rAasp2dJQfrJwTitPfrWzzLTZaGSxv3AKRzVGjV6KdgmqO5+g7sys8c9hhsRzVT
         v4n0nCJk0XdMsOVrCBr6JgnafFcBC6D6uLntT3NwZ6YqEPa6SMIAhuH9VnpbA2EPq75e
         hdWiqZiK284DacWRhwFlXkJBI8sG98j9Ufqs2A6jz8MCKUPQrIiOeghfZWbuxmvIdeXo
         1fudBPmh8mewKdkKGCPkCDGTy4jiOQ32Y5xDDKga2944ZCpKrtEQWdf/ZrjuAwKSml+S
         9zLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TcaU65qRcXa83yubdN4O2QG/8/lJCd9hnha7LHqglvU=;
        b=pIzsKV0rD/3kWsYOg3yHJbrjUpVlcVJf5bGqLm01X0lDNDkOY11BAfW30gDe6UUIon
         jbeQUa6U9uTNge2HQ5qt2lZmJxzr7IZ7z8yprSw/9C2Gw9RmqpWizHKurTeu7qx/p7kv
         bGF1WXlGDXqdlZiFCPyK4691RL0cOSQ5ZvqGezaIwh9c9vctGAih76C9t4/fGIKU6GSI
         fbCzpriOlflV/oLLxxxvddGrLxAfpHl9WeafzFm32JRl45BsTwAzGf3DTSK/a/eVvhmr
         vY4VBM8/Nj/d911g5SJz+KbrwoU8vJgn/HAz58E1V1TWWX2zcfREu97R8J3UKtlifHpZ
         FxnQ==
X-Gm-Message-State: AOAM532XOiA7R/1qeP4Q3jJocTSXcvu04epxaqNmaVYICmnUe8vd/YKO
        mgSb9UyRCf3cCTThgUgDSEFU00AOusI=
X-Google-Smtp-Source: ABdhPJzJqgdoBJw7gWnsV6B7SnEqFonVqLpH9hhIK4rloFBwS7AtBJ0P2rZP+zghCrloBeKbhzqqHw==
X-Received: by 2002:a17:90b:4a0f:: with SMTP id kk15mr19880553pjb.223.1636191133386;
        Sat, 06 Nov 2021 02:32:13 -0700 (PDT)
Received: from host-x86-64.. ([122.161.244.211])
        by smtp.gmail.com with ESMTPSA id w11sm7855242pge.48.2021.11.06.02.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 02:32:12 -0700 (PDT)
From:   Ajay Garg <ajaygargnsit@gmail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ajay Garg <ajaygargnsit@gmail.com>
Subject: [PATCH] tty: vt: keyboard: Free dynamic-memory only if kmalloc'ed.
Date:   Sat,  6 Nov 2021 15:02:02 +0530
Message-Id: <20211106093202.44518-1-ajaygargnsit@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

In "vt_do_kdgkb_ioctl", kbs is kmalloced, if cmd is one of
KDGKBSENT or KDGSKBSENT.

If cmd is none of the above, no kbs is kmalloced, and thus,
kbs must only be kfreed if it is really kmalloced.

Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
---
 drivers/tty/vt/keyboard.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index dfef7de8a057..95839987c79c 100644
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
@@ -2092,7 +2092,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		break;
 	}
 
-	kfree(kbs);
+        if(kbs)
+            kfree(kbs);
 
 	return ret;
 }
-- 
2.30.2

