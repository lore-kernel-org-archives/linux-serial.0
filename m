Return-Path: <SRS0=zA/y=5F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4B0C43332
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C3120722
	for <linux-serial@archiver.kernel.org>; Fri, 20 Mar 2020 17:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbgCTRla (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:41:30 -0400
Received: from v6.sk ([167.172.42.174]:51822 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbgCTRl3 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:29 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 5EEA760FF9;
        Fri, 20 Mar 2020 17:41:27 +0000 (UTC)
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
Subject: [PATCH 04/10] ARM: dts: mmp2-brownstone: Don't redeclare phandle references
Date:   Fri, 20 Mar 2020 18:41:01 +0100
Message-Id: <20200320174107.29406-5-lkundrak@v3.sk>
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
 arch/arm/boot/dts/mmp2-brownstone.dts | 330 +++++++++++++-------------
 1 file changed, 164 insertions(+), 166 deletions(-)

diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index aaedc4c742ea5..04f1ae1382e7a 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -19,176 +19,174 @@ memory {
 		device_type = "memory";
 		reg = <0x00000000 0x08000000>;
 	};
+};
 
-	soc {
-		apb@d4000000 {
-			uart3: uart@d4018000 {
-				status = "okay";
-			};
-			twsi1: i2c@d4011000 {
-				status = "okay";
-				pmic: max8925@3c {
-					compatible = "maxium,max8925";
-					reg = <0x3c>;
-					interrupts = <1>;
-					interrupt-parent = <&intcmux4>;
-					interrupt-controller;
-					#interrupt-cells = <1>;
-					maxim,tsc-irq = <0>;
+&uart3 {
+	status = "okay";
+};
 
-					regulators {
-						SDV1 {
-							regulator-min-microvolt = <637500>;
-							regulator-max-microvolt = <1425000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						SDV2 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2225000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						SDV3 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO1 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO2 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2250000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO3 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2250000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO4 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO5 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO6 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO7 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO8 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO9 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO10 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-						};
-						LDO11 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO12 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO13 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO14 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO15 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO16 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO17 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2250000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO18 {
-							regulator-min-microvolt = <650000>;
-							regulator-max-microvolt = <2250000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO19 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-						LDO20 {
-							regulator-min-microvolt = <750000>;
-							regulator-max-microvolt = <3900000>;
-							regulator-boot-on;
-							regulator-always-on;
-						};
-					};
-					backlight {
-						maxim,max8925-dual-string = <0>;
-					};
-					charger {
-						batt-detect = <0>;
-						topoff-threshold = <1>;
-						fast-charge = <7>;
-						no-temp-support = <0>;
-						no-insert-detect = <0>;
-					};
-				};
+&twsi1 {
+	status = "okay";
+	pmic: max8925@3c {
+		compatible = "maxium,max8925";
+		reg = <0x3c>;
+		interrupts = <1>;
+		interrupt-parent = <&intcmux4>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		maxim,tsc-irq = <0>;
+
+		regulators {
+			SDV1 {
+				regulator-min-microvolt = <637500>;
+				regulator-max-microvolt = <1425000>;
+				regulator-boot-on;
+				regulator-always-on;
 			};
-			rtc: rtc@d4010000 {
-				status = "okay";
+			SDV2 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2225000>;
+				regulator-boot-on;
+				regulator-always-on;
 			};
+			SDV3 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO1 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO2 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO3 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO4 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO5 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO6 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO7 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO8 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO9 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO10 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+			};
+			LDO11 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO12 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO13 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO14 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO15 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO16 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO17 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO18 {
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2250000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO19 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			LDO20 {
+				regulator-min-microvolt = <750000>;
+				regulator-max-microvolt = <3900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+		backlight {
+			maxim,max8925-dual-string = <0>;
+		};
+		charger {
+			batt-detect = <0>;
+			topoff-threshold = <1>;
+			fast-charge = <7>;
+			no-temp-support = <0>;
+			no-insert-detect = <0>;
 		};
 	};
 };
+
+&rtc {
+	status = "okay";
+};
-- 
2.25.1

