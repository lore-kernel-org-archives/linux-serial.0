From: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: [PATCH] Fix oops in the 8250 serial driver when accessing a removed device
Date: Tue, 22 Jul 2008 17:37:05 +0200
Message-ID: <200807221737.06224.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailrelay005.isp.belgacom.be ([195.238.6.171]:49054 "EHLO
	mailrelay005.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751952AbYGVPhJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Jul 2008 11:37:09 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

The 8250 serial driver allocates dummy devices for ISA serial ports and lets
userspace applications open them even when they are not present. That hack is
required by setserial to set the ISA serial ports I/O address.

When a plug-and-play 8250 device is detected, the driver reuses one of the
dummy ports. If that device is later removed, the port goes pack to the dummy
ports pool. The capabilities field is not reset, which causes a oops when
trying to access the port.

This patch resets the capabilities field when a 8250 device is unregistered.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
---
 drivers/serial/8250.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index ef158c1..40eb91f 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2886,6 +2886,7 @@ void serial8250_unregister_port(int line)
 		uart->port.flags &= ~UPF_BOOT_AUTOCONF;
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
+		uart->capabilities = 0;
 		uart_add_one_port(&serial8250_reg, &uart->port);
 	} else {
 		uart->port.dev = NULL;
-- 
1.5.0

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
