Return-Path: <SRS0=2m+P=4R=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB10C3F2CD
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 22:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C529024650
	for <linux-serial@archiver.kernel.org>; Sat, 29 Feb 2020 22:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ld+GovSr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgB2WLs (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 29 Feb 2020 17:11:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46527 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgB2WLs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 29 Feb 2020 17:11:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id h18so7267495ljl.13
        for <linux-serial@vger.kernel.org>; Sat, 29 Feb 2020 14:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jYudkg4Lts72seJhGTtJ1KA52Ck45no23derqeXMEo=;
        b=Ld+GovSr38aKfcvguCkhX+UDmkCpvGzjuqEcogu8v/sORXEOaNltCmP1ndMx9jd0+T
         2E95y+wu6p5VnOVjQBC6xIS5jGt1I6h5plskWU0kfgksSIm5dEWT5x93QaCknD2NI2NN
         YKWO/eRsxyvRjWZjeoE15fIDnpR588+BixR8yYIZXRHBn4Rk/qN5HqU7FXY9a7VK2kdB
         0ibJVISd/R5J7bC4yVn/0V9DH9BOiXHRfJ6k0i8+Oh4vYlJ0P/y3ET6etFTJtlUWTERa
         SXhwdHm/xPM1lSOp8U+hKPIvTTBVuzWjULxlS6Qq3dkvV2mJpsBlpQMDzLuU1u3LSlfI
         m09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4jYudkg4Lts72seJhGTtJ1KA52Ck45no23derqeXMEo=;
        b=oQm0UY7xn8mWVt6Jud/xaDG3LChI9JwOML+pI3IroPCSp0QKZWdloXXCJbRRINtfch
         nGU9WYvUvBBd4E14pagmMHaNoBwz73JqAM3Mrt1GIZSQVOeEtsn6H1La+cswLd7TFN5B
         AP59htcS96r2Ca7crKrxz5+9kSyiRZsPHDm35ndUbkT76qbKWl/hmvTHxOSZvW5zRJYD
         OQnLMa6jIN7cml5gZDXr+pgAWq7LLzhlDL5bUk0JLfkphJ3fhCeiJCPdJSGvqyKjrlKY
         YEtlXPDcp2bzZuGOpYi+xXRRGOwBXhZTxQzU4kqeL4RTV7thzT5bhu+UEwxu8mPlBtyK
         BaUg==
X-Gm-Message-State: ANhLgQ2rpBq0bl3BRQO1OWFbTEaFpzVwoK30y9LX0tFxW4GwXGSfIuCc
        w1ZDlCzkjCjfozHpb7V+KNFHR/XwTlQ=
X-Google-Smtp-Source: ADFU+vuWtTANnum/S0E/vBTpzhOgXk9F77wDMWj3+VzM2m72H/BQE1F0DrE/4rLM9S0/3IzegeToiQ==
X-Received: by 2002:a2e:9e4c:: with SMTP id g12mr6826934ljk.15.1583014306008;
        Sat, 29 Feb 2020 14:11:46 -0800 (PST)
Received: from localhost.localdomain (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id u26sm7266604lfq.91.2020.02.29.14.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 14:11:45 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Razvan Stefanescu <razvan.stefanescu@microchip.com>
Subject: [PATCH] tty: serial: atmel_serial: Drop GPIO includes
Date:   Sat, 29 Feb 2020 23:09:41 +0100
Message-Id: <20200229220941.205599-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Nothing in this driver uses the symbols from these GPIO
includes so drop them. These are probably just historical
artifacts from befor mctrl_gpio was used.

Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Razvan Stefanescu <razvan.stefanescu@microchip.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/tty/serial/atmel_serial.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index c15c398c88a9..801b998c87e7 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -20,15 +20,12 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/atmel_pdc.h>
 #include <linux/uaccess.h>
 #include <linux/platform_data/atmel.h>
 #include <linux/timer.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/irq.h>
 #include <linux/suspend.h>
-- 
2.24.1

