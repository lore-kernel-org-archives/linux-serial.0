Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA0BC54E94
	for <linux-serial@archiver.kernel.org>; Wed, 25 Jan 2023 14:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbjAYOgH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Jan 2023 09:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjAYOfz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Jan 2023 09:35:55 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FCD3E092
        for <linux-serial@vger.kernel.org>; Wed, 25 Jan 2023 06:35:23 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bk15so48087311ejb.9
        for <linux-serial@vger.kernel.org>; Wed, 25 Jan 2023 06:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tN16lN3tQI1TVAWs7NSp7WntR2GpAGJj0GT7j6mK3Fw=;
        b=of6sbOD2tWa0RW4bJ3Il9EJBg+LeGX17z0Hq0/avk/NtM8cKmwTyKRRl7nPyyOxGwL
         mr2Qdv5TZ8iivrClY+6MV38YSUbwAhpZqrydvD5VKDl+CtN9Y74N2yPX/CGMF8yCJ4E/
         ZS2OOvWGfZvThUoOd4g6sWvzN9yRMzSFLS6Ghi5PQWElAMgukvYaUXy0oCSqzKAePT8D
         yuHKCh+b3jdVSLeVzCFnGM0F4f6KkE+8vNF63ZDI3J3v2Kx3//mnI3uzGU2d5ASxOBFl
         CS+oQf1lZQ9j5TpXVqmaAm39eKut09JSsWx2XLA5u1g+oj63Q1JJsUSk/F8KrgLDMLhT
         SK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tN16lN3tQI1TVAWs7NSp7WntR2GpAGJj0GT7j6mK3Fw=;
        b=e9G+KwU5meKB54rpil5p4NrW2eiuHEew74vj+rb5M73P0C6z0yvOmfvJk4/mLYmSSe
         34lsYozKycWm5zE5oqV46GbOomJK5Siyq8Ls/mp3R4vy6B0jC3g5BSqjkkGB0fGkqYPU
         Lj3FmEIeOspWiNfgdBy+JlrttD1GhgFnV9pAvSZ5rwqmIREHREKNCD+LlLaY45lY9AyS
         5dI5szj6Iv3NhKd+T/O7nooo3PjQAa5RdHGJCveEPwzvDp28o3ZjDCtVUUDJ2qBfJ5Xf
         Nv0uztFoegUebc9RWtXw5CtXihMZih63lkeOvz8gc9nWH4V+eJCk5NkzNgRmC0zmdJ+w
         k0Zg==
X-Gm-Message-State: AFqh2kp000cRsbuFN2FmhlC8IeY8UQDWd/v6rKyYR1Zu4GJ8C4Bdp6Ap
        y2taYibXL+tCcpqXDqMmhwSsvA==
X-Google-Smtp-Source: AMrXdXvaspNlldvkzbbWkaCPYnTmR1+Wj4YdgO5nLJERa80fBJ5oe8bu2kzgEQ/qdrEdkw2J/9fytw==
X-Received: by 2002:a17:906:40a:b0:86f:a21d:62b7 with SMTP id d10-20020a170906040a00b0086fa21d62b7mr35265266eja.9.1674657309549;
        Wed, 25 Jan 2023 06:35:09 -0800 (PST)
Received: from c64.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id gx2-20020a1709068a4200b0082000f8d871sm2437789ejc.152.2023.01.25.06.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:35:09 -0800 (PST)
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
Subject: [PATCH v9 3/9] dt-bindings: mfd: syscon: Add mt8365-syscfg
Date:   Wed, 25 Jan 2023 15:34:57 +0100
Message-Id: <20230125143503.1015424-4-bero@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230125143503.1015424-1-bero@baylibre.com>
References: <20230125143503.1015424-1-bero@baylibre.com>
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

