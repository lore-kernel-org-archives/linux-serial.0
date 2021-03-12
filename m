Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AADC433E6
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 15:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42EC64FB8
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 15:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbhCLPjp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:39:45 -0500
Received: from smtp.wifcom.cz ([85.207.3.150]:47635 "EHLO smtp.wifcom.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232165AbhCLPjo (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 10:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=LxZqyySCpkVm6WBH2H3h8XdkfiFZZjSDTwsoFd8R1oE=;
        b=wuw60i32/m0uJ59OMHIiIK0yeo1QlIW0EsYrNmfLQz0QLCM6uuRufD8O/e/HZMFeJ1nissFR6vBgmqdAjpBoNk6Gyu0YfcuixFagXUfCrOwXVhPjjo5sX4zTtbakx5vtmYv6w3cCEaDVr2Z8mmoVKY3NrOnBMmiRwf7uFbIG23E=;
From:   Martin Devera <devik@eaxlabs.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Devera <devik@eaxlabs.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jiri Slaby <jirislaby@kernel.org>, Le Ray <erwan.leray@st.com>,
        fabrice.gasnier@foss.st.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
Date:   Fri, 12 Mar 2021 16:37:01 +0100
Message-Id: <20210312153702.12349-1-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
References: <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Wif-ss: -2.9 (--)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add new rx-tx-swap property to allow for RX & TX pin swapping.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
v7:
  - fix yaml linter warning
v6: 
  - add version changelog
v5: 
  - yaml fixes based on Rob Herring comments
    - add serial.yaml reference
    - move compatible from 'then' to 'if'
v3:
  - don't allow rx-tx-swap for st,stm32-uart (suggested
    by Fabrice Gasnier)
v2:
  - change st,swap to rx-tx-swap (suggested by Rob Herring)
---
 .../devicetree/bindings/serial/st,stm32-uart.yaml  | 29 ++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..68a0f3ce8328 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -9,9 +9,6 @@ maintainers:
 
 title: STMicroelectronics STM32 USART bindings
 
-allOf:
-  - $ref: rs485.yaml
-
 properties:
   compatible:
     enum:
@@ -40,6 +37,8 @@ properties:
 
   uart-has-rtscts: true
 
+  rx-tx-swap: true
+
   dmas:
     minItems: 1
     maxItems: 2
@@ -66,13 +65,23 @@ properties:
   linux,rs485-enabled-at-boot-time: true
   rs485-rx-during-tx: true
 
-if:
-  required:
-    - st,hw-flow-ctrl
-then:
-  properties:
-    cts-gpios: false
-    rts-gpios: false
+allOf:
+  - $ref: rs485.yaml#
+  - $ref: serial.yaml#
+  - if:
+      required:
+        - st,hw-flow-ctrl
+    then:
+      properties:
+        cts-gpios: false
+        rts-gpios: false
+  - if:
+      properties:
+        compatible:
+          const: st,stm32-uart
+    then:
+      properties:
+        rx-tx-swap: false
 
 required:
   - compatible
-- 
2.11.0

