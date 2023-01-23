Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368C0C61D97
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 16:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjAWQio (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 11:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjAWQim (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 11:38:42 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9971C2BF08
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 08:38:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw16so31985872ejc.10
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMnhXtg85D4KtwJwkPkhLvAJp9rd3aoHLilVGsPoiao=;
        b=tbuUVPAWxwQkN/2kAW56UBHmw+ME9ICCY9uDoGdA3IKsA32JgEV68bINSCWVCE25Oc
         zmtTJfVy6rvbX+QB708xpTHcdTA9y91xCkY7HuZQ54eJ7X283uODiIjh1nlbCjmL6J+A
         0MlXYCFRWWKT5NFMutCKcZCCVxEKjedkM3VivDHTPy9fz/KnHKtybVenux8Cw2h2UqzV
         lx1z+Zm05haFWDAHLuzcv7i/x+hQdIIsdAGNBo/hX37zSumCuR/AgkMGhtJbPf+rc+GJ
         v6sQ+tZAZpzVWOh8iZt0M2GDLNqvP/n+EO1oNliPrQAACbz7gym4Ouv1NfjJePwbzbyi
         fGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMnhXtg85D4KtwJwkPkhLvAJp9rd3aoHLilVGsPoiao=;
        b=X54q7ljkR3eoCEHBHb5vnfWP4VPiIMsuxHB4C+YqHUZpkJpRoiMaWPtl9dF1XXdzUQ
         2+ueNStD7JRxCCuA46Bu8RwhRBd+ditLJ4JU1wCLLdZwQuZrGnj9hyd+YFTZn737LB5c
         pdcvSVdQ72RT/aCFPlf5P36WhYOGxmmB6UgGgZXZLLRlsPeoxIeyXYxA7bjIY4H12rcn
         9TXAiMdHx9eZNUZXZ+Hq9IXyZw3RAVkym1hJhbbTmhwcJuSlLrL+4Ho1p0uCdHTJG0wd
         FBMwIfvZywT2QFZueITAnuMvhbmKCvSum5iXl1+kjkjTnj1C9l6hjCBc7MdDGabvHxxb
         DA0g==
X-Gm-Message-State: AFqh2krmtQsF54fgTN5kNDOMsE9ggD/GiEWR1Yeb+eDOKFgqcpr4VBHN
        ZL9S+iBll+OOBUYMN8KR9NzWDA==
X-Google-Smtp-Source: AMrXdXt8zeUfGlwgG5ONfXTt4dt9Q5KEkOp/A8qjBZ+PcwRcIeZFWge1bnr0YXpj5nF6K0GDyLbwXw==
X-Received: by 2002:a17:907:d40c:b0:872:af53:a028 with SMTP id vi12-20020a170907d40c00b00872af53a028mr24562227ejc.61.1674491919166;
        Mon, 23 Jan 2023 08:38:39 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007c00323cc23sm22198562ejc.27.2023.01.23.08.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 08:38:38 -0800 (PST)
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
Subject: [PATCH v8 3/9] dt-bindings: mfd: syscon: Add mt8365-syscfg
Date:   Mon, 23 Jan 2023 17:38:27 +0100
Message-Id: <20230123163833.1007181-4-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123163833.1007181-1-bero@baylibre.com>
References: <20230123163833.1007181-1-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Document Mediatek mt8365-syscfg

Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 1b01bd0104316..7beeb0abc4db0 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -50,6 +50,7 @@ properties:
               - marvell,armada-3700-usb2-host-misc
               - mediatek,mt8135-pctl-a-syscfg
               - mediatek,mt8135-pctl-b-syscfg
+              - mediatek,mt8365-syscfg
               - microchip,lan966x-cpu-syscon
               - microchip,sparx5-cpu-syscon
               - mstar,msc313-pmsleep
-- 
2.39.1

