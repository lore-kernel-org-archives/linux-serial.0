Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D74C2D0E4
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A8823B8A
	for <linux-serial@archiver.kernel.org>; Fri, 18 Dec 2020 19:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbgLRTBa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:01:30 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41124 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726011AbgLRTB3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Dec 2020 14:01:29 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIIx6no005387;
        Fri, 18 Dec 2020 20:00:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Ka8iceOB3Xs/cEsTiVyBu9ihsXtHU5bQ3J2Fth7vxDs=;
 b=8HLJXbMULBYk+f+yA3V68ljwcZKjhMMTxXOeRVu4L7SUchlxxI2HdrYC9WusE8QfVjR0
 anSTOImIIdUu6H/3bhNuS2oo1os85JbH/SuNSQwjSRDXi3a03rG+JLtrzJJDIOD/v5Kd
 aS9ctsbvPlItRmSO9TR6qmij0kaLvnw/BPcehKdRsLO7X7qfH3t6/nj51PXJZdBoW3oG
 1d5yOtwGaZi+H7Q/2t5zJA3sTdkt0X+cmIyXBvjkASLXAqQH0wIlkkYD/MkcDEEUDtVs
 Mi1BZ8l6pZx6gA9tx6C9gE31r420g5Fk+jSN7hzR+HF9dYx8vXTXhjj/xq7qQ7+9beke Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 35cpwern1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 20:00:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F2E0510002A;
        Fri, 18 Dec 2020 20:00:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E4C04228601;
        Fri, 18 Dec 2020 20:00:30 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 18 Dec 2020 20:00:30
 +0100
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
Subject: [PATCH 5/8] dt-bindings: serial: stm32: update rts-gpios and cts-gpios
Date:   Fri, 18 Dec 2020 20:00:16 +0100
Message-ID: <20201218190020.1572-6-erwan.leray@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218190020.1572-1-erwan.leray@foss.st.com>
References: <20201218190020.1572-1-erwan.leray@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_12:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Update rts-gpios and cts-gpios:
- remove max-items as already defined in serial.yaml
- add a note describing rts-gpios and cts-gpios usage with stm32

Document the use of cts-gpios and rts-gpios for flow control in STM32 UART
controller. These properties can be used instead of 'uart-has-rtscts' or
'st,hw-flow-ctrl' (deprecated) for making use of any gpio pins for flow
control instead of dedicated pins.
It should be noted that both cts-gpios/rts-gpios and 'uart-has-rtscts' or
'st,hw-flow-ctrl' (deprecated) properties cannot co-exist in a design.

Signed-off-by: Erwan Le Ray <erwan.leray@foss.st.com>

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 06d5f251ec88..8631678283f9 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -50,11 +50,14 @@ properties:
     minItems: 1
     maxItems: 2
 
-  cts-gpios:
-    maxItems: 1
-
-  rts-gpios:
-    maxItems: 1
+# cts-gpios and rts-gpios properties can be used instead of 'uart-has-rtscts'
+# or 'st,hw-flow-ctrl' (deprecated) for making use of any gpio pins for flow
+# control instead of dedicated pins.
+#
+# It should be noted that both cts-gpios/rts-gpios and 'uart-has-rtscts' or
+# 'st,hw-flow-ctrl' (deprecated) properties cannot co-exist in a design.
+  cts-gpios: true
+  rts-gpios: true
 
   wakeup-source: true
 
-- 
2.17.1

