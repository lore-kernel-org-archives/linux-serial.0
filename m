Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04003C00454
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99372073B
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="cwLK4NNB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbfLMAJU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36647 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731816AbfLMAJS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id x184so398410pfb.3
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pjqr9PsS0EovzJGQYpD/pwwPvvnyZIwKp6EbPz/5EgY=;
        b=cwLK4NNB2VWHR4d7JpiEvbIAkwzbxJnPfZRa8DuBvQuFwUNYO11+2xy87bxT8WfePD
         owa871l8tcOEzZCC9BswW1773QFWI3vhOLaPkOHEOnkzVwJED1OqwQtSPz27a3YEBaXb
         W9VM2BPgmz4oKWUvOq9BdWrJvYCEZQ0OyM9+kVS/G4PJcBmlmmybzb6fD+4fTiarvje2
         I3ZccabCSytAd6H7kbx+ULDd5Utcapa7yyCKlYxclYQiw9OEUuoVEIgVtvhKOntI7O3v
         OpJaKtBcSUL6h6OL6nagXEwYjQsv1z8VcELiylZ3PcbBgDsjoMLCTrS69+YmjuwLKuT3
         76Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pjqr9PsS0EovzJGQYpD/pwwPvvnyZIwKp6EbPz/5EgY=;
        b=cfOixxcSt6V879T/UzwKaR1zWl4HCGioLEod6nWrh+yLZUVaGwMPobyHgPeGLd4PrR
         yS1cOGkRrTkAWf31wketrjXv9vuKoYzr54vFD7wEixrDU8wtF8ReBFRgrqz8trld5taL
         UbFr9YvLYvEWtVp1d9d6Cx3srBMEOI+Gye1dR2sTvdllvmdmzcHSCKe13/kXkdQTB5Um
         VYJYP3w4xCq0C87IerJL/G1Ucua1mrVBIxMxPWzmURK1Hlm4ik77U2FngZpR63rWGyd8
         +9zR4mAZc7a7UtFVr9rkxDXOXylGgygU8vCr9WNVeuz8k7b7wVDiQBl8sgcNvma4GT2d
         vP4Q==
X-Gm-Message-State: APjAAAX/39b4xsvmtteqt1l52LUfJ9fzqAnUggrx4YQ4R9ajvoTRFvBS
        lk0StgGp7N8KyAxIfILCEkwSuw==
X-Google-Smtp-Source: APXvYqylNIScI/0cKlTTskoG1NnO9Lpswns54njx5jJy10duraYGPjumdQEWf5EWn2gPG/Cr/NBhLg==
X-Received: by 2002:a63:510e:: with SMTP id f14mr13779333pgb.35.1576195758296;
        Thu, 12 Dec 2019 16:09:18 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:17 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Subject: [PATCH 42/58] tty/serial: Migrate sprd_serial to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:41 +0000
Message-Id: <20191213000657.931618-43-dima@arista.com>
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

Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sprd_serial.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 31df23502562..0c3b7420b01e 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -3,10 +3,6 @@
  * Copyright (C) 2012-2015 Spreadtrum Communications Inc.
  */
 
-#if defined(CONFIG_SERIAL_SPRD_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -1227,6 +1223,7 @@ static int sprd_probe(struct platform_device *pdev)
 	up->fifosize = SPRD_FIFO_SIZE;
 	up->ops = &serial_sprd_ops;
 	up->flags = UPF_BOOT_AUTOCONF;
+	up->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SPRD_CONSOLE);
 
 	ret = sprd_clk_init(up);
 	if (ret)
-- 
2.24.0

