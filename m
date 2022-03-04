Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55CEC433FE
	for <linux-serial@archiver.kernel.org>; Fri,  4 Mar 2022 08:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiCDIFE (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Mar 2022 03:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiCDIE4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Mar 2022 03:04:56 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086E5105AA8
        for <linux-serial@vger.kernel.org>; Fri,  4 Mar 2022 00:04:07 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 533D23F61F
        for <linux-serial@vger.kernel.org>; Fri,  4 Mar 2022 08:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381046;
        bh=T44npRNeKYD0vpyzx7RQhW2Cib6n/i6fxec+7s1/j58=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pGAIqBHvBOdWcS7dIr8DY6pNM9wexYrKgz69XViHk/JPx+Ah5uLHuwwmWSBOjo3b1
         Zt4Vt50wp6FlgNhrhYDozlK6E4MYi8DeqyRIlSugD2+D0YVIjm4aeio4dmGDnk5BzX
         uG1I9B5w3HjAVOVeOisJY3juHiMF3/QRgLoFjnZTHUr+82bF/KW4nHjvB2hOcj/xps
         +7TOMK09yR3rCuj286wWs8BOYmpcsKpaxWUXm1UmT0H132evmvx9gqBf1St/iPKFOl
         R89DNXDTpcUf4incQrRr4Dfmg7V2Nzqoui0MsqQLBl/eKFoXsUOh2V2szh3f4d3N6g
         MpQKL6w639C4A==
Received: by mail-ed1-f70.google.com with SMTP id j10-20020a05640211ca00b004090fd8a936so4199951edw.23
        for <linux-serial@vger.kernel.org>; Fri, 04 Mar 2022 00:04:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T44npRNeKYD0vpyzx7RQhW2Cib6n/i6fxec+7s1/j58=;
        b=p7q5hFHNsFyhVnKyrbyrBUxQX1fxRjwbVH9OoBgWhrxKyKZrw8xWxWyCzhzlS3M5E/
         e5bHmR9CdWx8VOOfgpEYQ0omb9EI3VI2NqwjjEe4qJ4ySrc/ODBIK61UmZ7dzdEVoUpS
         WzWCoUrdf9W/2mWY2jDgUeOzNWnPcyHW0MVrEgiA2LswyNAKPZjBWhpjkWUmIr0UKFKm
         1CvSPmWb2T4SyPiZL008iUgt7txIsP3NbVkbgKrA6Bf7ZnVNkMxYHx/FbwnuYNAAZS9j
         S0wOBiFYguoWvfjauWB4UeQq5FryO/ge/NUbWDoGhifNOKrLCTnjSH4+6voQcGBUXCdN
         x6XQ==
X-Gm-Message-State: AOAM531GqUZQJJ2rX0QTrbYgl44b6OGY//+GxJ0y63bYbYqAHtTa1vvd
        CVN5ybn+f1RQpgrUD1lgRbvVwf9ATbjcOEtpp9Vsxa6TAdPHWcxd7Ab7VD3PlGmUG22/sgEK8Gr
        lm8oBy2ajOburBpGwPCdz853rim+2QZR5u5WVUvzRaw==
X-Received: by 2002:aa7:c1d7:0:b0:415:9906:8900 with SMTP id d23-20020aa7c1d7000000b0041599068900mr14995503edp.360.1646381045100;
        Fri, 04 Mar 2022 00:04:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQx+JALUcgr+aV10z5DLRK2lWPO6mxFP6+bRPUxVe5mDfuxGx3aQWGNaHOFHObaAzRiHXZiw==
X-Received: by 2002:aa7:c1d7:0:b0:415:9906:8900 with SMTP id d23-20020aa7c1d7000000b0041599068900mr14995487edp.360.1646381044922;
        Fri, 04 Mar 2022 00:04:04 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm1481465ejb.82.2022.03.04.00.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:04:03 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] tty: serial: samsung: constify s3c24xx_serial_drv_data members
Date:   Fri,  4 Mar 2022 09:03:46 +0100
Message-Id: <20220304080348.218581-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The driver data (struct s3c24xx_serial_drv_data) is never modified, so
also its members can be make const.  Except code style this has no
impact because the structure itself is always a const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 279c413f2300..eecefff5c4a4 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -85,9 +85,9 @@ struct s3c24xx_uart_info {
 };
 
 struct s3c24xx_serial_drv_data {
-	struct s3c24xx_uart_info	info;
-	struct s3c2410_uartcfg		def_cfg;
-	unsigned int			fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
+	const struct s3c24xx_uart_info	info;
+	const struct s3c2410_uartcfg	def_cfg;
+	const unsigned int		fifosize[CONFIG_SERIAL_SAMSUNG_UARTS];
 };
 
 struct s3c24xx_uart_dma {
-- 
2.32.0

