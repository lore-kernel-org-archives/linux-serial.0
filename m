Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F149CC2D0E8
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5893206B8
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="pUpI01zC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390291AbgDCJYq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34589 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCJYp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id c195so1621540wme.1
        for <linux-serial@vger.kernel.org>; Fri, 03 Apr 2020 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8JvSInALjg1eXytJe5rJ7Y+P/uCTlj1zhyKbmCjjiPU=;
        b=pUpI01zCKVNQrq5ERO/mla4Lr68bFQ3Zp3lTFlDns9uNpDzBo6DBRHdV3wXllO6+MK
         r8MOVC2B1+QIY2v1njT4H5C1urVQ0FaG0TLLJUn+7A94KPnUz6vAGtFcxFHYAp92MgIr
         NWmjntkMiUFPhZ0NMUoDr/1fWr1ff67ztCp0FChj9ofg7P2UbjbwCDChCkp9sjPa1A52
         OaX6VEPjcT2j/0wiydEp7PX0guLLu4FsSgnSsM++XKv+ycHee2D4zDaCjLLeVlvtfxEo
         S412CFlJjcA5+A49EbeER7Jbg832oxCizJ49k4AMpMgeAxwyAuouNHkrjsrbmoajr+Lg
         eO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8JvSInALjg1eXytJe5rJ7Y+P/uCTlj1zhyKbmCjjiPU=;
        b=lVkJjaPhkaBb1zLHZg+x3wWpiMFGgnfb9stopf7N9SnJGpl3L2kRS/gOl2OjHnx0og
         u+GNsy14zf8x6kupWGCry6YnIh5yiLrUhOkY34bdEEzsvoFsiLLP/n5PxBqSkByXmiD7
         dp80emxFmf98J7Dam7PP0BH8372cNedahIU0DFW/A56V0oXjiwSmuHBXRx3TnUxppkYj
         ENqIAPtHmpkWlV842KgpHqqY0LWU+eagSVzEMW/t+z7w8ArLQkQagUNMD2LVQN7rumun
         qhNrFgmF2iWcdgTq8EghX5EJG9RGMEQ+atdAHF5PZeJdrxAvi5ZckIaPzpoI7Ta5C4ed
         XHmg==
X-Gm-Message-State: AGi0PubJNmaKtC7KFm8JhSKV6igxIug2+/YEQDskT8gH6WSfzOBQ+i9N
        p8kWLVZy/HW/Uv9cUFXi8INJ6A==
X-Google-Smtp-Source: APiQypLTY2q4droXAn+PImr6R7KdJsQTivawrm05+aIHGeYkU4uUUqsytYyy5pUINlGhas6RP3zyRw==
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr8069792wmf.118.1585905883683;
        Fri, 03 Apr 2020 02:24:43 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id s9sm14159903wmc.2.2020.04.03.02.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:43 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 1/7] Revert "serial: uartps: Fix uartps_major handling"
Date:   Fri,  3 Apr 2020 11:24:30 +0200
Message-Id: <310999ab5342f788a7bc1b0e68294d4f052cad07.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 5e9bd2d70ae7c00a95a22994abf1eef728649e64.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
    https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 6b26f767768e..b858fb14833d 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1564,6 +1564,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_id;
 	}
 
+	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
 
 	/*
@@ -1694,7 +1695,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
-	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
 							     "cts-override");
 	return 0;
@@ -1756,12 +1756,6 @@ static int cdns_uart_remove(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
-	/* If this is last instance major number should be initialized */
-	mutex_lock(&bitmap_lock);
-	if (bitmap_empty(bitmap, MAX_UART_INSTANCES))
-		uartps_major = 0;
-	mutex_unlock(&bitmap_lock);
-
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
-- 
2.26.0

