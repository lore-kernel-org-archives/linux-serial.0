Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED26C433EF
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 13:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECA161178
	for <linux-serial@archiver.kernel.org>; Mon,  8 Nov 2021 13:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240112AbhKHNwF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238804AbhKHNwD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Nov 2021 08:52:03 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCFAC061570;
        Mon,  8 Nov 2021 05:49:19 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id o4so2005710pfp.13;
        Mon, 08 Nov 2021 05:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0pSRTw7ZC0+s4OzaQWGGWnVDXOfXxdQMKH6CCzPOw8=;
        b=H+RJug8nrhgfdlsaokIuo+zjCpYA0hwpjmN4aCwxnO/x9rHtA7JeT6h0on4lAeenRf
         j+AolIkV8rNhB1Ufo1p6LYB+wI9h7Ev4YfJrBzimsbcuC2ksbZAofVpho9TTPhRNvPZm
         O+7jhould/HsIN186yVOO+oK5RCy5rbs/Coditkqau/MyutOW12+zE8RBSkiugndYamD
         Q+C5bfzqk2YiB1agI10XVP8YlV24WQIk6Ag8VfDc4aKqm2y9uuOBZzwkz9ZepGC8PQIA
         M8pqVg2RVfHre9xrgofRlG3tZEPXqX0h+0K28GGbdn/ZWP5xYP04aeFk26z77xDSBzwK
         SgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0pSRTw7ZC0+s4OzaQWGGWnVDXOfXxdQMKH6CCzPOw8=;
        b=G2mlHQR7Nfq0ZcrncFsl8mgrJ/shiYHh0jQPZ7m9y8+TjpVbTt3UxQs0xw6DCF0eIJ
         nUXGtKlxMLT3B0spsnBcs6HcT+52ZUvaQ5YC64Z7oXOAWx06TcylmodJ201DsbnMN1Qg
         JP/oEgt35NHb2HqT2Sc8e8K/ILOnWslwwiPBWtjHos+iarU3WX+c02PBIhdHsYpdut27
         DpQSEMWysJ1cR6xQKWLtY2tzGY3l7/0isux3WpjOOoYo2yvBvGh1MpU8l/dBCK2filjI
         eE9xIYtGcBX5cVkzn7xLOY9mg/EPmGqq+Nv6oqCVxpepEMl9RU5j29sl5d8WeaJZ3gs1
         xyZQ==
X-Gm-Message-State: AOAM530LFLRjfayu8NbnRKUa+BgXznbs6WBD8gzkTMpfVLJ6aUvO3aHh
        uJ70KHw7+Bk/L4qUn6TucYQ=
X-Google-Smtp-Source: ABdhPJxDFObt0FQYT2Iv0mXH2xKIKNjN8TCDBfvaRHjMigY30k85rupTkFf71SaR6ffEgg5rGey9vA==
X-Received: by 2002:a63:5fc8:: with SMTP id t191mr46165273pgb.361.1636379358950;
        Mon, 08 Nov 2021 05:49:18 -0800 (PST)
Received: from host-x86-64.. ([122.161.243.27])
        by smtp.gmail.com with ESMTPSA id t13sm10780466pfl.214.2021.11.08.05.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:49:18 -0800 (PST)
From:   Ajay Garg <ajaygargnsit@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, kernel@esmil.dk,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com, johan@kernel.org
Cc:     Ajay Garg <ajaygargnsit@gmail.com>
Subject: [PATCH v5] vt: keyboard: suppress warnings in vt_do_kdgkb_ioctl
Date:   Mon,  8 Nov 2021 19:19:01 +0530
Message-Id: <20211108134901.7449-1-ajaygargnsit@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

smatch-kchecker gives the following warnings when run on keyboard.c :

vt_do_kdgkb_ioctl() error: uninitialized symbol 'kbs'.
vt_do_kdgkb_ioctl() error: uninitialized symbol 'ret'.

i)
The 'kbs" warning was introduced by "07edff926520" :
("vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl")

* 
prior 07edff926520, the scope of kbs (allocation/deallocation) was
external to switch-cases.

*
post 07edff926520, kbs is allocated internally for each case, however the
deallocation remains external.

Thus, as the "fix", the scope of kbs deallocation is now made internal
to each switch case.

ii)
The 'ret' warning is the result of "4e1404a5cd04" :
("vt: keyboard, extract and simplify vt_kdskbsent")

where the "ret = 0" (right at the end) was accidentally removed.

Bringing back the above in a slightly different way, by initializing ret
to 0 at the start.

Many thanks to the following for review of previous versions :

	* Pavel Skripkin <paskripkin@gmail.com> 
	* Andy Shevchenko <andy.shevchenko@gmail.com> 
	* Johan Hovold <johan@kernel.org>

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

v4 :
https://lore.kernel.org/linux-serial/YYjw2mRIhy1SoIb+@hovoldconsulting.com/T/#mf25ca00a93e278bbb8f0382a4f7752dc35f4aa8b

Changes in v2 :

        * Changes as required by scripts/checkpatch.pl

        * Checking whether kbs is not NULL before kfree is not required,
          as kfree(NULL) is safe. So, dropped the check.

Changes in v3 :

        * Using default-switch case, and setting the variables 
          when there is no matching cmd.

Changes in v4 :

        * Removed braces for the default switch-case.

Changes in v5 :

        * Incorporating changes as suggested by Johan Hovold
 	  (please see v4 link).

 drivers/tty/vt/keyboard.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index c7fbbcdcc346..ea19671d5d0c 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2050,7 +2050,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 	unsigned char kb_func;
 	unsigned long flags;
 	char *kbs;
-	int ret;
+	int ret = 0;
 
 	if (get_user(kb_func, &user_kdgkb->kb_func))
 		return -EFAULT;
@@ -2073,6 +2073,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
 			-EFAULT : 0;
 
+		kfree(kbs);
 		break;
 	}
 	case KDSKBSENT:
@@ -2088,11 +2089,11 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 		kbs = vt_kdskbsent(kbs, kb_func);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 
+		kfree(kbs);
 		ret = 0;
 		break;
 	}
 
-	kfree(kbs);
 
 	return ret;
 }
-- 
2.30.2

