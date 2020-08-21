Return-Path: <SRS0=3upM=B7=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531AAC433DF
	for <linux-serial@archiver.kernel.org>; Fri, 21 Aug 2020 11:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8932078D
	for <linux-serial@archiver.kernel.org>; Fri, 21 Aug 2020 11:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHFImIr3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgHULDH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgHULDF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Aug 2020 07:03:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E7FC061385
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2020 04:03:04 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so901030pfh.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2020 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DGscCnE9QszAjWEAPcRAu9jEqvaTuqlPRFuqo4CZFwU=;
        b=GHFImIr3Wc/2d47TCow4n/7zhAD24l8TaJdR4+ikNjgvtlGvddupdqefK7kiewqpWd
         ntkTw2OvG5Kkk4UZU6C+YqhxqGaS4AtrZp/gpLVcuqTEfMFPiP/UHRP3cdQKN832zsYt
         h0DoTxkrT5+VrMOA1/R75L0AQx4rQAp3V7J6cOUx1cyoCZ6sbjwaoYOjb++/+N2GR1bd
         6DtlnVqz0tDuc9p4r4YoPMjsZWsZ43dbFeAGeu28leOwwW0CMtwo1zAqrYbg+h7yVbOu
         2kKywS4GLekRJ17MT0bRjylfSM7yOcTozgznYHEiAVeI+uCEvKP8eRWcLJN7zGBqRhap
         suKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DGscCnE9QszAjWEAPcRAu9jEqvaTuqlPRFuqo4CZFwU=;
        b=JeGsOaMV5pt+4D44RBlT8aJCpAA5SqPpSdGQs+unqpiLkGXQ4RTMR2dl2w1tnUcHVP
         pJXEFpyfI+A+poZ8hL6/bYbSHg8VZoRiLg+a/pfjrDAHh/pGBLfEwbP5v5wpIKnjFtyF
         uVjQ1QQxcAucpn2Ck0CQF79iw0Dy0sbhGgWew1UsuxvWXopwY5cgDXTrTOMWiuyZIEBU
         hGocso7y4CUw3QwJ+8hcJEReiPxcRZgkG4vlcbJ7DNBwXLGZSPwDlFUZbg9l0Vy2NGc1
         g6YUceZTtMePit1RzuxW5velPrGRBbS0EyiMnScEnm1m01ZJLrXHLw2Pw/NcyoSGiTLB
         wluw==
X-Gm-Message-State: AOAM530duww2G60M3u7aq7NbqLKXFsptE8+s6uoQ97ckp57WGTCHG/ew
        TDcc8fRCIAgRL/iNj72MSuP6JApDrtOWxw==
X-Google-Smtp-Source: ABdhPJxEre3GhkRnpSCmzTfLuCm/0dPU5fTLTJWJ0jqH4BmdBbYyWBkcOooW4ulnj41IAYcUcSI+ug==
X-Received: by 2002:a63:1457:: with SMTP id 23mr1983294pgu.80.1598007781554;
        Fri, 21 Aug 2020 04:03:01 -0700 (PDT)
Received: from localhost.localdomain ([207.204.224.6])
        by smtp.gmail.com with ESMTPSA id 63sm2149721pfu.196.2020.08.21.04.02.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 04:03:01 -0700 (PDT)
From:   Du Huanpeng <u74147@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     linux@rempel-privat.de, mkl@blackshift.org, zhangj@wch.cn,
        Du Huanpeng <u74147@gmail.com>
Subject: [PATCH] serial: 8250_pci: Add WCH384_8S 8 port serial device
Date:   Fri, 21 Aug 2020 19:02:35 +0800
Message-Id: <1598007755-16428-1-git-send-email-u74147@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add PCI id for WCH384_8S 8 port PCI-E serial card.
because this card has so many ports, you may have
to check these two options before use it:
  CONFIG_SERIAL_8250_RUNTIME_UARTS
  CONFIG_SERIAL_8250_NR_UARTS

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 drivers/tty/serial/8250/8250_pci.c | 56 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 0804469..db6dc03 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1776,6 +1776,39 @@ pci_wch_ch38x_setup(struct serial_private *priv,
 	return pci_default_setup(priv, board, port, idx);
 }
 
