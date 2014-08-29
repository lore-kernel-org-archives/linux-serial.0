From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 0/1] ARM SBSA UART driver
Date: Fri, 29 Aug 2014 17:13:22 +0100
Message-ID: <1409328803-1953-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:55585 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753256AbaH2QOA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Aug 2014 12:14:00 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>

Hi,

this is my first try on a driver for the generic UART defined in the
ARM Server Base System Architecture (SBSA) [1] document.
It it basically a severly restricted subset of the PL011 driver,
removing DMA, modem control, baud rate setting and other features.
The idea of it is to let it be initialized by the firmware, so Linux
can just use it without fiddling with the parameters.
Given the subset nature of the spec, a full featured PL011 can be
driven by this driver - given it has been initialized before.

So this version is a stripped copy of the AMBA PL011 driver, removing
everything not needed (including the AMBA bindings, instead just use
the device tree).
This works for me on a hardware PL011 and on the fast model. My
version of it allows to restrict the register set to the SBSA subset.

I tried deriving it from the goldfish TTY driver before, but that
didn't work very well - it had no TX IRQ support and required an ugly
hack to convert the line endings on the console.

To avoid further churn with the device namings, this driver also uses
the ttyAMA prefix. That seems to make sense given the relationship
of the two devices and the possibility to drive real PL011s with this
driver. However there is an issue when both drivers are active: the
numbering could possibly be wrong, causing udev to complain.

So there is the possibility to fold this driver back into
amba-pl011.c, providing a separate _probe function and a separate
struct uart_ops, possibly reusing PL011 functions, while using
extra functions for the incompatible part of it. Not sure if it's
worth it, though.

I'd love to have some feedback on how to proceed from here:

Is this separate driver (file) OK?
Should this be part of the PL011 driver?
Should it use a different tty prefix?
Does it need the separate config options?
Should the existing PL011 driver be refactored to support both?

Cheers,
Andre

P.S. There is an almost trivial patch to add ACPI support for this,
but which this margin is too narrow to contain ;-)

[1] http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0029

Andre Przywara (1):
  drivers: introduce ARM SBSA generic UART driver

 .../devicetree/bindings/serial/arm_sbsa_uart.txt   |    6 +
 drivers/tty/serial/Kconfig                         |   28 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/sbsa_uart.c                     |  793 ++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |    1 +
 5 files changed, 829 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
 create mode 100644 drivers/tty/serial/sbsa_uart.c

-- 
1.7.9.5

