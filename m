Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7976C433E6
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 16:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B2A64E76
	for <linux-serial@archiver.kernel.org>; Fri, 12 Feb 2021 16:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhBLQlB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Feb 2021 11:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230471AbhBLQjy (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Feb 2021 11:39:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 589F464E79;
        Fri, 12 Feb 2021 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613147952;
        bh=51XcX6dQowx6/pTqJK4HCz4dT/40q9kddHBTcC+0Nic=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OUEzPzTR+mGgYKzjh8QjFCoL9iZCZZfoWJd2xLPOrhNEeKONpcmLuauoDEgXt0WpP
         dljiEtaAKCM7qd0/g2c0ioOHi0c1GvmpxGayN+v73tCOHas4qHVKpiEXbR+m7h8A5X
         THdZDUpK67g1O1gMNx9gDKZSPXL6UVCb6vcSCgnKXalAEtYc3xmHtGdoD/70aXgl4G
         jptOOrxWlA6CTRwX/ERDLn4UybX+YlZOMdwkyT3IyJe/hZN0hTpE8Ywloi4kU/HKmr
         JjJntdvizCa69M2aBA6uWYE0lTPxC10fbysj0qkPPLYReRSnzgjURfCU6Z5xmlDjAX
         hbSu+EDsUDdUQ==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: serial: samsung: include generic dtschema to match bluetooth child
Date:   Fri, 12 Feb 2021 17:39:05 +0100
Message-Id: <20210212163905.70171-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210212163905.70171-1-krzk@kernel.org>
References: <20210212163905.70171-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Include the generic serial.yaml dtschema so the child node like
"bluetooh" will be properly matched:

  arch/arm/boot/dts/exynos4210-universal_c210.dt.yaml:
    serial@13800000: 'bluetooth' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/serial/samsung_uart.yaml         | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 3e29b561223d..f4faf32ab00f 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -78,9 +78,11 @@ required:
   - interrupts
   - reg
 
-additionalProperties: false
+unevaluatedProperties: false
 
 allOf:
+  - $ref: /schemas/serial.yaml#
+
   - if:
       properties:
         compatible:
@@ -134,3 +136,25 @@ examples:
                  <&clocks SCLK_UART>;
         samsung,uart-fifosize = <16>;
     };
+
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    serial@13800000 {
+        compatible = "samsung,exynos4210-uart";
+        reg = <0x13800000 0x100>;
+        interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clock CLK_UART0>, <&clock CLK_SCLK_UART0>;
+        clock-names = "uart", "clk_uart_baud0";
+        dmas = <&pdma0 15>, <&pdma0 16>;
+        dma-names = "rx", "tx";
+        pinctrl-0 = <&uart0_data &uart0_fctl>;
+        pinctrl-names = "default";
+
+        bluetooth {
+            compatible = "brcm,bcm4330-bt";
+            pinctrl-0 = <&bt_shutdown &bt_device_wakeup &bt_host_wakeup>;
+            pinctrl-names = "default";
+        };
+    };
-- 
2.25.1

