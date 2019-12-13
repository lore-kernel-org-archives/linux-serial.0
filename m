Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99135C43603
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAD52073B
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FVQ6yX+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731412AbfLMAJi (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34113 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731867AbfLMAJi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:38 -0500
Received: by mail-pj1-f66.google.com with SMTP id j11so355585pjs.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tRWGiJTgH8ojKPgouCjHwlEMcuQFXWpAzPDdrUxEpKQ=;
        b=FVQ6yX+kvRCHL6zKDUuiBB1rf+YvkRSWFt5vXirWLuXqYqBXjk9mjSdMrZwfGlZLGq
         POOC8a4uStNYh6tMonPqVWrJKWIQu6ooxZM3MQjlSrnp2DpB7XTz1dJSYtt7wlhV0p4C
         mdFGes9xCtuCsWzeg6yE3Z3wjEJ+BFUtADcjhl/TehOfjK/r0RVJ6qxO7cwcdnf5lACx
         mDD2sq/RdojXuL0TBrD6GNdPbtmar66iemj2l/jdXXEVV1Uv3LMt3NHzie7GFU02aw8m
         GnV+CsXFRGUQcj1aMmDqAFtddqcU/I27uJG7gilqV48RYol5+kk4Laex2pZ5092HRxTd
         9d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tRWGiJTgH8ojKPgouCjHwlEMcuQFXWpAzPDdrUxEpKQ=;
        b=oIvXAoIb+0p0ItaEw+x6vml+wRoQpDnfK3zev2yfP4RLZbulOKO9g2vsf2bZ3R+GLF
         RdVN0e9gZiuT1VuV58LCRNSIeeNe3qrmZfIQFVLaI4moYfSYbQz9PnqwjLBVpiwIu2Qb
         4x+4o2Tr1en/XO58D+3BdWfxwAwH0nSmDTvYJFM+VdfJu7cYICZLJbCVmv3TOWICabBW
         tMivneODrHV+hjF+hWwJXFgh773sIvxSs/kYqBNwyJ8gMsertaJUKd7trq4oQ343gMnZ
         2XWNEXjB2y3t0MVH9AGGzoN6QFMG3Qxg4r/y3xb0rJlUQVaap1WFz+dCqmniXFlRXeoV
         hZ1Q==
X-Gm-Message-State: APjAAAW++iMms2EQwc4wruSqBRr3ZpAEAk1wsttFHvsctOrVL9C7nGJ/
        C83VR05na6fhwHSXoSRAia669Q==
X-Google-Smtp-Source: APXvYqyeabE7rfY9K9RLj7vZAopmNplzFjzuLaZ8dvksqSyNsq801CAohBkkytIuAMMulL7af1Qpzg==
X-Received: by 2002:a17:90a:21ee:: with SMTP id q101mr13227836pjc.94.1576195777319;
        Thu, 12 Dec 2019 16:09:37 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:36 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 48/58] tty/serial: Migrate sunzilog to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:47 +0000
Message-Id: <20191213000657.931618-49-dima@arista.com>
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
 drivers/tty/serial/sunzilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index bc7af8b08a72..103ab8c556e7 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -40,10 +40,6 @@
 #include <asm/prom.h>
 #include <asm/setup.h>
 
-#if defined(CONFIG_SERIAL_SUNZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/sunserialcore.h>
 
@@ -1444,6 +1440,7 @@ static int zs_probe(struct platform_device *op)
 	up[0].port.line = (inst * 2) + 0;
 	up[0].port.dev = &op->dev;
 	up[0].flags |= SUNZILOG_FLAG_IS_CHANNEL_A;
+	up[0].port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SUNZILOG_CONSOLE);
 	if (keyboard_mouse)
 		up[0].flags |= SUNZILOG_FLAG_CONS_KEYB;
 	sunzilog_init_hw(&up[0]);
@@ -1461,6 +1458,7 @@ static int zs_probe(struct platform_device *op)
 	up[1].port.line = (inst * 2) + 1;
 	up[1].port.dev = &op->dev;
 	up[1].flags |= 0;
+	up[1].port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SUNZILOG_CONSOLE);
 	if (keyboard_mouse)
 		up[1].flags |= SUNZILOG_FLAG_CONS_MOUSE;
 	sunzilog_init_hw(&up[1]);
-- 
2.24.0

