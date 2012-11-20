From: Matt Schulte <matts@commtech-fastcom.com>
Subject: [PATCH 2/3] Optimization: check for presence of UPF_EXAR_EFR flag
 before serial_in
Date: Tue, 20 Nov 2012 11:23:56 -0600
Message-ID: <CAJp1Oe5hAU252XGEMNTCGZhdV2jyBvhsOVANyt0hZTaDZrS26A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:33854 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab2KTRYR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Nov 2012 12:24:17 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so2610370vcm.19
        for <linux-serial@vger.kernel.org>; Tue, 20 Nov 2012 09:24:16 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Kroah-Hartman <greg@kroah.com>

Optimization: check for presence of UPF_EXAR_EFR flag before serial_in

Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
---
Built against tty-next commit: 1e619a1bf9ac878e6a984e4e279ccf712a65bc23

This depends on my previous patch submission:
[PATCH v3] Add support for new devices: Exar's XR17V35x family of
multi-port PCIe UARTs

 drivers/tty/serial/8250/8250.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 1cda869..336d17c 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -913,9 +913,9 @@ static void autoconfig_16550a(struct uart_8250_port *up)
 	 * found at offset 0x09. Instead check the Deice ID (DVID)
 	 * register for a 2, 4 or 8 port UART.
 	 */
-	status1 = serial_in(up, UART_EXAR_DVID);
-	if (status1 == 0x82 || status1 == 0x84 || status1 == 0x88) {
-		if (up->port.flags & UPF_EXAR_EFR) {
+	if (up->port.flags & UPF_EXAR_EFR) {
+		status1 = serial_in(up, UART_EXAR_DVID);
+		if (status1 == 0x82 || status1 == 0x84 || status1 == 0x88) {
 			DEBUG_AUTOCONF("Exar XR17V35x ");
 			up->port.type = PORT_XR17V35X;
 			up->capabilities |= UART_CAP_AFE | UART_CAP_EFR |
-- 
1.7.2.5
