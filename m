Return-Path: <SRS0=aJ84=3L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3879AC2D0DB
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCBA20704
	for <linux-serial@archiver.kernel.org>; Wed, 22 Jan 2020 09:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sfHOOtVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbgAVJ4P (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:56:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36142 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730120AbgAVJ4O (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Jan 2020 04:56:14 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00M9rrMZ005275;
        Wed, 22 Jan 2020 10:56:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=s07sRjVZ0SVXOOYoRmcEc515pUwV9NcjWvaQS3FOy84=;
 b=sfHOOtVmej9FNBH0/4QDl+9r+JJjgdbv0ooNUsKuMJOwawF4z2WQqLUoeZgRisIbVuV4
 W9cBblYni1ydi4KncnV/uwJDJOz60gRT2V6Jueule0/M9YnATlsSnL7VAUuoSj3BUxTN
 3+DsOW+tPqjKJcytQYo+SZsi8be77tCsm8CZI233OsSQUPun5SM5M0EynZ9wIVBrPGox
 5vr4z5aA659FQ5oRTQYKQLC7GkSEJiX+200cPDgDGlwQVbcc7JxPzm/SfwkMmOU/XQzn
 34WGrHgTT6PT7t0miDHVrwbBfXgW29Rx5e4z/qPWLPGXvZqw5vq0fGMTSc0Ni21dfDKN 6w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkssp3dmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 10:56:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 337A310002A;
        Wed, 22 Jan 2020 10:56:01 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1EC392AD14D;
        Wed, 22 Jan 2020 10:56:01 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Jan 2020 10:56:00
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <fabrice.gasnier@st.com>,
        <erwan.leray@st.com>, Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: Convert rs485 bindings to json-schema
Date:   Wed, 22 Jan 2020 10:55:57 +0100
Message-ID: <20200122095558.22553-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200122095558.22553-1-benjamin.gaignard@st.com>
References: <20200122095558.22553-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert rs485 binding to yaml style file.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2:
- remove types inside rs485-rts-delay property and add a maximum for delay
  values

 Documentation/devicetree/bindings/serial/rs485.txt | 32 +--------------
 .../devicetree/bindings/serial/rs485.yaml          | 45 ++++++++++++++++++++++
 2 files changed, 46 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/rs485.yaml

diff --git a/Documentation/devicetree/bindings/serial/rs485.txt b/Documentation/devicetree/bindings/serial/rs485.txt
index b92592dff6dd..a7fe93efc4a5 100644
--- a/Documentation/devicetree/bindings/serial/rs485.txt
+++ b/Documentation/devicetree/bindings/serial/rs485.txt
@@ -1,31 +1 @@
-* RS485 serial communications
-
-The RTS signal is capable of automatically controlling line direction for
-the built-in half-duplex mode.
-The properties described hereafter shall be given to a half-duplex capable
-UART node.
-
-Optional properties:
-- rs485-rts-delay: prop-encoded-array <a b> where:
-  * a is the delay between rts signal and beginning of data sent in milliseconds.
-      it corresponds to the delay before sending data.
-  * b is the delay between end of data sent and rts signal in milliseconds
-      it corresponds to the delay after sending data and actual release of the line.
-  If this property is not specified, <0 0> is assumed.
-- rs485-rts-active-low: drive RTS low when sending (default is high).
-- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
-  feature at boot time. It can be disabled later with proper ioctl.
-- rs485-rx-during-tx: empty property that enables the receiving of data even
-  while sending data.
-
-RS485 example for Atmel USART:
-	usart0: serial@fff8c000 {
-		compatible = "atmel,at91sam9260-usart";
-		reg = <0xfff8c000 0x4000>;
-		interrupts = <7>;
-		atmel,use-dma-rx;
-		atmel,use-dma-tx;
-		linux,rs485-enabled-at-boot-time;
-		rs485-rts-delay = <0 200>;		// in milliseconds
-	};
-
+See rs485.yaml
diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
new file mode 100644
index 000000000000..d4beaf11222d
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/rs485.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RS485 serial communications Bindings
+
+description: The RTS signal is capable of automatically controlling
+             line direction for the built-in half-duplex mode.
+             The properties described hereafter shall be given to a
+             half-duplex capable UART node.
+
+maintainers:
+  -  Rob Herring <robh@kernel.org>
+
+properties:
+  rs485-rts-delay:
+    description: prop-encoded-array <a b>
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - items:
+          items:
+            - description:
+                Delay between rts signal and beginning of data sent in milliseconds.
+                It corresponds to the delay before sending data.
+              default: 0
+              maximum: 1000
+            - description:
+                Delay between end of data sent and rts signal in milliseconds.
+                It corresponds to the delay after sending data and actual release of the line.
+              default: 0
+              maximum: 1000
+
+  rs485-rts-active-low:
+    description: drive RTS low when sending (default is high).
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  linux,rs485-enabled-at-boot-time:
+    description: enables the rs485 feature at boot time. It can be disabled later with proper ioctl.
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  rs485-rx-during-tx:
+   description: enables the receiving of data even while sending data.
+   $ref: /schemas/types.yaml#/definitions/flag
-- 
2.15.0

