Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811D0C00454
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531B72173E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="O0pwB2uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfLMAIA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:43475 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbfLMAH6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id g4so333992pjs.10
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zxx/HRHL6kjWjxkGDaGwGWZ/6AVYaJNa85HBD92o/lM=;
        b=O0pwB2uuaJIoMx5Hj0eQnZ5uh3n3bDklfwUjHwIMqdbZZ3fHbmNl1iqmqJSlpryRO2
         YIZy1T2tmjVvvgwOCKOqck2p3o6WvqTmgsTBvNhnAXKo+GXKmHllndUAmhIoLT+zTTOq
         b+NuFqv9SquAq2CzlPTcE6pGHnd7/QBtqd+7xLnSktuU2SNBOoNpBQbuEPOxPJbaNkqE
         EdatrGQPNq5Es0t0w37x8URXMcjITkkMbtAEWY3w0kuCeVZc4EHiKePPcyUptrKDAubv
         jxYsYVD2dxj3yVxvebmhJvoEZAj1V+qH4IF410bk3LLvfbwl+RqvVPPp0mvrnMi5Qr2M
         4VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zxx/HRHL6kjWjxkGDaGwGWZ/6AVYaJNa85HBD92o/lM=;
        b=HnU529rMj+1mOc/vL21Q1AEdBL7l+NhzicTO+stY+qztmGkhIV0yb52FemTANCkZ+K
         vzn7Q6XMjlIjeTycGJ4tS0LLEH5Dsk0ziQcDe0xsz8KhOJGr8Xcldrlf0ff4UESMPVx5
         b29BAubAFixlCT2YXkBh03rJNmhnCSZY+/8uEYMvtmrgyLLABGXoyi3zad3JsCTIZ14V
         Lq23biKktCQDXSDKWFAnSsBCSLYJdgEFglf8yNcfgXd76DcqSp+NqPydK3SoWzhoff+/
         RT8hUqS24NPDAxvRZs4JO0Tp+RLsfxlllkDa5CygtQdVPAYyfozsRY3qkImgO6E5PAxQ
         RNcg==
X-Gm-Message-State: APjAAAXz7flk90+K4oK7wYNBjBy01Y4DvPgvt7wSkT5+KRwRSc6oSBNL
        w244FE4+gQ5fhlJY6ZTZ2EB9+g==
X-Google-Smtp-Source: APXvYqxJAMj6b+gRXMvs56fGQZqyz8wB4ICEEZaUhOEliFjrIdFM1hNV0AKbBv3XVTo5qVQMWh3sOQ==
X-Received: by 2002:a17:902:b598:: with SMTP id a24mr12416703pls.247.1576195677874;
        Thu, 12 Dec 2019 16:07:57 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:57 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 15/58] tty/serial: Migrate dz to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:14 +0000
Message-Id: <20191213000657.931618-16-dima@arista.com>
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

Cc: "Maciej W. Rozycki" <macro@linux-mips.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/dz.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 7b57e840e255..6192ed011bc3 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -29,10 +29,6 @@
 
 #undef DEBUG_DZ
 
-#if defined(CONFIG_SERIAL_DZ_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/console.h>
@@ -787,6 +783,7 @@ static void __init dz_init_ports(void)
 		uport->ops	= &dz_ops;
 		uport->line	= line;
 		uport->mapbase	= base;
+		uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_DZ_CONSOLE);
 	}
 }
 
-- 
2.24.0

