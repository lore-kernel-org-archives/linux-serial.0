Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54EEC00454
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C4A2173E
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jTv/nJFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbfLMAIX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:08:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34828 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbfLMAIW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:08:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so553245pgk.2
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZPFnvCvJBYmx33IldYqpYC2OD9JgOy1m32P6dx6e2CQ=;
        b=jTv/nJFKEOHtN7iFsmXTXSL2QWF5HdZIW518+oS7Gcw73spK0LXZ0xQOEXi5MISP3P
         MIoA6idMD21+W5Lic+rLUj8vezUykGuyCTPY1SogEK4NY9b39rNw+vu4oQzfD2yb+Br9
         VNESDO/YZOAqqYRnZ8AxgonZFqtKs3jM8M6EFEL65/1Fb9M6u29K7eG2MfOqTgVTloD9
         eCqxzjCBpVCSPs0ewDR4x3JtyuZPGS9ovM3Ew1GTekf3+i/myReae+gAKFBF5tbiGiRm
         O349lznywVofJ+m2Z7kTf6C7UvQAUgIzNKGpF/ZYVDLzKbMj4t8odwaLTsyOgM8uAvkw
         KKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZPFnvCvJBYmx33IldYqpYC2OD9JgOy1m32P6dx6e2CQ=;
        b=O1TQSrXn5gfZk44LePUYhvWgG/0fMts9hWR2qgyFqI8bgI4+9Mq/fOotCRNfCMoEgT
         /NdSkLUVrQRtIXcExKr6X8Sm2vUgn0UKPMaiiSprhi5HasPonjEj2zTmzG1KRF0RyfCe
         ka8ZnTSnLL3tXBW/DcE9IHrV8BHtnJDqXfhc0n/FaJH4+Meoi7RG53o9ZziMoXIW5vY8
         CqeseKUEacK4cOGdnqmQfrW6qNEXgLyy1aA7GcNY3bPwDaiOcVFtmq5JAur0fVnuGM2A
         OT3diLAk06MtSbxoLdC/zUgG9voqZiS4ME41DudAXHUaXZ0qaMHc7NSezmAKv1jGx/21
         9ucA==
X-Gm-Message-State: APjAAAVDyztuU0zRp0tqqCvfhUIvjx6+BVVvJVunVL/RjgUGL8g0XOwN
        l15V2i6fhi83zINiPlgmZVVT9g==
X-Google-Smtp-Source: APXvYqytHWXf2qibEPWOKjrjlhCGbIMcJhM73HibG3q1GXBJWhcP/DOuZd9G2UB9/eo66U2V8qsX8g==
X-Received: by 2002:aa7:9d0d:: with SMTP id k13mr13481565pfp.254.1576195702076;
        Thu, 12 Dec 2019 16:08:22 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:08:21 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 23/58] tty/serial: Migrate mpc52xx_uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:22 +0000
Message-Id: <20191213000657.931618-24-dima@arista.com>
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
 drivers/tty/serial/mpc52xx_uart.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 3a75ee08d619..ba1fddb6801c 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -44,10 +44,6 @@
 #include <asm/mpc52xx.h>
 #include <asm/mpc52xx_psc.h>
 
-#if defined(CONFIG_SERIAL_MPC52xx_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 
 
@@ -1382,12 +1378,10 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 		ch = psc_ops->read_char(port);
 
 		/* Handle sysreq char */
-#ifdef SUPPORT_SYSRQ
 		if (uart_handle_sysrq_char(port, ch)) {
 			port->sysrq = 0;
 			continue;
 		}
-#endif
 
 		/* Store it */
 
@@ -1770,6 +1764,7 @@ static int mpc52xx_uart_of_probe(struct platform_device *op)
 	spin_lock_init(&port->lock);
 	port->uartclk = uartclk;
 	port->fifosize	= 512;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_MPC52xx_CONSOLE);
 	port->iotype	= UPIO_MEM;
 	port->flags	= UPF_BOOT_AUTOCONF |
 			  (uart_console(port) ? 0 : UPF_IOREMAP);
-- 
2.24.0

