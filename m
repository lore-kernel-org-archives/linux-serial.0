Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16747C4320A
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 14:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC7560C41
	for <linux-serial@archiver.kernel.org>; Mon,  9 Aug 2021 14:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhHIOzX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234787AbhHIOzQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Aug 2021 10:55:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3646960C41;
        Mon,  9 Aug 2021 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628520895;
        bh=Bju+leec27BJ4QYvQY3PA8U9CmRnt/W8mNw7VpNHRP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4BdBuCnR4jKeXbFWTt0b3h27ezCQSF4GiwDiSASn8dkWMHFf6dv7xETJOGUa3pxp
         BviDC48Ua/ElZsPcZZXYYQV8i+QrU5KMrobngDKwzPuyUaBh/yxPlmPcjZsC6TM+GC
         SbpfKSnIVzMPOvmvsVyfvdhloa+m9CXPL4SqPI3ctagtL23QwpL2B7J06PAarElrs9
         K2sxQbkbvwuo2VMJO9Zvi61b350z/fnkGw2Wki0djWhtqLMKTPlnP1l+iWbp8EcFPG
         YvkqzgSOBW1+51wpakMqbyXPm3m5RehzWn/90utfv8VI7hMv3ti/tJVdIDtJ6ZjYp3
         gkUbIGwpOf8cA==
Received: by pali.im (Postfix)
        id 77F17C7C; Mon,  9 Aug 2021 16:54:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/6] serial: mvebu-uart: Support for higher baudrates
Date:   Mon,  9 Aug 2021 16:53:23 +0200
Message-Id: <20210809145329.24177-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series add support for baudrates higher than 230400 on
Marvell Armada 37xx boards.

Please review these patches as they touch both Device Tree bindings and
mvebu-uart.c driver.

Changes in v5:
* fixed yaml binding file

Changes in v4:
* converted armada3700-uart-clock documentation to YAML
* split documentation changes into two commits:
  - first which adds clock documentation
  - second which updates UART documentation

Changes in v3:
v3 is rebased on top of Linus master branch and all already applied patches
were dropped. There are no changes in patches itself since v2.

Pali Rohár (6):
  math64: New DIV_U64_ROUND_CLOSEST helper
  serial: mvebu-uart: implement UART clock driver for configuring UART
    base clock
  dt-bindings: mvebu-uart: document DT bindings for
    marvell,armada-3700-uart-clock
  dt-bindings: mvebu-uart: update information about UART clock
  arm64: dts: marvell: armada-37xx: add device node for UART clock and
    use it
  serial: mvebu-uart: implement support for baudrates higher than 230400

 .../bindings/clock/armada3700-uart-clock.yaml |  57 ++
 .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
 .../arm64/boot/dts/marvell/armada-3720-db.dts |   4 +
 .../dts/marvell/armada-3720-espressobin.dtsi  |   4 +
 .../dts/marvell/armada-3720-turris-mox.dts    |   4 +
 .../boot/dts/marvell/armada-3720-uDPU.dts     |   4 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  15 +-
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
 include/linux/math64.h                        |  13 +
 10 files changed, 682 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml

-- 
2.20.1

