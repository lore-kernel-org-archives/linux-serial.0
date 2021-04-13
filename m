Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01D4C43611
	for <linux-serial@archiver.kernel.org>; Tue, 13 Apr 2021 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99708613CF
	for <linux-serial@archiver.kernel.org>; Tue, 13 Apr 2021 17:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbhDMRlB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 13 Apr 2021 13:41:01 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48102 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232398AbhDMRk7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Apr 2021 13:40:59 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13DHVRM1008843;
        Tue, 13 Apr 2021 19:40:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=kWKeujSJDhbX3k9cwpPH58goeXuXklCREiTzjebN1Ak=;
 b=eWkv/UYtPc1/vrtNjhpJNMxuaXHgi7v9SWAhEM2ltVtv23tbi4lHv5yiUiz56kzwlOVl
 FFjjxlOBGbKqYvecTUofapwu7Uk7Lr18SQH0p4HapLR5Pd3FNFGEQiUHtm8QmEU8iPm8
 XqReyGkV/CjMz4D43VJ8ni59vzVdJCEtnNPjCgLNkOsrB8lMk6jWPSf3vz95Y7laSSUa
 287Bzl+xavxfChdhdd+z/LfyMcY6hNkYndwsxNEyBAYNdhJEjrxwyskbUtaW29WMBAg/
 agqnflEi4f4/qhbtmbprvn83a1xh4Q+00CWB/ldZAT+OILS9QCY/BdX9NDRUW8YgxJY8 LQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37vu4e66ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Apr 2021 19:40:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BDB1100034;
        Tue, 13 Apr 2021 19:40:21 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2B0842159E9;
        Tue, 13 Apr 2021 19:40:21 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Apr 2021 19:40:20
 +0200
From:   Erwan Le Ray <erwan.leray@foss.st.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Erwan Le Ray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: [PATCH v2 1/4] dt-bindings: serial: add RX and TX FIFO properties
Date:   Tue, 13 Apr 2021 19:40:12 +0200
Message-ID: <20210413174015.23011-2-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210413174015.23011-1-erwan.leray@foss.st.com>
References: <20210413174015.23011-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_12:2021-04-13,2021-04-13 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add two optional DT properties to configure RX and TX FIFO thresholds:
- rx-threshold
- tx-threshold

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
index 65e75d040521..f368d58e8086 100644
--- a/Documentation/devicetree/bindings/serial/serial.yaml
+++ b/Documentation/devicetree/bindings/serial/serial.yaml
@@ -75,6 +75,16 @@ properties:
     type: boolean
     description: CTS and RTS pins are swapped.
 
+  rx-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      RX FIFO threshold configuration (in bytes).
+
+  tx-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      TX FIFO threshold configuration (in bytes).
+
 if:
   required:
     - uart-has-rtscts
-- 
2.17.1

