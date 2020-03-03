Return-Path: <SRS0=YTEb=4U=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC393C3F2D7
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF87E246D9
	for <linux-serial@archiver.kernel.org>; Tue,  3 Mar 2020 02:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583203943;
	bh=mQi+kJKCA4XsCXfQOnNrS/gSe+ZGvNiadlAQOyB6ZBM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VmjfSgaDdsF2yWLt7elzjPs5AJFYbs1nwo6o80GXaZLLjoPmNwHeqZMwVQC70DnQ6
	 ZiO0+XAGGDbLbAm5aiNXW8uRlUkTnpRhfW9oS3SKM8oUUaTdq7YD7m8695yvecPNGm
	 AIGFg5BxfulamL+H3mvgwLLyJaNq7AV9Tm4cQeEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgCCCwS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:52:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:46680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgCCCuE (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 2 Mar 2020 21:50:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B238E246D5;
        Tue,  3 Mar 2020 02:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203804;
        bh=mQi+kJKCA4XsCXfQOnNrS/gSe+ZGvNiadlAQOyB6ZBM=;
        h=From:To:Cc:Subject:Date:From;
        b=zNVQ1QPdO4MZATr8RVADQWjstKYSxcP5jFsP+TiAg7sGnCSmX/XLRPB/MjE5fkWwt
         wKLRaEUKwE6PHUGfPWs0plD34bDiwGG4KG9zUwuzRw+tgze5gR1dvy6+GV/bqpGXY8
         L0Z2bXfM+gzWKBWKegmm94AjCp9Kk4tp1NWZ64Os=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Golle <daniel@makrotopia.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 01/13] serial: ar933x_uart: set UART_CS_{RX,TX}_READY_ORIDE
Date:   Mon,  2 Mar 2020 21:49:50 -0500
Message-Id: <20200303025002.10600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
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
index d4462512605b5..246f4aab74075 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -289,6 +289,10 @@ static void ar933x_uart_set_termios(struct uart_port *port,
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 			    AR933X_UART_CS_HOST_INT_EN);
 
+	/* enable RX and TX ready overide */
+	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
+		AR933X_UART_CS_TX_READY_ORIDE | AR933X_UART_CS_RX_READY_ORIDE);
+
 	/* reenable the UART */
 	ar933x_uart_rmw(up, AR933X_UART_CS_REG,
 			AR933X_UART_CS_IF_MODE_M << AR933X_UART_CS_IF_MODE_S,
@@ -421,6 +425,10 @@ static int ar933x_uart_startup(struct uart_port *port)
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

