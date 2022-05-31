Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2F7C433F5
	for <linux-serial@archiver.kernel.org>; Tue, 31 May 2022 13:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344919AbiEaNvC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 May 2022 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344925AbiEaNur (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 May 2022 09:50:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7413554AA
        for <linux-serial@vger.kernel.org>; Tue, 31 May 2022 06:50:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d26so13180672wrb.13
        for <linux-serial@vger.kernel.org>; Tue, 31 May 2022 06:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uV55XMdMMXm/8YBcA+hYcRdN/Sy/q9ytKejpU0TX1a4=;
        b=ydZ0fPc4/noMrgY/rszzHccN97Dm96R2jV+wrzbjo52SSgkXsjX2+EmRB8HsR5XPRy
         OVhxeu+TgJKJQmJ8ptz4ZS7KSw34lKfJHR/Oh1KxcrGhn/iCWSi/i3mbLTb8GgMD5vo4
         pr0FmYobyv9iFimX2s+CYCufeQZNf5yKkJ6M6nUmnNbMUbsURMc58EQ4rsJoD++egq8e
         XahX6EwRKB1QJ10UyGUAm9BQzptgx5KvmldEadtAjoKFX5UJv5AzOa20xrPpQB/aVtrR
         qLyOwm378YQrHUZMrdxvMFzDfZaVWFwOrMrwzLddQGIhcZrd9/nkoQi88OD6OFhcqZvG
         /tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uV55XMdMMXm/8YBcA+hYcRdN/Sy/q9ytKejpU0TX1a4=;
        b=D2ADFjBJOQjtepQuXf2JH6DFeyUxirfTAlcGPVqKGIDINmd9o/+TBMv8kCLnH3uAVZ
         J5dF2UZ8CbWfSRA6Aky3Wbsf3/X82fhwqHz+gvBzdy3AI+VwW+73M/cwsigFuQXSeRWX
         yGj1Z/zDG80urv8Dga0r+H53V4I7BvvqDGDE0kZtvmUIiRChsBVNW+AtFUveH/VjKCcK
         SGxzjhuuVCK23i4Q27vCTnnJ5VbHlcz6yy/8TX0cmY2ch8C0QU0lYISsrQe71Fh6BNPv
         1jxEYzToZDvXsLeF64uVfZ0TscD3M+NzmDXBU38mKza3f8jQVRUEobgtgLYcAZx/JaMt
         RWMg==
X-Gm-Message-State: AOAM533BzD7ePAUgQ7yzx54wGeLAYlwc1Hb79HsRBIo7GBQ9uXpLbkvl
        5cnRsQhlhpYZ233kl0Tkrjo/Yg==
X-Google-Smtp-Source: ABdhPJxv8/PQNV+ezFLIiwnnP78JfWw4efymnBcIzCpOQsc85VBTswc/napM3IwCND/u1AFwGmeM9A==
X-Received: by 2002:a05:6000:1869:b0:20f:c1a4:111 with SMTP id d9-20020a056000186900b0020fc1a40111mr43818748wri.261.1654005045408;
        Tue, 31 May 2022 06:50:45 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l11-20020a05600c1d0b00b00394351e35edsm2404806wms.26.2022.05.31.06.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 06:50:44 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, qii.wang@mediatek.com, matthias.bgg@gmail.com,
        jic23@kernel.org, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        chunfeng.yun@mediatek.com, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 04/17] dt-bindings: arm: mediatek: Add binding for mt8365-evk board
Date:   Tue, 31 May 2022 15:50:13 +0200
Message-Id: <20220531135026.238475-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531135026.238475-1-fparent@baylibre.com>
References: <20220531135026.238475-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add binding documentation for the MT8365-EVK board. The MT8365 EVK board
has the following IOs:
* DPI <-> HDMI bridge and HDMI connector.
* 2 audio jack
* 1 USB Type-A Host port
* 2 UART to USB port
* 1 battery connector
* 1 eMMC
* 1 SD card
* 2 camera connectors
* 1 M.2 slot for connectivity
* 1 DSI connector + touchscreen connector
* RPI compatible header
* 1 Ethernet port

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 4a2bd9759c47..a4b1288fa837 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -216,6 +216,10 @@ properties:
           - enum:
               - mediatek,mt8516-pumpkin
           - const: mediatek,mt8516
+      - items:
+          - enum:
+              - mediatek,mt8365-evk
+          - const: mediatek,mt8365
 
 additionalProperties: true
 
-- 
2.36.1

