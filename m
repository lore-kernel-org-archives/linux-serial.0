Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C981C4708D
	for <linux-serial@archiver.kernel.org>; Fri,  2 Dec 2022 10:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiLBKoF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 2 Dec 2022 05:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiLBKnq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 2 Dec 2022 05:43:46 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B061EA80BA;
        Fri,  2 Dec 2022 02:43:41 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id A1B3D5E99E;
        Fri,  2 Dec 2022 11:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669977770;
        bh=jqDVLZ1Ing9hJRDRxYi7bntuyllmW9Hd+BSl+I1NndE=;
        h=From:To:CC:Subject:Date:From;
        b=HU/pXZLZmRcF1uN0PFqfGG/og/EYzT8EzGJ7udmm9gEpOOkX9JCFzVSANYXIlfuMI
         tE5SmtRUfP/v6+Bo4GbkqEQy3Jdcrsftl2L0ti4lb+ozTgZiOyoU748gTKrc3/WkS5
         c3DyGZkTyI3BuyAO78hB00QVcMV0cplew+2Ar/OSF89/zBxwVVYSqIWPl3WXXS4ZZd
         Buc65mtcnhfd5ppZd8xKIUXBqITPq02n/mRxeW3p+8zHWzCNJ3Tft/V9Ggru1dNMe2
         00mBpEK48B3VsIy9V6vAbz/40sE1t3WpK5bN/0RbJT8+yDg5g/9UNFL2i0LOZ1PLJL
         nUDC4J9yaw8Vw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 2 Dec 2022 11:42:37 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Fri, 2 Dec 2022 11:42:36 +0100
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Alexander Dahl" <ada@thorsis.com>, <kernel@dh-electronics.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V4 1/4] dt-bindings: serial: rs485: Add GPIO controlling RX enable during TX
Date:   Fri, 2 Dec 2022 11:41:24 +0100
Message-ID: <20221202104127.122761-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add a binding for a generic definition of an output GPIO that sets the
state of rs485-rx-during-tx. The idea is that the hardware already controls
the option receiving during sending before it gets to the signal receiving
hardware. The standard RS485 is a half-duplex bus that in most cases is
driven by an UART controller. The advantage of using this GPIO is that it
is independent of the capabilities of the UART core and the UART driver.
On the hardware side the interface to the bus is controlled by a transceiver,
that has a pin called RE (RX Enable) or similar, which connects the bus to
the RX signal of the UART controller. The GPIO can switch between two states
to control the RE pin via an electrical circuit:
- Active:
  The RE pin is always active. The UART RX see everything on the bus and
  therefore also what happens with the TX signal on the bus.
- Inactive:
  The RE pin is always active, but during sending on the bus the pin RE is
  inactive. So basically the receiving during sending is suppressed.

A possible circuit diagram could look like this:
                                  ┌──────────────────┐
                                  │       RS485      │
                TX ───────────────┤D                 │
                                  │    Transceiver   │
               RTS ────┬──────────┤DE                │
                       │          │                  │
                       │ ┌─────┐  │                  │
                       └─┤&    │  │                  │
                         │     ├──┤!RE               │
!rx_during_tx_gpio ──────┤     │  │                  │
                         └─────┘  │                  │
                                  │                  │
                RX ───────────────┤R                 │
                                  │                  │
                                  └──────────────────┘

Here the RTS pin of the UART core is used to control TX via the transceiver
pin DE (Drive Enable). RE and rx_during_tx_gpio are active low.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Alexander Dahl <ada@thorsis.com>
Cc: Marek Vasut <marex@denx.de>
Cc: kernel@dh-electronics.com
Cc: devicetree@vger.kernel.org
To: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Rework of the commit message
    - Rework GPIO property comment
V3: - Rework the binding description
    - Rework message title
    - Rework of the commit message
V4: - Add Reviewed-by tag
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 90a1bab40f05..a973ab7d7e46 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -51,6 +51,12 @@ properties:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1
 
+  rs485-rx-during-tx-gpios:
+    description: Output GPIO pin that sets the state of rs485-rx-during-tx. This
+      signal can be used to control the RX part of an RS485 transceiver. Thereby
+      the active state enables RX during TX.
+    maxItems: 1
+
 additionalProperties: true
 
 ...
-- 
2.11.0

