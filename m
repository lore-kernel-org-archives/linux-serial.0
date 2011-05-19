From: Pavan Savoy <pavan_savoy@sify.com>
Subject: serial_core's port->count mess
Date: Thu, 19 May 2011 15:08:52 +0530
Message-ID: <BANLkTim=dgCwFTeCyz273nBq4MGQs1FJsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49194 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844Ab1ESJiy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 May 2011 05:38:54 -0400
Received: by wya21 with SMTP id 21so1823520wya.19
        for <linux-serial@vger.kernel.org>; Thu, 19 May 2011 02:38:53 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: pavan_savoy@sify.com

Hi,

I have a device connected to my apps processor over UART, the serial
core's hooked up with omap-serial UART driver.
There is a scenario, where the device just fails to respond, and I
should be closing the UART & opening it again to re-try the request.
This is also coupled with power-cycling the chip.

However a normal start/stop sequence where chip responds to every
request & I close UART when I'm done - is something like this,
[function name & line number in logs)
uart_open(1) called
uart_open: 1635
uart_open: 1651
uart_open: 1663
uart_open: 1674
omap-hsuart omap-hsuart.1: serial_omap_pm+1
omap-hsuart omap-hsuart.1: Enable CTS wakeup for UART 1
omap-hsuart omap-hsuart.1: serial_omap_startup+1
omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
omap-hsuart omap-hsuart.1: serial_omap_get_mctrl+1
uart_open: 1686
uart_open: 1694
omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
omap-hsuart omap-hsuart.1: serial_omap_set_termios+1
omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
uart_open: 1705
uart_flush_buffer(1) called
omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
omap-hsuart omap-hsuart.1: serial_omap_set_termios+1
omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
omap-hsuart omap-hsuart.1: serial_omap_set_termios+1
uart_flush_buffer(1) called
uart_flush_buffer(1) called
uart_flush_buffer(1) called
omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
omap-hsuart omap-hsuart.1: serial_omap_set_termios+1
uart_wait_until_sent(1), jiffies=4294954470, expire=4294954474...
omap-hsuart omap-hsuart.1: serial_omap_tx_empty+1
uart_wait_until_sent(1), jiffies=4294954471, expire=4294954475...
omap-hsuart omap-hsuart.1: serial_omap_tx_empty+1
(stc): st_tty_open

uart_flush_buffer(1) called
uart_flush_buffer(1) called
uart_flush_buffer(1) called
(stk) :ldisc_install = 0
uart_close(1) called
uart_close: 1295
uart_close: 1316
uart_wait_until_sent(1), jiffies=4294951992, expire=4294951996...
omap-hsuart omap-hsuart.1: serial_omap_tx_empty+1
uart_close: 1327
omap-hsuart omap-hsuart.1: Disable CTS wakeup for UART1
uart_wait_until_sent(1), jiffies=4294951994, expire=4294951996...
omap-hsuart omap-hsuart.1: serial_omap_tx_empty+1
uart_close: 1345
omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
omap-hsuart omap-hsuart.1: serial_omap_shutdown+1
omap-hsuart omap-hsuart.1: serial_omap_set_mctrl+1
uart_flush_buffer(1) called
uart_flush_buffer(1) called
omap-hsuart omap-hsuart.1: serial_omap_pm+1
uart_close: 1368
(stc): st_tty_close

However, in a scenario where the chip fails to respond to one of the
requests, the start/stop sequence becomes something like this,
uart_open(1) called
uart_open: 1635
uart_open: 1651
uart_open: 1663
uart_open: 1705

So, the problem seems to be that the port->count in the serial_core
isn't 1 & hence the call,
        if (port->count == 1)
                uart_change_pm(state, 0);
doesn't seem to be happening, which is very critical. Also no calls
are made to uart_startup & hence omap-serial's startup.

Where should I be looking as to why the port->count is messed up ?
What is the this count used for?
Also how is this related to chip not responding to certain commands?
