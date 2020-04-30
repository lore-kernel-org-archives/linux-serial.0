Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052EAC83001
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 08:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F962073E
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 08:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="OU5l9pzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgD3IL1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgD3IL0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Apr 2020 04:11:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6946DC035494
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 01:11:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so5701120wrx.4
        for <linux-serial@vger.kernel.org>; Thu, 30 Apr 2020 01:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2o2Fztfk5W//D3bO+bVikVHBouyFoiJ2j9CyC6fkXWQ=;
        b=OU5l9pzjK2RQxM/eLRsv2chYFmymKQ5mxvF6GfOCys0Xtnj05P4pcSm6uR6bGUDa5P
         UTBh9te0UCO3ieR/1G4plJHfDbekvivY22NAHTT4GQGdU5yIZg+Qrfr1ZsZ7iwEyzFyI
         bfsPbs+2NFYLl/hgTX7ixpfR5v1314z90YVHVHBwhAIbk+sEaCbCERIuzQGY+7iMlNRL
         wWH+u4FfSBG6j7/NmbmpJni6XO3kmQlTF1c3kE6lnfVAl9WhWfDj0CaVx8+GeL9Hq/O6
         2owMONvh/MqWiGdeWn/U5Pq+pCVpwFB93zlr3xOg39sX0xVvx8yAAwpeNgMy6x1v/aGv
         MbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=2o2Fztfk5W//D3bO+bVikVHBouyFoiJ2j9CyC6fkXWQ=;
        b=kCz4EC9tM/QNBJ2z7O8DrQL0vY5+dkaiZF/Z7v76owwoAjS9L5MKCadGT+MZHtUyz3
         zoCtpdi5oMfWVHINcK2R71NXbP1ta/TqAcGohFrbT+enlWgrQJvyeIuf/tDfYeaMETQb
         6DoLBmxhKOg68K2Bo2Mqg3U5UaLUWXJbe5J0vQmR3foNO7epP+KmjKw5/STn6m95JwxF
         YvwPEjxL0cYKHH3aN2XTemMIF1ZqJRwa0Pd0Lhy+SWeBBOTnVtxchgHbVcUwLmRQEAKQ
         +WF3w/13qHLNfDhCENXAGS0QaGsov1+Ud4h6MS2QU4D+eZ0djUFwGYHdWZoHv2a4dvnN
         lBNg==
X-Gm-Message-State: AGi0PuZ3xBdGHewgdo1C2yZHhA9EhTnlFFdYvbNw1XZMAsJejbsrxgIm
        eb3luOLlF/b+aSlZq92Oqj79sA==
X-Google-Smtp-Source: APiQypILYB6i3OfitZOpjN+VgEPWdREhEKMt8Kth4moHZ+k3RT3PZah4rsctCqNQ9LdsMEwFt0izSw==
X-Received: by 2002:adf:b310:: with SMTP id j16mr2555234wrd.95.1588234282987;
        Thu, 30 Apr 2020 01:11:22 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 74sm2992078wrk.30.2020.04.30.01.11.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 01:11:22 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, stable@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH] tty: xilinx_uartps: Add the id to the console
Date:   Thu, 30 Apr 2020 10:11:21 +0200
Message-Id: <06195dc0effe2fb82e264e4faefcfdd6ebc00516.1588234277.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

Update the console index. Once the serial node is found update it to the
console index.

Fixes: 18cc7ac8a28e ("Revert "serial: uartps: Register own uart console and driver structures"")
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Greg: Would be good if you can take this patch to 5.7 and also to stable
trees.
---
 drivers/tty/serial/xilinx_uartps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 672cfa075e28..b9d672af8b65 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1465,6 +1465,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		cdns_uart_uart_driver.nr = CDNS_UART_NR_PORTS;
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 		cdns_uart_uart_driver.cons = &cdns_uart_console;
+		cdns_uart_console.index = id;
 #endif
 
 		rc = uart_register_driver(&cdns_uart_uart_driver);
-- 
2.26.2

