Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF590C433C1
	for <linux-serial@archiver.kernel.org>; Sun, 28 Mar 2021 15:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A962661974
	for <linux-serial@archiver.kernel.org>; Sun, 28 Mar 2021 15:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhC1PqF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 28 Mar 2021 11:46:05 -0400
Received: from smtp.wifcom.cz ([85.207.3.150]:36824 "EHLO smtp.wifcom.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhC1Ppp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 28 Mar 2021 11:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=vpikJD29gomwC8ZCLMcKJZFaNKhjOnwb++xunGrRQQY=;
        b=FjRxjHgQ/JU0splXWne3o9kBFZy2G/z0jd6nmLeR6XSOjhL04ELAZ2IuF++sSM8g8+6wdfvhIg0D5Ob0hV4qL9oLgvrchpXVWi3dhQy1m3o+SUEM8pro7Pt+jHEgGkEumcvg47lccuzQzrr5dkkV/rQcpEOunnzQ8uzZJ+B4ibk=;
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
Subject: [PATCH v8 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
Date:   Sun, 28 Mar 2021 17:43:05 +0200
Message-Id: <20210328154306.22674-1-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <YF3tKmzX1PtlX59x@kroah.com>
References: <YF3tKmzX1PtlX59x@kroah.com>
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Wif-ss: -1.1 (-)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add new rx-tx-swap property to allow for RX & TX pin swapping.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v8:
  - rebase to the latest tty-next
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
---
 .../devicetree/bindings/serial/st,stm32-uart.yaml  | 29 ++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..126e07566965 100644
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

