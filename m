Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3004EC49EB7
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 14:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183C46197F
	for <linux-serial@archiver.kernel.org>; Fri, 25 Jun 2021 14:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbhFYOje (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 25 Jun 2021 10:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231775AbhFYOjZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 25 Jun 2021 10:39:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58E0461965;
        Fri, 25 Jun 2021 14:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624631824;
        bh=Nu54X5q0A7lAD3PI/6jbtY+Y1bhEuC3ltNWvMu7bpzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H79jqpCbgOt8WsMhLVx9jxSk2kUHdeT90sjhk0mK4Gxgk9kZ6hmHuUO/nFYA5crle
         NUJvnK+j2OvO2huTPFh1E1lVLTlMf6OAD4a9Z12gsDFp2vZorKFueSug9eaFi1zESB
         jly491V4hv7KrX0Drvqp0Yb6MKGdw+/G08/Iw+tG6ggcdw8tfF4cjdvicGmGKJrfZq
         VDnl+1sQtSFHzfdcjuKcJaltNMXAz5BoeiEQLIkDvVouhNZy7qyIxYMvtqpvUSa3a+
         IJDYIwGXhxWBDJFc5yYkcn4Z2VOuBK7jLVElcPHMnvKQJ8HYbp0pGB+wcI9mweQB7Y
         n6EQOAr9zgDmg==
Received: by pali.im (Postfix)
        id 190B260E; Fri, 25 Jun 2021 16:37:04 +0200 (CEST)
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
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 09/11] dt-bindings: mvebu-uart: document DT bindings for marvell,armada-3700-uart-clock
Date:   Fri, 25 Jun 2021 16:36:15 +0200
Message-Id: <20210625143617.12826-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625143617.12826-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210625143617.12826-1-pali@kernel.org>
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
 .../bindings/clock/armada3700-uart-clock.txt  | 24 +++++++++++++++++++
 .../devicetree/bindings/serial/mvebu-uart.txt |  9 ++++---
 2 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt
new file mode 100644
index 000000000000..144bc6d7eae8
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/armada3700-uart-clock.txt
@@ -0,0 +1,24 @@
+* Marvell Armada 3720 UART clocks
+
+Required properties:
+- compatible: "marvell,armada-3700-uart-clock"
+- reg: two 4-bytes registers: UART Clock Control and UART 2 Baud Rate Divisor
+- #clock-cells : from common clock binding; shall be set to 1
+- clocks: List of parent clocks suitable for UART from following set:
+		"TBG-A-P", "TBG-B-P", "TBG-A-S", "TBG-B-S", "xtal"
+	UART clock can use one from this set and when more are provided
+	then kernel would choose and configure the most suitable one.
+	It is suggest to specify at least one TBG clock to achieve
+	baudrates above 230400 and also to specify clock which bootloader
+	used for UART (most probably xtal) for smooth boot log on UART.
+
+Example:
+	uartclk: uartclk@12000 {
+		compatible = "marvell,armada-3700-uart-clock";
+		reg = <0x12010 0x4>, <0x12210 0x4>;
+		clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+			<&tbg 3>, <&xtalclk>;
+		clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
+			"TBG-B-S", "xtal";
+		#clock-cells = <1>;
+	};
diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
index 2d0dbdf32d1d..463968e7e7f3 100644
--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
@@ -14,7 +14,10 @@ Required properties:
       is provided (possible only with the "marvell,armada-3700-uart"
       compatible string for backward compatibility), it will only work
       if the baudrate was initialized by the bootloader and no baudrate
-      change will then be possible.
+      change will then be possible. When provided it should be UART1-clk
+      for standard variant of UART and UART2-clk for extended variant
+      of UART. TBG clock (with TBG divisors d1=d2=1) or xtal clock should
+      not be used and are supported only for backward compatibility.
 - interrupts:
     - Must contain three elements for the standard variant of the IP
       (marvell,armada-3700-uart): "uart-sum", "uart-tx" and "uart-rx",
@@ -34,7 +37,7 @@ Example:
 	uart0: serial@12000 {
 		compatible = "marvell,armada-3700-uart";
 		reg = <0x12000 0x18>;
-		clocks = <&xtalclk>;
+		clocks = <&uartclk 0>;
 		interrupts =
 		<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 		<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
@@ -45,7 +48,7 @@ Example:
 	uart1: serial@12200 {
 		compatible = "marvell,armada-3700-uart-ext";
 		reg = <0x12200 0x30>;
-		clocks = <&xtalclk>;
+		clocks = <&uartclk 1>;
 		interrupts =
 		<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 		<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
-- 
2.20.1

