From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: s3c24xx : TIOCM_CTS handling problem
Date: Thu, 18 Sep 2008 14:00:28 +0200
Message-ID: <48D242DC.30102@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060704010706020709070609"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:40466 "EHLO
	toronto.xi-lite.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751588AbYIRMV2 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Sep 2008 08:21:28 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>

This is a multi-part message in MIME format.
--------------060704010706020709070609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

there is a problem in samsung soc serial driver with the report of
TIOCM_CTS in get_mctrl.

The uart layer check the status of the TIOCM_CTS in the open or
set_termios function and cache the result in the tty->hw_stopped flag.

Then when sending data, in the function uart_start, it check
tty->hw_stopped flag before calling the start_tx uart driver callback.


For the samsung uart driver it means :
- if the other side is not connected or in a reset state, then CTS
signal is not activated
- we open and configure the uart. get_mctrl don't report TIOCM_CTS flag.
uart layer set tty->hw_stopped flag.
- we connect or start the other side. CTS signal become activated.
- we send some characters on the uart. This call uart_write which fill
uart tx queue and call uart_start. uart_start doesn't call driver
start_tx because tty->hw_stopped flag is set.
- because driver start_tx is never call, the data is never send on the uart.

>From what I see, working driver managing TIOCM_CTS flag (amba-pl011,
8250), call uart_handle_cts_change when the uart driver detect a CTS
signal change (via a interrupt).

Because the samsung controller doesn't generate an interrupt when CTS
signal change, we can't call uart_handle_cts_change.

And easy fix could be to always report TIOCM_CTS.

I believe this bug is tricky and can affect other drivers.
Can this be documented in Documentation/serial/driver like the attached
patch ?


Matthieu

--------------060704010706020709070609
Content-Type: text/plain;
 name="uart_doc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uart_doc"

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 77ba0af..8395d5a 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -109,6 +109,10 @@ hardware.
 	the port does not support CTS, DCD or DSR, the driver should
 	indicate that the signal is permanently active.  If RI is
 	not available, the signal should not be indicated as active.
+	If the port does not support automatic detection of change of
+	CTS or DCD (and report via uart_handle_cts_change or 
+	uart_handle_dcd_change) the driver should indicate that the
+	signal is permanently active.
 
 	Locking: port->lock taken.
 	Interrupts: locally disabled.

--------------060704010706020709070609--
