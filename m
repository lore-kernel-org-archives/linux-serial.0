Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135C9C43332
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C305520773
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCTRlo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:41:44 -0400
Received: from v6.sk ([167.172.42.174]:51914 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgCTRln (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:43 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 6128A61090;
        Fri, 20 Mar 2020 17:41:40 +0000 (UTC)
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
Subject: [PATCH 08/10] powerpc/fsl: Make serial ports compatible with ns16550a
Date:   Fri, 20 Mar 2020 18:41:05 +0100
Message-Id: <20200320174107.29406-9-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
References: <20200320174107.29406-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

There are separate compatible strings for ns16550 and ns16550a and the
Freescale serial port is compatible with the latter one, with working
FIFO.

Use the appropriate compatible string that is also consistent with ARM64
Freescale boards and thus avoiding one special case in the binding schema.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/powerpc/boot/dts/asp834x-redboot.dts  | 4 ++--
 arch/powerpc/boot/dts/kmeter1.dts          | 2 +-
 arch/powerpc/boot/dts/kuroboxHD.dts        | 4 ++--
 arch/powerpc/boot/dts/kuroboxHG.dts        | 4 ++--
 arch/powerpc/boot/dts/mpc8308_p1m.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8308rdb.dts       | 4 ++--
 arch/powerpc/boot/dts/mpc8313erdb.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8315erdb.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc832x_mds.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc832x_rdb.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8349emitx.dts     | 4 ++--
 arch/powerpc/boot/dts/mpc8349emitxgp.dts   | 4 ++--
 arch/powerpc/boot/dts/mpc834x_mds.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc836x_mds.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc836x_rdk.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8377_mds.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8377_rdb.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8377_wlan.dts     | 4 ++--
 arch/powerpc/boot/dts/mpc8378_mds.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8378_rdb.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8379_mds.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8379_rdb.dts      | 4 ++--
 arch/powerpc/boot/dts/mpc8610_hpcd.dts     | 4 ++--
 arch/powerpc/boot/dts/socrates.dts         | 4 ++--
 arch/powerpc/boot/dts/storcenter.dts       | 4 ++--
 arch/powerpc/boot/dts/stxssa8555.dts       | 4 ++--
 arch/powerpc/boot/dts/tqm8540.dts          | 4 ++--
 arch/powerpc/boot/dts/tqm8541.dts          | 4 ++--
 arch/powerpc/boot/dts/tqm8548-bigflash.dts | 4 ++--
 arch/powerpc/boot/dts/tqm8548.dts          | 4 ++--
 arch/powerpc/boot/dts/tqm8555.dts          | 4 ++--
 arch/powerpc/boot/dts/xcalibur1501.dts     | 4 ++--
 arch/powerpc/boot/dts/xpedite5200.dts      | 4 ++--
 arch/powerpc/boot/dts/xpedite5200_xmon.dts | 4 ++--
 arch/powerpc/boot/dts/xpedite5301.dts      | 4 ++--
 arch/powerpc/boot/dts/xpedite5330.dts      | 4 ++--
 arch/powerpc/boot/dts/xpedite5370.dts      | 4 ++--
 37 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
index 52a84561c4f07..fea08278e4ce0 100644
--- a/arch/powerpc/boot/dts/asp834x-redboot.dts
+++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
@@ -250,7 +250,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <400000000>;
 			interrupts = <9 0x8>;
@@ -260,7 +260,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <400000000>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/kmeter1.dts b/arch/powerpc/boot/dts/kmeter1.dts
index 154f5d293fd3b..376720d15e572 100644
--- a/arch/powerpc/boot/dts/kmeter1.dts
+++ b/arch/powerpc/boot/dts/kmeter1.dts
@@ -76,7 +76,7 @@ i2c@3000 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <264000000>;
 			interrupts = <9 0x8>;
diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 0a4545159e800..a487f242d919f 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -84,7 +84,7 @@ rtc@32 {
 		serial0: serial@80004500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x80004500 0x8>;
 			clock-frequency = <97553800>;
 			current-speed = <9600>;
@@ -95,7 +95,7 @@ serial0: serial@80004500 {
 		serial1: serial@80004600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x80004600 0x8>;
 			clock-frequency = <97553800>;
 			current-speed = <57600>;
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 0e758b347cdb7..11c650cd1af35 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -84,7 +84,7 @@ rtc@32 {
 		serial0: serial@80004500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x80004500 0x8>;
 			clock-frequency = <130041000>;
 			current-speed = <9600>;
@@ -95,7 +95,7 @@ serial0: serial@80004500 {
 		serial1: serial@80004600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x80004600 0x8>;
 			clock-frequency = <130041000>;
 			current-speed = <57600>;
diff --git a/arch/powerpc/boot/dts/mpc8308_p1m.dts b/arch/powerpc/boot/dts/mpc8308_p1m.dts
index 2638555afcc45..8578dbf1f31b5 100644
--- a/arch/powerpc/boot/dts/mpc8308_p1m.dts
+++ b/arch/powerpc/boot/dts/mpc8308_p1m.dts
@@ -227,7 +227,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <9 0x8>;
@@ -237,7 +237,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8308rdb.dts b/arch/powerpc/boot/dts/mpc8308rdb.dts
index af2ed8380a867..3b42eede80bc6 100644
--- a/arch/powerpc/boot/dts/mpc8308rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8308rdb.dts
@@ -203,7 +203,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <9 0x8>;
@@ -213,7 +213,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index a8315795b2c95..d09db72277527 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -256,7 +256,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -266,7 +266,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index e09b37d7489d0..4fc0d3fbe39f3 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -259,7 +259,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <9 0x8>;
@@ -269,7 +269,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <133333333>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 3af073f01e71f..a9f95df92e694 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -102,7 +102,7 @@ rtc@68 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -112,7 +112,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index ecebc27a28987..435efd2f748fd 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -79,7 +79,7 @@ i2c@3000 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -89,7 +89,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index d4ebbb93de0b3..48b14d1d1f3a0 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -278,7 +278,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <9 0x8>;
@@ -288,7 +288,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index bcf68a0a7b557..5a460275cb93b 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -184,7 +184,7 @@ tbi0: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <9 0x8>;
@@ -194,7 +194,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;		// from bootloader
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 6c8cb859c55f8..386baac9c5a86 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -236,7 +236,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -246,7 +246,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index f4ca12ec57f18..38ca10da4e2d2 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -132,7 +132,7 @@ i2c@3100 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <264000000>;
 			interrupts = <9 0x8>;
@@ -142,7 +142,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <264000000>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index a0cc1953484d7..51e0b6754748f 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -98,7 +98,7 @@ i2c@3100 {
 
 		serial0: serial@4500 {
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			interrupts = <9 8>;
 			interrupt-parent = <&ipic>;
@@ -108,7 +108,7 @@ serial0: serial@4500 {
 
 		serial1: serial@4600 {
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			interrupts = <10 8>;
 			interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 9227bce0e2f56..11c522d4fffaa 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -270,7 +270,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -280,7 +280,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 7df452efa9579..dba5e7e1bc16a 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -316,7 +316,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -326,7 +326,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8377_wlan.dts b/arch/powerpc/boot/dts/mpc8377_wlan.dts
index d8e7d40aeae44..82d4517261597 100644
--- a/arch/powerpc/boot/dts/mpc8377_wlan.dts
+++ b/arch/powerpc/boot/dts/mpc8377_wlan.dts
@@ -298,7 +298,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -308,7 +308,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index e45b25554e8c7..aa1cd44284005 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -309,7 +309,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -319,7 +319,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index bdcfe83a561e1..af53d5f47719c 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -316,7 +316,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -326,7 +326,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index f7379a1cbb6c7..c11bc5cdaa954 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -307,7 +307,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -317,7 +317,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index a5f702304a353..9f58b82ce3d8d 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -314,7 +314,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <9 0x8>;
@@ -324,7 +324,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <10 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 33bbe58c1ad08..6b197f460e5cb 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -172,7 +172,7 @@ i2c@3100 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -183,7 +183,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/socrates.dts b/arch/powerpc/boot/dts/socrates.dts
index 00a56e8e367cd..2915af26be21a 100644
--- a/arch/powerpc/boot/dts/socrates.dts
+++ b/arch/powerpc/boot/dts/socrates.dts
@@ -195,7 +195,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -205,7 +205,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/storcenter.dts b/arch/powerpc/boot/dts/storcenter.dts
index 99f6f544dc5f8..5fed642164627 100644
--- a/arch/powerpc/boot/dts/storcenter.dts
+++ b/arch/powerpc/boot/dts/storcenter.dts
@@ -74,7 +74,7 @@ rtc@68 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x20>;
 			clock-frequency = <97553800>; /* Hz */
 			current-speed = <115200>;
@@ -85,7 +85,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x20>;
 			clock-frequency = <97553800>; /* Hz */
 			current-speed = <9600>;
diff --git a/arch/powerpc/boot/dts/stxssa8555.dts b/arch/powerpc/boot/dts/stxssa8555.dts
index 5dca2a91c41f6..59ea659d7d6d6 100644
--- a/arch/powerpc/boot/dts/stxssa8555.dts
+++ b/arch/powerpc/boot/dts/stxssa8555.dts
@@ -204,7 +204,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -214,7 +214,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index 9c1eb9779108c..11e855217a5c8 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -243,7 +243,7 @@ tbi2: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -253,7 +253,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 44595cf675d01..60f9be355857f 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -217,7 +217,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -227,7 +227,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index caa36c5ef1155..0139b40263758 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -296,7 +296,7 @@ tbi3: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			current-speed = <115200>;
@@ -307,7 +307,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			current-speed = <115200>;
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index 12a64410f349c..3f0579f6cbcd5 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -296,7 +296,7 @@ tbi3: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			current-speed = <115200>;
@@ -307,7 +307,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>;	// should we fill in in uboot?
 			current-speed = <115200>;
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 54f3e82907d69..90e5d007033a0 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -217,7 +217,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>; 	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
@@ -227,7 +227,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;	// reg base, size
 			clock-frequency = <0>; 	// should we fill in in uboot?
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/boot/dts/xcalibur1501.dts
index 46c25bda9515d..00dd0b65f9483 100644
--- a/arch/powerpc/boot/dts/xcalibur1501.dts
+++ b/arch/powerpc/boot/dts/xcalibur1501.dts
@@ -528,7 +528,7 @@ tbi3: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -539,7 +539,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/xpedite5200.dts b/arch/powerpc/boot/dts/xpedite5200.dts
index 840ea84bbb595..730ca82efa567 100644
--- a/arch/powerpc/boot/dts/xpedite5200.dts
+++ b/arch/powerpc/boot/dts/xpedite5200.dts
@@ -330,7 +330,7 @@ tbi3: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			current-speed = <115200>;
@@ -341,7 +341,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			current-speed = <115200>;
diff --git a/arch/powerpc/boot/dts/xpedite5200_xmon.dts b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
index 449fc1b5dc230..e123e3eb858c2 100644
--- a/arch/powerpc/boot/dts/xpedite5200_xmon.dts
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -334,7 +334,7 @@ tbi3: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			current-speed = <9600>;
@@ -345,7 +345,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			current-speed = <9600>;
diff --git a/arch/powerpc/boot/dts/xpedite5301.dts b/arch/powerpc/boot/dts/xpedite5301.dts
index 12184e1796381..4afac7c0693e0 100644
--- a/arch/powerpc/boot/dts/xpedite5301.dts
+++ b/arch/powerpc/boot/dts/xpedite5301.dts
@@ -438,7 +438,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -449,7 +449,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/xpedite5330.dts b/arch/powerpc/boot/dts/xpedite5330.dts
index e8fc90c52ad6b..013002a16bdda 100644
--- a/arch/powerpc/boot/dts/xpedite5330.dts
+++ b/arch/powerpc/boot/dts/xpedite5330.dts
@@ -474,7 +474,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -485,7 +485,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
diff --git a/arch/powerpc/boot/dts/xpedite5370.dts b/arch/powerpc/boot/dts/xpedite5370.dts
index 2b5aa2f3a7098..6b3f1cada6326 100644
--- a/arch/powerpc/boot/dts/xpedite5370.dts
+++ b/arch/powerpc/boot/dts/xpedite5370.dts
@@ -436,7 +436,7 @@ tbi1: tbi-phy@11 {
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4500 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
@@ -447,7 +447,7 @@ serial0: serial@4500 {
 		serial1: serial@4600 {
 			cell-index = <1>;
 			device_type = "serial";
-			compatible = "fsl,ns16550", "ns16550";
+			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
 			interrupts = <42 2>;
-- 
2.25.1

