Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35615C43462
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 13:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067D7601FE
	for <linux-serial@archiver.kernel.org>; Thu,  6 May 2021 13:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhEFNWa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 May 2021 09:22:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:18360 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhEFNWZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 May 2021 09:22:25 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FbZ102Ff8zlc6p;
        Thu,  6 May 2021 21:19:16 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 6 May 2021 21:21:14 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Al Cooper <alcooperx@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-stm32 <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 1/2] dt-bindings: serial: Change to reference the kernel-defined serial.yaml
Date:   Thu, 6 May 2021 21:20:48 +0800
Message-ID: <20210506132049.1513-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210506132049.1513-1-thunder.leizhen@huawei.com>
References: <20210506132049.1513-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The /schemas/serial.yaml from dt-schema only has the property $nodename,
whereas the kernel-defined /schemas/serial/serial.yaml contains more
useful properties, support for more complex application scenarios.

For example:
1) The property "current-speed" in fsl-lx2160a.dtsi
2) The subnode "bluetooth" in hi3660-hikey960.dts

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/devicetree/bindings/serial/8250.yaml            | 2 +-
 .../devicetree/bindings/serial/brcm,bcm7271-uart.yaml         | 2 +-
 Documentation/devicetree/bindings/serial/ingenic,uart.yaml    | 2 +-
 Documentation/devicetree/bindings/serial/pl011.yaml           | 4 ++--
 Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml | 4 ++--
 Documentation/devicetree/bindings/serial/renesas,em-uart.yaml | 2 +-
 Documentation/devicetree/bindings/serial/samsung_uart.yaml    | 2 +-
 Documentation/devicetree/bindings/serial/sifive-serial.yaml   | 4 ++--
 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml          | 2 +-
 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml   | 3 +--
 10 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index f0506a917793dde..1a849fc17181c8d 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -10,7 +10,7 @@ maintainers:
   - devicetree@vger.kernel.org
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
   - if:
       anyOf:
         - required:
diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
index 46c62745f901e2f..6d176588df47d84 100644
--- a/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm7271-uart.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Al Cooper <alcooperx@gmail.com>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 description: |+
   The Broadcom UART is based on the basic 8250 UART but with
diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index 7748d8c3bab85b6..b432d4dff730b1f 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Paul Cercueil <paul@crapouillou.net>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml b/Documentation/devicetree/bindings/serial/pl011.yaml
index 1f8e9f2644b6b80..142187337c765fa 100644
--- a/Documentation/devicetree/bindings/serial/pl011.yaml
+++ b/Documentation/devicetree/bindings/serial/pl011.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Rob Herring <robh@kernel.org>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 # Need a custom select here or 'arm,primecell' will match on lots of nodes
 select:
@@ -103,7 +103,7 @@ dependencies:
   poll-rate-ms: [ auto-poll ]
   poll-timeout-ms: [ auto-poll ]
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml b/Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml
index a344369285b6aa9..a644e5af12b24ba 100644
--- a/Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 properties:
   compatible:
@@ -35,7 +35,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
index 82aefdb0d45e5f1..e98ec48fee46379 100644
--- a/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
@@ -35,7 +35,7 @@ required:
   - clocks
   - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 97ec8a093bf303e..0c24e7b1f15ec32 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -82,7 +82,7 @@ required:
 unevaluatedProperties: false
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.yaml b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
index 5fa94dacbba97b4..09aae43f65a7f4a 100644
--- a/Documentation/devicetree/bindings/serial/sifive-serial.yaml
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.yaml
@@ -12,7 +12,7 @@ maintainers:
   - Palmer Dabbelt <palmer@sifive.com>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 properties:
   compatible:
@@ -49,7 +49,7 @@ required:
   - interrupts
   - clocks
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 87ef1e218152d1a..99d8888e88a9d18 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Rob Herring <robh@kernel.org>
 
 allOf:
-  - $ref: /schemas/serial.yaml#
+  - $ref: serial.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 71a6426bc558a1c..f50f4ca893a099d 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -112,8 +112,7 @@ required:
   - interrupts
   - clocks
 
-additionalProperties:
-  type: object
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.26.0.106.g9fadedd


