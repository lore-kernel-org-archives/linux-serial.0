From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
Subject: open-source driver for the Advantech PCI-16xx series (dumb multiport serial, RS485 RX/TX in HW)
Date: Thu, 07 Jun 2007 19:55:20 +0200
Message-ID: <466862A8.4357.14E06538@Frantisek.Rysanek.post.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.seznam.cz ([212.80.76.43]:41027 "HELO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761508AbXFGSCF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Jun 2007 14:02:05 -0400
Content-description: Mail message body
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: rmk@arm.linux.org.uk

Dear gentlemen,

as the Linux "serial" driver (8250.c et al.) seems unmaintained (status: orphan),
I am in doubt as to whom to send this message... Russell King gets a Cc: just
in case, as he's the author of the current version.

Perhaps take this as an announcement: I've written an open-source "driver"
for the Advantech PCI-16xx family of dumb multiport serial boards (PCI bus),
based on the OX16PCI954 (and OX16PCI952) chips by Oxford Semiconductor.

http://www.fccps.cz/download/adv/frr/pci-16xx-1.3.tgz
http://www.fccps.cz/download/adv/frr/README.pci-16xx.txt

I'm calling it a "driver" for the lack of a better word, though it's really just a
setup module that provides a table of PCI ID's and a probe routine which 
registers the 16C950 UARTs with the standard Linux 2.6 serial driver.

There's just a little bit of trivial "proprietary" candy, that gets the HW-driven
RS485 RX/TX steering initialized, plus a tiny patch into the linux kernel
to prevent it from spoiling the RS485 configuration of the 16C950 UART.
(The UART can be set to drive its DTR pin with an internal TEMT flag,
which is exactly the sort of information needed for RS485.)
Also, the driver contains a "cut'n'paste" copy of 8250.c's private
"struct uart_port", which allows me to avoid patching kernel headers...

It's a trade-off: I believe this is the most straight-forward way of keeping the driver
simple and compatible with the vanilla kernel over time with minimum maintenance.
That is, without actually patching the whole thing into the kernel, which might
entail some ongoing maintenance of the patch, if the driver is to remain a stand-alone 
project.

On the other hand I believe that the various necessary bits could be easily massaged 
into 8250_pci.c and 8250.c, but that's probably not worth the bother unless there is some
interest on part of the Kernel maintainers - i.e., unless the added code becomes
a permanent part of the vanilla 8250_pci.c.

The RS485 control via the 16C950 TEMT flag is specific to the Oxford UART, 
i.e. it's board-vendor-independent. It's not specific to Advantech.
It could be perfectly useful for people who happen to have 16C950-based RS232 hardware 
coupled to an external RS485 converter. To the Internet/PC/Server folks it may seem 
ridiculous to support such an ancient technology (the RS485 bus), but believe me that in the 
industrial automation business (plant control, inteligent buildings, telematics etc) this is still 
the golden standard, a common denominator, used to run a number of payload protocols, 
open and proprietary.

Anyway I'm perfectly happy with my "driver" the way it is, as a stand-alone project.
If it ain't broke, don't fix it, and Russell's work on the serial driver cleanups
from 2.4 has moved code clarity and structure quite a bit forward. 
Any further ideas are welcome...

Frank Rysanek

