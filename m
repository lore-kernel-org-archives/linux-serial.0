Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E5FC2D0C9
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8192253D
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LaFrKk11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbfLMAIF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44423 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731603AbfLMAIE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id d199so374043pfd.11
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2REjU/wwnolNmgskeGgLHtzvyMo6gxfjQO8hwRD4+s=;
        b=LaFrKk11y/qrDvhQLpcH/tMn+AtEjidQ/S7Bwoxt39T5iq+B30U8Mc+eOfD0LfH360
         lfASYZ/X7dlq46kHk+mMuhSN4KnTA+vjMRNULdxAO63sm4G6zrJd+LhX8NDkwdN1F8/o
         q49Gcv/HMMMZEFLQwKm7mssNJD/s0CBhMCGxDKQvGuFqMx0l11wT/btdwjESZslbvPhy
         dG4uu64q5dMA1sEF8iBFz3hXZMOyV/2hplSD20Addim7ZTuvfHqFhNpOPqZv3H0M1RJ1
         iI18523qhABfn5eXBRRQq5ll+lyLxBGLKnBy/0nQn/swzNkGcac3fE3CSJxK2VcN9Y+4
         Z8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2REjU/wwnolNmgskeGgLHtzvyMo6gxfjQO8hwRD4+s=;
        b=ORKXjAyBm7fdOMWbYO115hhfT0/LshiQqzikHaTqnFWkCk4hz7fdVEzB28USybK9K8
         0kVExhmwFtAANEOEvL+aXUutyFInimJVLLb/FPf6pypmMJoGliqZ0SXQ+LYK1r9loN2l
         dB67JRxJo8oQMn3UFeqF2nvksEW4PYGXQnnCWMpLa6BZACKR8REphtopPHAH2WiqNuaq
         DFJPcvGl1jxCM2RUW7AXy7DxjUfeew22506/Ii2rAWp1yEiR+Xp4tEwSMcpXvUwRO8xI
         frzWWx8XmLl5eUYRJEXQeYD3SVb3mIkf8zAz7TRLqkhuPoJzCyC7s57G7y2stAJ6CKT5
         4wcg==
X-Gm-Message-State: APjAAAVlR7SGAY8A/bsfXkAHh2kcJpwMzUnq+BRwnWTkvFD7lMNY5OKO
        YSG+p7K+QY07jCCcB7cIKatjiQ==
X-Google-Smtp-Source: APXvYqxZ1ecBMRbAkQc7ypC+wk6mb+prHBAmlYnfp/H0DqnpcVDElYmDMsrtZg5kggM4Ju6hJKzJgw==
X-Received: by 2002:a62:aa13:: with SMTP id e19mr12821823pff.36.1576195684100;
        Thu, 12 Dec 2019 16:08:04 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:03 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 17/58] tty/serial: Migrate fsl_linflexuart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:16 +0000
Message-Id: <20191213000657.931618-18-dima@arista.com>
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

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 205c31a61684..3e28be402aef 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -6,11 +6,6 @@
  * Copyright 2017-2019 NXP
  */
 
-#if defined(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE) && \
-	defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/console.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -279,10 +274,8 @@ static irqreturn_t linflex_rxint(int irq, void *dev_id)
 		if (brk) {
 			uart_handle_break(sport);
 		} else {
-#ifdef SUPPORT_SYSRQ
 			if (uart_handle_sysrq_char(sport, (unsigned char)rx))
 				continue;
-#endif
 			tty_insert_flip_char(port, rx, flg);
 		}
 	}
@@ -863,6 +856,7 @@ static int linflex_probe(struct platform_device *pdev)
 	sport->irq = platform_get_irq(pdev, 0);
 	sport->ops = &linflex_pops;
 	sport->flags = UPF_BOOT_AUTOCONF;
+	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
 
 	linflex_ports[sport->line] = sport;
 
-- 
2.24.0

