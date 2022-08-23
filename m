Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC52C3F6B0
	for <linux-serial@archiver.kernel.org>; Tue, 23 Aug 2022 13:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbiHWNLK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Aug 2022 09:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiHWNK1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Aug 2022 09:10:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52215133BA9
        for <linux-serial@vger.kernel.org>; Tue, 23 Aug 2022 03:11:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id l21so13042658ljj.2
        for <linux-serial@vger.kernel.org>; Tue, 23 Aug 2022 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NT1MdaiiRgNNPmqthPsgEEr8eAf1OtODyvfC9Tez9jE=;
        b=d24AUdC2zPUgd6lTx38GCpKnI0tTonPkL/qz4kouYg3AoGNTke4nCB4BkFXP8UdoXm
         NnANB9WAmrgV39AqWqOVeBT9U7jCVE1RI8ph602wo2TBenMiheVSZSomxVv67hqniiE/
         sasY/1pB8N9k1YwqWDcSbr1MVJoS9CHohekJGJlWjIZGAbK7cmQHJoKoE7DbIdFHSX49
         h8fNlZ9+ORtRz9MdMRYeglTknssPo6/83lMswQUO5VX8mlUAu+jWBMrPGBgoedg2GHDQ
         8DS5Ell0Jx3Es8VISpQ/r0autuLlz6yaZMPXEYCvFncwnVTQiOcjMx9UqylQrqKtURjP
         FRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NT1MdaiiRgNNPmqthPsgEEr8eAf1OtODyvfC9Tez9jE=;
        b=a/lltgSCKygXGQHAWx+v/nrDhgrb4OU1/fcxtw8x+dIgHstVtHl2IQTTYo1U4zxZIy
         3pM70ojl1PgKkcoVswvlJveT4XD15aTu7vW1i7UeDHQRxZixnNnh0RdKd5BUM4sUNPhJ
         lGsk93EKzAxvwST0EEDxGLa1BTLRTTcMXsi5PCeTyEmxeX524V1c8DdKV6pdX9+S2/n9
         LhcISG9tQz6S2ZLSBOr7393ju0Wo1jF0jQKZeYLkgPOUL05kV7t3vK33HF33xB2d267S
         jPgbPMgvhcpTPGB8BiXPwyROoq4cMki/Cu7ZptvTtvwKyPuSbw8eIdG+RPdI3YH46zQF
         zOKQ==
X-Gm-Message-State: ACgBeo3kRFiA7pHbgv6S5eR9JKVwKX3W924429lvYc4a45HAGi2iuljm
        YqL65a8NVFG43+aHlqHDT7qzHQ==
X-Google-Smtp-Source: AA6agR4x9HadMmuOlofp0PRb7+HJm0Tgt7RCUUlor0M2WSkzU/nuFxZEGkfwoOuVnq8W/4obs0Getw==
X-Received: by 2002:a05:651c:238b:b0:261:d3dd:3aa6 with SMTP id bk11-20020a05651c238b00b00261d3dd3aa6mr1403084ljb.348.1661249404252;
        Tue, 23 Aug 2022 03:10:04 -0700 (PDT)
Received: from krzk-bin.. (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b00492db3caa0dsm1415846lfr.295.2022.08.23.03.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 03:10:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: serial: samsung_uart: drop ref from reg-io-width
Date:   Tue, 23 Aug 2022 13:10:00 +0300
Message-Id: <20220823101000.386927-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

reg-io-width is a standard property, so no need for defining its type

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 901c1e2cea28..8dbf5885488a 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -37,7 +37,6 @@ properties:
     description: |
       The size (in bytes) of the IO accesses that should be performed
       on the device.
-    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [ 1, 4 ]
 
   clocks:
-- 
2.34.1

