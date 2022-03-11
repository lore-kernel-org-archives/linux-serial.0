Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D9FC433F5
	for <linux-serial@archiver.kernel.org>; Fri, 11 Mar 2022 09:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347675AbiCKJqd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347649AbiCKJq2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Mar 2022 04:46:28 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7141BE4D8;
        Fri, 11 Mar 2022 01:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646991924;
  x=1678527924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HGte/zaS5mfJUA4/Q4DGs8r+NCytaCeHNe8LA2QiASY=;
  b=m9KCbxlJCv+udCdeH0UTFeus96wzYIUKN9pTop2RX5Fd+luLE2vDpFCS
   75nIXFKQ1aPgEzniLjIJjyhyL6Hr2C+mIVHCoV3dUx6IpXj2l3TWI8nxm
   06H2TpVMb9BB4rP/QTku4d/wjowePuoO/LognOsU1hBP84UyCYFsQKyKx
   Feu0D9aleBLCk6wu444hdJZWndQk30LuazgSt60DE7oBGYbSEvpeuaEWE
   kv36kzXpL+QeK9vwLEoyFXnzwrrzfVl8t26hDeZGTH3IN9wUNuBkxPPHO
   ek7EH92HaYfi5fw2CMuE/r98uiEc+dtaYDhYadJQn0BswtPjWzBoDnBlG
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <krzysztof.kozlowski@canonical.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <alim.akhtar@samsung.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: samsung: Add ARTPEC-8 UART
Date:   Fri, 11 Mar 2022 10:45:14 +0100
Message-ID: <20220311094515.3223023-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
References: <20220311094515.3223023-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a compatible for the UART on the ARTPEC-8 SoC.  This hardware block
is closely related to the variants used on the Exynos chips.  The
register layout is identical to Exynos850 et al but the fifo size is
different (64 bytes in each direction for all instances).

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v2:
    - Expand commit message.
    - Define required clocks.

 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 2940afb874b3..c2423144a4d6 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -20,6 +20,7 @@ properties:
     items:
       - enum:
           - apple,s5l-uart
+          - axis,artpec8-uart
           - samsung,s3c2410-uart
           - samsung,s3c2412-uart
           - samsung,s3c2440-uart
@@ -110,6 +111,7 @@ allOf:
           contains:
             enum:
               - apple,s5l-uart
+              - axis,artpec8-uart
               - samsung,exynos4210-uart
     then:
       properties:
-- 
2.34.1

