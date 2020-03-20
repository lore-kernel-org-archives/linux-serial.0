Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50055C4332B
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3667720767
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCTRl0 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:41:26 -0400
Received: from v6.sk ([167.172.42.174]:51786 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTRlZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:25 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D68E160F22;
        Fri, 20 Mar 2020 17:41:23 +0000 (UTC)
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
Subject: [PATCH 03/10] ARM: dts: pxa*: Make the serial ports compatible with xscale-uart
Date:   Fri, 20 Mar 2020 18:41:00 +0100
Message-Id: <20200320174107.29406-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
References: <20200320174107.29406-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Some drivers that claim to support mrvl,mmp-uart default to a reg-shift
of two, some don't. Be explicit to be on a safe side.

With that in place, a XScale serial port driver is perfectly capable of
supporting the MMP serial port. Add a compatible string.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/pxa168.dtsi | 9 ++++++---
 arch/arm/boot/dts/pxa910.dtsi | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 41dc79c9f6320..9a9e38245e88c 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -56,8 +56,9 @@ timer0: timer@d4014000 {
 			};
 
 			uart1: serial@d4017000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4017000 0x1000>;
+				reg-shift = <2>;
 				interrupts = <27>;
 				clocks = <&soc_clocks PXA168_CLK_UART0>;
 				resets = <&soc_clocks PXA168_CLK_UART0>;
@@ -65,8 +66,9 @@ uart1: serial@d4017000 {
 			};
 
 			uart2: serial@d4018000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4018000 0x1000>;
+				reg-shift = <2>;
 				interrupts = <28>;
 				clocks = <&soc_clocks PXA168_CLK_UART1>;
 				resets = <&soc_clocks PXA168_CLK_UART1>;
@@ -74,8 +76,9 @@ uart2: serial@d4018000 {
 			};
 
 			uart3: serial@d4026000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4026000 0x1000>;
+				reg-shift = <2>;
 				interrupts = <29>;
 				clocks = <&soc_clocks PXA168_CLK_UART2>;
 				resets = <&soc_clocks PXA168_CLK_UART2>;
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index 209b1f0ea67b2..587a5e7f0702f 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -68,8 +68,9 @@ timer1: timer@d4016000 {
 			};
 
 			uart1: serial@d4017000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4017000 0x1000>;
+				reg-shift = <2>;
 				interrupts = <27>;
 				clocks = <&soc_clocks PXA910_CLK_UART0>;
 				resets = <&soc_clocks PXA910_CLK_UART0>;
@@ -77,8 +78,9 @@ uart1: serial@d4017000 {
 			};
 
 			uart2: serial@d4018000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4018000 0x1000>;
+				reg-shift = <2>;
 				interrupts = <28>;
 				clocks = <&soc_clocks PXA910_CLK_UART1>;
 				resets = <&soc_clocks PXA910_CLK_UART1>;
@@ -86,8 +88,9 @@ uart2: serial@d4018000 {
 			};
 
 			uart3: serial@d4036000 {
-				compatible = "mrvl,mmp-uart";
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
 				reg = <0xd4036000 0x1000>;
+				reg-shift = <2>;
 				interrupts = <59>;
 				clocks = <&soc_clocks PXA910_CLK_UART2>;
 				resets = <&soc_clocks PXA910_CLK_UART2>;
-- 
2.25.1

