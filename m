Return-Path: <SRS0=T9rn=2D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8456C2D0C9
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4CD24679
	for <linux-serial@archiver.kernel.org>; Fri, 13 Dec 2019 00:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ZjM0WASa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbfLMAJr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Dec 2019 19:09:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38620 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbfLMAJq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Dec 2019 19:09:46 -0500
Received: by mail-pl1-f195.google.com with SMTP id a17so389283pls.5
        for <linux-serial@vger.kernel.org>; Thu, 12 Dec 2019 16:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJ2E958f/h3TR+z5z75agqEzfHRfr6uCgt8ddQ7s9q0=;
        b=ZjM0WASaUm3158P4aA/qSMiTuTxfZ0g0mnaqn6VQq2A9gp6x/kr2DPY2osBTrCcVOO
         FeYDIGvkRgR0Sy5Q0c1XfmA+b3xVl+ueMcEQh0SoGPRMO6pVb8czVwHzeq7CUyRD+R3K
         lsV9Q19RCUEugmfP4IvdYTo19nBAln4FxkhUGA5wX2vsbw/JmDbXxp01HZ6SDbJzrfU7
         0akXweakNMC1T9n7nvsK5kVEWHoAWNVX4nFsj/KGnM6kYZ2YjiUIuNWQaAVq6mKZuCj2
         Y+EBqOIvzO8p7Yc0T4LHsb5dM9dv2cK30fFPspQT5Tu+lkaIi0WPXm19b4/Z/4nbIFT/
         4QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJ2E958f/h3TR+z5z75agqEzfHRfr6uCgt8ddQ7s9q0=;
        b=qUYAXW1YLbOjd1VNgJvV+usF1DOxQ6PlZ5G28SaWWDlhfSQWso+ZfOevXG/HAoCI2B
         KxVcPJmcz7TyoFi/Z0EezlmIoJE1P6sitxyhg8LYD4ocSUhh/xnYjm6G7SnPt/sgIQEx
         jKde7ZRkHucPBczAbFmVVDYPRfWOuBk69JKgi+CCLOs4k6rBAHA85XzFpx8x5Bm1BCzy
         HCfAieJOH5dNVzJ+o4KzvNjBwfuvCBJ/bQmgfZ9Ma79kfPuy0LFuew49wMe52t/iTdnK
         o6ZwOfKRs8Vx/1LpjD9tF0mLpCjlL3nY90Mq32Pu778yq/bSX603EGA/PpL6MQXzPWys
         tifg==
X-Gm-Message-State: APjAAAVl5fsBiVAxyZMSFxL2Da7fRtfJ3TbWQQJtolnr+r+EDppAJk5I
        Jk5DSOPvv52W6viPbzH9aYuK9A==
X-Google-Smtp-Source: APXvYqwDYZCTcPhfGFZk4d1JFI8jcLKengT8YOjdiZDuy9hSDm/wiYpEsgokOMWWQd/YlA9PdVg2Rw==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr13017685pjb.125.1576195785826;
        Thu, 12 Dec 2019 16:09:45 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j38sm8317647pgj.27.2019.12.12.16.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:09:45 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 51/58] tty/serial: Migrate vt8500_serial to use has_sysrq
Date:   Fri, 13 Dec 2019 00:06:50 +0000
Message-Id: <20191213000657.931618-52-dima@arista.com>
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

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/vt8500_serial.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 3d58e9b34553..764e992438b2 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -7,10 +7,6 @@
  * Author: Robert Love <rlove@google.com>
  */
 
-#if defined(CONFIG_SERIAL_VT8500_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-# define SUPPORT_SYSRQ
-#endif
-
 #include <linux/hrtimer.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -703,6 +699,7 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	vt8500_port->uart.line = port;
 	vt8500_port->uart.dev = &pdev->dev;
 	vt8500_port->uart.flags = UPF_IOREMAP | UPF_BOOT_AUTOCONF;
+	vt8500_port->uart.has_sysrq = IS_ENABLED(CONFIG_SERIAL_VT8500_CONSOLE);
 
 	/* Serial core uses the magic "16" everywhere - adjust for it */
 	vt8500_port->uart.uartclk = 16 * clk_get_rate(vt8500_port->clk) /
-- 
2.24.0

