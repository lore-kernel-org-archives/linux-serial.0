Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590CEC4332F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Dec 2022 04:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiLWEYj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Dec 2022 23:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiLWEYc (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Dec 2022 23:24:32 -0500
Received: from gw.atmark-techno.com (gw.atmark-techno.com [13.115.124.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDE82CCBD
        for <linux-serial@vger.kernel.org>; Thu, 22 Dec 2022 20:24:29 -0800 (PST)
Received: from gw.atmark-techno.com (localhost [127.0.0.1])
        by gw.atmark-techno.com (Postfix) with ESMTP id EC6F760111
        for <linux-serial@vger.kernel.org>; Fri, 23 Dec 2022 13:24:28 +0900 (JST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by gw.atmark-techno.com (Postfix) with ESMTPS id 75ADB6010E
        for <linux-serial@vger.kernel.org>; Fri, 23 Dec 2022 13:24:28 +0900 (JST)
Received: by mail-pg1-f200.google.com with SMTP id g1-20020a636b01000000b00479222d9875so2136516pgc.12
        for <linux-serial@vger.kernel.org>; Thu, 22 Dec 2022 20:24:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBDC9ChAeeQBia/ZUlsALV6hFzA+pCEINYLDDXbpoLE=;
        b=iA4ZjC6dRCgCjJXlfo0aeb64MlctBSrMCY3/UAJUKObfTs7CVulzoHF8fbZEeBDSAY
         JUzEnVuyRlQbSm8Ttib7YUDMU7gnLDPe+H4dqpai4T8Cm2sXTgcVxZoESaI1nmUT1Xmi
         qMxYyR1wO7IRcPnscINV8jFt7YXffhmeV54lyF7dTVbQVeR6QekvYltGhJsRmJUkNH9x
         b71q1Zxedhney9LQaRm7/A4Kr9T0IQ8k1EUiMZ4JKA2hr5cL/IIDBGiN6rqJzV2IgzEq
         lrOrCo90bTPY8x1o7wYdpX9mafYYigj8SeGWKUwtgIZxps9BPHD2PJ1p+Onsx5nXEcaJ
         l7xA==
X-Gm-Message-State: AFqh2koxNxT2ZNcl5kT+RFS5BR3/KWfKH75ZBCLeYDcvCpiggr6mhweq
        6/hKuOnubLkDduuPfQTCiSSeIcEsfpxCJ2JqU6GwE7ZBtc28Ee4n00SqrIGC7bW1WMvxOBqI808
        usgigehAWEPXdAS86uWgcgv5CJKaJ
X-Received: by 2002:a17:90b:1989:b0:219:f1a2:b665 with SMTP id mv9-20020a17090b198900b00219f1a2b665mr9786154pjb.5.1671769467527;
        Thu, 22 Dec 2022 20:24:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv7B5arxTkr0s2RS7gyNogNZ7TKCvV+Zp4rTfz1L9JK8wCUpHA+itk2hYbI0HMM53TWY+Hy2g==
X-Received: by 2002:a17:90b:1989:b0:219:f1a2:b665 with SMTP id mv9-20020a17090b198900b00219f1a2b665mr9786138pjb.5.1671769467304;
        Thu, 22 Dec 2022 20:24:27 -0800 (PST)
Received: from pc-zest.atmarktech (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a8c8800b00213c7cf21c0sm1350295pjo.5.2022.12.22.20.24.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Dec 2022 20:24:26 -0800 (PST)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.96)
        (envelope-from <martinet@pc-zest>)
        id 1p8Zbd-00H7dX-0o;
        Fri, 23 Dec 2022 13:24:25 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Daisuke Mizobuchi <mizo@atmark-techno.com>, stable@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PATCH 5.10 2/2] serial: fixup backport of "serial: Deassert Transmit Enable on probe in driver-specific way"
Date:   Fri, 23 Dec 2022 13:23:54 +0900
Message-Id: <20221223042354.4080724-2-dominique.martinet@atmark-techno.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223042354.4080724-1-dominique.martinet@atmark-techno.com>
References: <20221223042354.4080724-1-dominique.martinet@atmark-techno.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

When 7c7f9bc986e6 ("serial: Deassert Transmit Enable on probe in
driver-specific way") got backported to 5.10.y, there known as
26a2b9c468de, some hunks were accidentally left out.

In serial_core.c, it is possible that the omission in
uart_suspend_port() is harmless, but the backport did have the
corresponding hunk in uart_resume_port(), it runs counter to the
original commit's intention of

  Skip any invocation of ->set_mctrl() if RS485 is enabled.

and it's certainly better to be aligned with upstream.

Link: https://lkml.kernel.org/r/20221222114414.1886632-1-linux@rasmusvillemoes.dk
Fixes: 26a2b9c468de ("serial: Deassert Transmit Enable on probe in driver-specific way")
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
[the fsl_lpuart part of the 5.15 patch is not required on 5.10,
because the code before 26a2b9c468de was incorrectly not calling
uart_remove_one_port on failed_get_rs485]
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
---

The part in v2 of the patch still makes sense, so here's just that for
5.10.
(I've kept Rasmus as author for the 5.10 version as well, thanks again!)


 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 605f928f0636..40fff38588d4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2254,7 +2254,8 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 
 		spin_lock_irq(&uport->lock);
 		ops->stop_tx(uport);
-		ops->set_mctrl(uport, 0);
+		if (!(uport->rs485.flags & SER_RS485_ENABLED))
+			ops->set_mctrl(uport, 0);
 		ops->stop_rx(uport);
 		spin_unlock_irq(&uport->lock);
 
-- 
2.35.1


