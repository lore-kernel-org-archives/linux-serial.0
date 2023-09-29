Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735A7E743F2
	for <linux-serial@archiver.kernel.org>; Fri, 29 Sep 2023 05:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjI2FmG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjI2Fl3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 29 Sep 2023 01:41:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CB21A7
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:59 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8a822508so1827984366b.0
        for <linux-serial@vger.kernel.org>; Thu, 28 Sep 2023 22:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695965998; x=1696570798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up2XNokZoiA5TPtK9O+gQhlckgwCOolxXgSc1vLyaO8=;
        b=YknDKgl04XH/fGUl3cvgX27rH4ko0OA9ftaLD7CgqH6+DtQASHK/hWamd29DMk6O4u
         yP17ENutevN+8+7RAaJyzS1rvaNr5k/gZCM8g9+Rb4QA3qA2QHzewSIurB+++KbkDjvi
         iQLL3L6PyDmpmOIqpucAxPZ2+WrE7YNWtSymIcaAoHjhxDtVN8g+Ys2lN+dP8CGkENN+
         Faxcoyf21DvMFS/j9BJ97CZpSbRkLbYrJ9j6UZrVcJJFmkGtQOujh6eMTlO7b5v9VALm
         2xfrm1yZ4AhnQphANBOicIZQ9wXjXnFfXwe4oSQ8VukitbLtPTyoNvP5szo9Bt9w7itc
         MMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695965998; x=1696570798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up2XNokZoiA5TPtK9O+gQhlckgwCOolxXgSc1vLyaO8=;
        b=eZ/bKLVmqgSCnqV0htcVW9f/rSE0/q4CZggwCmEIUPZMuJ7sPJ7uQbRhdfOQmHqR/s
         GVMcRu78kjPHda0JMYAtWlzOENj5oL/c+6Q+9y4Nd4ouofJRNLKEVTxPKNfM+pbT82o8
         Zv1KwxGuDNfvN+Ey0aql7YULVjliQ/J2AZd5+blYH55ANCyJne+xQGqvmhcI2DkJDNs1
         v2uprGf1BL0ANOWzuE1ucuh2aT8iLhuX8bNcZ9ErwDmXcFSckpGIzNvwU9O1+yTbZUra
         mkRohzCqV7uhUztag2vMGaHDCyW2KU2kcEmwGUPeID7TVf3lHMnbQMjot57mCZ2oEhwW
         2B1g==
X-Gm-Message-State: AOJu0YyGERefSDluTh6zUID5gnT0KqY+/19DgnKsIdRqukKjV1QC5B5r
        N/mXk31K6eH+P0okRYLLzcznWw==
X-Google-Smtp-Source: AGHT+IHWGRdKt18vqmb08FW6Gqil2AJFzy4wYogTFWvh2EtAsEFK8s2z8hF1JCvsa15u5k7BOdpWVQ==
X-Received: by 2002:a17:906:cc1:b0:9a2:28dc:4166 with SMTP id l1-20020a1709060cc100b009a228dc4166mr2898785ejh.75.1695965997654;
        Thu, 28 Sep 2023 22:39:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id z19-20020a1709063ad300b009a1a653770bsm11971992ejd.87.2023.09.28.22.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:39:57 -0700 (PDT)
From:   Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea@bp.renesas.com>
To:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, konrad.dybcio@linaro.org, arnd@arndb.de,
        neil.armstrong@linaro.org, prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 19/28] dt-bindings: pinctrl: renesas: set additionalProperties: false
Date:   Fri, 29 Sep 2023 08:39:06 +0300
Message-Id: <20230929053915.1530607-20-claudiu.beznea@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
References: <20230929053915.1530607-1-claudiu.beznea@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Set additionalProperties: false.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- this patch is new in v2 and added as suggested by Rob

 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml     | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index 4782f96feb7e..eb726770f571 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -106,8 +106,7 @@ additionalProperties:
         line-name: true
 
     - type: object
-      additionalProperties:
-        $ref: "#/additionalProperties/anyOf/0"
+      additionalProperties: false
 
 allOf:
   - $ref: pinctrl.yaml#
-- 
2.39.2

