From: Rob Herring <robh@kernel.org>
Subject: [PATCH 0/9] tty: tty_struct dependency clean-ups
Date: Fri,  9 Sep 2016 17:37:01 -0500
Message-ID: <20160909223711.26238-1-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

This patch series removes or prepares to remove some of the dependencies 
on tty_struct within tty_port drivers. This will allow using tty_ports 
directly for so called UART slave devices. 

The first patch fixes a regression from the last round with tty 
closing. Patches 2-4 are mechanical conversions generated with 
coccinelle. This is my first adventure into coccinelle, so hopefully I 
didn't screw things up. :) Only serial_core has some of its tty_struct 
dependencies removed as those are the drivers we immediately care about 
supporting slave devices with.

Next up after this are moving some functions to the tty_port ops. I've 
got some WIP patches for some of that, but nothing ready to send out 
quite yet.

Rob

Rob Herring (9):
  tty: serial_core: add tty NULL check to uart_tx_stopped
  tty: remove tty_struct dependency in tty flag macros
  tty: move hw_stopped flag to tty_port
  tty: move TTY_IO_ERROR flag to tty_port iflags
  tty: serial_core: use tty_port_tty_wakeup instead of tty_wakeup
  tty: serial_core: introduce tty_port_to_uart_state
  tty: serial_core: convert private functions to use tty_port instead of
    tty_struct
  tty: serial_core: remove dependence on tty->driver_data
  tty: serial_core: add tty NULL check in uart_port_startup

 arch/ia64/hp/sim/simserial.c          |   8 +-
 drivers/char/pcmcia/synclink_cs.c     |  50 +++----
 drivers/dma/at_xdmac.c                |   4 +-
 drivers/isdn/i4l/isdn_tty.c           |  12 +-
 drivers/mmc/card/sdio_uart.c          |  40 +++---
 drivers/net/ppp/ppp_async.c           |   6 +-
 drivers/s390/char/ctrlchar.c          |   6 +-
 drivers/s390/char/tty3270.c           |   4 +-
 drivers/staging/dgnc/dgnc_cls.c       |   4 +-
 drivers/staging/dgnc/dgnc_neo.c       |   4 +-
 drivers/staging/dgnc/dgnc_tty.c       |   6 +-
 drivers/staging/fwserial/fwserial.c   |  56 ++++----
 drivers/tty/amiserial.c               |  74 +++++-----
 drivers/tty/cyclades.c                |  54 +++----
 drivers/tty/hvc/hvc_console.c         |   4 +-
 drivers/tty/hvc/hvsi.c                |   2 +-
 drivers/tty/isicom.c                  |  41 +++---
 drivers/tty/moxa.c                    |   4 +-
 drivers/tty/mxser.c                   |  72 +++++-----
 drivers/tty/n_gsm.c                   |   8 +-
 drivers/tty/n_tty.c                   | 259 +++++++++++++++++-----------------
 drivers/tty/pty.c                     |  14 +-
 drivers/tty/rocket.c                  |  36 ++---
 drivers/tty/serial/bfin_uart.c        |   6 +-
 drivers/tty/serial/crisv10.c          |  32 +++--
 drivers/tty/serial/etraxfs-uart.c     |   2 +-
 drivers/tty/serial/ioc4_serial.c      |   2 +-
 drivers/tty/serial/jsm/jsm_cls.c      |   2 +-
 drivers/tty/serial/jsm/jsm_neo.c      |   2 +-
 drivers/tty/serial/jsm/jsm_tty.c      |   4 +-
 drivers/tty/serial/serial_core.c      | 152 ++++++++++----------
 drivers/tty/synclink.c                |  56 ++++----
 drivers/tty/synclink_gt.c             |  52 +++----
 drivers/tty/synclinkmp.c              |  54 +++----
 drivers/tty/tty_audit.c               |   4 +-
 drivers/tty/tty_ioctl.c               |  22 +--
 drivers/tty/tty_port.c                |  16 +--
 drivers/tty/vt/keyboard.c             |   2 +-
 drivers/usb/class/cdc-acm.c           |   2 +-
 drivers/usb/serial/ark3116.c          |   2 +-
 drivers/usb/serial/cypress_m8.c       |   2 +-
 drivers/usb/serial/digi_acceleport.c  |   4 +-
 drivers/usb/serial/f81232.c           |  12 +-
 drivers/usb/serial/ftdi_sio.c         |   2 +-
 drivers/usb/serial/generic.c          |   2 +-
 drivers/usb/serial/io_edgeport.c      |  22 +--
 drivers/usb/serial/io_ti.c            |  22 +--
 drivers/usb/serial/mct_u232.c         |   8 +-
 drivers/usb/serial/mos7720.c          |  12 +-
 drivers/usb/serial/mos7840.c          |  12 +-
 drivers/usb/serial/mxuport.c          |  26 ++--
 drivers/usb/serial/pl2303.c           |  18 +--
 drivers/usb/serial/quatech2.c         |   4 +-
 drivers/usb/serial/ssu100.c           |   4 +-
 drivers/usb/serial/ti_usb_3410_5052.c |  16 +--
 drivers/usb/serial/whiteheat.c        |   6 +-
 include/linux/serial_core.h           |   2 +-
 include/linux/tty.h                   | 171 +++++++++++-----------
 net/bluetooth/rfcomm/tty.c            |   2 +-
 net/irda/ircomm/ircomm_tty.c          |  40 +++---
 net/irda/ircomm/ircomm_tty_attach.c   |   6 +-
 net/irda/ircomm/ircomm_tty_ioctl.c    |   6 +-
 62 files changed, 795 insertions(+), 784 deletions(-)

-- 
2.9.3
