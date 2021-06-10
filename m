Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB4FC48BE5
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 18:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E28613DF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 18:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFJSlD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhFJSlA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Jun 2021 14:41:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DBBAC061760;
        Thu, 10 Jun 2021 11:39:04 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B52AD92009E; Thu, 10 Jun 2021 20:39:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id AEF4592009B;
        Thu, 10 Jun 2021 20:39:03 +0200 (CEST)
Date:   Thu, 10 Jun 2021 20:39:03 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] serial: 8250: Correct the clock for OxSemi PCIe
 devices
In-Reply-To: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106100203510.5469@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Oxford Semiconductor PCIe (Tornado) serial port devices are driven by a 
fixed 62.5MHz clock input derived from the 100MHz PCI Express clock.  

In the enhanced (650) mode, which we select in `autoconfig_has_efr' by 
setting the ECB bit in the EFR register, and in the absence of clock 
reconfiguration, which we currently don't do, the clock rate is divided 
only by the oversampling rate of 16 as it is supplied to the baud rate 
generator, yielding the baud base of 3906250.  This comes from the reset 
values of the TCR and MCR[7] registers which are both zero[1][2][3][4], 
choosing the oversampling rate of 16 and the normal (divide by 1) baud 
rate generator prescaler respectively.  This is the rate that is divided 
by the value held in the divisor latch to determine the baud rate used.

Replace the incorrect baud base of 4000000 with the right value of 
3906250 then.

References:

[1] "OXPCIe200 PCI Express Multi-Port Bridge", Oxford Semiconductor, 
    Inc., DS-0045, 10 Nov 2008, Section "Reset Configuration", p. 72

[2] "OXPCIe952 PCI Express Bridge to Dual Serial & Parallel Port", 
    Oxford Semiconductor, Inc., DS-0046, Mar 06 08, Section "Reset 
    Configuration", p. 27

[3] "OXPCIe954 PCI Express Bridge to Quad Serial Port", Oxford 
    Semiconductor, Inc., DS-0047, Feb 08, Section "Reset Configuration", 
    p. 28

[4] "OXPCIe958 PCI Express Bridge to Octal Serial Port", Oxford 
    Semiconductor, Inc., DS-0048, Feb 08, Section "Reset Configuration", 
    p. 28

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 7106b4e333bae ("8250: Oxford Semiconductor Devices")
---
 drivers/tty/serial/8250/8250_pci.c |  128 ++++++++++++++++++-------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

linux-serial-8250-oxsemi-pcie-clock.diff
Index: linux-malta-cbus-uart/drivers/tty/serial/8250/8250_pci.c
===================================================================
--- linux-malta-cbus-uart.orig/drivers/tty/serial/8250/8250_pci.c
+++ linux-malta-cbus-uart/drivers/tty/serial/8250/8250_pci.c
@@ -2851,7 +2851,7 @@ enum pci_board_num_t {
 	pbn_b0_2_1843200,
 	pbn_b0_4_1843200,
 
-	pbn_b0_1_4000000,
+	pbn_b0_1_3906250,
 
 	pbn_b0_bt_1_115200,
 	pbn_b0_bt_2_115200,
@@ -2931,10 +2931,10 @@ enum pci_board_num_t {
 	pbn_plx_romulus,
 	pbn_endrun_2_4000000,
 	pbn_oxsemi,
-	pbn_oxsemi_1_4000000,
-	pbn_oxsemi_2_4000000,
-	pbn_oxsemi_4_4000000,
-	pbn_oxsemi_8_4000000,
+	pbn_oxsemi_1_3906250,
+	pbn_oxsemi_2_3906250,
+	pbn_oxsemi_4_3906250,
+	pbn_oxsemi_8_3906250,
 	pbn_intel_i960,
 	pbn_sgi_ioc3,
 	pbn_computone_4,
@@ -3081,10 +3081,10 @@ static struct pciserial_board pci_boards
 		.uart_offset	= 8,
 	},
 
-	[pbn_b0_1_4000000] = {
+	[pbn_b0_1_3906250] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
-		.base_baud	= 4000000,
+		.base_baud	= 3906250,
 		.uart_offset	= 8,
 	},
 
@@ -3479,31 +3479,31 @@ static struct pciserial_board pci_boards
 		.base_baud	= 115200,
 		.uart_offset	= 8,
 	},
-	[pbn_oxsemi_1_4000000] = {
+	[pbn_oxsemi_1_3906250] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 1,
-		.base_baud	= 4000000,
+		.base_baud	= 3906250,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_oxsemi_2_4000000] = {
+	[pbn_oxsemi_2_3906250] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 2,
-		.base_baud	= 4000000,
+		.base_baud	= 3906250,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_oxsemi_4_4000000] = {
+	[pbn_oxsemi_4_3906250] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 4,
-		.base_baud	= 4000000,
+		.base_baud	= 3906250,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
-	[pbn_oxsemi_8_4000000] = {
+	[pbn_oxsemi_8_3906250] = {
 		.flags		= FL_BASE0,
 		.num_ports	= 8,
-		.base_baud	= 4000000,
+		.base_baud	= 3906250,
 		.uart_offset	= 0x200,
 		.first_offset	= 0x1000,
 	},
@@ -4510,158 +4510,158 @@ static const struct pci_device_id serial
 	 */
 	{	PCI_VENDOR_ID_OXSEMI, 0xc101,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_4000000 },
+		pbn_b0_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc105,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_4000000 },
+		pbn_b0_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc11b,    /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc11f,    /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc120,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_4000000 },
+		pbn_b0_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc124,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_4000000 },
+		pbn_b0_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc138,    /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc13d,    /* OXPCIe952 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc140,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_4000000 },
+		pbn_b0_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc141,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_4000000 },
+		pbn_b0_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc144,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_4000000 },
+		pbn_b0_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc145,    /* OXPCIe952 1 Legacy UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_b0_1_4000000 },
+		pbn_b0_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc158,    /* OXPCIe952 2 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_4000000 },
+		pbn_oxsemi_2_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc15d,    /* OXPCIe952 2 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_4000000 },
+		pbn_oxsemi_2_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc208,    /* OXPCIe954 4 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_4_4000000 },
+		pbn_oxsemi_4_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc20d,    /* OXPCIe954 4 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_4_4000000 },
+		pbn_oxsemi_4_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc308,    /* OXPCIe958 8 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_8_4000000 },
+		pbn_oxsemi_8_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc30d,    /* OXPCIe958 8 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_8_4000000 },
+		pbn_oxsemi_8_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc40b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc40f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc41b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc41f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc42b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc42f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc43b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc43f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc44b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc44f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc45b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc45f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc46b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc46f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc47b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc47f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc48b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc48f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc49b,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc49f,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4ab,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4af,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4bb,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4bf,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4cb,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_OXSEMI, 0xc4cf,    /* OXPCIe200 1 Native UART */
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	/*
 	 * Mainpine Inc. IQ Express "Rev3" utilizing OxSemi Tornado
 	 */
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 1 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4001, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_oxsemi_1_3906250 },
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 2 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4002, 0, 0,
-		pbn_oxsemi_2_4000000 },
+		pbn_oxsemi_2_3906250 },
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 4 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4004, 0, 0,
-		pbn_oxsemi_4_4000000 },
+		pbn_oxsemi_4_3906250 },
 	{	PCI_VENDOR_ID_MAINPINE, 0x4000,	/* IQ Express 8 Port V.34 Super-G3 Fax */
 		PCI_VENDOR_ID_MAINPINE, 0x4008, 0, 0,
-		pbn_oxsemi_8_4000000 },
+		pbn_oxsemi_8_3906250 },
 
 	/*
 	 * Digi/IBM PCIe 2-port Async EIA-232 Adapter utilizing OxSemi Tornado
 	 */
 	{	PCI_VENDOR_ID_DIGI, PCIE_DEVICE_ID_NEO_2_OX_IBM,
 		PCI_SUBVENDOR_ID_IBM, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_4000000 },
+		pbn_oxsemi_2_3906250 },
 
 	/*
 	 * SBS Technologies, Inc. P-Octal and PMC-OCTPRO cards,
