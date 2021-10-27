Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028D5C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 27 Oct 2021 11:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D702960FBF
	for <linux-serial@archiver.kernel.org>; Wed, 27 Oct 2021 11:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbhJ0LZf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:25:35 -0400
Received: from goliath.siemens.de ([192.35.17.28]:60051 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhJ0LZf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 27 Oct 2021 07:25:35 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Oct 2021 07:25:34 EDT
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 19RBHQkF007081
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Oct 2021 13:17:26 +0200
Received: from cnctu04711.ad001.siemens.net ([139.24.142.64])
        by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id 19RBHHGL006640;
        Wed, 27 Oct 2021 13:17:18 +0200
From:   Su Bao Cheng <baocheng.su@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        lukas@wunner.de
Cc:     jan.kiszka@siemens.com, chao.zeng@siemens.com,
        Su Bao Cheng <baocheng.su@siemens.com>
Subject: [PATCH] Revert "serial: 8250: Don't touch RTS modem control while in rs485 mode"
Date:   Wed, 27 Oct 2021 19:16:44 +0800
Message-Id: <20211027111644.1996921-1-baocheng.su@siemens.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This reverts commit f45709df7731ad36306a28a3e1af7309d55c35f5.

The `serial8250_do_set_mctrl` not only used by userspace ioctl but
also the kernel itself.

During tty_open, the uart_port_startup sets the MCR to 0, and then use
set_mctrl to restore the MCR, so at this time, the MCR read does not
reflect the desired value.

Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
---
 drivers/tty/serial/8250/8250_port.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 66374704747e..40736e460956 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2024,13 +2024,6 @@ void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned char mcr;
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		if (serial8250_in_MCR(up) & UART_MCR_RTS)
-			mctrl |= TIOCM_RTS;
-		else
-			mctrl &= ~TIOCM_RTS;
-	}
-
 	mcr = serial8250_TIOCM_to_MCR(mctrl);
 
 	mcr = (mcr & up->mcr_mask) | up->mcr_force | up->mcr;
-- 
2.25.1

