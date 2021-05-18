Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A74CC433B4
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 07:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2163D61285
	for <linux-serial@archiver.kernel.org>; Tue, 18 May 2021 07:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347357AbhERIAD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 May 2021 04:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbhERIAB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 May 2021 04:00:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04E1C06175F
        for <linux-serial@vger.kernel.org>; Tue, 18 May 2021 00:58:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y14so6999343wrm.13
        for <linux-serial@vger.kernel.org>; Tue, 18 May 2021 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5P13XdRJ5R/5Y8xqS3/eplu5G6R3raia4VI6wdvH9Ik=;
        b=nAIosDiI0M9zpMXy6SmYuUyikkN2Y5kzizB4+p6bL4/wXwW5XJNJDGPWDpFnp7wlLk
         JzsGYf5zr/W/7m17ExyVWK98IK9y/BbfFTN6yzvmFJyhlzvyUunbbHgTSAbs35DCFatV
         qn3Rw+ngZJJhZYN60GnE2L9Vfy9hAkKii/YFy1sXXtjB0aKaK7CMdBdLu8lVbuuzAh2z
         Z4MLKQrjbyYAP8eZzIXywV52v6jFL9EoWVNDNH+VL3Z8K/DEQwJ0FdckuCeTfhF+jYwU
         q7vnCZkpPeNAm/3LciIj/uce9L3JiNl28LwOAyD7tBOYVkjyvZJlk2SOOJpJx2pOrFeS
         cjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5P13XdRJ5R/5Y8xqS3/eplu5G6R3raia4VI6wdvH9Ik=;
        b=ET52o0HY5x0R6e9jl30bljARrsJ1oHRRvtVZh78KRMlhNI0VzM1NMRRShJZRNCoAlf
         Fbj5ox2Yw5exYpV0ClzeOW2JyA7MIKAhIIB340Q0jeKfk2tlmPG1Go/Vyr4xznV2epMQ
         KV6e4Mv/KHEQ90vIxJblKDd0gQe+CcND7HFC430RJGkf6VUyPML+nlfvdDEmxveiIVPq
         xdiKCmDhgyT5jtH8kJATtc7y6Fw3ONMamdYKS84p8sFGmW0euwJQ7FZGpgt/wV2cGwLm
         nReuWM9lb/YsGVjBKoPSjV/evLJX73oqajZJuriu2scOFZLNOoyskCzEErbOu719e1MX
         AsoA==
X-Gm-Message-State: AOAM531fTNwG/WOcGwnXYGIlRjRAcRUgoPzbcLM34JzUDAvHiIhc50fK
        xcJ6Tn2p8NQ46VxwdnROcxBFdw==
X-Google-Smtp-Source: ABdhPJyRndly5u8TalfalAaQOTRDWC6iTH+suIZiJ9ud2vBJ0tW6ZTaoSfgolwkhjrOWeedIvdsnJA==
X-Received: by 2002:a5d:53c4:: with SMTP id a4mr5156417wrw.195.1621324722285;
        Tue, 18 May 2021 00:58:42 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:842:2d82:a1ae:1a91])
        by smtp.gmail.com with ESMTPSA id v16sm735448wml.6.2021.05.18.00.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 00:58:41 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] dt-bindings: serial: amlogic,meson-uart: add fifo-size property
Date:   Tue, 18 May 2021 09:58:31 +0200
Message-Id: <20210518075833.3736038-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518075833.3736038-1-narmstrong@baylibre.com>
References: <20210518075833.3736038-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On most of the Amlogic SoCs, the first UART controller in the "Everything-Else"
power domain has 128bytes of RX & TX FIFO, so add an optional property to describe
a different FIFO size from the other ports (64bytes).

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 75ebc9952a99..7487aa6ef849 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -55,6 +55,11 @@ properties:
       - const: pclk
       - const: baud
 
+  fifo-size:
+    description: The fifo size supported by the UART channel.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [64, 128]
+
 required:
   - compatible
   - reg
-- 
2.25.1

