Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107DC48BDF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 18:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC12D613FF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Jun 2021 18:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFJSk7 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhFJSk5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Jun 2021 14:40:57 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E25CC061574;
        Thu, 10 Jun 2021 11:39:00 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B7BA89200B4; Thu, 10 Jun 2021 20:38:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B385E92009E;
        Thu, 10 Jun 2021 20:38:59 +0200 (CEST)
Date:   Thu, 10 Jun 2021 20:38:59 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] serial: 8250: Dissociate 4MHz Titan ports from Oxford
 ports
In-Reply-To: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2106100142310.5469@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2106071700090.1601@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Oxford Semiconductor PCIe (Tornado) serial port devices have their baud 
base set incorrectly, however their `pciserial_board' entries have been 
reused for Titan serial port devices.  Define own entries for the latter 
devices then, carrying over the settings, so that Oxford entries can be 
fixed.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/tty/serial/8250/8250_pci.c |   44 +++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

linux-serial-8250-titan-driver-data.diff
Index: linux-malta-cbus-uart/drivers/tty/serial/8250/8250_pci.c
===================================================================
--- linux-malta-cbus-uart.orig/drivers/tty/serial/8250/8250_pci.c
+++ linux-malta-cbus-uart/drivers/tty/serial/8250/8250_pci.c
@@ -2972,6 +2972,10 @@ enum pci_board_num_t {
 	pbn_sunix_pci_4s,
 	pbn_sunix_pci_8s,
 	pbn_sunix_pci_16s,
+	pbn_titan_1_4000000,
+	pbn_titan_2_4000000,
+	pbn_titan_4_4000000,
+	pbn_titan_8_4000000,
 	pbn_moxa8250_2p,
 	pbn_moxa8250_4p,
 	pbn_moxa8250_8p,
@@ -3759,6 +3763,34 @@ static struct pciserial_board pci_boards
 		.base_baud      = 921600,
 		.uart_offset	= 0x8,
 	},
+	[pbn_titan_1_4000000] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 1,
+		.base_baud	= 4000000,
+		.uart_offset	= 0x200,
+		.first_offset	= 0x1000,
+	},
+	[pbn_titan_2_4000000] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 2,
+		.base_baud	= 4000000,
+		.uart_offset	= 0x200,
+		.first_offset	= 0x1000,
+	},
+	[pbn_titan_4_4000000] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 4,
+		.base_baud	= 4000000,
+		.uart_offset	= 0x200,
+		.first_offset	= 0x1000,
+	},
+	[pbn_titan_8_4000000] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud	= 4000000,
+		.uart_offset	= 0x200,
+		.first_offset	= 0x1000,
+	},
 	[pbn_moxa8250_2p] = {
 		.flags		= FL_BASE1,
 		.num_ports      = 2,
@@ -4703,22 +4735,22 @@ static const struct pci_device_id serial
 		pbn_b0_4_921600 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100E,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_1_4000000 },
+		pbn_titan_1_4000000 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200E,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_4000000 },
+		pbn_titan_2_4000000 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400E,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_4_4000000 },
+		pbn_titan_4_4000000 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800E,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_8_4000000 },
+		pbn_titan_8_4000000 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EI,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_4000000 },
+		pbn_titan_2_4000000 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200EISI,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		pbn_oxsemi_2_4000000 },
+		pbn_titan_2_4000000 },
 	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200V3,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_2_921600 },
