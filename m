Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B52CDB465
	for <linux-serial@archiver.kernel.org>; Thu, 19 Oct 2023 10:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345115AbjJSKGx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 Oct 2023 06:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345191AbjJSKGw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Oct 2023 06:06:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45787129
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 03:06:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32003aae100so351211f8f.0
        for <linux-serial@vger.kernel.org>; Thu, 19 Oct 2023 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697710008; x=1698314808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WoHbbCT5Q2YnMBHSSHndfYfjoqOXcMkJzKxQOn/3xRA=;
        b=ImpEh6W1/dFwD4S2TTyk775srATk8mfedRwwcdPhsxk25S0MO2zsjF1D/56f5JL6uo
         foh1ZNiJiJZc2/Rv2t10/HwaMvfjHtWzEExyorfuS7dXtEKXM36cOVrhoN2cyDhbiZVS
         NDeE+IYzj3bK9m3vWBbioO2/qKsKzDeoNoVDBOVvn61uOGYRVAehC+swPOU6n3ReSnc+
         2QZG6L41SvSyHQb/D4a+Op3QJvwZqSvga/1njK56YUME1A1qNzK4+6Pfycnm0UhzIPnk
         O/MBd8iB5mZ5pGAgZAX8/mjlFu/jPhCa8SOAuXeoNp2XcpISYq5h2vJ+4E5ZT5naJfOd
         hURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697710008; x=1698314808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WoHbbCT5Q2YnMBHSSHndfYfjoqOXcMkJzKxQOn/3xRA=;
        b=vnGnyP4ebQ1eSF+mYbgzJNB5BOOJzSs1MjPCnpYuucnDVMYEJUXkUnUddgnmO5dSnX
         QDMKSCNZA7JSge2Kmf1g1RZvmpPGr47W9AUeQACMEQbPwIeqMA3EtPIIWeSylaALHTWV
         K1pLaXbZlm1lEb65rsVW+U0S3/5Bo45rPNxOarGYqZzOidxpl3+xNQjX1dynv0Kq7hpz
         02gPsZxIhQnQdTuQxspHQ/Vlsz49ESvK02qtg/lYrw3XbjuBoZM9AJrNEgbwkSOH4niE
         jrnG1c8nmTX5AbXOgvYG46oOjSLKmKGxrd72h+hQk0oYChkxusrBQiyJr8G4liqgHaY+
         sOvA==
X-Gm-Message-State: AOJu0YyHxfQDBz6T3L2U8nP7pPSgPSU776keUWFgk80sWryldna9dA8s
        2nnvphpqwBQ2fWwY341vpxo6tw==
X-Google-Smtp-Source: AGHT+IEfXFBWcICclgq5d25qXX2874TWMOZrlbxekqA4ORYxEx8VBvpzwo4h+e4GbPTKtVhUnU3Rrg==
X-Received: by 2002:a5d:4ed0:0:b0:317:6579:2b9f with SMTP id s16-20020a5d4ed0000000b0031765792b9fmr1138930wrv.30.1697710008730;
        Thu, 19 Oct 2023 03:06:48 -0700 (PDT)
Received: from salami.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d664e000000b0032d687fd9d0sm4169035wrw.19.2023.10.19.03.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:06:48 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, alim.akhtar@samsung.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: serial: drop unsupported samsung bindings
Date:   Thu, 19 Oct 2023 11:06:39 +0100
Message-Id: <20231019100639.4026283-2-andre.draszik@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231019100639.4026283-1-andre.draszik@linaro.org>
References: <20231019100639.4026283-1-andre.draszik@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Now that no implementation exists anymore for
samsung,s3c24(1[02]|40)-uart, remove those bindings from here as well.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 8bd88d5cbb11..d45079ef7bd9 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -24,9 +24,6 @@ properties:
       - enum:
           - apple,s5l-uart
           - axis,artpec8-uart
-          - samsung,s3c2410-uart
-          - samsung,s3c2412-uart
-          - samsung,s3c2440-uart
           - samsung,s3c6400-uart
           - samsung,s5pv210-uart
           - samsung,exynos4210-uart
@@ -96,7 +93,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - samsung,s3c2410-uart
               - samsung,s5pv210-uart
     then:
       properties:
-- 
2.40.1

