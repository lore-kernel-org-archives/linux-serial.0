Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384AEC433FE
	for <linux-serial@archiver.kernel.org>; Thu, 10 Mar 2022 16:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbiCJQX3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244196AbiCJQW4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Mar 2022 11:22:56 -0500
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC419ABDE
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 08:20:43 -0800 (PST)
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 8EE8ACDF24
        for <linux-serial@vger.kernel.org>; Thu, 10 Mar 2022 16:17:02 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 61215C0015;
        Thu, 10 Mar 2022 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646929013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WpebAfFd0IgvUrxMb8erGsqJQOKHrfdGSaIJIzZI9SI=;
        b=SpEEVwQCB2/oVmNDb3AMftMOAbqP7cCBNn2UnL5SwCNLw0pLq3jEMj2hl9GmdTQ5q0HcBB
        X4enrno99tdEyOBtHjPjNoLlFL5Z6xJgAgpOoYJUQS1nhVoPAj81vPpiXVhfkleiP3oL5C
        6cJqKfRfjc7CWDBTk1qVtR6e3ZMAvDoBVb4bCG3vJ5pxVKr2YrYYw6jnfr2sDaEasgxBLY
        GbfE0JrI+lDFxDr1k6jjt5Hn/OaA5A7DoEQjo4OvY5Fpms3FcmnJI3iaHacmIhQmbz63hG
        y03a67d4flQT45Qjab9KOFj5Fto1CKzCEbSqoEZN/kxj1fdnsNwCTBIHjt+XJw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/7] RZN1 UART DMA support
Date:   Thu, 10 Mar 2022 17:16:43 +0100
Message-Id: <20220310161650.289387-1-miquel.raynal@bootlin.com>
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
support, currently on its v4, see [1]. Technically speaking, only the DT
patch needs to be applied after [1]. The other patches can come in at
any moment, because if no "dmas" property is provided in the DT, DMA
support will simply be ignored.

[1] https://lore.kernel.org/dmaengine/20220310155755.287294-1-miquel.raynal@bootlin.com/T/#mce6fec36e16dca560ab18935c273fcaf794a1cc4

Thanks,
Miquèl

Miquel Raynal (2):
  serial: 8250_dw: Provide the RZN1 CPR register value
  ARM: dts: r9a06g032: Fill the UART DMA properties

Phil Edworthy (5):
  serial: 8250_dma: Use ->tx_dma function pointer to start next DMA
  serial: 8250_dw: Move the per-device structure
  serial: 8250_dw: Use a fallback CPR value if not synthesized
  serial: 8250_dw: Add a dma_capable bit to the platform data
  serial: 8250_dw: Add support for RZ/N1 DMA

 arch/arm/boot/dts/r9a06g032.dtsi     |  15 ++++
 drivers/tty/serial/8250/8250_dma.c   |   4 +-
 drivers/tty/serial/8250/8250_dw.c    | 119 +++++++++++++++++++++++----
 drivers/tty/serial/8250/8250_dwlib.c |  17 +++-
 drivers/tty/serial/8250/8250_dwlib.h |  22 +++++
 5 files changed, 155 insertions(+), 22 deletions(-)

-- 
2.27.0

