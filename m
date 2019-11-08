Return-Path: <SRS0=ooY1=ZA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D37C5DF60
	for <linux-serial@archiver.kernel.org>; Fri,  8 Nov 2019 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D575E214DB
	for <linux-serial@archiver.kernel.org>; Fri,  8 Nov 2019 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITi9Uzuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfKHOll (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:41:41 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34646 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKHOll (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Nov 2019 09:41:41 -0500
Received: by mail-ed1-f68.google.com with SMTP id b72so5231262edf.1;
        Fri, 08 Nov 2019 06:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=jqgQDUtm5ZOLrV45scC6kMe64FlNahXYE/bDngjFUZw=;
        b=ITi9UzucKgQ1HuPWbpe8EAo1deMMiEl8oKfI+o9mgtgjXwQHHh/2R976vBIpAhAH1n
         Vq0S/5rrJ0kW26K5JLBelf9FSZLfL5OkTOeCG2Jmh41IrMpS4ELyxQYuXaIQsrsScjoi
         fbnzcaGTpm4HCGwWW5UDoVBNRjaQbad8ZwESeuxO12aqrb4qc5A6e95GUlY0WjNPCMdK
         1eEMW70/S982VwjANZUxElmlJgp3ywyn738OCZjboauYjb0LWzVCPH6FKoGkGiBIMy4s
         xPUDrNcV2JG4ZkhOaqQl8K6+ijY6e5yutx917Yb1ZfASxIImMWwkleIgMiOYjjjYfuHu
         +LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=jqgQDUtm5ZOLrV45scC6kMe64FlNahXYE/bDngjFUZw=;
        b=o/9EZO00GGwiBDU4XYhQsh1+89updf6Gh2Dk7yXgDZ33oDUu2RDmZlZg8COo1SxEKk
         QtJ1csXaQk1yD5sIem425QfzokDiHpS4xGRuiDBNJrkAzhFIJciJhmnaLpgSmBNz55cS
         3Cy8JZEsQCasKwYX7ataPEtp/YE3kdD30Rb0Sm1czIJJk7UTFgkLoJuo8vkA7erUxWMx
         3wCn50bhMBWVbvD80by5OvgM4KWsiBvo+bLGfG1v0AAJPiKFivRa/n8Yi9T1Bwxm8NvR
         2Eutud3Qogdxnt+p8oguYYYTUVSvQJIfHq7qqtUfXgiKjVWNk2L5E2sJ2Fo+mB38DlLX
         QpSA==
X-Gm-Message-State: APjAAAVJUrI+4F0PWaO86gysVaAxMJ6A/n1z2SvHzgKukWv58NrjQKr8
        pbsvNdyq6WSJ67a4l+Qdww0=
X-Google-Smtp-Source: APXvYqyxtV365f42zsFfcSTopr12wL9MbJ4YIALG+KXvuffgmRNBclLxPcr1SkPPGJ9PFY1nH+BaEw==
X-Received: by 2002:a50:950a:: with SMTP id u10mr10789135eda.68.1573224099885;
        Fri, 08 Nov 2019 06:41:39 -0800 (PST)
Received: from [192.168.1.145] (mail.visionsystems.de. [213.209.99.202])
        by smtp.gmail.com with ESMTPSA id c93sm163534edf.92.2019.11.08.06.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:41:39 -0800 (PST)
From:   Falco Hyfing <hyfinglists@gmail.com>
Subject: Minimal patch against TI AM335x UART swallowing the first byte using
 the 8250_omap driver in RS485 mode
To:     linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, giulio.benetti@benettiengineering.com,
        aford173@gmail.com, andrej.skvortzov@gmail.com, sr@denx.de,
        rafael.gago@gmail.com, avistel@gmail.com,
        matwey.kornilov@gmail.com, yegorslists@gmail.com
Message-ID: <249e4532-e7a6-a1f3-499f-8a2beef82f41@gmail.com>
Date:   Fri, 8 Nov 2019 15:41:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I stumbled upon this unresolved issue where the TI AM335x UART is 
sporadically swallowing the first byte using the 8250_omap driver in 
RS485 mode.

Previous discussions of the issue ended on Christmas Eve last year. For 
reference:
https://marc.info/?w=2&r=1&s=fix+clearing+fifos+rs485+mode+again&q=t

As our company plans to move our serial device servers' firmware to an 
upstream kernel version we need a solution for this problem.

I appended a small patch that seems to resolve the issue for our products.

I would like to kindly ask whether you could test this patch with 
various serial hardware that would be affected by this driver.

Kind regards,

     Falco Hyfing
     Software Engineer at VisionSystems GmbH


diff --git a/drivers/tty/serial/8250/8250_port.c 
b/drivers/tty/serial/8250/8250_port.c
index 8407166610ce..25dd44d5f6ff 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1405,7 +1405,8 @@ static void __do_stop_tx_rs485(struct 
uart_8250_port *p)
          * Enable previously disabled RX interrupts.
          */
         if (!(p->port.rs485.flags & SER_RS485_RX_DURING_TX)) {
-               serial8250_clear_and_reinit_fifos(p);
+               serial_port_out(&p->port, UART_FCR, p->fcr |
+                               UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);

                 p->ier |= UART_IER_RLSI | UART_IER_RDI;
                 serial_port_out(&p->port, UART_IER, p->ier);

