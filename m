Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14848C4332B
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE41920767
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgCTRlf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:41:35 -0400
Received: from v6.sk ([167.172.42.174]:51868 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgCTRlf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:35 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id BC7E86108C;
        Fri, 20 Mar 2020 17:41:33 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 06/10] ARM: dts: mmp*: Make the serial ports compatible with xscale-uart
Date:   Fri, 20 Mar 2020 18:41:03 +0100
Message-Id: <20200320174107.29406-7-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
References: <20200320174107.29406-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

XScale serial port driver is perfectly capable of supporting this hardware. A
separate compatible string is probably a historical mess.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 8 ++++----
 arch/arm/boot/dts/mmp3.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 45372df0ec2ad..da10567b5aca6 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -209,7 +209,7 @@ timer0: timer@d4014000 {
 			};
 
 			uart1: serial@d4030000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4030000 0x1000>;
 				interrupts = <27>;
 				clocks = <&soc_clocks MMP2_CLK_UART0>;
@@ -219,7 +219,7 @@ uart1: serial@d4030000 {
 			};
 
 			uart2: serial@d4017000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <28>;
 				clocks = <&soc_clocks MMP2_CLK_UART1>;
@@ -229,7 +229,7 @@ uart2: serial@d4017000 {
 			};
 
 			uart3: serial@d4018000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <24>;
 				clocks = <&soc_clocks MMP2_CLK_UART2>;
@@ -239,7 +239,7 @@ uart3: serial@d4018000 {
 			};
 
 			uart4: serial@d4016000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4016000 0x1000>;
 				interrupts = <46>;
 				clocks = <&soc_clocks MMP2_CLK_UART3>;
diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 7a5b9962497e4..9b5087a95e736 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -319,7 +319,7 @@ timer: timer@d4014000 {
 			};
 
 			uart1: serial@d4030000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4030000 0x1000>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&soc_clocks MMP2_CLK_UART0>;
@@ -329,7 +329,7 @@ uart1: serial@d4030000 {
 			};
 
 			uart2: serial@d4017000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&soc_clocks MMP2_CLK_UART1>;
@@ -339,7 +339,7 @@ uart2: serial@d4017000 {
 			};
 
 			uart3: serial@d4018000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&soc_clocks MMP2_CLK_UART2>;
@@ -349,7 +349,7 @@ uart3: serial@d4018000 {
 			};
 
 			uart4: serial@d4016000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4016000 0x1000>;
 				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&soc_clocks MMP2_CLK_UART3>;
-- 
2.25.1

