Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB47C43219
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 09:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2406197A
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 09:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349652AbhI3KAu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349619AbhI3KAr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 06:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 229CE61882;
        Thu, 30 Sep 2021 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995945;
        bh=NHJBEDETpANIrgHSRJleNxObvssqlufzbMGZPXguFq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYZaECC+Le1M7pmz9o0J5cwv4WYXGJvGz1Y2bZL8Hlt9ql23Mu6jxy/QIHWj3CPjz
         tauq0OXPw0/DVD3DQNUg5fFhj2Q1lk1L/GAeV5VbMC4V7uplOuTfFtlmn3LmmyoLjf
         LGYIdFoP6EIuvnC7B/XlfFAUAr6zRw6Gddsd7/8ayWj6nabRT2CI8QFKwMGBv//kPD
         YExiwoFQOQ/O2JFhfAMMkj748bhWubraE+YIyg6iQ8qFYgXSj+0i8/qK+r+7Nfns7t
         7c12bWcMTQUDbwjQHfVo3DLzl+PXClMvGsywL9fK3dqLyG72hkTP6m1f+O30gOZ0p4
         uHwQkMdSPAYlA==
Received: by pali.im (Postfix)
        id D814CE79; Thu, 30 Sep 2021 11:59:04 +0200 (CEST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 3/6] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
Date:   Thu, 30 Sep 2021 11:58:35 +0200
Message-Id: <20210930095838.28145-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930095838.28145-1-pali@kernel.org>
References: <20210930095838.28145-1-pali@kernel.org>
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
Changes in v7
* Fix errors

Changes in v6
* Fix license
* Rename node to clock-controller@12010
* Remove maxItems
---
 .../clock/marvell,armada-3700-uart-clock.yaml | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml b/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
new file mode 100644
index 000000000000..175f5c8f2bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/marvell,armada-3700-uart-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+title: Marvell Armada 3720 UART clocks
+
+maintainers:
+  - Pali Rohár <pali@kernel.org>
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
+    uartclk: clock-controller@12010 {
+      compatible = "marvell,armada-3700-uart-clock";
+      reg = <0x12010 0x4>, <0x12210 0x4>;
+      clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>, <&tbg 3>, <&xtalclk>;
+      clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal";
+      #clock-cells = <1>;
+    };
-- 
2.20.1

