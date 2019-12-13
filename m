Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9553C2D0CA
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0DA24671
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="opcG6ew6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbfLMAHr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39163 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731529AbfLMAHr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:47 -0500
Received: by mail-pj1-f66.google.com with SMTP id v93so340011pjb.6
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfdmzXy/tr/5l8uacjPRcN2UZbf1ukI0DlMsU/05qw8=;
        b=opcG6ew61EJlu0r95XGFc0PBlPnVEbSyEkZ/PnI0ZvDTlp8HFvlbBEpZ9Gmby6WJ0o
         x8dQuRBaYdcXvyeYkznLCRWgFHDGqR1VbOOMOGTvCjB5DlZjpFQtxm4YeMy4IkPYUs7z
         yZHrw0L5pC6ttRfVAYC+2s644nfuroRAZF9+/tTrtwJPka0wffAN7KgsM3kqP0uoMB3/
         4+FWHzUY2je/bHI/bUhTicfSETJmPN3Bsp4uocM8WmmJu93OHA60j+Z9ozh13FmFzye1
         mHNxKrvWgHUaUw2N20lHh80X1chtCvQwlCSTqjjLbG3i0kbgPq2y7ddSNEvW86fOwASf
         ppcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfdmzXy/tr/5l8uacjPRcN2UZbf1ukI0DlMsU/05qw8=;
        b=dO/2mveXNmM+lWzlGFJd930pzL7r1HVbylADrCbLCBmVXCi7v97f9lWKQ2z0Juo3FV
         kjhwMlEvvd/x6UkanmuH5Lr+9hPXh9RkTNX2O048mr+RAKE3wFnMIsC6CEkLyh+HJ1iP
         wYAUS9dFMmSUUCbXlko0Bf5YjWTLdohh4uJ5pskmTN35Ddgv6CwTiMHieql3g+V2q9pr
         vtdR6epAmAQU4uI/Y31aZFyYBlL+5h0IP0roXYBpebHqrypQIg1HL3d6xEV00gILV/qm
         qUXSixGSM9zY8bcto3520Y89dmbx750Mxy0Z5GZW+HJxj8sTm0pXaEUtW47Zu4Mg9E6A
         6H5g==
X-Gm-Message-State: APjAAAV/gNXScCpnF+qKE8e2fxiMvYK+3vXeO+miwvqY359fa+qCxxBJ
        EqQ/AjtF3W4i4bgrkixf0bGJJA==
X-Google-Smtp-Source: APXvYqxw5XZn4UQX0vr1Ac16jLp4hYP0SiJLcSrh0Xn/J4KufxFS6+XB4I5Rh8TAOkkESDtUbglbyg==
X-Received: by 2002:a17:90a:6346:: with SMTP id v6mr12974695pjs.51.1576195666067;
        Thu, 12 Dec 2019 16:07:46 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:45 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 11/58] tty/serial: Migrate arc_uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:10 +0000
Message-Id: <20191213000657.931618-12-dima@arista.com>
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

Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/arc_uart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index d904a3a345e7..17c3fc398fc6 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -21,10 +21,6 @@
  *  -check if sysreq works
  */
 
-#if defined(CONFIG_SERIAL_ARC_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/module.h>
 #include <linux/serial.h>
 #include <linux/console.h>
@@ -625,6 +621,7 @@ static int arc_serial_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->line = dev_id;
 	port->ops = &arc_serial_pops;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ARC_CONSOLE);
 
 	port->fifosize = ARC_UART_TX_FIFO_SIZE;
 
-- 
2.24.0

