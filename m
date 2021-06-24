Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC90C49EA6
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CCB613B7
	for <linux-serial@archiver.kernel.org>; Thu, 24 Jun 2021 22:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhFXWwS (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 24 Jun 2021 18:52:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232850AbhFXWwP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 24 Jun 2021 18:52:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56124613BD;
        Thu, 24 Jun 2021 22:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624574995;
        bh=LqSbUvnklLbaikHJmUbHetSoNII9E7rRJugAzbxIQ/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pc5IcxrnR1APWm0YnMbiv7pPi8B76nCkRiCQQLM0/PoI+uFR2187LksHycNw3NMh2
         aONs9EVaxpRtDRshl00FqUK4dh5DjOJHwj3pCz5wapg2sBUCuqL/2fKVx+6I5GPrTm
         e8qOBeHaykSqFsdm13RkoeMxrEUbtXDysYtYcyeBCXL0O41KWLlFNMTVNSPakJIOdA
         vvg1JyTJJs50v2agaa1BMCpbtYX1v1O78YuSB+jlouuz7VIc0DSyMcgL9anE4JC9Uk
         ZSJAdRMzkSoGhLrepfQO1TMoSx+uQGyYcw8M8T0MNDEKb+b3TWoPBnHpLHFDQ2DmaR
         IRStHzcdKIqrg==
Received: by pali.im (Postfix)
        id 13BEF8A3; Fri, 25 Jun 2021 00:49:55 +0200 (CEST)
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
Subject: [PATCH 04/10] dt-bindings: mvebu-uart: fix documentation
Date:   Fri, 25 Jun 2021 00:49:03 +0200
Message-Id: <20210624224909.6350-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624224909.6350-1-pali@kernel.org>
References: <20210624224909.6350-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Both UARTs support higher baudrates and are not limited to baudrate 230400.
Only current kernel driver implementation has limitation for both UARTs in
maximal baudrate 230400. This limitation will be removed in next patches.
So remove incorrect information about (hardware) limitation from bindings.

UART1 (standard variant with DT node name 'uart0') has register space
0x12000-0x12018 and not whole size 0x200. So fix also this in example.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: d160c3413478 ("dt-bindings: mvebu-uart: update documentation with extended UART")
---
 Documentation/devicetree/bindings/serial/mvebu-uart.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/mvebu-uart.txt b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
index b7e0e32b9ac6..2d0dbdf32d1d 100644
--- a/Documentation/devicetree/bindings/serial/mvebu-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mvebu-uart.txt
@@ -5,10 +5,10 @@ Required properties:
 - compatible:
     - "marvell,armada-3700-uart" for the standard variant of the UART
       (32 bytes FIFO, no DMA, level interrupts, 8-bit access to the
-      FIFO, baudrate limited to 230400).
+      FIFO), called also UART1.
     - "marvell,armada-3700-uart-ext" for the extended variant of the
       UART (128 bytes FIFO, DMA, front interrupts, 8-bit or 32-bit
-      accesses to the FIFO, baudrate unlimited by the dividers).
+      accesses to the FIFO), called also UART2.
 - reg: offset and length of the register set for the device.
 - clocks: UART reference clock used to derive the baudrate. If no clock
       is provided (possible only with the "marvell,armada-3700-uart"
@@ -33,7 +33,7 @@ Required properties:
 Example:
 	uart0: serial@12000 {
 		compatible = "marvell,armada-3700-uart";
-		reg = <0x12000 0x200>;
+		reg = <0x12000 0x18>;
 		clocks = <&xtalclk>;
 		interrupts =
 		<GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.20.1

