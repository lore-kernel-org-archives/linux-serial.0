Return-Path: <SRS0=+zim=5T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D4DC2BA17
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A8D2073B
	for <linux-serial@archiver.kernel.org>; Fri,  3 Apr 2020 09:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="x21dt5c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390622AbgDCJZH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 3 Apr 2020 05:25:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53800 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390573AbgDCJYv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 3 Apr 2020 05:24:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id d77so6425613wmd.3
        for <linux-serial@vger.kernel.org>; Fri, 03 Apr 2020 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4X9CztVv9fuiwGgU0m8a6G5JZzhVQteYALGdpAp1X0=;
        b=x21dt5c2oqbttSzIm/GZIb7/QsS3KtZXZgyAyN2Xse45a99hSr5eVgqq8spcF/SQVZ
         qgUF+VQ2qONzOO5CUInCWe31mzt1Pv6h2KZuLurNrhWbwpy6uX01/UbRSdVBblHnX7cA
         r/iiLD1ddJETbqB2QE056DrI7zCE/qV9RKnbcw90CmmICoXI8uvPks8pYHxIz+O0m/sX
         OfdeiUcVZGhPXh8CuLTDR204+4VnRHn5enAMclLlGS/7udW/kt1i8VTyEDNzRi3o0e3U
         4aQsJIlGVSHkMH99GVa84vSMxbqoyFMOuGJWX/TsCY4AIYBhF33LEjC0DrF969HuKROL
         JP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Z4X9CztVv9fuiwGgU0m8a6G5JZzhVQteYALGdpAp1X0=;
        b=jpE2w7YwhqR+9gsJrTsGc3YHAqz7t+GUhfyUc4sTm+WLEcjebDREqK6Is+lft6lZre
         PLaGh2CO4rfAKgQoqtJfkYoDm7Wn6gwRWbvl4/VOzt7YUneXf22puZsJ4Fxk6Z2e/UAx
         GVwu1qP/Mn4eSJ2zOuFD5vooyeodSoGiI0Gv320iHUYpAShVEZOjxeA5O8HfM0p0/eB8
         Dcg1jHOC5TxN7wzXmeLAUl/dvYcCyRmkbe8UF9LJ67DCxEN9DInlyOba9yUJa5Zxryzs
         QiVSV63muplPVC9OsxlIk3TCRr9LnqzU2dEKUoKl7JHdQagHKucdhZHmfgavqne2hCtE
         Zyyg==
X-Gm-Message-State: AGi0Pua9rh0dhnkR7AhosZHrfe40IiZiLOnJInAOWCl0W8+kA3TJYDW5
        GsBvZT0xVFMX1b72CXyy1MQtXQ==
X-Google-Smtp-Source: APiQypLXsFB4Nhp1P6wz0oWS1uTO4dCw50x90jze73F6lCQ9haNDHgdotGFAdwgjiq807zSRUQZjiA==
X-Received: by 2002:a7b:c452:: with SMTP id l18mr8086444wmi.140.1585905888590;
        Fri, 03 Apr 2020 02:24:48 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q4sm14554079wmj.1.2020.04.03.02.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 02:24:48 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org
Subject: [PATCH 4/7] Revert "serial: uartps: Do not allow use aliases >= MAX_UART_INSTANCES"
Date:   Fri,  3 Apr 2020 11:24:33 +0200
Message-Id: <dac3898e3e32d963f357fb436ac9a7ac3cbcf933.1585905873.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585905873.git.michal.simek@xilinx.com>
References: <cover.1585905873.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 2088cfd882d0403609bdf426e9b24372fe1b8337.

As Johan says, this driver needs a lot more work and these changes are
only going in the wrong direction:
  https://lkml.kernel.org/r/20190523091839.GC568@localhost

Reported-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 412bfc51f546..9db3cd120057 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1712,8 +1712,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	uart_unregister_driver(cdns_uart_data->cdns_uart_driver);
 err_out_id:
 	mutex_lock(&bitmap_lock);
-	if (cdns_uart_data->id < MAX_UART_INSTANCES)
-		clear_bit(cdns_uart_data->id, bitmap);
+	clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	return rc;
 }
@@ -1738,8 +1737,7 @@ static int cdns_uart_remove(struct platform_device *pdev)
 	rc = uart_remove_one_port(cdns_uart_data->cdns_uart_driver, port);
 	port->mapbase = 0;
 	mutex_lock(&bitmap_lock);
-	if (cdns_uart_data->id < MAX_UART_INSTANCES)
-		clear_bit(cdns_uart_data->id, bitmap);
+	clear_bit(cdns_uart_data->id, bitmap);
 	mutex_unlock(&bitmap_lock);
 	clk_disable_unprepare(cdns_uart_data->uartclk);
 	clk_disable_unprepare(cdns_uart_data->pclk);
-- 
2.26.0

