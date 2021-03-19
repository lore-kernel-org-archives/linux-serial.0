Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380E7C433E6
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C466198C
	for <linux-serial@archiver.kernel.org>; Fri, 19 Mar 2021 18:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhCSSpB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Mar 2021 14:45:01 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:42774 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230223AbhCSSoW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Mar 2021 14:44:22 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JIg5LT007150;
        Fri, 19 Mar 2021 19:43:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=WPsJD07taG6bSi67dQZQOBWHCrvFMzxNJLWjag8WCLg=;
 b=zk8Uv9JTj3cidFrdljg1NFDz4H4W6P4azuDR1ihHguJflXGoKtnOqAoSHRjyGHVAYWWq
 cjsk4osSMke887jZnw/mT+T+3wOvwqqqmmoopDku9Yhvh0RpdR4g153zdj4NxeMMqeJQ
 IwIE+uE9LcGDALfekvup1BsshTHbJtymMh/I0vbEYG68Wusc/PEM2RUcJ7rjBAGYZ1iS
 q/GIM9m/0sBRj6+VFcCQfFvfdHmEjpZl8lw2d6KwTTezf7WuByKuiOy/6cM92X4htfJe
 8P9aOuK4QGf9I9CtGV4f54C0dix/ht1vfWUYYdnB6Rnoe2ESCK7WtP9RWQAxf7CxCXLP nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 378psa4ygs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 19:43:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F19810002A;
        Fri, 19 Mar 2021 19:43:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7D0B62721FC;
        Fri, 19 Mar 2021 19:43:27 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 19 Mar 2021 19:43:27
 +0100
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 5/5] ARM: dts: stm32: Add wakeup management on stm32mp15x UART nodes
Date:   Fri, 19 Mar 2021 19:42:53 +0100
Message-ID: <20210319184253.5841-6-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210319184253.5841-1-erwan.leray@foss.st.com>
References: <20210319184253.5841-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add EXTI lines to the following UART nodes which are used for
wakeup from CStop.
- EXTI line 26 to USART1
- EXTI line 27 to USART2
- EXTI line 28 to USART3
- EXTI line 29 to USART6
- EXTI line 30 to UART4
- EXTI line 31 to UART5
- EXTI line 32 to UART7
- EXTI line 33 to UART8

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 4b8031782555..e242d7211059 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -452,32 +452,36 @@
 		usart2: serial@4000e000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000e000 0x400>;
-			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&exti 27 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART2_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
 		usart3: serial@4000f000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x4000f000 0x400>;
-			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&exti 28 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART3_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
 		uart4: serial@40010000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40010000 0x400>;
-			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&exti 30 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART4_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
 		uart5: serial@40011000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40011000 0x400>;
-			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&exti 31 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART5_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -577,16 +581,18 @@
 		uart7: serial@40018000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40018000 0x400>;
-			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&exti 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART7_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
 		uart8: serial@40019000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x40019000 0x400>;
-			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&exti 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc UART8_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -665,8 +671,9 @@
 		usart6: serial@44003000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x44003000 0x400>;
-			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&exti 29 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART6_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
@@ -1505,8 +1512,9 @@
 		usart1: serial@5c000000 {
 			compatible = "st,stm32h7-uart";
 			reg = <0x5c000000 0x400>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts-extended = <&exti 26 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc USART1_K>;
+			wakeup-source;
 			status = "disabled";
 		};
 
-- 
2.17.1

