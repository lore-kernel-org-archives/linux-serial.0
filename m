From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pch_uart: Fix missing break for 16 byte fifo
Date: Mon, 02 Jul 2012 18:51:38 +0100
Message-ID: <20120702175133.10373.40518.stgit@bluebook>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:47269 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752866Ab2GBQwu (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 2 Jul 2012 12:52:50 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

Otherwise we fall back to the wrong value.

Reported-by: <dcb314@hotmail.com>
Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=44091
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/pch_uart.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 4fdec6a..d53621a 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1263,6 +1263,7 @@ static int pch_uart_startup(struct uart_port *port)
 		break;
 	case 16:
 		fifo_size = PCH_UART_HAL_FIFO16;
+		break;
 	case 1:
 	default:
 		fifo_size = PCH_UART_HAL_FIFO_DIS;

