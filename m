Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57EC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 08:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7747861452
	for <linux-serial@archiver.kernel.org>; Wed, 29 Sep 2021 08:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244703AbhI2IYe (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Sep 2021 04:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240284AbhI2IYd (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Sep 2021 04:24:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CF9E613A6;
        Wed, 29 Sep 2021 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632903773;
        bh=CaZv5D6dBea9V73DW6In0hGNMqG2tpf4Jer/zjX4Zto=;
        h=From:To:Cc:Subject:Date:From;
        b=uJqGIJiWMZH9pKkJMRU08OKxG3jxLoX7g3bp/nMbKemRyLh7tH+Wp0kKosDPvgg5x
         hIay9JRi6DG2DJqayM5seWElEItChISfMhCT4Rcxc6Rs8LjU89u4lpMJ4sNNVakkaC
         ejOaxW2T0b2RgPyF7Mwl3l8lu9iCnXTVmBQs5FQ+D9ZkpizRNV2IixeUJipIBnqRwA
         USUAJzWleYOQmgYu8rwCzqfL0mEb3t7TnYDhBI2ogCFWFmQoAR8jZz8gbLUVCQSwQq
         QluSUmg0c6aEOKXpwW6MItasTqcBUr4jGn/wytuLR7EvLOW//wqMp58IWtQo8pKufz
         m1YymgvpKDckA==
Received: by pali.im (Postfix)
        id B552C76E; Wed, 29 Sep 2021 10:22:50 +0200 (CEST)
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
Subject: [PATCH v6 0/6] serial: mvebu-uart: Support for higher baudrates
Date:   Wed, 29 Sep 2021 10:20:28 +0200
Message-Id: <20210929082034.15098-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This patch series add support for baudrates higher than 230400 on
Marvell Armada 37xx boards.

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

 .../bindings/clock/armada3700-uart-clock.yaml |  56 ++
 .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
 include/linux/math64.h                        |  13 +
 6 files changed, 664 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/armada3700-uart-clock.yaml

-- 
2.20.1

