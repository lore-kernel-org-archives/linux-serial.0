Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8915C4167D
	for <linux-serial@archiver.kernel.org>; Thu, 17 Mar 2022 17:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237059AbiCQRsI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiCQRrw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Mar 2022 13:47:52 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B21EA5E9;
        Thu, 17 Mar 2022 10:46:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7F548FF803;
        Thu, 17 Mar 2022 17:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1647539191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iI9wwji8k0+AembrWgi5sMcCLpiITbWtijKnVA6Fwo0=;
        b=gNOI1ysHMejPjxFWvW+oiMxW7ok0gKaHaEDRgLR7LsEEpCeToZM79QHhtu/97mACdyT4yw
        xMmsIbUkXLgRwyHr/Crg79iyYbn2bqWsc4iZSFfP7u3rxnycHi2SKINryjWNfBWi2mnQeT
        vNLrDgqd/jSkAH10YdOUiaRMAtk05D5ud1whCwcFJaR9Iwx3i9GcvAlUJ26tY1ZUc2i1vh
        Hfk1i7oSdQ04yMmKK+TUJ72YY1VIoWYMFN0UaeGvb3K3R9xcCeglX1cJD0Lw8/aqfs+CTe
        Z+iH49VGJ5tzaIVj0vuV6gjhuixxUOXe1933P0NIjspv/vvX70h/U4EjMWHcgg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        linux-serial@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 00/10] serial: 8250: dw: RZN1 DMA support
Date:   Thu, 17 Mar 2022 18:46:17 +0100
Message-Id: <20220317174627.360815-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

Support for the RZN1 DMA engine allows us adapt a little bit the 8250 DW
UART driver with to bring DMA support for this SoC.

This short series applies on top of the series bringing RZN1 DMA
support, currently on its v5, see [1]. Technically speaking, only the DT
patch needs to be applied after [1]. The other patches can come in at
any moment, because if no "dmas" property is provided in the DT, DMA
support will simply be ignored.

[1] https://lore.kernel.org/dmaengine/20220315191255.221473-1-miquel.raynal@bootlin.com/T/#m0ef3323abce3eec961e142bf2fb35e95b9045fc5

Thanks,
Miquèl

Changes in v2:
* Rebased on top of Emil's patches. Added platform data structures
  instead of raw quirk integers in order to provide a CPR value.
* Added includes in dwlib.h even though it's not particularly useful, it
  may help preventing a build error later on if we ever decide to include
  this file from another location.
* Dropped the call to ->tx_dma and instead implemented a callback that
  can be called from serial8250_tx/rx_dma.
* Used the device API instead of the of API.
* Changed the logic about DMA capabilities to avoid breaking existing
  designs.
* Introduced a new quirk related to the flow-control feature of the
  RZ/N1 version of the UART controller when used with DMA.
* Re-arranged the entire series as advised by Andy and Geert.
* Added several preparation patches to ease the review of various
  functional changes.

Miquel Raynal (6):
  serial: 8250: dw: Use the device API
  serial: 8250: dw: Create a more generic platform data structure
  serial: 8250: dw: Check when possible if DMA is effectively supported
  serial: 8250: dma: Allow driver operations before starting DMA
    transfers
  serial: 8250: dw: Introduce an rx_timeout variable in the IRQ path
  ARM: dts: r9a06g032: Fill the UART DMA properties

Phil Edworthy (4):
  serial: 8250: dw: Move the per-device structure
  serial: 8250: dw: Allow to use a fallback CPR value if not synthesized
  serial: 8250: dw: Add support for DMA flow controlling devices
  serial: 8250: dw: Improve RZN1 support

 arch/arm/boot/dts/r9a06g032.dtsi     |  15 ++++
 drivers/tty/serial/8250/8250.h       |  18 +++++
 drivers/tty/serial/8250/8250_dma.c   |   4 +
 drivers/tty/serial/8250/8250_dw.c    | 116 +++++++++++++++++++++------
 drivers/tty/serial/8250/8250_dwlib.c |  11 ++-
 drivers/tty/serial/8250/8250_dwlib.h |  26 ++++++
 6 files changed, 163 insertions(+), 27 deletions(-)

-- 
2.27.0

