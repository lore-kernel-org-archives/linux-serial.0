Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5015EC41537
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355F361029
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhHBOqF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234199AbhHBOqD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Aug 2021 10:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A16C60E97;
        Mon,  2 Aug 2021 14:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627915554;
        bh=Gn6aJIz4qbLtWhu0ndvUgCY6f/5Zfl8nTLtnA2Awyxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7nIRzYn9fNJNwMx9n4bxSR0d29yPFnS2OvhO9q8J6fHvAHqffixET+GD4vKqPxcc
         Lssasy6BYnhikjejGqawc+AMg2NsaLX6aYYrwVrJdRl2LWCJKXjGu6Xp5CG0lwVqMN
         tMPKYHTYvBdJAiXsxxRR7DCCq2KIq9CF1WeOK8iQNUi+KrUM/vSM/jcSHm+L8EGlN4
         YTH+YsMTT5j3o66nQaqTrzXghTl59jX5ZQQFU1PTRcd201HYk3qsLJRMY7UECfpdQC
         gSyl48nac7yIOGjTTNVHDRzs5a5Q3y5yfBA4ijD9HQA+2VEQ8aKb8KcFC/5tuUt7Fs
         o399TURJC8Stw==
Received: by pali.im (Postfix)
        id EE1E6B98; Mon,  2 Aug 2021 16:45:53 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
Date:   Mon,  2 Aug 2021 16:45:26 +0200
Message-Id: <20210802144529.1520-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802144529.1520-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210802144529.1520-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This change adds DT bindings documentation for device nodes with compatible
string "marvell,armada-3700-uart-clock".

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 .../bindings/clock/armada3700-uart-clock.yaml | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
new file mode 100644
index 000000000000..5ef04f3affda
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+title: Marvell Armada 3720 UART clocks
+properties:
+  compatible:
+    const: marvell,armada-3700-uart-clock
+  reg:
+    items:
+      - description: UART Clock Control Register
+      - description: UART 2 Baud Rate Divisor Register
+  clocks:
+    description: |
+      List of parent clocks suitable for UART from following set:
+        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
+      UART clock can use one from this set and when more are provided
+      then kernel would choose and configure the most suitable one.
+      It is suggest to specify at least one TBG clock to achieve
+      baudrates above 230400 and also to specify clock which bootloader
+      used for UART (most probably xtal) for smooth boot log on UART.
+  clock-names:
+    items:
+      - const: TBG-A-P
+      - const: TBG-B-P
+      - const: TBG-A-S
+      - const: TBG-B-S
+      - const: xtal
+    minItems: 1
+    maxItems: 5
+  '#clock-cells':
+    const: 1
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+additionalProperties: false
+examples:
+  - |
+    uartclk: uartclk@12000 {
+      compatible = "marvell,armada-3700-uart-clock";
+      reg = <0x12010 0x4>, <0x12210 0x4>;
+      clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
+      clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal";
+      #clock-cells = <1>;
+    };
-- 
2.20.1

