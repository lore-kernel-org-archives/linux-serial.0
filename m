From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: [PATCH] RS485 documentation: add 16C950 UART description
Date: Mon, 22 Nov 2010 11:06:32 +0100
Message-ID: <4CEA40A8.5090401@visionsystems.de>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:42653 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752830Ab0KVKGn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 22 Nov 2010 05:06:43 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: gregkh@suse.de, claudio@evidence.eu.com

Add a notion about 16C950 UART, that is using DTR signal for RS485 mode.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/Documentation/serial/serial-rs485.txt
===================================================================
--- a/Documentation/serial/serial-rs485.txt	2010-11-19 03:48:08.000000000 +0100
+++ b/Documentation/serial/serial-rs485.txt	2010-11-19 10:42:22.000000000 +0100
@@ -11,10 +11,11 @@
 
 2. HARDWARE-RELATED CONSIDERATIONS
 
-   Some CPUs (e.g., Atmel AT91) contain a built-in half-duplex mode capable of
-   automatically controlling line direction by toggling RTS. That can used to
-   control external half-duplex hardware like an RS485 transceiver or any
-   RS232-connected half-duplex device like some modems.
+   Some CPUs/UARTs (e.g., Atmel AT91 or 16C950 UART) contain a built-in
+   half-duplex mode capable of automatically controlling line direction by
+   toggling RTS or DTR signals. That can be used to control external
+   half-duplex hardware like an RS485 transceiver or any RS232-connected
+   half-duplex devices like some modems.
 
    For these microcontrollers, the Linux driver should be made capable of
    working in both modes, and proper ioctls (see later) should be made

