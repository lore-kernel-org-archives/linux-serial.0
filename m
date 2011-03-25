From: Jiri Slaby <jslaby@suse.cz>
Subject: Should .dtr_rts do tty_port_tty_get?
Date: Fri, 25 Mar 2011 11:45:39 +0100
Message-ID: <4D8C7253.3040204@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37188 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934195Ab1CYKpo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Mar 2011 06:45:44 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>

Hi,

I'm playing with a serial device and got a nice oops. Maybe after some
weird stty's, I don't know. But it dies in uart_dtr_rts:
        .loc 1 1535 0
        movq    (%rbx), %r13    # port_1(D)->tty, D.26746
...
        .loc 1 1494 0
        testb   $2, 224(%r13)   #, D.26746_10->flags
                    ^^^^^^^^^
                      HERE

Because r13 (port->tty) is NULL. So the question is about the principle.
Should it call tty_port_tty_get or is it a bug in the TTY layer and
uart_dtr_rts should not be called with port->tty == NULL?

I'll attach a patch which does the former as a reply to this message.

BTW only serial_core needs tty in dtr_rts.

thanks,
-- 
js
suse labs
