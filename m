Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB79AC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 09:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6223617E6
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 09:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349672AbhI3KAy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349634AbhI3KAt (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 06:00:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47401619E2;
        Thu, 30 Sep 2021 09:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995947;
        bh=QLuW6v3Lic+9u3xvdpn5U7PciiFoV7G+AE18M57+JTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7aFa6+yKObecr7WrVQFqTSyFOeK8n4xt1DvaAt6FnPIaukQW5Yo7VxDXmdhq5InL
         8D9Lyp56CdLbRyIQ4FUAzaDIiJj/qWAZgOaWBK7lvHbEQGjBd4VUzILOFSDWQW8rfN
         JLLgm2nTUbUCiZ6s4XwU8AbmUeKGyQusbXenS4+0k/kLCOYChL29aRZ16glQ3HR9vN
         S4PeJz5i5gAAPPHBElQNMMO0nu0LchTfgtU6UDpkIScUZ2oOvWBjdZEJPv5NUPC1Ms
         pjwecehT73wsvykJ/Aym7Pmoyk6k8+AwYVyvxc3OLBxITTG1o4NPABHMkaXXnBTHKA
         qMp/h6Pq0DVIQ==
Received: by pali.im (Postfix)
        id 089E0E79; Thu, 30 Sep 2021 11:59:07 +0200 (CEST)
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
Subject: [PATCH v7 5/6] arm64: dts: marvell: armada-37xx: add device node for UART clock and use it
Date:   Thu, 30 Sep 2021 11:58:37 +0200
Message-Id: <20210930095838.28145-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210930095838.28145-1-pali@kernel.org>
References: <20210930095838.28145-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This change defines DT node for UART clock "marvell,armada-3700-uart-clock"
and use this UART clock as a base clock for all UART devices.

Signed-off-by: Pali Rohár <pali@kernel.org>

---
Changes in v6:
* Do not disable uartclk by default
* Rename node to clock-controller@12010
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 9acc5d2b5a00..f9bfe73d8ec2 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -132,10 +132,20 @@
 				reg = <0x11500 0x40>;
 			};
 
+			uartclk: clock-controller@12010 {
+				compatible = "marvell,armada-3700-uart-clock";
+				reg = <0x12010 0x4>, <0x12210 0x4>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+					<&tbg 3>, <&xtalclk>;
+				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
+					"TBG-B-S", "xtal";
+				#clock-cells = <1>;
+			};
+
 			uart0: serial@12000 {
 				compatible = "marvell,armada-3700-uart";
 				reg = <0x12000 0x18>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 0>;
 				interrupts =
 				<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				<GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
@@ -147,7 +157,7 @@
 			uart1: serial@12200 {
 				compatible = "marvell,armada-3700-uart-ext";
 				reg = <0x12200 0x30>;
-				clocks = <&xtalclk>;
+				clocks = <&uartclk 1>;
 				interrupts =
 				<GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				<GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
-- 
2.20.1

