Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4ADC433FE
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 10:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F824611C9
	for <linux-serial@archiver.kernel.org>; Wed, 22 Sep 2021 10:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhIVK6E (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Sep 2021 06:58:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235123AbhIVK6D (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Sep 2021 06:58:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A3CA60ED7;
        Wed, 22 Sep 2021 10:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632308193;
        bh=AU3eAVQ3E4tohBMshWxiOAyUqFg6wmmF2TEuQwxk1K4=;
        h=From:To:Cc:Subject:Date:From;
        b=uWaFnuBdoPKXKXfJE6p9k4asTcMuvae5MoYmInpwI5sELfZf0ouMwAJyXZ5c/cUr1
         ztE9MezqTEsMJQHIyorJLO/OaEkyJacWUZgOjbK6mM2NGoW46/+ZE48//2aCkOtXdi
         43OJEe/UrXcFIU23mgKcBW5TqVNlLUQOwcTKjegWwKdfIa3cs5ka5YzBBpcNzNuazK
         i+KxODgWFB0ePNaPOYrTmk7vzStZJLjKjx3XMqqgaXFK+K2jPjXNiBgoxD0Hp/YxJ2
         yhIsKYMhSvFG4kRhOWHuVDVD0YHSYaUfmvyaXMvdlpi16gg6601S+2t3ORX+sXKg7+
         OXPK/8V7j2x2Q==
Received: by pali.im (Postfix)
        id 0F95E79F; Wed, 22 Sep 2021 12:56:31 +0200 (CEST)
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
Subject: [RESEND PATCH v5 0/6] serial: mvebu-uart: Support for higher baudrates
Date:   Wed, 22 Sep 2021 12:54:27 +0200
Message-Id: <20210922105433.11744-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Per Greg's request I'm resending this patch series, please review it:
https://lore.kernel.org/linux-serial/YUmMli6LA%2F7Ew3hD@kroah.com/

This patch series add support for baudrates higher than 230400 on
Marvell Armada 37xx boards.

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

