Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBB3C4332F
	for <linux-serial@archiver.kernel.org>; Wed, 23 Nov 2022 12:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237169AbiKWMcs (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Nov 2022 07:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236447AbiKWMcq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Nov 2022 07:32:46 -0500
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9624EDEE7;
        Wed, 23 Nov 2022 04:32:41 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 6E7055DD10;
        Wed, 23 Nov 2022 13:31:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669206704;
        bh=amx/zyjZBJGMftjsLDTt/UwXEKNtP40hnCvAlZShRs0=;
        h=From:To:CC:Subject:Date:From;
        b=X0YGN9WQubxi+RS9cHBTzEKkoHha0d2OCtorSlc2w/ZUFq0m6TEOzpMN9eWl8EnUv
         V1wJfiodEBRgt2OXqSpt6maVGDPPfELx8T1OJ6o1y6XvJSHjozg7Vk+TxI+usooc09
         RvEpwp4fxgDlRV3YK+y5E+Hmvfa+OghNXrdhxd5DL2whrHmzusR80+b4ci4oRVCwDY
         XN3/TfKXDDglivO/lf9nD1PVz0vTZ30h6yMB1iPMpQKrv08LVkb1HkWgVwf3xqhteL
         PYFUwzDsKVVQepp3gEDVfI6V9GT+BXSPYNIEPVevyH9Jj+pjWilkFlronYGj2v2e9Q
         fWHpmPTy9uxvw==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Wed, 23 Nov 2022 13:31:35 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Wed, 23 Nov 2022 13:31:34 +0100
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
Subject: [PATCH V2 1/4] dt_bindings: rs485: Add binding for GPIO that controls Rx enable during Tx
Date:   Wed, 23 Nov 2022 13:30:01 +0100
Message-ID: <20221123123004.7216-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch adds a binding for a generic definition of an output GPIO that
indicates the state of rs485-rx-during-tx. The idea is that the hardware
already controls the option receiving during sending before it gets to the
signal receiving hardware. The standard RS485 is a half-duplex bus that in
most cases is driven by an UART controller. The advantage of using this
GPIO is that it is independent of the capabilities of the UART core and
the UART driver. On the hardware side the interface to the bus is
controlled by a transceiver, that has a pin called RE (RX enable) or
similar, which connects the bus to the RX signal of the UART controller.
The GPIO can switch between two states to control the RE pin via an
electrical circuit:
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
---
 Documentation/devicetree/bindings/serial/rs485.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Documentation/devicetree/bindings/serial/rs485.yaml
index 90a1bab40f05..6d780911e342 100644
--- a/Documentation/devicetree/bindings/serial/rs485.yaml
+++ b/Documentation/devicetree/bindings/serial/rs485.yaml
@@ -51,6 +51,10 @@ properties:
     description: GPIO pin to enable RS485 bus termination.
     maxItems: 1
 
+  rs485-rx-during-tx-gpios:
+    description: Output GPIO pin that indicates the state of rs485-rx-during-tx.
+    maxItems: 1
+
 additionalProperties: true
 
 ...
-- 
2.11.0

