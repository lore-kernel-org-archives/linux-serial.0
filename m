Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D7C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  4 Mar 2022 08:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbiCDIF0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Mar 2022 03:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbiCDIFC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Mar 2022 03:05:02 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26C6BD7D9
        for <linux-serial@vger.kernel.org>; Fri,  4 Mar 2022 00:04:09 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AD04A3F613
        for <linux-serial@vger.kernel.org>; Fri,  4 Mar 2022 08:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381047;
        bh=rlX9LT2Ku3zafWWNfSgPawKn9LilfNFaq1DtAqUhXpM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IM7SuxZipeNQoHHawU6CiA74eJTir1weyfXATGcjUgJLMrmM5iitcR2sIUVlpxwBW
         P7ZIEMzEdUhZuKHqHOevCOynGEAwAxmenDn4lpWGJZOitxp9XQE08LFlqtRRY+b5S9
         v/iZkP9fSW4i3ORw5Q0CDLFMHLyX4lDWk40G1+Vu+O8EqIB0JMrTuF4nndEpw0tocb
         ZwJykDT8uiAC9v/J9VYI4JIkRrkKtXJN06kdzAC1ogf/iCHOSzJfDvs7MmpL8AsCFM
         keyiDoo11KcSPtGbblcmtQliYZYT71FVKtwa3Shq6XZ+itxti+qLFcmgJO/wGAAN3S
         ZHgtsqJL1a8cw==
Received: by mail-ej1-f72.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so4038018ejk.16
        for <linux-serial@vger.kernel.org>; Fri, 04 Mar 2022 00:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rlX9LT2Ku3zafWWNfSgPawKn9LilfNFaq1DtAqUhXpM=;
        b=O67qsQx6RMIv05AkewXdB9BI8+1pImwiHIWnTyPUUhb6UMd4+kylDZ6WfL/SP01eq+
         /L0mypzqmBe/zLtEoTVVHjYjm4A4m+CucI0/XhUIirKHA9D6Xzak8Yhb6UkSmteJGQZq
         YyJNPlgSF0Fx7VlzVQMIYIUnusbiBeAJUvC5Pp98SWhdyHkoP8JJjPBvVRB7jBHPjk7L
         WyVpB5qrQ5gnljj+wHZXtSmSnq3zE7he9gC5xKYsNtOHmzxH23+6U0uI5uM+GRwTfhgH
         bUyJeC9/doHCrYuhsWsyneZVJQmvnPpn56ti/sL428aPmknGvryXx3AI2XG92mC+KMUv
         bs4g==
X-Gm-Message-State: AOAM532ShsKKVk80JQYQqAWGBoqF7KttEPkySUGPOmWejzTbnnB0QIMK
        aq7npKHPw2yM5uufZy3atEzFv4BLmFQMycLLzH4tv/0TOMtxkdKrxNSUXiSUBCSQMqwGGxIoYFl
        tlpc/r4NUrn7hZwb9n4Re4qTfB9f5lIMGVcxFP3bc4w==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr29023912ejm.70.1646381047109;
        Fri, 04 Mar 2022 00:04:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9NTQ5aaCe/mw4aEV5jifd4tz1CDgIbNknK5DSvctYEEFyUW63B8TVoeIxQGRv9fsptQj8Sw==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr29023896ejm.70.1646381046879;
        Fri, 04 Mar 2022 00:04:06 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id rv11-20020a17090710cb00b006d5c0cd5e0dsm1481465ejb.82.2022.03.04.00.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:04:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] tty: serial: samsung: simplify getting OF match data
Date:   Fri,  4 Mar 2022 09:03:48 +0100
Message-Id: <20220304080348.218581-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
References: <20220304080348.218581-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Simplify the code with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/samsung_tty.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 00e7c34fad46..76f7afd1b7f7 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2150,23 +2150,16 @@ static int s3c24xx_serial_init_port(struct s3c24xx_uart_port *ourport,
 
 /* Device driver serial port probe */
 
-#ifdef CONFIG_OF
-static const struct of_device_id s3c24xx_uart_dt_match[];
-#endif
-
 static int probe_index;
 
 static inline const struct s3c24xx_serial_drv_data *
 s3c24xx_get_driver_data(struct platform_device *pdev)
 {
 #ifdef CONFIG_OF
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-
-		match = of_match_node(s3c24xx_uart_dt_match, pdev->dev.of_node);
-		return (struct s3c24xx_serial_drv_data *)match->data;
-	}
+	if (pdev->dev.of_node)
+		return of_device_get_match_data(&pdev->dev);
 #endif
+
 	return (struct s3c24xx_serial_drv_data *)
 			platform_get_device_id(pdev)->driver_data;
 }
-- 
2.32.0

