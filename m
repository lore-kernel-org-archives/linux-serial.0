Return-Path: <SRS0=da9C=AL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB43C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 30 Jun 2020 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD19206CB
	for <linux-serial@archiver.kernel.org>; Tue, 30 Jun 2020 23:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A08aIEHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgF3XmX (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgF3XmX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 30 Jun 2020 19:42:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D7C03E979
        for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2020 16:42:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b14so17686995ybq.3
        for <linux-serial@vger.kernel.org>; Tue, 30 Jun 2020 16:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n7raTtIxzIsyGs4VWsPeosbmDVfxOPL6Kt3Xxdq+NzQ=;
        b=A08aIEHFxec2io4UGF3QU20z0l2BqR3XRZdtO0deY3xpDvUVhgUsaEA0fEJq8xLVv1
         8iCEpYwHEW+DpYTAYAhmywuVfaUUvalvMif/YEaUBGSUyzVMqL63Rsp0U5Ru387tHPZ+
         /fUOjy+s+z1U8vdgIPpCtI/0xDh2YjITOMhhvLn43fEsd8+265yQGgrr2glqwnWDdJ8K
         uz6cuejZtMwVxmLDE78AoZpJAyRmOBqX3S9faTinh0d0+P8tC+NoQk3w7V4yXR3zn5pI
         dR94lL+K0Kfj/bjLrk6DNrWqlH2Zk40NlXWbGZtj95aLheVuSpxG3LAHfny/GIJwuRr3
         YTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n7raTtIxzIsyGs4VWsPeosbmDVfxOPL6Kt3Xxdq+NzQ=;
        b=OzUpd79iGWThA7aZACw2F5R5ifiBGoZhW7bq2BLiMstT3Fswmj+tK/cX6ife2V1saP
         C+7LJxS0N+E2witrWXsIpug+8pVC3ZspHwVT6vOhqiJjIaxmbStAgdQ9FdM/w/rNm++n
         XaBPJ++cXqO6SQ6/k+PMJta46EO1ZqFvlJnYGQ5jCh2S9xsgVmKuYPnWiwQGk6RSeFNy
         te4whSqqtxHNaWIEB7Sgv8kaJfFORhwM41b3i1DV+TRy0JDwUyynnf8ggUTdqxnZzOo4
         h9pU3UwefySqpxMBAucrpLBScw5lvh6Z269Z98PY0g89RT/NyPu2MoJlsOlalvYAOy2C
         yJnw==
X-Gm-Message-State: AOAM533FBw97SLSAD/e7HH6WFJ9NDjWUnRf9E7i5L3kbn3AHEJzThi2m
        TBtmfJSV9zJMVTcAer/w30zaG0d2LxcKa0+agwe/qqo3W08syqjeW1YAE/m05A8h8LEhEqsrkKa
        xrt5wvlxbwYKJSiw1RWvUsB2K1Ke+VJgqlZv6Je5mQBAUdxpdntrQYJqHlHNnY8wjy0+PXYDBY6
        r4Cptrt+gQMPyG
X-Google-Smtp-Source: ABdhPJywusfTFjpLcjnVuDSLKVbrHofdt3NFwsfza8+5TL1nTp3jEw6krmAW8VgpGWoTnARjWoermlh95MMUneiy1oeH
X-Received: by 2002:a25:5d04:: with SMTP id r4mr35391905ybb.290.1593560542263;
 Tue, 30 Jun 2020 16:42:22 -0700 (PDT)
Date:   Tue, 30 Jun 2020 16:42:11 -0700
Message-Id: <20200630164204.1.I2cc415fa5793b3e55acfd521ba8f0a71e79aa5f1@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] Revert "serial: 8250: Fix max baud limit in generic 8250 port"
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     chromeos-bluetooth-upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Lukas Wunner <lukas@wunner.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit 0eeaf62981ecc79e8395ca8caa1570eaf3a12257.

The change regresses the QCA6174A-3 bluetooth chip, preventing
firmware from being properly loaded. We have verified that without
this patch, the chip works as intended.

Signed-off-by: Daniel Winkler <danielwinkler@google.com>
---

 drivers/tty/serial/8250/8250_port.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1632f7d25acca..e057c65ac1580 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2618,8 +2618,6 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 					     struct ktermios *termios,
 					     struct ktermios *old)
 {
-	unsigned int tolerance = port->uartclk / 100;
-
 	/*
 	 * Ask the core to calculate the divisor for us.
 	 * Allow 1% tolerance at the upper limit so uart clks marginally
@@ -2628,7 +2626,7 @@ static unsigned int serial8250_get_baud_rate(struct uart_port *port,
 	 */
 	return uart_get_baud_rate(port, termios, old,
 				  port->uartclk / 16 / UART_DIV_MAX,
-				  (port->uartclk + tolerance) / 16);
+				  port->uartclk);
 }
 
 void
-- 
2.27.0.212.ge8ba1cc988-goog

