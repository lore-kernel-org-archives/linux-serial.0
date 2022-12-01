Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC4C4321E
	for <linux-serial@archiver.kernel.org>; Thu,  1 Dec 2022 11:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiLALGp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 1 Dec 2022 06:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbiLALFl (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 1 Dec 2022 06:05:41 -0500
Received: from mx3.securetransport.de (mx3.securetransport.de [IPv6:2a01:4f8:c0c:92be::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECEAD13D20;
        Thu,  1 Dec 2022 03:05:03 -0800 (PST)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx3.securetransport.de (Postfix) with ESMTPSA id 92D755DDF5;
        Thu,  1 Dec 2022 12:04:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1669892649;
        bh=oHceRgk+gFfdajQXBs3vdONlXzIv43vyzNrgumEI73k=;
        h=From:To:CC:Subject:Date:From;
        b=df9YQpSl5ROg2pVfpnO69J8V3eJTYYv3vjSJLCXcoqKse/XwNuByOE1cTj6xVtrTl
         qOnmiZyV0yUj4GR4MLehlCc0JhzsOss4Ko1qH7hQTUrBu5OIxs0uw+1CzI5G5qSsU+
         JGRNDb7ws/zww0Z5KfqhZAlaO8mSfbf3SgE+KGvjQsmwPrtKKM3Qmz4zwriDD1Kdoq
         277Q2XzunorUxq78Rks5dNbQnTWM5FdHzjFQ2rv0/RXQQFmXitnde3eA+SfMfObQ7m
         Plym2f/rp41/7/Olz+TOXYIPJcwNWsH1Gyf2MEPge1d/m6l5XyW7myc43MER7uadDY
         Zge06SQ8322eQ==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Thu, 1 Dec 2022 12:03:55 +0100
Received: from localhost.localdomain (172.16.51.2) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20 via Frontend Transport; Thu, 1 Dec 2022 12:03:55 +0100
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
Subject: [PATCH V3 1/4] dt-bindings: serial: rs485: Add GPIO controlling RX enable during TX
Date:   Thu, 1 Dec 2022 12:02:34 +0100
Message-ID: <20221201110237.7917-1-cniedermaier@dh-electronics.com>
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

