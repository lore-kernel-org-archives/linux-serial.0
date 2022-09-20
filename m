Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6D0ECAAD8
	for <linux-serial@archiver.kernel.org>; Tue, 20 Sep 2022 16:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiITQA5 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 20 Sep 2022 12:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiITQAz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Sep 2022 12:00:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0C5AA22
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 09:00:51 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v4so3065826pgi.10
        for <linux-serial@vger.kernel.org>; Tue, 20 Sep 2022 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=/XA5rkoouGgX9DCK7SjCAV6orQoM99AmvM4Gl/XVcZc=;
        b=UbdCnls33atG4xWvWkmByU/a6tf+VDySm1kndblgUXjNNzsdPPmowbUFA11ocrRWSh
         BDGKgRXo1Tyg27YE89N4hwD27d5JT7U64+hgjWoag4+AgFhsV8J3naLUCmgu8SJ5HTEc
         ZNgYAhlLVTYexBs5rA9it8sXkQvHoKzIjWUWCk+UIDWupY8B6v/xyp95mmGvWHh3IseX
         l8AQ7TDBzS8r0EQfO7RWzP0BLAbLPjoyKs50cCbjv8zaumDgF35xr35MisOarryf1kg3
         Y0RCKoGEmn3ig3ip85mGIeU4uswZ86MQG886MXYoldVfo3qKXUAR6fXVQj71ExGqEptp
         BcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=/XA5rkoouGgX9DCK7SjCAV6orQoM99AmvM4Gl/XVcZc=;
        b=kUKE1XCoE+KEiT/wA//8Fj9d0LECKheuHE8QjSqDvMp/sKQqkTdrvTNeKjYkNiOPMi
         MmQg+QUf+YtwucDzXFPJz8LSSkjO2eSZXqlPJpFcnCzTGr2EdUDXYlsqAHz1tfqcDeIr
         Ipcd3hyDW87iixYcgM+CpEgx6WhHPmlyF31ixKkZ9tFWQnPTL69LbkCreIOket7KgSiO
         7ofpm/NXAYvlXDjEoi2JTu79eYMmbvKieZELuUPswci0w4GMopyOiHkMN+/dIvfjI3nF
         aS2wnEXNUKXoY9sJrl1h0vRgKLBKYOrDhszLCsoeJA2jSXEo579gNUB9m6pchOiKwxKa
         FVjg==
X-Gm-Message-State: ACrzQf0XTO+sld5W8ieZcKVhVqIOu3Q+NiUToU2PARpyxpNb9Wm9rNcI
        9KVSV2O5vLRWVpCk55232rbgTQ==
X-Google-Smtp-Source: AMsMyM7Bspny5wJ7RTUvQPBMhUFUW4mhUnaRJBnTUiH0bjIFvW70GdXwxuc6WhIqJ42e15MlO4qMzQ==
X-Received: by 2002:a63:b4a:0:b0:438:c97c:994d with SMTP id a10-20020a630b4a000000b00438c97c994dmr21373081pgl.597.1663689650624;
        Tue, 20 Sep 2022 09:00:50 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id bf10-20020a170902b90a00b0017849a2b56asm89488plb.46.2022.09.20.09.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 09:00:48 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2] serial: sifive: enable clocks for UART when probed
Date:   Tue, 20 Sep 2022 09:00:18 -0700
Message-Id: <20220920160017.7315-1-olof@lixom.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When the PWM driver was changed to disable clocks if no PWMs are enabled,
it ended up also disabling the shared parent with the UART, since the
UART doesn't do any clock enablement on its own.

To avoid these surprises, switch to clk_get_enabled().

Fixes: ace41d7564e655 ("pwm: sifive: Ensure the clk is enabled exactly once per running PWM")
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Olof Johansson <olof@lixom.net>

---

v2: Switch to devm_clk_enabled() per Uwe's suggestion.

---
 drivers/tty/serial/sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 5c3a07546a58..4b1d4fe8458e 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -945,7 +945,7 @@ static int sifive_serial_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "unable to find controller clock\n");
 		return PTR_ERR(clk);
-- 
2.30.2

