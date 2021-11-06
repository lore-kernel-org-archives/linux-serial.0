Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E023CC433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 09:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8122611C4
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 09:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhKFJXk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 05:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhKFJXk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 05:23:40 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9AAC061570;
        Sat,  6 Nov 2021 02:20:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q17so483148plr.11;
        Sat, 06 Nov 2021 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjsiBBR4iQ9J6KRlh4zbj1SuSSwOxk/0qaq6CzZ2u1Q=;
        b=UcGs2unyDElkJEfyMNWOyZf0PPJiDDvz1eMFIkcK3e/TCxcXtJYq62t1rdxbJwOibx
         niJ4czW6AmA77yCNrAhHWqfAKvyQLl23RYYE2fSPd8J5WOG7NC3A01Gp2wqA5dNTzxeq
         2vrXOVZ99pf8qhTgdBKdyWt3CAiulHo72QsKHd7cx0OGitbNXbT0A72yNubaPuH0wCD6
         W9t2WMjigC9gtlmWs0D+c7Fkqx6frMQldXO90aN5n/ypJxsFUy1THD7Z/g8SqDNxvSI3
         4uZDssIQntu2QCkJeoEv9unBk/W3QBRA4/8D8PPfo9lC29tMRzmP7v1JAuc51cGEq9zU
         nqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SjsiBBR4iQ9J6KRlh4zbj1SuSSwOxk/0qaq6CzZ2u1Q=;
        b=uZ7aXf97Ikd9WMPtejFrlrDsnEJqDJvocCxAWcJY+qh+zC3J+QS/svcPJ8nQ5ssmjp
         O46lSPRiQyq0LvdDSag2mhtEyBuXUeQ/yFPaiVqUf380UztepWOl5HmxvTJ1BaALzpBE
         bsvaPlsHCRqKo9bYCck772cqnSsL5Rfc4y6IJY1GlS4BZMO+jRqIWj11Ga6sV4SXHl8v
         gCQaVY+o9cFt9DBjkH+p1H6r4gDGJc6VL/Kh0q4MlXbKgJXf04p7cPhsuNNzJn9Zli5O
         E9u+k7YU1HyOVQCCHqOeopt7VBlQg/15qei2WRFg5dY40JOda4MTNsjeyVC4q9SxeBJZ
         8ogQ==
X-Gm-Message-State: AOAM533YPuaugI5Gi9PIjXKwEeLk27sPVCAdXjsLXsMNi+6bvXqLWTa0
        2GAeGV8651Y31+90G0snzAqhYkM3ohk=
X-Google-Smtp-Source: ABdhPJzjauw8zXCQjetliVqjsgRLmaICA2Xy8uvLlLUG58orP8B2/Pmn8z/nsmBwYdaV0/k9/gykAA==
X-Received: by 2002:a17:90b:1812:: with SMTP id lw18mr19547891pjb.196.1636190458899;
        Sat, 06 Nov 2021 02:20:58 -0700 (PDT)
Received: from host-x86-64.. ([122.161.244.211])
        by smtp.gmail.com with ESMTPSA id m10sm8871380pfk.152.2021.11.06.02.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 02:20:58 -0700 (PDT)
From:   Ajay Garg <ajaygargnsit@gmail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ajay Garg <ajaygargnsit@gmail.com>
Subject: [PATCH] tty: vt: keyboard: do not copy an extra-byte in copy_to_user
Date:   Sat,  6 Nov 2021 14:50:40 +0530
Message-Id: <20211106092041.43745-1-ajaygargnsit@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Both (statically-allocated) "user_kdgkb->kb_string" and
(dynamically-allocated) "kbs" are of length "len", so we must
not copy more than "len" bytes.

Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
---
 drivers/tty/vt/keyboard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..dfef7de8a057 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2070,7 +2070,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 
-		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
+		ret = copy_to_user(user_kdgkb->kb_string, kbs, len) ?
 			-EFAULT : 0;
 
 		break;
-- 
2.30.2

