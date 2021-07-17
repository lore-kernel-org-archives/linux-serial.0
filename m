Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F20C636CB
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 12:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48360611C1
	for <linux-serial@archiver.kernel.org>; Sat, 17 Jul 2021 12:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhGQMlw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 17 Jul 2021 08:41:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233662AbhGQMlr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 17 Jul 2021 08:41:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A677613EE;
        Sat, 17 Jul 2021 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626525530;
        bh=LXDwk1gYabXV3hYmtYeDzVFhnOPDvwkZMuYNH7JDko4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vv7wBrIE89Kqpg6BYR0gzeYc066s2aDJNwrk33el8nW03OEmHWfpe7JefsP/BQpvR
         2pZ2hrUrm/DkUlV+Lap33tB8pZE1JL4eLhb4ihqxi00g8YHUrqazPXKeHv2CNMuVmr
         S3lChivJ0nRp83gjlIbWWr5bfD+sDMX4SD5KMIeEqX2mAjHBa9gkpR68czRoP+MDNR
         /3MiyaJMi7WudRh77Ca3A9XzUKkDWJhItt+PgRl+cVnayA6EPTJiXYDmPWhhg3ZEat
         kz6FLI+TeBtmpwPlQJMw/w6JvKGwDQkAhnzoHaH+SZJRsCB2PInWNwtYFQ8vMGS+N4
         +wvGtzlPdlHSg==
Received: by pali.im (Postfix)
        id 35C6DEA7; Sat, 17 Jul 2021 14:38:50 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>,
        "Vladimir Vid" <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/5] arm64: dts: marvell: armada-37xx: add device node for UART clock and use it
Date:   Sat, 17 Jul 2021 14:38:28 +0200
Message-Id: <20210717123829.5201-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210717123829.5201-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
 <20210717123829.5201-1-pali@kernel.org>
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
 arch/arm64/boot/dts/marvell/armada-3720-db.dts    |  4 ++++
 .../boot/dts/marvell/armada-3720-espressobin.dtsi |  4 ++++
 .../boot/dts/marvell/armada-3720-turris-mox.dts   |  4 ++++
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts  |  4 ++++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi      | 15 +++++++++++++--
 5 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 3e5789f37206..accf014a6a1e 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -191,6 +191,10 @@
 	};
 };
 
+&uartclk {
+	status = "okay";
+};
+
 /*
  * Exported on the micro USB connector CON30(V2.0)/CON32(V1.4) through
  * an FTDI (also on CON24(V2.0)/CON26(V1.4)).
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 5fc613d24151..d03c7cdfbfb3 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -117,6 +117,10 @@
 	};
 };
 
+&uartclk {
+	status = "okay";
+};
+
 /* Exported on the micro USB connector J5 through an FTDI */
 &uart0 {
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index ce2bcddf396f..724b41cca3b6 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -137,6 +137,10 @@
 	status = "disabled";
 };
 
+&uartclk {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 95d46e8d081c..c8217440b8dd 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -183,6 +183,10 @@
 	phy-names = "usb2-utmi-otg-phy";
 };
 
+&uartclk {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 5db81a416cd6..d62bf4a798d9 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -132,10 +132,21 @@
 				reg = <0x11500 0x40>;
 			};
 
+			uartclk: uartclk@12000 {
+				compatible = "marvell,armada-3700-uart-clock";
+				reg = <0x12010 0x4>, <0x12210 0x4>;
+				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
+					<&tbg 3>, <&xtalclk>;
+				clock-names = "TBG-A-P", "TBG-B-P", "TBG-A-S",
+					"TBG-B-S", "xtal";
+				#clock-cells = <1>;
+				status = "disabled";
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
@@ -147,7 +158,7 @@
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

