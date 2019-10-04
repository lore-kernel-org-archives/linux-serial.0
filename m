Return-Path: <SRS0=XuIp=X5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919D9C47404
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 13:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A2A21D81
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 13:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="hpoO5wzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbfJDNEV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:04:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34876 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387648AbfJDNEU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Oct 2019 09:04:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id y21so5788291wmi.0
        for <linux-serial@vger.kernel.org>; Fri, 04 Oct 2019 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=6cIhPqLGXV0mIo22OdHVVmjhEt+X44Ftc/dasgZTMCs=;
        b=hpoO5wzoB7KyTA/SQfRaeG7/oLKsQ58wZ42OaVoyWiIuaNrP3ojQCLTM6Qi1Os8oVU
         gno3cKeIwu3sgjAYBg0U5SUthfJc5wm17kx7XBXK6QfQIrBE+FqdPaBXiNQhPgwLLcYY
         nrPfVJuOP48R51bTr642p3RTh9H13FhJUlQipT32PF+iMqUGbDI+CDxyaHhij0AOEbNJ
         yL64ZXuPRZOJKQt66P/bglx8xcRhhDzF0sHLPp2AXmg0Cyfv9a6BF+CJB1xn9qi830D4
         CE4hzw9bv7ykYTO2yGyM/CuDTsRdodyZMwo94BD6Dsw/NdfGtKB93TJxJS4M6i0TEUNZ
         b5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=6cIhPqLGXV0mIo22OdHVVmjhEt+X44Ftc/dasgZTMCs=;
        b=ReIc2CfVgtPTi+2nwENnyoQ56T8Ow6pVBBLrEIYSLEAtUoXYfEZVbZjmvk/ihejUbH
         yrE94DikwwI4lv8qXU1B1bQRPZKmnr4pN2Zf8rqqiJ4JInHHGv14T1r8pGRm+yikkxpj
         TuaWR+RwZkBy7Y/HdLRzZBpUNQsMB9eMUffABgCN4BfV2DhD+km/v0vOqYGSEmlktdta
         NeWKBc6fEzaTzNgc10kfn7+WKHCeIZKu98qpDfai7i8on3a9eqPSr4zgRK6NYIxTsARX
         a+ZJgfiK1C7snB8htq0hrYZAoWNKk3G0wGispZ+W1fhDnQRNTKmjqZJiLC57zfU1M7DF
         GoCQ==
X-Gm-Message-State: APjAAAUCgBXuiX6HTc4cflCRSEKOBcAg6bVjvvfhTDvDDidr7jN1xAen
        9pto9uFMV7B+I/XnhS1emV4wGA==
X-Google-Smtp-Source: APXvYqxPR021c5nzAa3KiGUN5im5Lql/MqfwT4I/CSWRooJDFbWaUR+S79zSEnZdyii+AYqY+9npIw==
X-Received: by 2002:a7b:c088:: with SMTP id r8mr11524493wmh.44.1570194257479;
        Fri, 04 Oct 2019 06:04:17 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id v16sm5662064wrt.12.2019.10.04.06.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 06:04:16 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Paul Thomas <pthomas8589@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Subject: [PATCH v2] serial: uartps: Fix uartps_major handling
Date:   Fri,  4 Oct 2019 15:04:11 +0200
Message-Id:
 <d2652cda992833315c4f96f06953eb547f928918.1570194248.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20191004130411.bAwhqLvVcN-99wXDmD7fTxVhK21D0DrShbBUVJxR4ZM@z>

There are two parts which should be fixed. The first one is to assigned
uartps_major at the end of probe() to avoid complicated logic when
something fails.
The second part is initialized uartps_major number to 0 when last device is
removed. This will ensure that on next probe driver will ask for new
dynamic major number.

Fixes: ab262666018d ("serial: uartps: Use the same dynamic major number for all ports")
Reported-by: Paul Thomas <pthomas8589@gmail.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Use sha1 from Linus tree not stable tree

 drivers/tty/serial/xilinx_uartps.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index da4563aaaf5c..4e55bc327a54 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1550,7 +1550,6 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		goto err_out_id;
 	}
 
-	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cdns_uart_driver = cdns_uart_uart_driver;
 
 	/*
@@ -1680,6 +1679,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
+	uartps_major = cdns_uart_uart_driver->tty_driver->major;
 	cdns_uart_data->cts_override = of_property_read_bool(pdev->dev.of_node,
 							     "cts-override");
 	return 0;
@@ -1741,6 +1741,12 @@ static int cdns_uart_remove(struct platform_device *pdev)
 		console_port = NULL;
 #endif
 
+	/* If this is last instance major number should be initialized */
+	mutex_lock(&bitmap_lock);
+	if (bitmap_empty(bitmap, MAX_UART_INSTANCES))
+		uartps_major = 0;
+	mutex_unlock(&bitmap_lock);
+
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 	return rc;
 }
-- 
2.17.1

