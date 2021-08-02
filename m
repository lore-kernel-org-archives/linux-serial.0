Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE56EC19F39
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5531610FF
	for <linux-serial@archiver.kernel.org>; Mon,  2 Aug 2021 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbhHBOqG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234463AbhHBOqF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Aug 2021 10:46:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42BCA600D4;
        Mon,  2 Aug 2021 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627915555;
        bh=Tj1KoLbRx36Cai5tD6gjvLCZPUH6QNJdzsfNne47jbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cqcflLKvVHSnlZkDzqKpmRedA1aWckNKmZdpeF/Krkn1IyncDidFNFthXQB4QdJpk
         JTjuYGLM8YJ6k9Ayd4RajaYC7kN4y1e7Hh3sAdNEr+kgnuEG/LmK7OZbssrLXtjzbA
         GI+yJBvgZEQXWkzQxrHzAuq4AGx6m9UCn/JesfqRHG5RM29wYNT9FU4yQl4RT/eD56
         pmD/tHbMDkXWtf1dbwNfFwlvA4yhaKBIMSFecODbD3Oo0TYjGMXzMCpM4mGPv+kq9A
         buJC4VltblrjiCtJJyvQlKYPqBiifFctDIyRNDu7Wuw0sqJycocFDMYMih5n3ewicB
         Zymx5O/g5oSbQ==
Received: by pali.im (Postfix)
        id ED7EFB98; Mon,  2 Aug 2021 16:45:54 +0200 (CEST)
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
Subject: [PATCH v4 4/6] dt-bindings: mvebu-uart: update information about UART clock
Date:   Mon,  2 Aug 2021 16:45:27 +0200
Message-Id: <20210802144529.1520-5-pali@kernel.org>
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

Device "marvell,armada-3700-uart" should use
"marvell,armada-3700-uart-clock" compatible clock.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/devicetree/bindings/serial/mvebu-uart.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
index 2d0dbdf32d1d..a062bbca532c 100644
--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
@@ -14,7 +14,10 @@ Required properties:
       is provided (possible only with the "marvell,armada-3700-uart"
       compatible string for backward compatibility), it will only work
       if the baudrate was initialized by the bootloader and no baudrate
-      change will then be possible.
+      change will then be possible. When provided it should be UART1-clk
+      for standard variant of UART and UART2-clk for extended variant
+      of UART. TBG clock (with UART TBG divisors d1=d2=1) or xtal clock
+      should not be used and are supported only for backward compatibility.
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

