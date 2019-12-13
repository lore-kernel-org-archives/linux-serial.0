Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0268DC43603
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3D1206E2
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="P8Xa9IyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbfLMAJ3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40141 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731841AbfLMAJ2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so383415plp.7
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l5WLqTQP9VT3Wj9H/IDghikmP99MJJRtTWNwh4knJ1g=;
        b=P8Xa9IyOFvUhnq1qV0qnqNFEDzFCnyBVvEhf15NcXH/cTRxIvFsnDeJh431tEL7Bho
         vdUjPUjtRf7DXpmoLJ4OgEeMus6y8d+uGvBU3rBIastCi+YaDl7eBBH1PPp+J8z/8v1b
         OAK7+gFw8kV3SQdJZu0ik5pf6c4aVoyS+z5NAOJ0ENZ7s40qEPP7yAuuSHjBLl9qHISY
         pzuxIWw/vGVhkuP91JKD4QoZjBzpnqxee8Xfx92EgK55JdIiTx0rg3wcqTMThvBtjYJs
         d/3tWF946bZdAjgsjrIflpPX6sGopVBo1A3BGFh0K4Sdr/Z+A6g0ZWtd4/unAg8p8CnU
         TBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l5WLqTQP9VT3Wj9H/IDghikmP99MJJRtTWNwh4knJ1g=;
        b=e4M8ftcY3MeSBtN20/nGFpY82yaGnih2DK3ocgu3oBvCWtod13JePoI7ldEDmKA/A3
         b4+emJD5rtink/sA8iIpb7rZnK4RjmjxjjZ22iU2QrWaTz02JGEpQpB2fcmOpClk5we6
         CP2LPw71Lx36AA5dn+UvZvcU32W9wMW0gRMZPsxK7BgEOLJksH0dc4b8fiIn3wuk5c0x
         IlEKbs2qvFSfL26HgD/fRlV9j2b4Yl/2WCl+41Yba+l9zijvQbqzzcK8aqrzE6rIKATA
         b9wBOE23FN0Sxr6g7ZfP013S5QZKkZEVLGW+Bli49jTPeh5x+w9wxy2PyA3b7kPUCLjz
         yejA==
X-Gm-Message-State: APjAAAXyDebAN2gEADfnjZD7AVRIeqmVmpu7zS3qxTUG7swrr41q2zLW
        4NbDyRtPS3p+jksACbBRNOpm9Q==
X-Google-Smtp-Source: APXvYqy3wIN8nnc/UL9s/cxQrhBLjGU7KJitO7vCE6oaWq78Eq4QrQYcUGPCAaWotsrH9/5FfOuNkg==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr12477341plt.159.1576195767792;
        Thu, 12 Dec 2019 16:09:27 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:27 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 45/58] tty/serial: Migrate sunhv to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:44 +0000
Message-Id: <20191213000657.931618-46-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
References: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sunhv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index f8503f8fc44e..eafada8fb6fa 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -25,10 +25,6 @@
 #include <asm/irq.h>
 #include <asm/setup.h>
 
-#if defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/sunserialcore.h>
 
@@ -552,6 +548,7 @@ static int hv_probe(struct platform_device *op)
 
 	sunhv_port = port;
 
+	port->has_sysrq = 1;
 	port->line = 0;
 	port->ops = &sunhv_pops;
 	port->type = PORT_SUNHV;
-- 
2.24.0

