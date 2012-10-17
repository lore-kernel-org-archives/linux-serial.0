From: Noam Camus <noamc@ezchip.com>
Subject: RE: 8250_early for big-endian
Date: Wed, 17 Oct 2012 11:07:36 +0200
Message-ID: <264C179F799EF24AB26D5319053335E80CC30499B2@ezexch.ezchip.com>
References: <264C179F799EF24AB26D5319053335E80CC30499A2@ezexch.ezchip.com>
	<20121012175150.4b081343@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A4@ezexch.ezchip.com>
	<20121012195102.5781c7d4@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A5@ezexch.ezchip.com>
	<20121012220604.3f99d003@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC30499A9@ezexch.ezchip.com>
	<20121013145212.27f6fcbd@pyramind.ukuu.org.uk>
	<264C179F799EF24AB26D5319053335E80CC3001073@ezexch.ezchip.com>,<20121014133216.686277e1@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ezexch.ezchip.com ([212.179.42.101]:53703 "EHLO
	ezexch.ezchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab2JQJIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 17 Oct 2012 05:08:19 -0400
In-Reply-To: <20121014133216.686277e1@pyramind.ukuu.org.uk>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

________________________________________
From: Alan Cox [alan@lxorguk.ukuu.org.uk]
Sent: Sunday, October 14, 2012 2:32 PM

>For 8250_early it may well be the right thing is to support similar
serial_in/serial_out methods.

Hello Alan,
Here is my patch:

>From e819fbbf9690b72620c54a62fa34545c7b035f91 Mon Sep 17 00:00:00 2001
From: Noam Camus <noamc@ezchip.com>
Date: Wed, 3 Oct 2012 09:40:36 +0200
Subject: [PATCH] tty/8250_early: Make serial_in/serial_out be over-ridden

Now one can replace default methods with similar fit to its needs.
e.g. choose other regshift, register offset...

Signed-off-by: Noam Camus <noamc@ezchip.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/tty/serial/8250/8250_early.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index eaafb98..ac31b0c 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -48,7 +48,7 @@ struct early_serial8250_device {
 
 static struct early_serial8250_device early_device;
 
-static unsigned int __init serial_in(struct uart_port *port, int offset)
+unsigned int __weak __init serial_in(struct uart_port *port, int offset)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
@@ -62,7 +62,7 @@ static unsigned int __init serial_in(struct uart_port *port, int offset)
 	}
 }
 
-static void __init serial_out(struct uart_port *port, int offset, int value)
+void __weak __init serial_out(struct uart_port *port, int offset, int value)
 {
 	switch (port->iotype) {
 	case UPIO_MEM:
-- 
1.7.1


Noam