From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: RFC: extending serial line disciplines to handle CTS changes.
Date: Thu, 8 Jul 2010 16:18:54 -0400
Message-ID: <AANLkTinZUIh9cuHzwJWnyDhDKu6yASZ27ZSyoCf41Dil@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35904 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab0GHUS4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Jul 2010 16:18:56 -0400
Received: by ewy23 with SMTP id 23so293032ewy.19
        for <linux-serial@vger.kernel.org>; Thu, 08 Jul 2010 13:18:54 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linuxpps@ml.enneenne.com
Cc: Christopher Cordahi <ChristopherCordahi@nanometrics.ca>

Hi All,

I am pondering the best approach to adding PPS over CTS lines of
serial ports. We are considering using a platform where the UARTs do
not have DCD lines and so we cannot use the usual PPS serial line
discipline which has a DCD change handler. The serial ports do,
however, have CTS lines with interrupt capability.

I'm wondering if setting up the serial port to no flow control and
routing the PPS over CTS line might work.

We could configure the serial port for no flow control and extend the
serial line discipline framework to allow CTS change handlers. This
could be accomplished by adding another function pointer to struct
tty_ldisc and handing off to it at the bottom of
uart_handle_cts_change like uart_handle_dcd_change does to the
dcd_change pointer of the current struct tty_ldisc. Future patches
would probably involve adding #ifdef CONFIG_HARD_PPS to the
uart_handle_cts_change function but I think a PPS line-discipline only
would be fine for the time-being.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
