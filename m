Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBD3C74A5B
	for <linux-serial@archiver.kernel.org>; Thu,  9 Mar 2023 21:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjCIVfL (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 9 Mar 2023 16:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjCIVfI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 9 Mar 2023 16:35:08 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B16E250F
        for <linux-serial@vger.kernel.org>; Thu,  9 Mar 2023 13:35:06 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g3so12740754eda.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Mar 2023 13:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678397705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/XGnTW8d5154ClkyTBOCffDzRAqbcCupwBDkGcyCWzM=;
        b=TIl/6CQjvSe4YeVvY4cH6nV4V3PGDBL5sVSS2OedjbPww9taZoGpOPUNznjXflof3O
         9ELuphT7XRtnzvEHQtPjNucUPk1fNRtQt+5bupz3jYBwW2Fl0CGYdi8T6j0cJWHjczb4
         SzKbUiLoZeh+2uXMsnOs1vdxP1mj/6etFSodRoiVRUNSzP8A+Eo3uRsiMsOksw+B/5u2
         JhdnK/ZGPELQ8eYlPaC57jfkbUgWDpQndn2dktjEynHr+E/R2hvpYD6c/RwtCZlIJbxr
         Nw11h84dUQ8lhyJj69mqvQeqlI+yoBNGRfG6J1uTIJIwcTBDi/TugVZTyJMf81CGTyfl
         mxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678397705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XGnTW8d5154ClkyTBOCffDzRAqbcCupwBDkGcyCWzM=;
        b=aREK2Xj62MPPfm0BKo8kBBRFqcFVc22egnXb+TSuuKIW5te+3OJVPPpUfQiYL2stlv
         xRz9ZPlE9ZFjCOawg0jO++pzMWcGjkVqz6iK/qN7Fix9O8fVSOAAzXwnLpfHhR7acrwR
         Oj6kincKP/toMf0c9b+St/shx0/lNq4OyKhwHTzW+MnXe0xSuo/5ZHCehqIJ1xk2kqqE
         BeoZV9pucNo4sB2Z7eUZiAUGfV11kFyWeftOUbtqAJmUhvSwLyYumuIPpFOks8HY47R2
         59m0kFKehVk1aJm9EWW1NL6SHfxVJhwfwzDu61n9Sbpm9VwaxHvAtIevKzcOcbzyy2u2
         hlUA==
X-Gm-Message-State: AO0yUKVZzihrZCVS0ze+1vbyMcpjur93z/mcl0ofHFr1LPNEL/zhLXdX
        bCQChSkUvtmsNO4RwUQD/dKo0Q==
X-Google-Smtp-Source: AK7set+jVjANLAicrQHU3OMzrMX/odh2hvLIfV3/Xo9e7u17cIrpWkfMHBv2UrKmn5EX1/IPQjS6jw==
X-Received: by 2002:a17:906:1289:b0:8f0:4a90:a764 with SMTP id k9-20020a170906128900b008f04a90a764mr92340ejb.23.1678397705156;
        Thu, 09 Mar 2023 13:35:05 -0800 (PST)
Received: from ryzen9.fritz.box ([81.221.122.240])
        by smtp.gmail.com with ESMTPSA id 8-20020a508748000000b004af7191fe35sm211486edv.22.2023.03.09.13.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 13:35:04 -0800 (PST)
From:   =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: [PATCH v11 2/3] dt-bindings: serial: mediatek,uart: add MT8365
Date:   Thu,  9 Mar 2023 22:35:00 +0100
Message-Id: <20230309213501.794764-3-bero@baylibre.com>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <20230309213501.794764-1-bero@baylibre.com>
References: <20230309213501.794764-1-bero@baylibre.com>
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

