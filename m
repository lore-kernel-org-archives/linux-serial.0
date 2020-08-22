Return-Path: <SRS0=gkMA=CA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70ECC433E1
	for <linux-serial@archiver.kernel.org>; Sat, 22 Aug 2020 01:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8263920735
	for <linux-serial@archiver.kernel.org>; Sat, 22 Aug 2020 01:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krOLdRR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgHVBrn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 21 Aug 2020 21:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHVBrm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 21 Aug 2020 21:47:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524EBC061573
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2020 18:47:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i10so1831588pgk.1
        for <linux-serial@vger.kernel.org>; Fri, 21 Aug 2020 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ecEv7XoXjFc8OQ/d+M11MEy/9WmfPQPLRo0cR2yVQvE=;
        b=krOLdRR5o1mKoKl6296/4Xj+yNnah8oxr9T6BEw5g5oZTpYWwszPsVa113zJZ2NGpb
         Fb5nywmE7tsZB5cVC4v9OBaIK0aOY9rqz9WwNHMPWp9cr+tahFTenOYjkCp+hYZLg/M0
         GAWc/4Grny8XmaIePFV6i3zxNXHFfd8o4dYrWH3oPiCmJJceKpaZXcGXrzqHEuTTh+Yv
         +f35b6d1CjbZN9m+uIKnQWBklNBFkwx93T5ONFl2L+/wH03u8UNFn/LvceR2zJi+aEP/
         HmujWaMoOW4iI2rY9m2HiBtpunOphJn/oMJzOW6ChhIGwx5UJ8qq5BUmqrE9x5dYd0Ll
         BmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ecEv7XoXjFc8OQ/d+M11MEy/9WmfPQPLRo0cR2yVQvE=;
        b=rTBeW3NfC26dxNsafo01x2Cvu7+f4itVKQDOaJa+UekalDx+HMIHAbNj1YbGW7ouZE
         GIss5uJNgffLkhQnkxkvBULNPSZHykEZIjtk0zN2ANi1orDEXX/VqqpZPOV5Ads/jOXh
         cIlfADbgD56Slr4SpHXOg7l+7t2Iyx5Sqx2MRQiDS9twyLnTmuB1dlRtTOdIcqYPTyli
         jMXg1p3pYXK6GoUulKafq2lnXoHZ7mgDM2PHpxWrxRCGqc5+NCcR1bu6UkRqTkh3xVAv
         wqZJZi8V4PPK1Uo/hthSxHUaMob5lGtSlDP6ht+V/9DeCU1HjPbF67bX6YTIqAfFgxXW
         ag8A==
X-Gm-Message-State: AOAM533CzK2wgMeVGoiyv9s92gBs1zx/1OhTSazqapPhB5RFA81wHAZ4
        sUoPH6cc95a8HK/1D1BX2EoFE1KDR98=
X-Google-Smtp-Source: ABdhPJzGxEHJHawHoWbNuBAuUlFuf3Dow3gycrL3DGpt0hs+MEoqjfD+KDTSZ0iEH5LOKG7dTsDrXg==
X-Received: by 2002:a65:524b:: with SMTP id q11mr4232802pgp.372.1598060861655;
        Fri, 21 Aug 2020 18:47:41 -0700 (PDT)
Received: from localhost.localdomain ([103.209.252.252])
        by smtp.googlemail.com with ESMTPSA id g15sm3886476pfh.70.2020.08.21.18.47.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 18:47:41 -0700 (PDT)
From:   Du Huanpeng <u74147@gmail.com>
To:     linux-serial@vger.kernel.org, linux@rempel-privat.de,
        mkl@blackshift.org, zhangj@wch.cn
Cc:     Du Huanpeng <u74147@gmail.com>
Subject: [PATCH] serial: 8250_pci: Add WCH384_8S 8 port serial device
Date:   Sat, 22 Aug 2020 09:47:28 +0800
Message-Id: <1598060848-27807-1-git-send-email-u74147@gmail.com>
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
index 1a74d51..d8f43f2 100644
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
 
 #define PCI_VENDOR_ID_ACCESIO			0x494f
@@ -2642,6 +2676,16 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
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
@@ -2913,6 +2957,7 @@ enum pci_board_num_t {
 	pbn_fintek_F81512A,
 	pbn_wch382_2,
 	pbn_wch384_4,
+	pbn_wch384_8,
 	pbn_pericom_PI7C9X7951,
 	pbn_pericom_PI7C9X7952,
 	pbn_pericom_PI7C9X7954,
@@ -3650,6 +3695,13 @@ static struct pciserial_board pci_boards[] = {
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
@@ -5566,6 +5618,10 @@ static const struct pci_device_id serial_pci_tbl[] = {
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

