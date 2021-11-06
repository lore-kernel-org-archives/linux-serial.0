Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A3C433EF
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59116112D
	for <linux-serial@archiver.kernel.org>; Sat,  6 Nov 2021 22:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhKFWGL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 18:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFWGL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 18:06:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF0AC061570;
        Sat,  6 Nov 2021 15:03:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v23so3450945pjr.5;
        Sat, 06 Nov 2021 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZQ75wWFyM5Gecc77Q2zBq9LYat0h4SleZlOYKg3r2A=;
        b=UyeIFI2/YLVZ5V0Q9lZG+VZoyj7ASuLKXbbl9JpWXc2NwLtxs1/+modnYvy6pATwwR
         rEyq5MfKdyXgyAhA2BSYoBanWjTbf02QUjpeoCrVekDDxWOKq0JxGA86itCdXIq4IUOa
         LupLzQoZ4Ov8aUFbgRTQv1coMWJpe7IBJdYHCA/eNc0opDpoboej1RFVepY2jWrxu2wH
         5SK7HUEQ0mcfTJwF1RPVah6FBg5vb85fjZ5McYPjDJzmboPj8t7il2DWnWyiVsmec3sQ
         ZIHQdw+UhzwgOcb9Fv6UFDgxig0IhRa4GUUi/JLSITB5MrnfMsjaKm6Z/ka/OR8tA918
         nQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XZQ75wWFyM5Gecc77Q2zBq9LYat0h4SleZlOYKg3r2A=;
        b=3MI9Sc45mY17R1qokMOKhJyUe1T/z4o4Vp71Q3ZQxhI+QnSvw+uXJ4ipn3xM4Em4iv
         BGSTjQeRSC8zTC+Qc0l8niTtc1SMpFA0ESQ/U6P1DvaAeKaW8IsWzayVF5pjc5fTsE2C
         fvDNjMWHQ+APkTsa6VQCiAhJbxq7nTPoM3asyIZflFlFy21yK4958gc1LQ2tCg//DWpL
         UnnRQkgRbtKttCmVaaL+T76b1qcmpl/Ii0DAVbV8HN4qRKXuXX96wVBRbaaJDK2LzT4O
         8x4V4WkhlbMcFsJBinbPD4hwXQHWcKxH5hPU3FRwveBkFzC/V6k8i9z8Jw5fFhpUkd01
         laYw==
X-Gm-Message-State: AOAM532LWVIH8EAfd/RXDPWS8yCzaC7FG+xI+xthAi9/kL8mLYJAmkqD
        IjuwDGIuBlECwdcER947nJg=
X-Google-Smtp-Source: ABdhPJxHwsei/tpXmT9MZoXC9IPsz+0upb565nk4TCypGEjVCdSh7e783j3r5OG4albQnCSVCWJQPw==
X-Received: by 2002:a17:902:7107:b0:142:5777:fb61 with SMTP id a7-20020a170902710700b001425777fb61mr8434164pll.59.1636236208475;
        Sat, 06 Nov 2021 15:03:28 -0700 (PDT)
Received: from host-x86-64.. ([122.161.244.211])
        by smtp.gmail.com with ESMTPSA id j6sm8628918pgf.60.2021.11.06.15.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 15:03:27 -0700 (PDT)
From:   Ajay Garg <ajaygargnsit@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     paskripkin@gmail.com, Ajay Garg <ajaygargnsit@gmail.com>
Subject: [PATCH v3] tty: vt: keyboard: add default switch-case, to handle smatch-warnings in method vt_do_kdgkb_ioctl
Date:   Sun,  7 Nov 2021 03:33:15 +0530
Message-Id: <20211106220315.392842-1-ajaygargnsit@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

smatch-kchecker gives the following warnings when run on keyboard.c :

vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
vt_do_kdgkb_ioctl() error: uninitialized symbol 'ret'.

This usually happens when switch has no default case and static 
analyzers and even sometimes compilers can’t prove that all possible 
values are covered.


Thus, the default switch-case has been added, which sets the values 
for the two variables :

        * kbs as NULL, which also nicely fits in with kfree.

        * ret as -ENOIOCTLCMD (on same lines if there is no cmd
                               match in "vt_do_kdskled" method).


Many thanks to the following for review of previous versions :

	* Pavel Skripkin <paskripkin@gmail.com> 
	* Andy Shevchenko <andy.shevchenko@gmail.com> 


Signed-off-by: Ajay Garg <ajaygargnsit@gmail.com>
---


There were discussions previously, and the current patch is the 
result.

v1 :
https://lore.kernel.org/linux-serial/YYZN30qfaKMskVwE@kroah.com/T/#t

v2 :
https://lore.kernel.org/linux-serial/CAHP4M8Vdj4Eb8q773BeHvsW9n6t=3n1WznuXAR4fZCNi1J6rOg@mail.gmail.com/T/#m18f45676feaba6b1f01ddd5fe607997b190ef4b9

Changes in v2 :

        * Changes as required by scripts/checkpatch.pl

        * Checking whether kbs is not NULL before kfree is not required,
          as kfree(NULL) is safe. So, dropped the check.

Changes in v3 :

        * Using default-switch case, and setting the variables 
          when there is no matching cmd.


 drivers/tty/vt/keyboard.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..b83e7669658d 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2090,6 +2090,12 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 
 		ret = 0;
 		break;
+	default: {
+		kbs = NULL;
+		ret = -ENOIOCTLCMD;
+
+		break;
+	}
 	}
 
 	kfree(kbs);
-- 
2.30.2

