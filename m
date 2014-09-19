From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 00/10] drivers: PL011: add SBSA subset support
Date: Fri, 19 Sep 2014 13:21:13 +0100
Message-ID: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36066 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755548AbaISMWG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:06 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

(This version has still issues, but I'd like to have feedback on
the general feasibility of this approach before wasting even more
time on debugging).

The ARM Server Base System Architecture[1] document describes a
generic UART which is a subset of the PL011 UART.
It lacks DMA support, baud rate control and modem status line
control, among other things.
The idea is to move the UART initialization and setup into the
firmware (which does this job today already) and let the kernel just
use the UART for sending and receiving characters.

This patchset is an attempt to integrate support for this UART subset
into the existing PL011 driver - basically by refactoring some
functions and providing a new uart_ops structure for it. It also has
a separate probe function to be not dependent on AMBA/PrimeCell.
Beside the obvious effect of code sharing it has the advantage of not
introducing another serial device prefix, so it can go with ttyAMA,
which seems to be pretty common.

There is still one issue in bringing up the UART. On the PL011 we
send a dummy character via the loopback facility with the FIFOs
disabled to get things going, but both FIFO control and loopback are
outside of the SBSA spec. I consider this loopback approach a kludge
anyway, but am struggling to find a better way of fixing this due to
my lack of understanding of the TTY/serial layer.
If someone with more wisdom could enlighten me, I would be grateful.


Patch 1/10 contains a bug fix which applies to the PL011 part also,
it should be considered regardless of the rest of the series.
Patch 2-7 refactor some PL011 functions by splitting them up into
smaller pieces, so that most the code can be reused later by the SBSA
part.
Patch 8 and 9 introduce two new properties for the vendor structure,
this is for SBSA functionality which cannot be controlled by
separate uart_ops members only.
Patch 10 then finally drops in the SBSA specific code, by providing
a new uart_ops, vendor struct and probe function for it.

Please have a look and tell me whether this SBSA driver approach has
any future.

Regards,
Andre

Andre Przywara (10):
  drivers: PL011: avoid potential unregister_driver call
  drivers: PL011: refactor pl011_startup()
  drivers: PL011: refactor pl011_shutdown()
  drivers: PL011: refactor pl011_set_termios()
  drivers: PL011: refactor pl011_probe()
  drivers: PL011: replace UART_MIS reading with _RIS & _IMSC
  drivers: PL011: move cts_event workaround into separate function
  drivers: PL011: allow avoiding UART enabling/disabling
  drivers: PL011: allow to supply fixed option string
  drivers: PL011: add support for the ARM SBSA generic UART

 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |    9 +
 drivers/tty/serial/amba-pl011.c                    |  509 ++++++++++++++------
 2 files changed, 380 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt

-- 
1.7.9.5

