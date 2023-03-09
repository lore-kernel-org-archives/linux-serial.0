Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCEBC742A7
	for <linux-serial@archiver.kernel.org>; Thu,  9 Mar 2023 14:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjCIOfO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Mar 2023 09:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjCIOfL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Mar 2023 09:35:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C58E7CAF
        for <linux-serial@vger.kernel.org>; Thu,  9 Mar 2023 06:35:10 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id a25so7984325edb.0
        for <linux-serial@vger.kernel.org>; Thu, 09 Mar 2023 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678372509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XGnTW8d5154ClkyTBOCffDzRAqbcCupwBDkGcyCWzM=;
        b=VWPDh6dtM1UkmUdD7p5LKK8/I9+WNmFbF+ajDTXODZ3BAiuXnUEvgLz40BtjcvPYRZ
         T/FpT9sG2LUdjcjm3BXeWIPvnqgqWZyrJCESFGxPJ/xizYSGzfwomH7IkORp0woQr4LV
         7EC6cWtPzN8QhwV9duy3AoX7PpW+T62soDi4eE1WhnElgDoIfmfONRcS6uw1NwhjYUo+
         J1QHsW611tFkrVCbFwA535WwMR8D8XWr/zaBP+l7NuVEzlrA50Z9CR0xzO4Hx0Ia1O6g
         a2AsWYRc9LvX0z9kSz0/n3T2dBk4IANbIxcNxbdgmP2N0sPCziJx7HE0+JOhe1IXKdET
         +Taw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678372509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XGnTW8d5154ClkyTBOCffDzRAqbcCupwBDkGcyCWzM=;
        b=oSULanI6iDLX2knJimFq88WBiMjSIs/JK+Hv1BfZdtZ7qudO7FByT6vBYQRpU0DH2b
         w+N4y8irGQbU7tcRxS0SpU1NElK5hduoaeXLexId8MYjh6ZcU6Lp+eO26nt4UEDfRs5f
         FgsvjKz0b3xIZccK2r5ul7evslKlvPnEgzzKPqBgiEWpBfZ36O1eqi+LSl71Gs0AJWnA
         H5SQjEdQu1FRPg7Twj8MtFReWJbMN9njKytN7U9wyuePng2+0gKNiv1ytQteMgL8cS6F
         XROaQuGu/nOUMAiZeHdR7NuJgw1BANNS2Ea5h6g+FRPaslRSp5RdTHwb64bIWmSIaUSr
         gYXQ==
X-Gm-Message-State: AO0yUKUMSPqRRy/OfAD916AFHeDP/nAFkkBDPK4Cz/OWmoTpZzmNmdFn
        7OZELS7ZZ6T31MvrU5S7AZWZdQ==
X-Google-Smtp-Source: AK7set9O4rl8P3uzhwE/hnhV/DPn1W87oDD35gpX7Y95gY0+bM2ivwGXgJy3SWXHzNLsycSnau36pw==
X-Received: by 2002:a17:907:72c9:b0:889:b38b:4bb2 with SMTP id du9-20020a17090772c900b00889b38b4bb2mr25849740ejc.49.1678372509238;
        Thu, 09 Mar 2023 06:35:09 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id w4-20020a170906184400b008cb7473e488sm9046239eje.12.2023.03.09.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 06:35:08 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v10 2/3] dt-bindings: serial: mediatek,uart: add MT8365
Date:   Thu,  9 Mar 2023 15:34:58 +0100
Message-Id: <20230309143459.401783-3-bero@baylibre.com>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <20230309143459.401783-1-bero@baylibre.com>
References: <20230309143459.401783-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add binding description for mediatek,mt8365-uart

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/serial/mediatek,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
index fe098d98af6ee..303d02ca4e1ba 100644
--- a/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/mediatek,uart.yaml
@@ -45,6 +45,7 @@ properties:
               - mediatek,mt8188-uart
               - mediatek,mt8192-uart
               - mediatek,mt8195-uart
+              - mediatek,mt8365-uart
               - mediatek,mt8516-uart
           - const: mediatek,mt6577-uart
 
-- 
2.40.0.rc2

