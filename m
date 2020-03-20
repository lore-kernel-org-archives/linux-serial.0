Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EF3C4332B
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03FE20722
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgCTRlT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:41:19 -0400
Received: from v6.sk ([167.172.42.174]:51716 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgCTRlS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:18 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 9D97B60EED;
        Fri, 20 Mar 2020 17:41:16 +0000 (UTC)
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
Subject: [PATCH 01/10] ARM: dts: pxa*: Don't redeclare phandle references
Date:   Fri, 20 Mar 2020 18:40:58 +0100
Message-Id: <20200320174107.29406-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320174107.29406-1-lkundrak@v3.sk>
References: <20200320174107.29406-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Extend the nodes by their phandle references instead of recreating the
tree and declaring references of the same names.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/pxa168-aspenite.dts |  26 ++-
 arch/arm/boot/dts/pxa910-dkb.dts      | 288 +++++++++++++-------------
 2 files changed, 155 insertions(+), 159 deletions(-)

diff --git a/arch/arm/boot/dts/pxa168-aspenite.dts b/arch/arm/boot/dts/pxa168-aspenite.dts
index 2ad40e373194c..8bade6bf395b3 100644
--- a/arch/arm/boot/dts/pxa168-aspenite.dts
+++ b/arch/arm/boot/dts/pxa168-aspenite.dts
@@ -18,18 +18,16 @@ chosen {
 	memory {
 		reg = <0x00000000 0x04000000>;
 	};
-
-	soc {
-		apb@d4000000 {
-			uart1: uart@d4017000 {
-				status = "okay";
-			};
-			twsi1: i2c@d4011000 {
-				status = "okay";
-			};
-			rtc: rtc@d4010000 {
-				status = "okay";
-			};
-		};
-	};
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&twsi1 {
+	status = "okay";
+};
+
+&rtc {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
index 0f899e672e824..ce76158867c7f 100644
--- a/arch/arm/boot/dts/pxa910-dkb.dts
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
@@ -18,155 +18,153 @@ chosen {
 	memory {
 		reg = <0x00000000 0x10000000>;
 	};
+};
 
-	soc {
-		apb@d4000000 {
-			uart1: uart@d4017000 {
-				status = "okay";
+&uart1 {
+	status = "okay";
+};
+
+&twsi1 {
+	status = "okay";
+
+	pmic: 88pm860x@34 {
+		compatible = "marvell,88pm860x";
+		reg = <0x34>;
+		interrupts = <4>;
+		interrupt-parent = <&intc>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		marvell,88pm860x-irq-read-clr;
+		marvell,88pm860x-slave-addr = <0x11>;
+
+		regulators {
+			BUCK1 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
 			};
-			twsi1: i2c@d4011000 {
-				status = "okay";
-
-				pmic: 88pm860x@34 {
-					compatible = "marvell,88pm860x";
-					reg = <0x34>;
-					interrupts = <4>;
-					interrupt-parent = <&intc>;
-					interrupt-controller;
-					#interrupt-cells = <1>;
-
-					marvell,88pm860x-irq-read-clr;
-					marvell,88pm860x-slave-addr = <0x11>;
-
-					regulators {
-						BUCK1 {
-							regulator-min-microvolt = <1000000>;
-							regulator-max-microvolt = <1500000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						BUCK2 {
-							regulator-min-microvolt = <1000000>;
-							regulator-max-microvolt = <1500000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						BUCK3 {
-							regulator-min-microvolt = <1000000>;
-							regulator-max-microvolt = <3000000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO1 {
-							regulator-min-microvolt = <1200000>;
-							regulator-max-microvolt = <2800000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO2 {
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO3 {
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO4 {
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-						LDO5 {
-							regulator-min-microvolt = <2900000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO6 {
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO7 {
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <2900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO8 {
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <2900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO9 {
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO10 {
-							regulator-min-microvolt = <1200000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO12 {
-							regulator-min-microvolt = <1200000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-						LDO13 {
-							regulator-min-microvolt = <1200000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-						LDO14 {
-							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3300000>;
-							regulator-always-on;
-						};
-					};
-					rtc {
-						marvell,88pm860x-vrtc = <1>;
-					};
-					touch {
-						marvell,88pm860x-gpadc-prebias = <1>;
-						marvell,88pm860x-gpadc-slot-cycle = <1>;
-						marvell,88pm860x-tsi-prebias = <6>;
-						marvell,88pm860x-pen-prebias = <16>;
-						marvell,88pm860x-pen-prechg = <2>;
-						marvell,88pm860x-resistor-X = <300>;
-					};
-					backlights {
-						backlight-0 {
-							marvell,88pm860x-iset = <4>;
-							marvell,88pm860x-pwm = <3>;
-						};
-						backlight-2 {
-						};
-					};
-					leds {
-						led0-red {
-							marvell,88pm860x-iset = <12>;
-						};
-						led0-green {
-							marvell,88pm860x-iset = <12>;
-						};
-						led0-blue {
-							marvell,88pm860x-iset = <12>;
-						};
-					};
-				};
+			BUCK2 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-boot-on;
+				regulator-always-on;
 			};
-			rtc: rtc@d4010000 {
-				status = "okay";
+			BUCK3 {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO1 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <2800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+			LDO5 {
+				regulator-min-microvolt = <2900000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO7 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO8 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <2900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO9 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO10 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO12 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+			LDO13 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+			LDO14 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+		rtc {
+			marvell,88pm860x-vrtc = <1>;
+		};
+		touch {
+			marvell,88pm860x-gpadc-prebias = <1>;
+			marvell,88pm860x-gpadc-slot-cycle = <1>;
+			marvell,88pm860x-tsi-prebias = <6>;
+			marvell,88pm860x-pen-prebias = <16>;
+			marvell,88pm860x-pen-prechg = <2>;
+			marvell,88pm860x-resistor-X = <300>;
+		};
+		backlights {
+			backlight-0 {
+				marvell,88pm860x-iset = <4>;
+				marvell,88pm860x-pwm = <3>;
+			};
+			backlight-2 {
+			};
+		};
+		leds {
+			led0-red {
+				marvell,88pm860x-iset = <12>;
+			};
+			led0-green {
+				marvell,88pm860x-iset = <12>;
+			};
+			led0-blue {
+				marvell,88pm860x-iset = <12>;
 			};
 		};
 	};
 };
+
+&rtc {
+	status = "okay";
+};
-- 
2.25.1

