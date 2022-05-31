Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E4C43217
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 13:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242021AbiEaNwf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238215AbiEaNv1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 09:51:27 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBCD98585
        for <linux-serial@vger.kernel.org>; Tue, 31 May 2022 06:50:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k19so10607060wrd.8
        for <linux-serial@vger.kernel.org>; Tue, 31 May 2022 06:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lW0yAksGLkkUyy22NDdYQDHyZq2zc0vWqxg9iWVW56I=;
        b=0Rpx6jMIsXbKBWz1Z4MydcV9MC4lfQ3IYbK0315TxxRiBKVFtYDLzjN7CG4UB2UfWq
         06uhmo1Q6/Mi1Jb09Hw7bavVWC473lzLKiVfHrsQ5in01UXAMACueQStByBDdPzDrBqp
         twnBLWRJxnAEiZ0+mPXx6cIxmUygABTTEFKvNZa/MjJr/Y2grABaHGjDVverTv4ebyxt
         TnzynXxR7yWbhOz4huGXpOoRp1SIMztgg1r5aLLCiQ3CmPtGzWQoJt1KE4PCgOXkFwQg
         zaN3g5ow5FcEEOLYDOomGD2Td/iJJorkSyXXnQpmbUAJFuBArGG5g3rkIgU01hKSc2lm
         Z3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW0yAksGLkkUyy22NDdYQDHyZq2zc0vWqxg9iWVW56I=;
        b=WmHQN10hcZWLYOzjHekVI6W+GJmnFD1spn+MiyDv6t+R4oYhqv6/oSOyZWVAQDNhWf
         yjWs3/ZANzwwMwQEQqyurHSRKxjpOCstJvoOvnefBXpSfZ3FQLaLLU7zT9Tow612WlVY
         CaxRfIRuX7YQDZ+bWiLUeQFavWeA02Y2lhO/JLMymyaLay70WypqaqPcimQEbpZ4VgUZ
         Rcfx12RQDl8N2vqa1ZFNRPg7wImHNyw6+EKIjS2uFfhKxeToKiGaXNkdl27rI7TwFo6o
         /YjjEFwN2ulqQ8EzGCrQ4HlKTklEcuglhv0MuwK4PJrV9HLMapLhFKixIJzMA/Ryfg5p
         L0Bg==
X-Gm-Message-State: AOAM532uLcaQuGc3eBFYBfW+BnaMiCwVIHhAhEDXfbYHemcV0WuaE1yz
        Y0KrgeWTcDlD9h7Dri5QaWEFBw==
X-Google-Smtp-Source: ABdhPJx92GIJhNJSvoi0FLCIeGZ8dl9Y3pv8+Zk660zC6fx9w1PvGGZpm6/Ia+aYM0mB7Jhr4qPWOw==
X-Received: by 2002:a5d:448d:0:b0:20d:744:7663 with SMTP id j13-20020a5d448d000000b0020d07447663mr50722292wrq.654.1654005055117;
        Tue, 31 May 2022 06:50:55 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:54 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Leilk Liu <leilk.liu@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 09/17] dt-bindings: spi: mt65xx: add MT8365 SoC bindings
Date:   Tue, 31 May 2022 15:50:18 +0200
Message-Id: <20220531135026.238475-10-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 94ef0552bd42..d3d34a3a0b7f 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt7629-spi
+              - mediatek,mt8365-spi
           - const: mediatek,mt7622-spi
       - items:
           - enum:
-- 
2.36.1

