From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 00/12] tty: take 3 - termios, locking and 8250 bugs
Date: Sat, 14 Jul 2012 15:30:59 +0100
Message-ID: <20120714142740.26945.98609.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34125 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab2GNOOJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 14 Jul 2012 10:14:09 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

This patch series is the tty backlog third attempt, so hopefully it's
now all behaving. This is versus the -next tree of Friday and has been
doing 24hrs of testing.

It starts with a revert of the tty lock localise that was applied
already before its dependancies. Without the dependancies it causes
random obscure memory scribbles so we really want it out before we
do the other bits so that we can bisect this !

The final patch then puts it back again.

Sorry for the mess up on the previous attempt. I love major structure
and API changes 8)

Alan

---

Alan Cox (12):
      tty: localise the lock
      tty: Move the handling of the tty release logic
      vt: fix the keyboard/led locking
      tty: tidy up the RESET_TERMIOS case
      8250: add support for ASIX devices with a FIFO bug
      8250: propogate the bugs field
      8250: use the 8250 register interface not the legacy one
      usb, kobil: Sort out some bogus tty handling
      usb: fix sillies in the metro USB driver
      f81232: correct stubbed termios handler
      tty: move the termios object into the tty
      tty: revert incorrectly applied lock patch


 arch/ia64/hp/sim/simserial.c          |    2 -
 arch/mips/cavium-octeon/serial.c      |   30 ++++----
 drivers/bluetooth/hci_ath.c           |    2 -
 drivers/char/mwave/mwavedd.c          |   16 ++--
 drivers/isdn/gigaset/interface.c      |    4 +
 drivers/isdn/i4l/isdn_tty.c           |   16 ++--
 drivers/misc/ibmasm/uart.c            |   16 ++--
 drivers/mmc/card/sdio_uart.c          |   20 +++--
 drivers/net/ethernet/sgi/ioc3-eth.c   |   22 +++---
 drivers/net/irda/irtty-sir.c          |   10 +--
 drivers/net/usb/hso.c                 |   12 +--
 drivers/tty/amiserial.c               |   20 +++--
 drivers/tty/cyclades.c                |   19 ++---
 drivers/tty/hvc/hvsi_lib.c            |    2 -
 drivers/tty/isicom.c                  |    8 +-
 drivers/tty/moxa.c                    |   10 +--
 drivers/tty/mxser.c                   |   20 +++--
 drivers/tty/n_gsm.c                   |    8 +-
 drivers/tty/n_tty.c                   |    2 -
 drivers/tty/pty.c                     |   35 ++-------
 drivers/tty/rocket.c                  |   18 ++---
 drivers/tty/serial/8250/8250.c        |   80 ++++++++-------------
 drivers/tty/serial/8250/8250.h        |   31 --------
 drivers/tty/serial/8250/8250_acorn.c  |   22 +++---
 drivers/tty/serial/8250/8250_dw.c     |   38 +++++-----
 drivers/tty/serial/8250/8250_gsc.c    |   26 +++----
 drivers/tty/serial/8250/8250_hp300.c  |   26 +++----
 drivers/tty/serial/8250/8250_pci.c    |  116 ++++++++++++++++++-------------
 drivers/tty/serial/8250/8250_pnp.c    |   28 ++++---
 drivers/tty/serial/8250/serial_cs.c   |   30 ++++----
 drivers/tty/serial/bfin_uart.c        |    2 -
 drivers/tty/serial/crisv10.c          |   26 +++----
 drivers/tty/serial/ioc4_serial.c      |    2 -
 drivers/tty/serial/jsm/jsm_tty.c      |    8 +-
 drivers/tty/serial/of_serial.c        |    9 ++
 drivers/tty/serial/samsung.c          |    2 -
 drivers/tty/serial/serial_core.c      |   28 ++++---
 drivers/tty/synclink.c                |   36 +++++-----
 drivers/tty/synclink_gt.c             |   24 +++---
 drivers/tty/synclinkmp.c              |   24 +++---
 drivers/tty/tty_io.c                  |   77 ++++++++------------
 drivers/tty/tty_ioctl.c               |  124 +++++++++++++++++----------------
 drivers/tty/tty_ldisc.c               |   10 +--
 drivers/tty/tty_port.c                |    6 +-
 drivers/tty/vt/keyboard.c             |   41 ++++++-----
 drivers/tty/vt/vt.c                   |    5 +
 drivers/usb/class/cdc-acm.c           |    2 -
 drivers/usb/serial/ark3116.c          |    4 +
 drivers/usb/serial/belkin_sa.c        |    2 -
 drivers/usb/serial/cp210x.c           |    8 +-
 drivers/usb/serial/cypress_m8.c       |   40 +++++------
 drivers/usb/serial/digi_acceleport.c  |   14 ++--
 drivers/usb/serial/empeg.c            |    2 -
 drivers/usb/serial/f81232.c           |    3 +
 drivers/usb/serial/ftdi_sio.c         |    2 -
 drivers/usb/serial/io_edgeport.c      |   12 ++-
 drivers/usb/serial/io_ti.c            |   12 ++-
 drivers/usb/serial/ir-usb.c           |    2 -
 drivers/usb/serial/iuu_phoenix.c      |   28 ++++---
 drivers/usb/serial/keyspan.c          |    6 +-
 drivers/usb/serial/keyspan_pda.c      |    4 +
 drivers/usb/serial/kl5kusb105.c       |   18 ++---
 drivers/usb/serial/kobil_sct.c        |   14 ++--
 drivers/usb/serial/mct_u232.c         |    4 +
 drivers/usb/serial/metro-usb.c        |    8 --
 drivers/usb/serial/mos7720.c          |   14 ++--
 drivers/usb/serial/mos7840.c          |   12 ++-
 drivers/usb/serial/oti6858.c          |   10 +--
 drivers/usb/serial/pl2303.c           |    6 +-
 drivers/usb/serial/quatech2.c         |    4 +
 drivers/usb/serial/sierra.c           |    2 -
 drivers/usb/serial/spcp8x5.c          |   12 ++-
 drivers/usb/serial/ssu100.c           |    4 +
 drivers/usb/serial/ti_usb_3410_5052.c |   10 +--
 drivers/usb/serial/usb-serial.c       |    5 +
 drivers/usb/serial/usb_wwan.c         |    2 -
 drivers/usb/serial/whiteheat.c        |    2 -
 include/linux/kbd_kern.h              |    1 
 include/linux/serial_8250.h           |   33 ++++++++-
 include/linux/tty.h                   |   47 ++++++-------
 include/linux/tty_driver.h            |   11 +--
 net/bluetooth/rfcomm/tty.c            |    2 -
 net/irda/ircomm/ircomm_tty.c          |   12 ++-
 net/irda/ircomm/ircomm_tty_ioctl.c    |   10 +--
 84 files changed, 728 insertions(+), 769 deletions(-)

-- 
Signature
