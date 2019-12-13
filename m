Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17CAC2D0CA
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56BB2173E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mWp9yH0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731791AbfLMAJI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39107 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731785AbfLMAJG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:06 -0500
Received: by mail-pg1-f193.google.com with SMTP id b137so537734pga.6
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4lYZdDwtdQBIclggA0bWMyCLHW3q7zupAZQy402Fd0=;
        b=mWp9yH0Vc2CNeqnIaym91/4DIhwEBKNorUH26C0EJi/KMKyIwOQrN0yx4HXE7ian9H
         OfLfOWbObSYBBqoc1MH5mKjzxExVnO3STfE2SrxzZjTQeLkAouoHmrQHEbf11U4EIcig
         kPLzJjkU3EGiNPrT6BsO+0t3u2X6hJbTmf9uKLGDMV5rDBb8bA9YnISjlaz0EOuq5Y1J
         +GTT6vdimCrjxzipC/Jmq1wCBUTgbkdXMT565PPjXrCahc8dnGOFvwlQw7zP3CmkXkHV
         BCmy75UFtaVUU2ex5yWF/V5SA64y/YdF8/GbKAsY6rFHFbR1NG+6ufn/Ps7nhUk9P1JA
         iU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4lYZdDwtdQBIclggA0bWMyCLHW3q7zupAZQy402Fd0=;
        b=mijJd93BaeeuAlKtDcIsNjdrUu8IR6eVNWAmiQ1HF4Hk/Xo1NAvXBJbsZCVz3CrORP
         Fnjm1CqfgB8F1ICw0rgWPBLunMF2H+8mnKHqqzBtIgEmc4Jyh4M2DxN5I4le9dNJlTmH
         uXBF5f4Q2xU9S5Vq5y+zK5oOBki9xd2Z2VwBjjEYNVEzpIHJRy8Ir8qEzwcolASj+4Ka
         JVAli3NPhRJ9F6kPPBX58YtRbaQL1G1ufI1YHRsGx/Koj3sR8nnBRj8oy/D7197bdcxi
         gu6XJyDmMw+zHvUi6/v/Q/Y3/CI7OS4jkmq7brrU8t3UUnVDgyJDLo7XiIP2aitX16BS
         2v2A==
X-Gm-Message-State: APjAAAVtv1IVUW3WCM8Hs3VawKowIFqv7j8H6mxXZqkl9E2KvO93rgV5
        iMGw88datNJxFJC6QUaFVkdhTA==
X-Google-Smtp-Source: APXvYqz0nRUqF6FBYGAYNKw+5MJ2oqirJQnva9+ZNbslF6K7J3asSfIbzrDEpwLMcHVr87dltfNRGg==
X-Received: by 2002:a63:4641:: with SMTP id v1mr13452225pgk.389.1576195745800;
        Thu, 12 Dec 2019 16:09:05 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:04 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 38/58] tty/serial: Migrate sb1250-duart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:37 +0000
Message-Id: <20191213000657.931618-39-dima@arista.com>
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
 drivers/tty/serial/sb1250-duart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 329aced26bd8..cb8185bffe42 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -15,10 +15,6 @@
  *	"BCM1250/BCM1125/BCM1125H User Manual", Broadcom Corporation
  */
 
-#if defined(CONFIG_SERIAL_SB1250_DUART_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/compiler.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -813,6 +809,7 @@ static void __init sbd_probe_duarts(void)
 			uport->ops	= &sbd_ops;
 			uport->line	= line;
 			uport->mapbase	= SBD_CHANREGS(line);
+			uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_SB1250_DUART_CONSOLE);
 		}
 	}
 }
-- 
2.24.0

