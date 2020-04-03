Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738C9C43331
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448F52080C
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="f28+6tql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbgDCJYt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:24:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37174 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390553AbgDCJYs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id j19so6899406wmi.2
        for <linux-serial@vger.kernel.org>; Fri, 03 Apr 2020 02:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UaJ/lm5B5irKRGuIGTcEW0nphrhQofKG2JxuS3fPTck=;
        b=f28+6tql43/Og7YGE8QTKNY9YPKkmPSkA+oKKSYv9PYyJk6WLaNxmW+YlH3qxlDr/Y
         NwnNRpNUWshiEO1F2NA9HHwJlKRUO8nEh+aOlZmS+LrNiLbjIT7ufQZHrX4TvhpHfZkI
         eM6vAJMjRTP2Yw1s7oqpT7/+9L3SokP2UXtfrN9ctVvWISHTB8D+4nQeNDu4HxTCuetr
         t9dBAJLDPx6kxzJNAhM9musdk4HAzpV7+ks6Zk9I3tASV6va7WiUVtiVT29gQvATkI6G
         MbVaLSngt0wG/uPQh8uWWdtqvbBBp397PfEIF8+UldkSINWALAXe/VGA9pJGvL5pD4vy
         neAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UaJ/lm5B5irKRGuIGTcEW0nphrhQofKG2JxuS3fPTck=;
        b=oYd6nhgGI/pD+Sh/zts1Hg5rAYr8s8vAHPQgHGmdPFtGafEyNLGPh6yr7cmtgS0fTP
         +lHZvNlz1YcH5UIFeiCjD0B/15Lde2u56Nx7yfRmqKUaK07UHxvYPbRgm0tABSN9rcMW
         pLMAsJ6BZTIdpLKTYw+2VEOkcN9O7S3b9l4P+j8ExMu21+ItpYdyayBphZhzbdz2AA6l
         viG8h6UDGXg4UK2X/60g4ENij1ye7giycPW0uL9e6sXN2FzBynCNueXeHgt6RNsk/q+p
         X0rpNH/eu2MH2XweIk2xeCNgOQe+9e7x8qwOANFHsfxMqJb5Lmkc4Vxkz3oYlbEcZrqH
         +f1w==
X-Gm-Message-State: AGi0Pube+nZ8yfP3u5ZuT3Tcgp2W6cIp0pJ87YQ4K6WqBfMZsXuGXhR9
        XShRfEkN3luRFMUc093fXw8bQA==
X-Google-Smtp-Source: APiQypKIfR0UUqDSY/h923iNyVZubvQ21RncjnJGFJLtdFqhHyi/SNSGNn8LFm3qvKctOPC0FGERzw==
X-Received: by 2002:a1c:c3c3:: with SMTP id t186mr8070012wmf.118.1585905886912;
        Fri, 03 Apr 2020 02:24:46 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z3sm10332947wma.22.2020.04.03.02.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:46 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 3/7] Revert "serial: uartps: Fix error path when alloc failed"
Date:   Fri,  3 Apr 2020 11:24:32 +0200
Message-Id: <46cd7f039db847c08baa6508edd7854f7c8ff80f.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 32cf21ac4edd6c0d5b9614368a83bcdc68acb031.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4e3fefa70b56..412bfc51f546 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1542,10 +1542,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 	cdns_uart_console = devm_kzalloc(&pdev->dev, sizeof(*cdns_uart_console),
 					 GFP_KERNEL);
-	if (!cdns_uart_console) {
-		rc = -ENOMEM;
-		goto err_out_id;
-	}
+	if (!cdns_uart_console)
+		return -ENOMEM;
 
 	strncpy(cdns_uart_console->name, CDNS_UART_TTY_NAME,
 		sizeof(cdns_uart_console->name));
-- 
2.26.0

