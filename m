Return-Path: <SRS0=zL5S=3D=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE89BC3F68F
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 12:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925CD2467C
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jan 2020 12:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="w7ctkzxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgANMd7 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:33:59 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4098 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgANMdz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jan 2020 07:33:55 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ECXKVn004923;
        Tue, 14 Jan 2020 13:33:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=0nqgUqSxwdpUconxF/xpmwGAMX5ggOvyFookkeKhb74=;
 b=w7ctkzxw2QhKmJRgqIQxoTLSOCVG+jjPHx9ZENhkAoaaAiy9a7Q8HynLFI9UwLGrQF6+
 CWUTqjjZaZ9peAAztdw189x9bv2pm+91yxLXVOJoq2YFMN6zZlaQ+l0mEqzrKP05TyTC
 bTl5SCd3HtXBsCs18kH4R9O27goWE1UWPcr8z1Gl7cfx1jmVeKlq9dbkbWzSK/SvhEtO
 qKmR3RRjePEToNFzkFDsxpREKkELGXvdc5TzDjeSj31eDykNJzg/5A31ZElRaPxHgei7
 JYfX1aeKP63FXtYvrpIOxAjG0e95S9ThGraK6U/tau6hAutY4nWo5JT/OZpv2ZXJpl3G qA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78s5f00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 13:33:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 09EA510003A;
        Tue, 14 Jan 2020 13:33:34 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EB2632AD9EC;
        Tue, 14 Jan 2020 13:33:33 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 14 Jan 2020 13:33:33
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
Subject: [PATCH 1/2] dt-bindings: serial: Convert rs485 bindings to json-schema
Date:   Tue, 14 Jan 2020 13:33:28 +0100
Message-ID: <20200114123329.3792-2-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200114123329.3792-1-benjamin.gaignard@st.com>
References: <20200114123329.3792-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Convert rs485 binding to yaml style file.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
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
index 000000000000..65c6a98969a8
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
+      - $ref: /schemas/types.yaml#/definitions/uint32-matrix
+      - items:
+          items:
+            - description:
+                Delay between rts signal and beginning of data sent in milliseconds.
+                It corresponds to the delay before sending data.
+              $ref: "/schemas/types.yaml#/definitions/uint32"
+              default: 0
+            - description:
+                Delay between end of data sent and rts signal in milliseconds.
+                It corresponds to the delay after sending data and actual release of the line.
+              $ref: "/schemas/types.yaml#/definitions/uint32"
+              default: 0
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

