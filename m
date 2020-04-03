Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5E5C2D0E8
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCC52173E
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="nqXDAcA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbgDCJYt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45390 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgDCJYs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id t7so7606070wrw.12
        for <linux-serial@vger.kernel.org>; Fri, 03 Apr 2020 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ew63BkEv/kfxHpMMNdikCR0PEHDgqdNqoqdmac2PSKA=;
        b=nqXDAcA18svfS3jZNCR7amAzTEV4XFdGl7xmK2DqvINR+SkL1t+v8YLTMfgVloHqWn
         E2/RWW/BQ2XYUiz4jg7loCIE4ACzMxBNacaqILqfCpg6CWfUmNCSvbwQ2nJHKIOD4EaC
         IE1IazZ8GWvVKNxBNCCeSqwDwqBgFI5W/NGHcR1txkEN2m2pIK/JQtar5bhcNw3foAZc
         GJ4WVmIXES9AVisyyi5zFCgUO2nfSx5d+cd6dTJ+ZW10LD7lqG3W+E38k/F2t966o4+v
         oRFbOvLLnMqcSkC63jPYy888YjYcM+ZdkthQDRmWDXqMmIpwKo5ZM6Gd1yuGEs/rnz/r
         /zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ew63BkEv/kfxHpMMNdikCR0PEHDgqdNqoqdmac2PSKA=;
        b=gccQGiZn1PofVE+hjdfGcP0yGQyVO7kmX9WHNcnPScOkm2rMB3oXBFMi5hpKauuMGe
         TcHu4aCuPqCXSLt5LOP3yYBeXsV4KVwDHDiLpDTB+5N1XZLrWb5mDps2HGVO2yDJMNTR
         9h8FwP7NR6x/vq+1OS1WppXPNZSkB/Ax1sU74TXXfEZvw+LvdNqKkflETAgu8k4gxW9K
         eurYP1x7WnUo36ePW/6AaN2YX6ADCK3EaxnFzABaXCCHkfHOTCPaxGk8aYzHuYbXcije
         KlqQUTiqYeCGFwaridEh8+2byJ6GjIBR3fBSxMVSgn3I+5fnFAsOmI5Pm3ma1cGUCAsQ
         evXQ==
X-Gm-Message-State: AGi0PubQnPp5aWBcEFCAuZLIBvRN5jsneTPXkspdAK47xMfA2OMpuRue
        G488plXd3EvNxvvQOCQ7Tq0Eqg==
X-Google-Smtp-Source: APiQypKUEmHsm1YoMsvpKAQDoaPcz47Ucobj2J3VmxgQorhw8miHjx4iVotM1xfJKqJqgSaSIvlvDA==
X-Received: by 2002:adf:e445:: with SMTP id t5mr8138163wrm.352.1585905885230;
        Fri, 03 Apr 2020 02:24:45 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id b6sm11508761wrp.59.2020.04.03.02.24.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:44 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 2/7] Revert "serial: uartps: Use the same dynamic major number for all ports"
Date:   Fri,  3 Apr 2020 11:24:31 +0200
Message-Id: <14a565fc1e14a5ec6cc6a6710deb878ae8305f22.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit ab262666018de6f4e206b021386b93ed0c164316.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index b858fb14833d..4e3fefa70b56 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -26,13 +26,13 @@
 
 #define CDNS_UART_TTY_NAME	"ttyPS"
 #define CDNS_UART_NAME		"xuartps"
+#define CDNS_UART_MAJOR		0	/* use dynamic node allocation */
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
 #define CDNS_UART_REGISTER_SPACE	0x1000
 #define TX_TIMEOUT		500000
 
 /* Rx Trigger level */
 static int rx_trigger_level = 56;
-static int uartps_major;
 module_param(rx_trigger_level, uint, 0444);
 MODULE_PARM_DESC(rx_trigger_level, "Rx trigger level, 1-63 bytes");
 
@@ -1535,7 +1535,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	cdns_uart_uart_driver->owner = THIS_MODULE;
 	cdns_uart_uart_driver->driver_name = driver_name;
 	cdns_uart_uart_driver->dev_name	= CDNS_UART_TTY_NAME;
-	cdns_uart_uart_driver->major = uartps_major;
+	cdns_uart_uart_driver->major = CDNS_UART_MAJOR;
 	cdns_uart_uart_driver->minor = cdns_uart_data->id;
 	cdns_uart_uart_driver->nr = 1;
 
@@ -1564,7 +1564,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_id;
 	}
 
-	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
 
 	/*
-- 
2.26.0

