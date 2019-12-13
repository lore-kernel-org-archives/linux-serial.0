Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC0C2D0C9
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C586206E2
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MwyEdNtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfLMAJZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:25 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34102 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731840AbfLMAJZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id j11so355236pjs.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2sVyEICGfKf72nEjPqSRaSmfvJt+VQfuvvM6oc7m9s=;
        b=MwyEdNtFfmjQZoB27Q0dIhnKa/eRsscBYXgN6mThQHZ0xuN2ZLNKi6ckLFpOQcPk+I
         NEzKUZY20I58iWtE45s2LmQvI8w3hNRVu//WpT5ZtNqDzUOxrG64HmkEASgMeCHQTYsF
         BERyiqKnSCv+Ntjq+29FADDKOnA7VRMDTnxpTxarc8+nLThS9SCFZDQDKEgOxRraWxtc
         mDUv5ABTRatRqAX5ufBfjct3CXHzkTHAAHIy1M6tlMHU59duHo5mn7JSUfcm8cmLplf2
         wmacPO5wGfnv2SXChdmY0aR2WF1f1/LIscRo2PIXHQtebaWsP6SCeTlACqAjfLxoowH2
         7pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2sVyEICGfKf72nEjPqSRaSmfvJt+VQfuvvM6oc7m9s=;
        b=AstslU+czebR0BY/08WOiwCx89UUG82d1O1fKCA8SDNxwSq6eIoKEONeOGSuCUxmLS
         zry/jN7cOoxoRrNwEcRxIFTVXtnuwEeSyHkeR271mC/Ib7E8njNOxFY/m9ishYVsxkmt
         ZqA1/kQgmWS8NsXGjjrRpdJ09AdIVs3hfhLFkMb3Wg0s8krC1Xk0962ihaGRfwtlIjmy
         C9N4lyIRJs8RZU++2Vu2MSuLs/NkeZsJp6oGmwnii+1hug/PrNI7cg+hkR8K7j6xBFem
         7/jEQDivPCiErtdwtNSDXXM06WdtkekaVukLlTAGrgfSXnwtu/Xi5+huvr/raPlfX7kU
         HV7Q==
X-Gm-Message-State: APjAAAWyX2L7vhatVLakO3dHLXm/a/viEXY9Z1nDuRJYhSAIpzW/Wma9
        1ZkH52bj5iPv8/5yAbCgEomJLsIq2I4=
X-Google-Smtp-Source: APXvYqyKleyWMddswHphitVEN0hVZKzYGZZEyMMWwvlQN495NyB0mhwoFp63U+7Ic280YNH9xNzNyQ==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr13557645pjz.116.1576195764822;
        Thu, 12 Dec 2019 16:09:24 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:23 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 44/58] tty/serial: Migrate stm32-usart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:43 +0000
Message-Id: <20191213000657.931618-45-dima@arista.com>
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

Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/stm32-usart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 2f72514d63ed..5e93e8d40f59 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -8,10 +8,6 @@
  * Inspired by st-asc.c from STMicroelectronics (c)
  */
 
-#if defined(CONFIG_SERIAL_STM32_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/delay.h>
@@ -926,6 +922,7 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
 	port->fifosize	= stm32port->info->cfg.fifosize;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_STM32_CONSOLE);
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0)
-- 
2.24.0