+
+#define CH384_XINT_ENABLE_REG   0xEB
+#define CH384_XINT_ENABLE_BIT   0x02
+
+static int pci_wch_ch38x_init(struct pci_dev *dev)
+{
+	int max_port;
+	unsigned long iobase;
+
+
+	switch (dev->device) {
+	case 0x3853: /* 8 ports */
+		max_port = 8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	iobase = pci_resource_start(dev, 0);
+	outb(CH384_XINT_ENABLE_BIT, iobase + CH384_XINT_ENABLE_REG);
+
+	return max_port;
+}
+
+static void pci_wch_ch38x_exit(struct pci_dev *dev)
+{
+	unsigned long iobase;
+
+	iobase = pci_resource_start(dev, 0);
+	outb(0x0, iobase + CH384_XINT_ENABLE_REG);
+}
+
+
 static int
 pci_sunix_setup(struct serial_private *priv,
 		const struct pciserial_board *board,
@@ -1867,6 +1900,7 @@ pci_moxa_setup(struct serial_private *priv,
 #define PCIE_VENDOR_ID_WCH		0x1c00
 #define PCIE_DEVICE_ID_WCH_CH382_2S1P	0x3250
 #define PCIE_DEVICE_ID_WCH_CH384_4S	0x3470
+#define PCIE_DEVICE_ID_WCH_CH384_8S	0x3853
 #define PCIE_DEVICE_ID_WCH_CH382_2S	0x3253
 
 #define PCI_VENDOR_ID_PERICOM			0x12D8
@@ -2648,6 +2682,16 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
 		.subdevice      = PCI_ANY_ID,
 		.setup          = pci_wch_ch38x_setup,
 	},
+	/* WCH CH384 8S card (16850 clone) */
+	{
+		.vendor         = PCIE_VENDOR_ID_WCH,
+		.device         = PCIE_DEVICE_ID_WCH_CH384_8S,
+		.subvendor      = PCI_ANY_ID,
+		.subdevice      = PCI_ANY_ID,
+		.init           = pci_wch_ch38x_init,
+		.exit		= pci_wch_ch38x_exit,
+		.setup          = pci_wch_ch38x_setup,
+	},
 	/*
 	 * ASIX devices with FIFO bug
 	 */
@@ -2919,6 +2963,7 @@ enum pci_board_num_t {
 	pbn_fintek_F81512A,
 	pbn_wch382_2,
 	pbn_wch384_4,
+	pbn_wch384_8,
 	pbn_pericom_PI7C9X7951,
 	pbn_pericom_PI7C9X7952,
 	pbn_pericom_PI7C9X7954,
@@ -3656,6 +3701,13 @@ static struct pciserial_board pci_boards[] = {
 		.uart_offset    = 8,
 		.first_offset   = 0xC0,
 	},
+	[pbn_wch384_8] = {
+		.flags		= FL_BASE0,
+		.num_ports	= 8,
+		.base_baud      = 115200,
+		.uart_offset    = 8,
+		.first_offset   = 0x00,
+	},
 	/*
 	 * Pericom PI7C9X795[1248] Uno/Dual/Quad/Octal UART
 	 */
@@ -5572,6 +5624,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
 		PCI_ANY_ID, PCI_ANY_ID,
 		0, 0, pbn_wch384_4 },
 
+	{	PCIE_VENDOR_ID_WCH, PCIE_DEVICE_ID_WCH_CH384_8S,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0, 0, pbn_wch384_8 },
+
 	/* Fintek PCI serial cards */
 	{ PCI_DEVICE(0x1c29, 0x1104), .driver_data = pbn_fintek_4 },
 	{ PCI_DEVICE(0x1c29, 0x1108), .driver_data = pbn_fintek_8 },
-- 
2.7.4

