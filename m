Return-Path: <SRS0=PCYV=4X=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493CCC10DCE
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 15:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FCB2073D
	for <linux-serial@archiver.kernel.org>; Fri,  6 Mar 2020 15:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eDnly6+w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFPcF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:32:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41080 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgCFPcF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Mar 2020 10:32:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id v4so2858282wrs.8
        for <linux-serial@vger.kernel.org>; Fri, 06 Mar 2020 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w97Pp2fKkn2kGX06OWuM0pYdHRbBbR8ZYFWEc1KVtOc=;
        b=eDnly6+wEeDutBAHN/dpAogQanE64PUyaCrAQFzo+sbg1i1Zp6bT8pxKj3Na/J1/5t
         XSxLDoR7a2Z5Af7faSCuE82OOz2Ud/uFgbw7auGxcmeUMNy7FnhLfwSwgC/w3HRFrmV8
         fg2Jfo7z7bbdfgULDMeAZsrGQ4xJdXkrsLtPpdqQhDBR2LrQccnnyfUktExKwg/SOAhK
         lXyVa5ppyTAU+Sap+/JyA9FEVxsmJnUxI4n4c3+RD6H7Z4zdrRWGVJFRd6q2yKULiikV
         9lDi5qpSdA4Joe1trfiFfsTBr9qWNZ2XbVJ/S/GNtHf2+5IirdI7EPhm1JJI8r6SjXk0
         4iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w97Pp2fKkn2kGX06OWuM0pYdHRbBbR8ZYFWEc1KVtOc=;
        b=JfVKTchgsJkW2Nfpp+4NdX9yRc0j4f+gUADDrXNQy6auljLfXIiQglBnAkuDGxG6fr
         cxABLmCH5eLvrNchzX2CermJHVHFARagM0mxBfTEQF/djkJ01I40zyTfItPAaopd6B1W
         5SPINTv2rLzfmHQ5YDgWgYPdojOA3rq3XmozOodzj8wFZv5b3BLO+PkMCZsJknk8BPmD
         LDUZGehuKU8RReDUMh93IwtbsqMvfHiyl7JppuYNQcGxVgJfyAumgozB+Wl7dMctjB4X
         ijtHmaj3naVuO78gHUwdOwY7KmyRADx6nX42w7PtGfDvOT2tK2U77jL/Im11+BbcxLnF
         gYpg==
X-Gm-Message-State: ANhLgQ1R5XxGmOVLFfzJ5vRbb8LTIxQOpd+RlDOQ5PHSs8YG1YPBoMeL
        lmZljM8bW/ttZ2EIiVBQCVC2yg==
X-Google-Smtp-Source: ADFU+vubD3BVDpKLzjLUgrQJ4T0Z9+TJjxru4N+98iWBwWsiW7iX3358rrmIOG6W/NTWUWg1/qivpA==
X-Received: by 2002:adf:e911:: with SMTP id f17mr4357585wrm.87.1583508723318;
        Fri, 06 Mar 2020 07:32:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id h20sm29006397wrc.47.2020.03.06.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 07:32:02 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH-next] serial/sysrq: Add a help-string for MAGIC_SYSRQ_SERIAL_SEQUENCE
Date:   Fri,  6 Mar 2020 15:31:56 +0000
Message-Id: <20200306153156.579921-1-dima@arista.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

To make it more obvious what almost everyone wants to set here.

Cc: Iurii Zaikin <yzaikin@google.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Joe Perches <joe@perches.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vasiliy Khoruzhick <vasilykh@arista.com>
Cc: linux-serial@vger.kernel.org
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 lib/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 38a8f3c99579..c4a45817918a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -439,6 +439,8 @@ config MAGIC_SYSRQ_SERIAL_SEQUENCE
 	  Specifies a sequence of characters that can follow BREAK to enable
 	  SysRq on a serial console.
 
+	  If unsure, leave an empty string and the option will not be enabled.
+
 config DEBUG_FS
 	bool "Debug Filesystem"
 	help
-- 
2.25.0

