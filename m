From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: earlycon: no match?
Date: Sun, 3 May 2015 23:10:54 +0200
Message-ID: <20150503211054.GR15254@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

Hi Peter,

with 4.1-rc1, my boxes with early console enabled show something like
this (the example is vexpress, but it for example also happens on an
AM335x board):

  earlycon: no match for ttyAMA0,38400n8

The box was booted with "console=ttyAMA0,38400n8" on the commandline.
If I understand this right, the code in drivers/tty/serial/earlycon.c
calls setup_earlycon() with the string above ("ttyAMA0,38400n8") and
fails to find that string in the "names" part of the __earlycon_table,
because for the pl011 component on vexpress, the early console was
registered in drivers/tty/serial/amba-pl011.c with:

OF_EARLYCON_DECLARE(pl011, "arm,pl011", pl011_early_console_setup);
                    ^^^^^ name

So isn't that trying to match "ttyAMA0" against "arm,pl011"? I have the
feeling that I didn't understand the logic behind that.

Can you elaborate about how this is supposed to work correctly?

Thanks,
rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
