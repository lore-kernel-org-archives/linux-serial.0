Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC84C61DA3
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 16:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjAWQin (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjAWQik (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 11:38:40 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EF6196A0
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 08:38:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id v6so32072906ejg.6
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 08:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bNAP8XOhS4LLuKpYRGvk3aTC1kcIWQVhxMWfMNAmKbo=;
        b=aT6upsI1JwMzSY7eVukOsifpXNDMezdPymjRLFWsmDkv2FFcM5HnniUWjCEvur2IJG
         ABaUlO+5S9l7OrD/Z4zo0E2oiAGasCk5prx1QDdZvZE8Kl1Zuh4AdErrbABXItCpN92G
         eiyvoEIx+A3EfFYaseOLk1Gf2Ezsk0ec3vua+feYS6mwpfc6cb1Mmrg8l00QtRK5HF0C
         seOa2fNPXYW2+EMIbcwSGtQ+3tSzYWtgJvWwfBD+Z1+qyt8CP3ANkExD8sJ/uWyp+mua
         1zMdB5bTndUhfSA4GRmmEP7e+X8Erfu/rMo38I9CLaWEwKgA2Gz8seRwG2aI09unAwBp
         skVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNAP8XOhS4LLuKpYRGvk3aTC1kcIWQVhxMWfMNAmKbo=;
        b=he+34fyTpP3Dz21trWzHCxzOqx+6UeYXpTtToVGzEfX7jBKNQgybliUROsbJ4qnQUp
         eKJjDwUDGnUUt4IeBVTtGfQQcVOaJp5uVD3+Odal1p97QHQez0Kq4MC4AO8GQPaay227
         OZXhGjDitv1Ppx9iVVNxN2tp2o33pfVLJ017vqhOkBRKsgv3enOvKSFAAozP5SS4Dczq
         Xw7pnBgVAFP4qo2ZGh89ja7okEDRECiZH3rfwyQ1BykiUXMkAeHPA1WihWzO5zKENymb
         WGPk6Cy64Az23t3IKimWhUsPvVTS4XGd+NJgFbo2Lf0P6JO4m4g0LjXXGclnH5LtlAff
         Yarg==
X-Gm-Message-State: AFqh2kr4McZDpfm9OqGi6shRxAbxmSH/THBw7jRmLm5ggMLui8RNPoaB
        X+b/OT2sJr1cvbffEnGsXoW7FA==
X-Google-Smtp-Source: AMrXdXtsaJFktS7KBs7eT5zNQMwVttcrDG+2mLD83vxFGQGT0aZ/o5dx5K+s8MXDl4SSXUdsgCn/xA==
X-Received: by 2002:a17:907:8b08:b0:86e:e403:4f2e with SMTP id sz8-20020a1709078b0800b0086ee4034f2emr30513666ejc.76.1674491917877;
        Mon, 23 Jan 2023 08:38:37 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007c00323cc23sm22198562ejc.27.2023.01.23.08.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:38:37 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        daniel.lezcano@linaro.org, chunfeng.yun@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, nfraprado@collabora.com,
        andrew@lunn.ch, gtk3@inbox.ru, sean.wang@mediatek.com,
        zhiyong.tao@mediatek.com
Subject: [PATCH v8 2/9] dt-bindings: irq: mtk, sysirq: add support for mt8365
Date:   Mon, 23 Jan 2023 17:38:26 +0100
Message-Id: <20230123163833.1007181-3-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123163833.1007181-1-bero@baylibre.com>
References: <20230123163833.1007181-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add binding documentation of mediatek,sysirq for mt8365 SoC.

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 84ced3f4179b9..3ffc60184e445 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -25,6 +25,7 @@ Required properties:
 	"mediatek,mt6577-sysirq": for MT6577
 	"mediatek,mt2712-sysirq", "mediatek,mt6577-sysirq": for MT2712
 	"mediatek,mt2701-sysirq", "mediatek,mt6577-sysirq": for MT2701
+	"mediatek,mt8365-sysirq", "mediatek,mt6577-sysirq": for MT8365
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Use the same format as specified by GIC in arm,gic.txt.
 - reg: Physical base address of the intpol registers and length of memory
-- 
2.39.1

