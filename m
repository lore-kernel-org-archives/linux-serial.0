Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C71C12002
	for <linux-serial@archiver.kernel.org>; Fri, 16 Jul 2021 22:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F33613DF
	for <linux-serial@archiver.kernel.org>; Fri, 16 Jul 2021 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhGPW6X (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 16 Jul 2021 18:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhGPW6U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Jul 2021 18:58:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8945C06175F
        for <linux-serial@vger.kernel.org>; Fri, 16 Jul 2021 15:55:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l11so864323ljq.4
        for <linux-serial@vger.kernel.org>; Fri, 16 Jul 2021 15:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NzFZx7BjonyE5OA8jgKf/uBGn05pZovkKHpoMsBKMNQ=;
        b=gjVHRBBZk7KgDEfyUyY9zZcFkWzFGyiJnJ9DhAKstZittZZ3OfkCiaFUtQf39dPpXZ
         +SrblgSrFwyPn4RGWEWCdUWaLS8FSJXMQPSMpYL6OrwwdwVGhUOnS2AjNPTuvxEQK17H
         eOoPwPXexVrUqeBheNEL2pQAy5r1+Hw7hDD7DoavLtZPGsx3JpeVamrmp1LYraIiPflF
         6FRJd5maRd6WbCiy4G+EfAqYHv8GxTib3hINQzZpfNBraYOrLlqHyOZYzW6i4UV7gkzd
         wqsN4gjY/A53myCaH7IUgybczXz8qtFlJniBPRbSnjTVV7tTYoKoP+/mpcGVP4JGrCfk
         IEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NzFZx7BjonyE5OA8jgKf/uBGn05pZovkKHpoMsBKMNQ=;
        b=Oe98P9i4xf8xyjztuQPwS4L+bPFNTv0sFo+5nBauXMBel8mOXAWJ7T1jBGFmdFe9uF
         dLbA5H5xQeROeX5MsPuE8v90Kd0Wzo70qCeyzZSToH+Kuubn7eKZkSENgD6igixQvU/a
         uiNO/TY6C/IiNj3sedW/tsHt/QL5xkSUNwusSWyXdSj6ExOF4gX690CN+eR8AHOcFGSk
         yfeUHM9iyO+C04Z2QiOUBwG4NsevRVIzNosj2AW2pTJ5UKlta9Ju9XezAolFKwdKHeKw
         XQTv7f15KJkPSrEAsTw4ve15iH2omO51dSzdt+/VcCAgcPAmECD3SZ/w9M1OTJIaI741
         0EbQ==
X-Gm-Message-State: AOAM532Xr33m30BG/tD4NGOaQu4t7W/cNnFm7U+xilKYpWM7e92RQVmZ
        5wjlP6+O5hVFNPZ2cQLhu13PlqTOfG6Zeg==
X-Google-Smtp-Source: ABdhPJxHFsQEvvmOMxDUSMQwcWDUKlgq9Mj/1HKuDjfV0f3+VNfRfeV+vS4FbXIb7hMC96T6rDwiAA==
X-Received: by 2002:a05:651c:488:: with SMTP id s8mr10820962ljc.328.1626476121798;
        Fri, 16 Jul 2021 15:55:21 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id t81sm741677lff.296.2021.07.16.15.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 15:55:21 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: 8250: Add Exar compatibles
Date:   Sat, 17 Jul 2021 00:53:19 +0200
Message-Id: <20210716225319.1282704-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The Intel IXP425 Vulcan board has an Exar XR16L2551 8250-compatible.
It works like an 8250 but it is always good to specify exactly which
component we are using. This allows us to specify:

compatible = "exar,xr16l2551", "ns8250";

Put in some sibling Exar serial compatibles while we're at it.

Cc: Marc Zyngier <maz@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index a0bf061b80fe..fa767440f281 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -64,6 +64,12 @@ properties:
       - const: nuvoton,npcm750-uart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
+      - items:
+          - enum:
+              - exar,xr16l2552
+              - exar,xr16l2551
+              - exar,xr16l2550
+          - const: ns8250
       - items:
           - enum:
               - altr,16550-FIFO32
-- 
2.31.1

