From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: arc_uart: serial output truncated
Date: Wed, 6 Mar 2013 19:17:22 +0530
Message-ID: <513748EA.7050407@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:48495 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990Ab3CFNrf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Mar 2013 08:47:35 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>

Hi,

I'm seeing truncated serial console output, with 3.8 based arc_uart driver
(drivers/tty/serial/arc_uart.c)

It would seem funny that I'm the driver author and still bringing this up -
because this seems like an interplay of tty-core/serial-core with a slow serial
device, rather than a driver specific issue, which is causing this.

The basic call flow is a write(2) to STDERR which lands in the tty layer. The
routine n_tty_write() successfully copies the complete msg from tty layer's buffer
to driver's tx buffer (tty->driver_state->xmit->buf). There are 3 arc-uart driver
output calls in that codepath and with 1 deep Tx FIFO only 3 characters are output
- as follows:

n_tty_write
  process_output_block
     tty->ops->write --> full user buffer
     uart_write
        copy tty buffer into driver buffer
        uart_start
           port->ops->start_tx
           arc_serial_tx_chars   ==> 1st char
  process_output
    tty->ops->write --> "\r\n"
        uart_start
           port->ops->start_tx
           arc_serial_tx_chars   ==> 2nd char
  tty_flush_chars
    uart_start
           port->ops->start_tx
           arc_serial_tx_chars   ==> 3rd char

Once interrupts are re-enabled (spin_unlock_irqrestore) a few more chars are
output via the driver ISR path.

However user app then immediately calls exit().

do_exit
  tty_release
    uart_close
      tty_port_close_start --> returns 0 - because port->count == 4
...
  disassociate_ctty
    tty_ldisk_hangup
      tty_driver_flush_buffer
         tty->ops->flush_buffer
         uart_flush_buffer
           uart_circ_clear  --> zeros the driver tx buffer head/tail


tty_port_close_start() has logic for port->drain_delay but in my case the
port->count is 4 (3 due to init task, 1 from this specific app) so that logic is
not hit.

Eventually, uart_flush_buffer is called, with unwritten data still present, but
the head/tail pointers are reset, causing that driver data to be effectively lost.

So maybe this is how it works (for a 1 deep FIFO uart) but I wanted to confirm
with the serial gurus. Is there any serial setting I can apply here to enable the
last remaining chars to be dumped out of uart tx buffer.

Thx,
-Vineet
