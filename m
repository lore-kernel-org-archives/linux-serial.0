From: Mikael Johansson <mikael.lars.johansson@axis.com>
Subject: artpec.c / serial_core.c hardware flow control problem
Date: Thu, 28 Jun 2012 17:29:27 +0200
Message-ID: <4FEC7857.6010006@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from anubis.se.axis.com ([195.60.68.12]:41725 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2F1Pdl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Jun 2012 11:33:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 60B1819D8B
	for <linux-serial@vger.kernel.org>; Thu, 28 Jun 2012 17:27:21 +0200 (CEST)
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id KH5umN78S5GF for <linux-serial@vger.kernel.org>;
	Thu, 28 Jun 2012 17:27:20 +0200 (CEST)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by anubis.se.axis.com (Postfix) with ESMTP id 4092119D1F
	for <linux-serial@vger.kernel.org>; Thu, 28 Jun 2012 17:27:20 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 3EBA234158
	for <linux-serial@vger.kernel.org>; Thu, 28 Jun 2012 17:27:20 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>, Johan Adolfsson <johana@axis.com>

Greetings,

We have a problem with drivers/serial/artpec.c (Not yet in main tree) 
which uses hardware supported flow control (XON/XOFF). We do cfmakeraw() 
and tcsetattr() from userspace to set a termios struct where (c_iflag & 
IXON) is not set. The problem is that the call to tcsetattr() is not 
propagated down to serial_artpec_set_termios(), the reason being that 
uart_set_termios() doesn't think that IXON is a RELEVANT_IFLAG and 
returns prematurely instead of calling uart_change_speed --> 
ops->set_termios().

Could this be fixed by making IXON a RELEVANT_IFLAG?:

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 7f28307..d45473d 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -1211,7 +1211,7 @@ static void uart_set_termios(struct tty_struct *tty,
       * bits in c_cflag; c_[io]speed will always be set
       * appropriately by set_termios() in tty_ioctl.c
       */
-#define RELEVANT_IFLAG(iflag)    ((iflag) & 
(IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
+#define RELEVANT_IFLAG(iflag)    ((iflag) & 
(IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK|IXON))
      if ((cflag ^ old_termios->c_cflag) == 0 &&
          tty->termios->c_ospeed == old_termios->c_ospeed &&
          tty->termios->c_ispeed == old_termios->c_ispeed &&


Or should it be fixed at some other level?

Note: This was tested on 2.6.35 but appears to have the same code in the 
newer kernels. Not many drivers seem to look at the IXON flag, only 
crisv10, omap_serial and jsm_neo.

Best regards,
Mikael Johansson

