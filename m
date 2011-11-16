From: Wolfram Sang <w.sang@pengutronix.de>
Subject: =?UTF-8?q?=5BPATCH=200/8=5D=20serial=3A=208250=3A=20support=20hw-based=20RS485=20direction=20control=20=28finally!=29?=
Date: Wed, 16 Nov 2011 17:24:37 +0100
Message-ID: <1321460685-15753-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>, Juergen Beisert <jbe@pengutronix.de>, Matthias Fuchs <mfuchs@ma-fu.de>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

Some 8250-variants control the direction pin for RS485 in hardware. Lin=
ux has
RS485 support these days, so update the 8250-driver to adhere to that. =
There
have been attempts for mainlining this before. So, I started with the v=
ersion
from Matthias which got no further comments, a proof-of-concept for the=
 16V2750
from J=C3=BCrgen, and reworked it to match the current state of RS485 i=
n Linux. Some
minor cleanup patches came along the way. Really looking forward to
comments/tags, because I think it is really time to get this functional=
ity into
mainline once and for all ;)

Code is based on 3.2-rc2, tested on a OMAP-based custom board with a 16=
V2750.
A git tree can be found here:

	git://git.pengutronix.de/git/wsa/linux-2.6.git 8250_rs485

Thanks and regards,

   Wolfram

Matthias Fuchs (1):
  serial: 8250: Add ioctl to enable auto rs485 mode with some Exar UART=
s

Wolfram Sang (7):
  serial: 8250: replace hardcoded 0xbf with #define
  serial: 8250: save rs485_flags per instance
  serial: 8250: add RX_DURING_TX capability to RS485 mode
  serial: 8250: reject delaying RTS with RS485
  serial: 8250: update rs485 flags with polarity settings
  serial: 8250: add Exar 16V2750 support
  serial: 8250: fix comment about accessing EMSR

 drivers/tty/serial/8250.c   |  143 +++++++++++++++++++++++++++++++++++=
++++---
 include/linux/serial_core.h |    3 +-
 include/linux/serial_reg.h  |    4 +-
 3 files changed, 137 insertions(+), 13 deletions(-)

--=20
1.7.7.1
