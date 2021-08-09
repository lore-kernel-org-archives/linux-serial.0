Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147B9C432BE
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 14:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E998B61019
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 14:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbhHIOz3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:55:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235255AbhHIOzQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 10:55:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15BEE6101E;
        Mon,  9 Aug 2021 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520896;
        bh=mDH2GCHWNM5isTwxDcPNqbsUHNnv4sybjDxlPu8Ps9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CT0b6K0NiPK3AkkWgtFi2xkZUytCS3qT+kx6WWxB4pPs5/kq5Dr4SuEXdRFpA/DIL
         k2bElmqeg084o6RCH2KZ/NGDysMYmvWNJPO2Y9ISabA3Nw+OOf3lxUY6vsv5lpfM8I
         AwjmH5CuzEAhfK75MFsI+kfHa1w7R/UCbNHOW9ehjo/g2KoQdKhHuSqlWAVz4fboB3
         ketOas+or8mMYyWKtYTGwNvfYyboIyT78GUnf5ihgdCAMaQ6s9uo+zfGNoxw8K2B0g
         WAB8C8SwmrtroIoh2BDJqdy2bfEvq/8l9eX4BRK7PT48FIOAlapvAPt3h4rmyo9SSp
         f6UlJj1M/tjkw==
Received: by pali.im (Postfix)
        id 2C3FF2879; Mon,  9 Aug 2021 16:54:54 +0200 (CEST)
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
Subject: [PATCH v5 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
Date:   Mon,  9 Aug 2021 16:53:26 +0200
Message-Id: <20210809145329.24177-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210809145329.24177-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210809145329.24177-1-pali@kernel.org>
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
 .../bindings/clock/armada3700-uart-clock.yaml | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
new file mode 100644
index 000000000000..5bdb23e0ba3e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+title: Marvell Armada 3720 UART clocks
+
+properties:
+  compatible:
+    const: marvell,armada-3700-uart-clock
+
+  reg:
+    items:
+      - description: UART Clock Control Register
+      - description: UART 2 Baud Rate Divisor Register
+
+  clocks:
+    description: |
+      List of parent clocks suitable for UART from following set:
+        "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
+      UART clock can use one from this set and when more are provided
+      then kernel would choose and configure the most suitable one.
+      It is suggest to specify at least one TBG clock to achieve
+      baudrates above 230400 and also to specify clock which bootloader
+      used for UART (most probably xtal) for smooth boot log on UART.
+
+  clock-names:
+    items:
+      - const: TBG-A-P
+      - const: TBG-B-P
+      - const: TBG-A-S
+      - const: TBG-B-S
+      - const: xtal
+    minItems: 1
+    maxItems: 5
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
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

