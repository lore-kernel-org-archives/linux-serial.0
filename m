Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27CBC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 09:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BA3619E7
	for <linux-serial@archiver.kernel.org>; Thu, 30 Sep 2021 09:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349636AbhI3KAt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Sep 2021 06:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349504AbhI3KAq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Sep 2021 06:00:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09D03615E2;
        Thu, 30 Sep 2021 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632995944;
        bh=EcQMCqZ6hJ0OCg9NAUge8n9Pch6KHPccpjuPzxh7O0A=;
        h=From:To:Cc:Subject:Date:From;
        b=SW7pjdwR9AIi4zwIetE5qF0As3jiBUbMhywYs+ISjVoaMwW5u2qEM36GWKTFZuxO0
         45LSAAF6/fNCvcESjyvOvSH6gltuHGUhaA4HdSdklT6gek+d1gotahqzqyWtPKERcH
         yeb3qu2HlMwVzdHEk4J4jcBhmupA0JnHjYDnKuJZtHozQetqYtTqqDZY/1hV8KNnRO
         W/JXtNUUaydCaDHxZfxH+lj6qw1uA2JSnUCFnEHVaiSKoma04V4RO1eoDm6x2h0fjI
         HsaJ7pU5XAKc+sqKPnYhfDjYaIboDxtym8SA2gFIXC6DMo+ImvYHYV6d6vCyGdAIVq
         kDnFmn9TpIZ3g==
Received: by pali.im (Postfix)
        id 8EBD7E79; Thu, 30 Sep 2021 11:59:01 +0200 (CEST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 0/6] serial: mvebu-uart: Support for higher baudrates
Date:   Thu, 30 Sep 2021 11:58:32 +0200
Message-Id: <20210930095838.28145-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series add support for baudrates higher than 230400 on
Marvell Armada 37xx boards.

Changes in v7:
* fixed lint errors in yaml binding file

Changes in v6:
* fixed yaml binding file and dts files

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

 .../clock/marvell,armada-3700-uart-clock.yaml |  59 ++
 .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
 include/linux/math64.h                        |  13 +
 6 files changed, 667 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml

-- 
2.20.1

