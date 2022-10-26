Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB279C38A2D
	for <linux-serial@archiver.kernel.org>; Wed, 26 Oct 2022 17:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiJZRBT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Oct 2022 13:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiJZRBR (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Oct 2022 13:01:17 -0400
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Oct 2022 10:01:14 PDT
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40C037C31D
        for <linux-serial@vger.kernel.org>; Wed, 26 Oct 2022 10:01:12 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.securetransport.de (Postfix) with ESMTPSA id 5C201720507;
        Wed, 26 Oct 2022 18:52:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1666803149;
        bh=QUKg28pcVKM/t0EP9hfe9G7J4P8dcYN9ZQdbQEccXVE=;
        h=From:To:CC:Subject:Date:From;
        b=LJdNBr1eCN0rB1bBz0MRlJNhW4LJYGu/auwVTHc05ZPemjyS6Et3vHDZUXbNSXXfP
         f41hTUTg1Vu93BRldtnsyJIJ46hp3bqa8maSsx+2QmjcbzhNTGQUA61W5kd9EWfuP/
         +visV24XQHhnHT9/7qRx5Ai59XutQ9bhEe18s9ZBoiFDnSULG/a2qYvE74vUFe7zog
         l/NVLdxakrQKFJCzMbfQNhNzBXh0DhPqx5QG8sDntxzDhOyxY+SbPwXgaE5tkN3/1a
         3aI6Euf7eBBS3x2wtENdj2GF2X25Nm7I6JgT3DibX2CaZ86WlduswF9fKh/qkaUcMK
         fnlXOWR/+BVjg==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15; Wed, 26 Oct 2022 18:52:18 +0200
Received: from localhost.localdomain (172.16.51.8) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.15 via Frontend Transport; Wed, 26 Oct 2022 18:52:17 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <marex@denx.de>,
        <jirislaby@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: [PATCH 0/4] tty: serial: Add ability to control rs485 RX_DURING_TX via a GPIO
Date:   Wed, 26 Oct 2022 18:50:45 +0200
Message-ID: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series add the ability to control the RS485 feature RX_DURING_TX via
a GPIO. Currently it is handled by the low level serial driver and it depends
on the ability of the serial hardware. In case of that RX_DURING_TX is disabled
the serial hardware must be capable to turn off the receiver during sending.
The idea is to have an electrical circuit that connects/disconnects the Rx by
using the RX_DURING_TX GPIO. On one hand by using this GPIO the use of RS485
RX_DURING_TX becomes independent of the capability of the serial hardware, and
on the other hand possible software-caused switch-off and switch-on times of the
receiver in case of RX_DURING_TX is disabled (default state) can also be avoided.

The core patch adds a generic GPIO variable for the use of this RS485 feature
controlled by a GPIO. The GPIO is defined by the devicetree property
"rs485-rx-during-tx-gpios".

The low-level implementation is done for the STM32 and the i.MX serial driver.
Other platforms are not covered in this series, but can easily be added.

I tested it with a DHCOM i.MX6DL and DHCOM STM32MP1 on a PicoITX board.

In this series the devicetree bindings description is also included.


Christoph Niedermaier (4):
  dt_bindings: rs485: Add binding for GPIO that controls Rx enable
    during Tx
  serial: core: Add option to control rs485 RX_DURING_TX by a GPIO
  serial: imx: Add support for rs485 RX_DURING_TX GPIO
  serial: stm32: Add support for rs485 RX_DURING_TX GPIO

 Documentation/devicetree/bindings/serial/rs485.yaml |  4 ++++
 drivers/tty/serial/imx.c                            | 13 +++++++++++--
 drivers/tty/serial/serial_core.c                    | 12 ++++++++++++
 drivers/tty/serial/stm32-usart.c                    |  9 ++++++++-
 include/linux/serial_core.h                         |  1 +
 5 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.11.0

