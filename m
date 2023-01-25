Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6411DC61D97
	for <linux-serial@archiver.kernel.org>; Wed, 25 Jan 2023 14:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbjAYOgX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Jan 2023 09:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjAYOf6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Jan 2023 09:35:58 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FBE59749
        for <linux-serial@vger.kernel.org>; Wed, 25 Jan 2023 06:35:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id mg12so48165498ejc.5
        for <linux-serial@vger.kernel.org>; Wed, 25 Jan 2023 06:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwIzfbsFdCDai/q3cnqayXJcFTx4vajk+OuUztkusTY=;
        b=qRmANpnH4is/F+5qvIY7noxMz+f6w7INvOBkCDarf9jnGLHpHmwGitGjNT7YsoAHAO
         I3tiTJWahRU0GLdO62FJgkFOMohild1tYcXsnyTqSKpQTNbcAO13t6pcEJ2k17WnvXvd
         0qehQE1yWK3Gg75asV51FzK1WVSqqoGyKe6LtT3qZt6UjDgVKJ1fMViRDMfM3p7cVqIy
         iFKWdhRxTP71DB/R4RgvpC682xXNu0I8d0mnJMxw1RMEbLI7ByX3Y5ZftXNkdt68U+PG
         XUDv0RZvEERPmfDJjErtNfi6PJDpDWkpB7EWXorereoU4PMn+ZxAvAFiUSd5N2VqeXcJ
         Di5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwIzfbsFdCDai/q3cnqayXJcFTx4vajk+OuUztkusTY=;
        b=qE3SiCbRAZUYjb+3yIxDPsTvhxW3czeLMFH9xPoieVABkS1g9FJ9c2z+E7fkdG6Xhp
         xb62JQrjsz8BNkOLRZB8cR9ug+6Qsk4Ig1CAxV6kjEnTuzppR4+mLH/oDkamPvZ3yV8w
         OCG6YIteMH2gSBGH/ZQaAeXW7fSsKry7wM+8Ql/hwFVWDH0giqSCkA8gHxDO9d+5Im53
         pYoyZVWX6XPVZ7wP5dACpGnvZCNY7zwKX5knhdKa7+QMKNOl2xz9cHQUAk55ln7H0hSy
         XuowuTbs18IUBaKABKiyqTlf/57JD+Vscv4Ei5y7cmSAwgQDdgcEPZr4vs6Go3Xh5Vir
         L11w==
X-Gm-Message-State: AFqh2koxPYcpVOB8g0NVPH2X5dtGqh9YIf0d6D0D1dz70zAol9mm7/aV
        VSzuEhWlJGHFjpYkX8xR+0xVoQ==
X-Google-Smtp-Source: AMrXdXstzqV2XL+/aQuS1AHHAlcElDVNa4FiNkbP0JXJYw+8OsK3hRRkIwgHSZHeYfhdvGBrMMlZDg==
X-Received: by 2002:a17:907:6d21:b0:805:1e6e:6777 with SMTP id sa33-20020a1709076d2100b008051e6e6777mr61071823ejc.23.1674657312110;
        Wed, 25 Jan 2023 06:35:12 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id gx2-20020a1709068a4200b0082000f8d871sm2437789ejc.152.2023.01.25.06.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:35:11 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com, nfraprado@collabora.com,
        allen-kh.cheng@mediatek.com, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: [PATCH v9 5/9] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC bindings
Date:   Wed, 25 Jan 2023 15:34:59 +0100
Message-Id: <20230125143503.1015424-6-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125143503.1015424-1-bero@baylibre.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index 7168110e2f9de..d2655173e108c 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -28,6 +28,7 @@ properties:
           - mediatek,mt8188-mtu3
           - mediatek,mt8192-mtu3
           - mediatek,mt8195-mtu3
+          - mediatek,mt8365-mtu3
       - const: mediatek,mtu3
 
   reg:
-- 
2.39.1

