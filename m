Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006BAC54E94
	for <linux-serial@archiver.kernel.org>; Mon, 23 Jan 2023 15:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjAWPNV (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjAWPNQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Jan 2023 10:13:16 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2124614222
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h12so7120594wrv.10
        for <linux-serial@vger.kernel.org>; Mon, 23 Jan 2023 07:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjUDPjFfIstrArrttGkIiPvgInIpWMnlY5IxKwKaSmM=;
        b=gBYz9l1ChBFTjyquDh1ZRllUadOhS3AOoSty4qM7gQFn3MA20fctQ9Rau+B9QwDvSO
         rwnELh0TsZEV1SENNaAwxrbvMZpyOcQpqOrZkidOK9PyOdIFdQ68uU5lY07aC9beRBFQ
         VFcEGa1/TJ9hw2tpi4rS8isfX7TV//tB0RhC7zKfWQfQHs19bT/PWeLt+XpmCmcpZ3pQ
         P+lQjZV5iQU7XifV/MniKY2UR8WQFm5+rkxBfAFJiDIAcFsY9yb8XamTbrGGz1HsH3ta
         tGwvMS4ewMzZ7GFLQSP06NgULdL1ShWttqEcreqeLg/Uh2RmDqDdijBb41n1CwJPRrSD
         JeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjUDPjFfIstrArrttGkIiPvgInIpWMnlY5IxKwKaSmM=;
        b=HgC+RurjljUzR4nlfo1AHE/Q59lvuTaO+uL1IvEaUWH3MEyF7LHwrrJrI3Su3ibLkg
         /UevWGhuPpfSTQF/iAFRqoM9hhsn3oOz1SDuG0OAy/AsxhavLWvzuBAnD8F242jWO533
         20N7zTHweROYd7ghisivqD/+O2XIFuEbaAiTq7WvxFkIfAFzfveQDl5TagWf/AsxGkV5
         6YpG59Z1bSF+aLqk+gHVjNAliumIEY+vcFAl2ZvtOsdkO+d2QpMep+/xFOnOSYzowZVM
         yjkwMcLuH8lWH+eDjKn6HKjdYwEppab6dQv1RSfkpA19DEcYEoZtqkRmfdMfw/c8GkWS
         xB/Q==
X-Gm-Message-State: AFqh2krOsI7FwsfHRqQ60DFccm8LFLStDrW/lIt6yrZLlTXwxsRhTuK0
        DroHHmeuMEzng2lzYzJgWo7GEWwncJ+aWhd3
X-Google-Smtp-Source: AMrXdXuiyS/nE1Nc3w4Ako2LBIBfE/IBn8kE3nDojB39mO64zJzuJZFatWSIZAd0fnHSuwEectyleg==
X-Received: by 2002:a05:6000:98d:b0:242:809e:1428 with SMTP id by13-20020a056000098d00b00242809e1428mr25207621wrb.5.1674486793685;
        Mon, 23 Jan 2023 07:13:13 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d67c1000000b002bc7f64efa3sm34737922wrw.29.2023.01.23.07.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:13:13 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Chester Lin <clin@suse.com>, Fugang Duan <fugang.duan@nxp.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Le Ray <erwan.leray@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Tomer Maimon <tmaimon77@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 02/13] dt-bindings: serial: 8250: correct Nuvoton NPCM850 compatible
Date:   Mon, 23 Jan 2023 16:12:51 +0100
Message-Id: <20230123151302.368277-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
References: <20230123151302.368277-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Nuvoton NPCM850 UART is compatible with NPCM750, so add proper fallback
to match existing DTS and Linux driver.

Fixes: c8177f90b7c6 ("dt-bindings: serial: 8250: Add npcm845 compatible string")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 34b8e59aa9d4..badaf6d5b6fe 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -62,7 +62,6 @@ properties:
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
-      - const: nuvoton,npcm845-uart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
       - items:
@@ -92,6 +91,10 @@ properties:
           - enum:
               - ns16550 # Deprecated, unless the FIFO really is broken
               - ns16550a
+      - items:
+          - enum:
+              - nuvoton,npcm845-uart
+          - const: nuvoton,npcm750-uart
       - items:
           - enum:
               - ralink,mt7620a-uart
-- 
2.34.1

