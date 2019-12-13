Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59950C43603
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3252073B
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="I+MIep7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbfLMAKU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:10:20 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46804 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731882AbfLMAJn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id k20so371938pll.13
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1hswEx2x16MZg3+wDm34G7hX0t+6S82ALeLREnIqNI=;
        b=I+MIep7ItOXumU24ng/GyM9a7ltKAp6dkShxqK9wAVtQKd1MMVjtKEXTNYDA+BihOc
         J7NyR38T+KMaxkIoFMz9N7EDDKKgsV4ePu75mYUJrAgz45yNC/QR7b+hOIlqxb+tDRwE
         elvi0laNYNd9atPasKFN8Zv1vQU2NPyA8qvOdwK+/WRWzmgFxmLIM+qKbdmnIa7BKncb
         fNpAKO5vmCPaM9Z0xatNN2tRdg9WMvgut3z7+QjboxXDx1zAehLeYZMQoFnkoJnaPzH7
         fEkJjsaCR2yX8eDu0t8MUhuj7Bt2XGrfao2gVmue+/W/i10Ed545dS72OL49/WmTcAfx
         4sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1hswEx2x16MZg3+wDm34G7hX0t+6S82ALeLREnIqNI=;
        b=VcEv2aVR++8EVrzrm2Lsw5rFBIzdU6yS/Y3p3EDWxVFeajEduX00EZRv1xq9YdLXrL
         QznYxH9zKkfOFvgzl5I1f7YojR7ZOHQO7sINqzjACWJifEBg1fxMoSLir2cVeSeoMnCu
         vRf17xxLz0ROSW76GKNY7hW6f4gU+SH4g0AHKp9BKZtWlXORnc1C86ZzzS/xg4ky8PSG
         YXInB03qymJ1cuc/oxCQo6SpqUyIGIeay09j/8+BL0rkVN9vJ8ET6Mvkoam3S9Azp5E/
         jNH7A7Nway7a7gYP1fspFDFAfGWl9UpA6mqu/zGz7St68gE4PK3DxSJ4uURidq6xOqES
         3NkA==
X-Gm-Message-State: APjAAAULDjkSVB4WuRXEgXbFlRsk8CDbWZdi5OfuHfW2LCKJb2gXzlCe
        guSPMyRH+sAZ67+SqtvitbBC1Q==
X-Google-Smtp-Source: APXvYqw0EJa5ClivPVkgMXHfBEu9Z0IvagnSOcvWrhNhKfyBhx4nsaI6cRdF6xZPH2fPRrhHMtpQ1w==
X-Received: by 2002:a17:90b:1115:: with SMTP id gi21mr13212775pjb.95.1576195782898;
        Thu, 12 Dec 2019 16:09:42 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:42 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: [PATCH 50/58] tty/serial: Migrate vr41xx_siu to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:49 +0000
Message-Id: <20191213000657.931618-51-dima@arista.com>
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
 drivers/tty/serial/vr41xx_siu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vr41xx_siu.c b/drivers/tty/serial/vr41xx_siu.c
index 6d106e33f842..eeb4b6568776 100644
--- a/drivers/tty/serial/vr41xx_siu.c
+++ b/drivers/tty/serial/vr41xx_siu.c
@@ -7,10 +7,6 @@
  *  Based on drivers/serial/8250.c, by Russell King.
  */
 
-#if defined(CONFIG_SERIAL_VR41XX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/console.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -869,6 +865,7 @@ static int siu_probe(struct platform_device *dev)
 		port = &siu_uart_ports[i];
 		port->ops = &siu_uart_ops;
 		port->dev = &dev->dev;
+		port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_VR41XX_CONSOLE);
 
 		retval = uart_add_one_port(&siu_uart_driver, port);
 		if (retval < 0) {
-- 
2.24.0

