Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D4CC3F2CD
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 02:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9362166E
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 02:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204367;
	bh=YKfdWWef2XAP+GCkkOxxFSr7TtbFVlNDiZybrdw5O7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pnl22kpegjQp4KvMCEnZLSmSix4aEBhyzbNF8f9O2wrQ6dubQgGEojhtQG3i7rYGe
	 K9mDrY/BXayd/FVD/TDkyvV9wmvvTu3rdm0PLrC9ow+6Y2rC/9cw5NbNQLgPuItjSP
	 YhpRiIR3tWY+YlZhzfg/I8z6cTSc2ebhiXwYECXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgCCCrp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:47:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:42846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgCCCro (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4412469C;
        Tue,  3 Mar 2020 02:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203664;
        bh=YKfdWWef2XAP+GCkkOxxFSr7TtbFVlNDiZybrdw5O7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmNhDbiR+eodjgBe9Yd7tlhhcXKff16UtuY9SadtOyNhFeJcAdd2JdEPxbVhfTFcT
         JW3tgNxNWAUNQyX4izLwfxpkt2sgzVh/TQuhUOz0vpK2JtzTaaecQ+7eNWt2Gpn+dT
         ywbhhWqAgyx3QSrWY4uicriQ99mYwMl0vZlLwEJ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 03/58] serial: ar933x_uart: set UART_CS_{RX,TX}_READY_ORIDE
Date:   Mon,  2 Mar 2020 21:46:45 -0500
Message-Id: <20200303024740.9511-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit 87c5cbf71ecbb9e289d60a2df22eb686c70bf196 ]

On AR934x this UART is usually not initialized by the bootloader
as it is only used as a secondary serial port while the primary
UART is a newly introduced NS16550-compatible.
In order to make use of the ar933x-uart on AR934x without RTS/CTS
hardware flow control, one needs to set the
UART_CS_{RX,TX}_READY_ORIDE bits as other than on AR933x where this
UART is used as primary/console, the bootloader on AR934x typically
doesn't set those bits.
Setting them explicitely on AR933x should not do any harm, so just
set them unconditionally.

Tested-by: Chuanhong Guo <gch981213@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Link: https://lore.kernel.org/r/20200207095335.GA179836@makrotopia.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/ar933x_uart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 3bdd56a1021b2..ea12f10610b64 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -286,6 +286,10 @@ static void ar933x_uart_set_termios(struct uart_port *port,
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 			    AR933X_UART_CS_HOST_INT_EN);
 
+	/* enable RX and TX ready overide */
+	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
+		AR933X_UART_CS_TX_READY_ORIDE | AR933X_UART_CS_RX_READY_ORIDE);
+
 	/* reenable the UART */
 	ar933x_uart_rmw(up, AR933X_UART_CS_REG,
 			AR933X_UART_CS_IF_MODE_M << AR933X_UART_CS_IF_MODE_S,
@@ -418,6 +422,10 @@ static int ar933x_uart_startup(struct uart_port *port)
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 			    AR933X_UART_CS_HOST_INT_EN);
 
+	/* enable RX and TX ready overide */
+	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
+		AR933X_UART_CS_TX_READY_ORIDE | AR933X_UART_CS_RX_READY_ORIDE);
+
 	/* Enable RX interrupts */
 	up->ier = AR933X_UART_INT_RX_VALID;
 	ar933x_uart_write(up, AR933X_UART_INT_EN_REG, up->ier);
-- 
2.20.1

