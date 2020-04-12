Return-Path: <SRS0=Ld9p=54=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A4C2BA2B
	for <linux-serial@archiver.kernel.org>; Sun, 12 Apr 2020 18:16:22 +0000 (UTC)
X-Greylist: delayed 75 seconds by postgrey-1.34 at mail.kernel.org; Sun, 12 Apr 2020 18:16:22 UTC
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKZgTR5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADC35206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC35206C3
	for <linux-serial@archiver.kernel.org>; Sun, 12 Apr 2020 18:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgDLSPG (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 12 Apr 2020 14:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgDLSPF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 12 Apr 2020 14:15:05 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 14:15:05 EDT
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03DAC0A88B8;
        Sun, 12 Apr 2020 11:09:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [157.50.0.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E80E4206E9;
        Sun, 12 Apr 2020 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586714998;
        bh=BUxT5IqaNvB9TgDMR7VN/qHcX2xgt0z3BHmRoAVi8ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKZgTR5H9n/+i9uvei5y+H4cpl7/P9LBuQV/mbHcvLwYjnhiUvBzUgKziqmln0BMf
         WMtSvMLCAXeyZryxOSU5YTztOHiOm75PVTsi6C8yxESQTxhFRuDVfYk9Uf0/68c/DM
         B+ujRUPVFg89VKeOKHTM6wPiy+vAQohRPyOCk3b0=
From:   mani@kernel.org
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 1/2] dt-bindings: serial: Add binding for software flow control in STM32 UART
Date:   Sun, 12 Apr 2020 23:39:22 +0530
Message-Id: <20200412180923.30774-2-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412180923.30774-1-mani@kernel.org>
References: <20200412180923.30774-1-mani@kernel.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Add devicetree binding for software flow control in STM32 UART
controller. While at it, let's also fix one schema error reported by
`make dtbs_check`.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---

Rob: Still the `dtbs_check` validation fails. This is due to the
`linux,rs485-enabled-at-boot-time` property. I don't have any idea on how
to fix this.

 .../devicetree/bindings/serial/st,stm32-uart.yaml | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
index 238c44192d31..ea5797a1b403 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
@@ -38,13 +38,26 @@ properties:
     description: enable hardware flow control
     $ref: /schemas/types.yaml#/definitions/flag
 
+  st,sw-flow-ctrl:
+    description: enable software flow control
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  rts-gpios:
+    description: RTS pin used if st,sw-flow-ctrl is true
+    maxItems: 1
+
+  cts-gpios:
+    description: CTS pin used if st,sw-flow-ctrl is true
+    maxItems: 1
+
   dmas:
     minItems: 1
     maxItems: 2
 
   dma-names:
     items:
-      enum: [ rx, tx ]
+      - const: rx
+      - const: tx
     minItems: 1
     maxItems: 2
 
-- 
2.17.1

