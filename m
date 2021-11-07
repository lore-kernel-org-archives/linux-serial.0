Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84851C433FE
	for <linux-serial@archiver.kernel.org>; Sun,  7 Nov 2021 03:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE2D6137C
	for <linux-serial@archiver.kernel.org>; Sun,  7 Nov 2021 03:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhKGDUQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 6 Nov 2021 23:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhKGDUP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 6 Nov 2021 23:20:15 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08164C061570;
        Sat,  6 Nov 2021 20:17:34 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a9so11915207pgg.7;
        Sat, 06 Nov 2021 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHmN3YW6/R/RxQnoPBZbOmRnvrA6AYrG3A+6cuRqvsw=;
        b=jhIfCpxd+KMMLK68XTqrwgAfgtfJNoy20wx7Ie4u0fnkURMQHhoAVDdPkUi3PFD+IQ
         MzN6recfvR1MvnukphiuWs3Iln9Y/fjVEv9GYNGryX2pascxhbt2FRf3e/XfyObsHmof
         Tf1CwiaXvfGsJe2dRMT4gH8lDtfTMwB375Y4ER0FnxJeMf21R737dFylKo0dzwcnGgZz
         /x1NFLvXa0DxCwUhKAiYFRitRq9R5a3SMgddukLDCBvcB/zxf9Tuaq46V3H2alnYJxcv
         qT8Gsl4pQz3/JutY7ccJG351l18JD03V2/PZVIROCkRENxo3FR9ZCo1ey8FTb/YyWFud
         x9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PHmN3YW6/R/RxQnoPBZbOmRnvrA6AYrG3A+6cuRqvsw=;
        b=mpbI7hanedcCNGU5ROcmJGiSSjUWseVtQ0pFvh+1Bcptede3WubSaPPsz4C5HiFbAb
         C80PIathmuKPzyYz8NZI1a504MwilW1Bws5fRkgRMYb8OKKh2hcHWyk8DkwSbbDiSrCv
         rZbI4sb5/wsEch0JM4MtyR9p1s+ZlXcsh2t3UwqOvXHpZt6ot9CT9Pe1AvBPFg+mEM6f
         uGME2hxi961fsQaxhDRveXFOGZEsNFgEAw1oSaEqMz7wAFcn8KRXC+yEatDtJcqRwznu
         o3f8c3L9WBry7hv8iMn0Bn9phQVGmKMK3AkiFcv2ZsM/Ndu2dU+ZyEY8QB0sHxIgyA3q
         RqmA==
X-Gm-Message-State: AOAM532Pmp+evxv8msRo9jpir4rj8pKs7xwMOyA6ryEWAdfTqC/vzaMJ
        AbkLusvcC/RDCgtG4ArZ2X0=
X-Google-Smtp-Source: ABdhPJxO0o2pl2zpUBTWsGHqWPZ09aLVs218OumhfCTa7KlFEtTgwRC0rfcXOBPai0DM2maZA5jQig==
X-Received: by 2002:a63:1d20:: with SMTP id d32mr9094714pgd.471.1636255053410;
        Sat, 06 Nov 2021 20:17:33 -0700 (PDT)
Received: from host-x86-64.. ([122.161.244.211])
        by smtp.gmail.com with ESMTPSA id t4sm494535pfq.163.2021.11.06.20.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 20:17:32 -0700 (PDT)
From:   Ajay Garg <ajaygargnsit@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     paskripkin@gmail.com, Ajay Garg <ajaygargnsit@gmail.com>
Subject: [PATCH v4] tty: vt: keyboard: add default switch-case, to handle smatch-warnings in method vt_do_kdgkb_ioctl
Date:   Sun,  7 Nov 2021 08:47:21 +0530
Message-Id: <20211107031721.4734-1-ajaygargnsit@gmail.com>
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

v3 :
https://lore.kernel.org/linux-serial/20211106220315.392842-1-ajaygargnsit@gmail.com/T/#u

Changes in v2 :

        * Changes as required by scripts/checkpatch.pl

        * Checking whether kbs is not NULL before kfree is not required,
          as kfree(NULL) is safe. So, dropped the check.

Changes in v3 :

        * Using default-switch case, and setting the variables 
          when there is no matching cmd.

Changes in v4 :

        * Removed braces for the default switch-case.


 drivers/tty/vt/keyboard.c | 6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..f66c32fe7ef1 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2090,6 +2090,10 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 
 		ret = 0;
 		break;
+	default:
+		kbs = NULL;
+		ret = -ENOIOCTLCMD;
+		break;
 	}
 
 	kfree(kbs);

-- 
2.30.2

