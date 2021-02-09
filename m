Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F318C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  9 Feb 2021 10:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A2E364E9A
	for <linux-serial@archiver.kernel.org>; Tue,  9 Feb 2021 10:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbhBIKNZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Feb 2021 05:13:25 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:25200 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231357AbhBIKFr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Feb 2021 05:05:47 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119A3J5D013945;
        Tue, 9 Feb 2021 11:04:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=Zj/l8ff2MIZmWBD3LcqbfDM/Ef46Cl4XOGv3ADgIyNc=;
 b=PWfDQFPyU4OuTbue0ooJSSoXsO8IztiRA3CedEem0X8kEpS4ERcnDyauK8Nuqkr7SBUr
 ftkj86/VVHQaExX6iXMvdWn4B5NpTIHWThwgZsdyAth8YzP+OV6HbmfK0O08UkeahC2s
 01SYWhpKizqsqraniYg0fdQpBIua/DNWPtLmTyGdGRC54zYrPzf1r2dWCZ3u4MA+yENs
 oWZYujdLgg5Deo4Sfb7SkF/h4TR7qcuC1N8v0zkGNj+9niF/zVBK+U39uori/8Mb8McL
 Zyg1uEP/Z3iKVOFhzOmaNQ105TeflBzQTsNbCPrjVKr8m3XMqgk+9shKO+jBb9W+f9w0 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36hr31frb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 11:04:51 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 885E110002A;
        Tue,  9 Feb 2021 11:04:49 +0100 (CET)
Received: from Webmail-eu.st.com (gpxdag2node6.st.com [10.75.127.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 72E9B22453E;
        Tue,  9 Feb 2021 11:04:49 +0100 (CET)
Received: from localhost (10.75.127.122) by GPXDAG2NODE6.st.com (10.75.127.70)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb 2021 11:04:48
 +0100
From:   Valentin Caron <valentin.caron@foss.st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: serial: stm32: add examples
Date:   Tue, 9 Feb 2021 10:59:48 +0100
Message-ID: <20210209095948.15889-1-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.122]
X-ClientProxiedBy: GPXDAG1NODE5.st.com (10.75.127.66) To GPXDAG2NODE6.st.com
 (10.75.127.70)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_02:2021-02-09,2021-02-09 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Valentin Caron <valentin.caron@st.com>

Add examples to show more use cases :
 - uart2 with hardware flow control
 - uart4 without flow control

Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 .../bindings/serial/st,stm32-uart.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 06d5f251ec88..3a4aab5d1862 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -82,6 +82,26 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/stm32mp1-clks.h>
+
+    usart4: serial@40004c00 {
+      compatible = "st,stm32-uart";
+      reg = <0x40004c00 0x400>;
+      interrupts = <52>;
+      clocks = <&clk_pclk1>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_usart4>;
+    };
+
+    usart2: serial@40004400 {
+      compatible = "st,stm32-uart";
+      reg = <0x40004400 0x400>;
+      interrupts = <38>;
+      clocks = <&clk_pclk1>;
+      st,hw-flow-ctrl;
+      pinctrl-names = "default";
+      pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rtscts>;
+    };
+
     usart1: serial@40011000 {
       compatible = "st,stm32-uart";
       reg = <0x40011000 0x400>;
-- 
2.17.1

