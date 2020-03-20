Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACC2C4332B
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3FE20767
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgCTRlc (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:41:32 -0400
Received: from v6.sk ([167.172.42.174]:51844 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgCTRlb (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:31 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id ADE0561008;
        Fri, 20 Mar 2020 17:41:30 +0000 (UTC)
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
Subject: [PATCH 05/10] ARM: dts: mmp*: Fix serial port names
Date:   Fri, 20 Mar 2020 18:41:02 +0100
Message-Id: <20200320174107.29406-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
References: <20200320174107.29406-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

A preferred node name for serial ports is "serial":

  mmp2-olpc-xo-1-75.dt.yaml: uart@d4030000: $nodename:0: 'uart@d4030000'
      does not match '^serial(@[0-9a-f,]+)*$'
  ...

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 8 ++++----
 arch/arm/boot/dts/mmp3.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 6a2f072c1d0a8..45372df0ec2ad 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -208,7 +208,7 @@ timer0: timer@d4014000 {
 				clocks = <&soc_clocks MMP2_CLK_TIMER>;
 			};
 
-			uart1: uart@d4030000 {
+			uart1: serial@d4030000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4030000 0x1000>;
 				interrupts = <27>;
@@ -218,7 +218,7 @@ uart1: uart@d4030000 {
 				status = "disabled";
 			};
 
-			uart2: uart@d4017000 {
+			uart2: serial@d4017000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <28>;
@@ -228,7 +228,7 @@ uart2: uart@d4017000 {
 				status = "disabled";
 			};
 
-			uart3: uart@d4018000 {
+			uart3: serial@d4018000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <24>;
@@ -238,7 +238,7 @@ uart3: uart@d4018000 {
 				status = "disabled";
 			};
 
-			uart4: uart@d4016000 {
+			uart4: serial@d4016000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4016000 0x1000>;
 				interrupts = <46>;
diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 59a108e49b41e..7a5b9962497e4 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -318,7 +318,7 @@ timer: timer@d4014000 {
 				clocks = <&soc_clocks MMP2_CLK_TIMER>;
 			};
 
-			uart1: uart@d4030000 {
+			uart1: serial@d4030000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4030000 0x1000>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
@@ -328,7 +328,7 @@ uart1: uart@d4030000 {
 				status = "disabled";
 			};
 
-			uart2: uart@d4017000 {
+			uart2: serial@d4017000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4017000 0x1000>;
 				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
@@ -338,7 +338,7 @@ uart2: uart@d4017000 {
 				status = "disabled";
 			};
 
-			uart3: uart@d4018000 {
+			uart3: serial@d4018000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4018000 0x1000>;
 				interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
@@ -348,7 +348,7 @@ uart3: uart@d4018000 {
 				status = "disabled";
 			};
 
-			uart4: uart@d4016000 {
+			uart4: serial@d4016000 {
 				compatible = "mrvl,mmp-uart";
 				reg = <0xd4016000 0x1000>;
 				interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

