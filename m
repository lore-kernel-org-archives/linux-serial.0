Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71FFC433DB
	for <linux-serial@archiver.kernel.org>; Sat, 27 Feb 2021 18:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A977E64E46
	for <linux-serial@archiver.kernel.org>; Sat, 27 Feb 2021 18:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhB0SFj (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Feb 2021 13:05:39 -0500
Received: from ms9.eaxlabs.cz ([147.135.177.209]:60970 "EHLO ms9.eaxlabs.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhB0SDK (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Feb 2021 13:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=8wPT4Fm48tx8LmVMJofADhT1X8gmYD2rnn9e/GVcaI8=;
        b=DAA86fc2l4F9PgbnBHiDCmOFqfsgbk40nERbUwxTJ/aQJF4QQ7Vy6R/T9Fq05piUaSUIrsBr1ObHawdlhdj3shaXI6AuaQK79snC1Qvrc03FPXBakdU+lEBcxsRs62twvdzVQiLYIA0siRsPkcQzw8JCQVWYhbbh+VUbULrwsUc=;
Received: from [82.99.129.6] (helo=localhost.localdomain)
        by ms9.eaxlabs.cz with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <devik@eaxlabs.cz>)
        id 1lG2fg-0005pS-Ed; Sat, 27 Feb 2021 17:42:26 +0100
From:   Martin Devera <devik@eaxlabs.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Martin Devera <devik@eaxlabs.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jiri Slaby <jirislaby@kernel.org>, Le Ray <erwan.leray@st.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
Date:   Sat, 27 Feb 2021 17:41:57 +0100
Message-Id: <20210227164157.30971-2-devik@eaxlabs.cz>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210227164157.30971-1-devik@eaxlabs.cz>
References: <CAL_JsqK8+M=Vg0PiDXP2f1LrEp4hSVea6piAASMGu1H=pxme6Q@mail.gmail.com>
 <20210227164157.30971-1-devik@eaxlabs.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add new rx-tx-swap property to allow for RX & TX pin swapping.

Signed-off-by: Martin Devera <devik@eaxlabs.cz>
---
 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 8631678283f9..45f2a19997da 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -40,6 +40,10 @@ properties:
 
   uart-has-rtscts: true
 
+  rx-tx-swap:
+    type: boolean
+    maxItems: 1
+
   dmas:
     minItems: 1
     maxItems: 2
-- 
2.11.0

