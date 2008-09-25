From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: better Documentation for TIOCM_CTS handling
Date: Thu, 25 Sep 2008 15:14:50 +0200
Message-ID: <48DB8ECA.1020302@parrot.com>
References: <48D242DC.30102@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050109070604060001010800"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:39278 "EHLO
	toronto.xi-lite.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752286AbYIYNOy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Sep 2008 09:14:54 -0400
Received: from toronto.xi-lite.net (localhost.localdomain [127.0.0.1])
	by toronto.xi-lite.net (Postfix) with ESMTP id 7824A6582BC
	for <linux-serial@vger.kernel.org>; Thu, 25 Sep 2008 13:14:52 +0000 (GMT)
Received: from mail.xi-lite.com (unknown [193.34.35.243])
	by toronto.xi-lite.net (Postfix) with ESMTP id 659986582BC
	for <linux-serial@vger.kernel.org>; Thu, 25 Sep 2008 13:14:52 +0000 (GMT)
In-Reply-To: <48D242DC.30102@parrot.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------050109070604060001010800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

can we add in the documentation that if the driver want to manage CTS or
DCD, it should be able to report the change with uart_handle_xx_change
function ?

Something like the attached patch.


Thanks


Matthieu

--------------050109070604060001010800
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

--------------050109070604060001010800--
