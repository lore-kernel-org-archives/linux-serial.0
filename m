Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93716C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF4C61882
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 14:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhKOOdo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 09:33:44 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:40165 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236641AbhKOOdM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 09:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636986617; x=1668522617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zuThhgTn4F0rTfrp7sz4M3WkIvUF2eQwlt70tY+m8ik=;
  b=rBbxDf08Ws0GTfP2csVtX8bmtwGJb2k53x7FqyjvAl9VlEUn0RKmUyJh
   kOWDzJrdJkl7F2TNsjW/k/Z7AWMr/VLE4cG7zL724q1GRwvoIn9MjGYnS
   4KHH4P+OIWfGUou+xZrnFrPcn1F7Dt011r3WpD9fOXbawAxflBD5rUN++
   M4Td2aEJsTGJiyJFnm1vVakVN7/aEpY1kpl5AtQPnysVrJeX8MRmy6OSo
   /Hibl/CXtUCXAehYuEEnu5YdvEtjk/K9nKOKsHJQ21ArR5hCU/1ghKkEc
   rOv1r3ZXOwEJ9BN9OqzFmorAPTPkk1b72lQsf52BXAhwShqGKu9EvoRUR
   Q==;
IronPort-SDR: RyZmDDRmWa63cpRskOdKhXT6QNg9JXpkCeybnqhcNSJlPwi3m5W6rqXtVsx4Pfc4YvvXfJbzS+
 4L6sTsHrOzEAvikVuAcQX4+VeheuogrPYRai4I48MxHCHF27MjfzwjUw1p5Byz1D/Bk03p4X3K
 Y1TBS1WS6P4ow47Hik/bXbiripHKEYVmg2wCW1Bi13fRthee2jZ/inia7UIXSZSBcSO81kPRXg
 1Vi3lSQ/G9uIbIx+RHx3m3lB+wRbY8cVAhjlKNYqQg+GjZPNM+25SRMb/f3BIUyBnVwaa66Lxw
 mlKrmCPAxde2b23yg8pJBL3h
X-IronPort-AV: E=Sophos;i="5.87,236,1631602800"; 
   d="scan'208";a="76457711"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Nov 2021 07:30:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 15 Nov 2021 07:30:13 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 15 Nov 2021 07:30:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] tty: serial: atmel: Check return code of dmaengine_submit()
Date:   Mon, 15 Nov 2021 16:30:04 +0200
Message-ID: <20211115143004.32743-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

dma_cookie_t < 0 indicates an error code, check for it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/tty/serial/atmel_serial.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2c99a47a2535..376f7a9c2868 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1004,6 +1004,11 @@ static void atmel_tx_dma(struct uart_port *port)
 		desc->callback = atmel_complete_tx_dma;
 		desc->callback_param = atmel_port;
 		atmel_port->cookie_tx = dmaengine_submit(desc);
+		if (dma_submit_error(atmel_port->cookie_tx)) {
+			dev_err(port->dev, "dma_submit_error %d\n",
+				atmel_port->cookie_tx);
+			return;
+		}
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -1258,6 +1263,11 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	desc->callback_param = port;
 	atmel_port->desc_rx = desc;
 	atmel_port->cookie_rx = dmaengine_submit(desc);
+	if (dma_submit_error(atmel_port->cookie_rx)) {
+		dev_err(port->dev, "dma_submit_error %d\n",
+			atmel_port->cookie_rx);
+		goto chan_err;
+	}
 
 	return 0;
 
-- 
2.25.1

