Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E92C43603
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66A1206E2
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kOAr/bES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfLMAHe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:07:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41171 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbfLMAHd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:07:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so380790pfd.8
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfbwjaEyczfW16aq2QbabEEFZwH6hIDwc8GGJT+n3VM=;
        b=kOAr/bESfHMzyhYULKoN7VTqNnOTJpMU0mgk421XezJV5Q1gVDfIowuDsypTlEeG+4
         Wv3ZxkAmjMRDkhkz30epuMui2pMMycipsnvSCcLAfWGgUChLIeG/qDfWA9Q5c9HHwy3u
         XAlGyFETvlNhDdukDWBLxJ3ostWQiTIcZ3rZtZZPz94kuRfPi5qohj+AZPRrHu4PG7dM
         o+S3j4QcHD9ZfqK/MTsu7PgJDr1N/S9YMcvdGzdFkIYDj2yaiJG8g4VE08ogTZnSEJPQ
         9Vys6Ais6lUp/4Io5DC91M9R6TqEdsKDjuzM6Qi7g6M3B8HlP6w/+TdGlLnfzkSYyT8z
         TSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfbwjaEyczfW16aq2QbabEEFZwH6hIDwc8GGJT+n3VM=;
        b=OjF2mXEaSAc83m5QATRIdLAjbWXqulj6QxOkx4/BlYorhlW0VW+ZEhjiyFY5ckdrnD
         onsD7YQT1yB57x6W743vu70UYaFOEO2Ie3gi16MhIOigt3PrxLWfRqH5WUwaZ0//E417
         GmWU637r+1MGVw6Rbh4RFaKnb2IjEBIWJRWEQn6LjeiRS+jrRH1Vp1dBT2PicdhnxDLK
         iVhbUJY/Sg7p+Krq61ASQ0fVtCPagvWfxmNFuGbiCNvJYwW09r8XiSKBtRhYKnuChzFs
         Uon4tCAG6hoHK+YLlXnYJzC9o3VrxeBSSMVK+1MNfc3esETV3cVzxX8YOdcjPyPH/CL2
         yazQ==
X-Gm-Message-State: APjAAAVITPdotOUv5GcPBvSRB796ivBFauliB+geBeATAEaWj2v9vTh7
        wjzphOCsnGu1HiRjpLZdrGqUuQ==
X-Google-Smtp-Source: APXvYqx9E42sVqpByu4dIZemxH7OmhQpFJLjLb3D8cu5jSrISXChsfZ8EkNjZPIX76mtZROIdvfiIQ==
X-Received: by 2002:a62:b60c:: with SMTP id j12mr13118959pff.8.1576195652339;
        Thu, 12 Dec 2019 16:07:32 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:07:31 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/58] tty/serial: Migrate bcm63xx_uart to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:05 +0000
Message-Id: <20191213000657.931618-7-dima@arista.com>
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

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/bcm63xx_uart.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index b7adc6127b3d..5674da2b76f0 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -10,10 +10,6 @@
  * my board.
  */
 
-#if defined(CONFIG_SERIAL_BCM63XX_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
@@ -858,6 +854,7 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	port->fifosize = 16;
 	port->uartclk = clk_get_rate(clk) / 2;
 	port->line = pdev->id;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_BCM63XX_CONSOLE);
 	clk_put(clk);
 
 	ret = uart_add_one_port(&bcm_uart_driver, port);
-- 
2.24.0

