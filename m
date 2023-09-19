Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441B6CE79A8
	for <linux-serial@archiver.kernel.org>; Tue, 19 Sep 2023 19:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjISTWS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjISTWR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 Sep 2023 15:22:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC849E1
        for <linux-serial@vger.kernel.org>; Tue, 19 Sep 2023 12:22:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bfccec7f3so65516887b3.2
        for <linux-serial@vger.kernel.org>; Tue, 19 Sep 2023 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695151330; x=1695756130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yV+mVHAnIooSuEN/VFCBHUTiM1RmBPNdtT6gcLOZR54=;
        b=IBIA+gVVAhP196Jd391IarZd7ZJlho5vHOuw9P1CuDNEMrPt1F2gYG2q+W/mkF56vh
         vSCn1rlnUxbUoTGRAxvUOv8XHVjFberF9gLvTdpS17kpSmRVvHD24+poS1O0ATpcqU76
         6SLAT6Dl7ZZ7Qbh08/dqF8TC3CX3gm2fy/JN0HIctNOXe+DsoMCFCTGmiZzqxoufFkat
         ikws/m7DI4b8yyVlyzezvtM1pPPbIkr7OTBH1VAi5L6UB/aCI3BYFZ9E5Zrce2uE2wab
         0X0qgjcKGlPWGBtt44gUyxtDlY/MgKkY5ku1WYQFae53MKg6/R3Z29uuOyA/iyRlbzNI
         EuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695151330; x=1695756130;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yV+mVHAnIooSuEN/VFCBHUTiM1RmBPNdtT6gcLOZR54=;
        b=iUQUo09oept87GwajwStb4pFfjZIr1InruwRPFn9RhopjwReZGpdpNcnMa9bDvc4DM
         vJHNjvwNIpd3AiqtkmmpTHJ0WocbyWL7L7HazRvTLc+CqFKqgeMXADzeSJHXSq0Pwd55
         HEea2I4y8X1OUf/ruiMXPCzE0famnUiHKLluRYTgZ/sYGo+EGRwADaWgRKpdMm/M8eLp
         rzsaOtbJKb0ozvDzic9/f4wL6ATqiqiZWCz+wCd0ovkbfPdkv82cp60Bd3U5f+nvCMTY
         XLo0aAfSDhlIeF7p+cURZ1rB0etaiz8qyHTZMO7JRuFTp1RADyUTSqHtEv7QhVZmmhqy
         Ef9A==
X-Gm-Message-State: AOJu0YxoWqsHp+UlUSCTiUL2XFXGmHoJpe0V2KJj0b0rrKfhwwOp32te
        jbMQVAK9fk43UkTPsf/oO2cJdmQ/RA==
X-Google-Smtp-Source: AGHT+IG30/zeIWID0NpFZN6N44QtOfBRG88bxDK/79HfI+SuDHpRF294zJmNYs/6N1K/Pr+qRzi1ZGeAAtM=
X-Received: from azeems-kspp.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:2403])
 (user=azeems job=sendgmr) by 2002:a25:73c7:0:b0:d7e:afff:c8fa with SMTP id
 o190-20020a2573c7000000b00d7eafffc8famr8442ybc.5.1695151330193; Tue, 19 Sep
 2023 12:22:10 -0700 (PDT)
Date:   Tue, 19 Sep 2023 19:21:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919192156.121503-1-azeems@google.com>
Subject: [PATCH v2] vt: Replace strlcpy with strscpy
From:   Azeem Shaikh <azeems@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-hardening@vger.kernel.org, Azeem Shaikh <azeems@google.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

strlcpy() reads the entire source buffer first and returns the size of
the source string, not the destination string, which can be accidentally
misused [1].

The copy_to_user() call uses @len returned from strlcpy() directly
without checking its value. This could potentially lead to read
overflow. There is no existing bug since @len is always guaranteed to be
greater than hardcoded strings in @func_table[kb_func]. But as written
it is very fragile and specifically uses a strlcpy() result without sanity
checking and using it to copy to userspace.

In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeems@google.com>
---
v2:
 * Return -ENOSPC instead of -EFAULT in case of truncation.
 * Update commit log to clarify that there is no exploitable bug but instead the code uses a fragile anti-pattern.

v1:
 * https://lore.kernel.org/all/20230830160410.3820390-1-azeemshaikh38@gmail.com/

 drivers/tty/vt/keyboard.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 1fe6107b539b..12a192e1196b 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2079,12 +2079,15 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 			return -ENOMEM;

 		spin_lock_irqsave(&func_buf_lock, flags);
-		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
+		len = strscpy(kbs, func_table[kb_func] ? : "", len);
 		spin_unlock_irqrestore(&func_buf_lock, flags);

+		if (len < 0) {
+			ret = -ENOSPC;
+			break;
+		}
 		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
 			-EFAULT : 0;
-
 		break;
 	}
 	case KDSKBSENT:
--
2.42.0.459.ge4e396fd5e-goog


