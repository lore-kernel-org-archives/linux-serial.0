From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 00/75] TTY updates for 2.6.29-rc
Date: Fri, 02 Jan 2009 13:40:06 +0000
Message-ID: <20090102133822.13472.53912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:46132 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752215AbZABNj4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Jan 2009 08:39:56 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

There are several chunks to this. The main thrust is extracting common code
into the tty layer and tidying up. Further lock_kernel removal is done (notably
Joe Peterson has removed in from most of n_tty now). Ptys get namespaces for
container usage.

---

Alan Cox (37):
      tty: Fix an ircomm warning and note another bug
      tty: We want the port object to be persistent
      tty: Drop the lock_kernel in the private ioctl hook
      synclink_cs: Convert to tty_port
      tty: use port methods for the rocket driver
      tty: kref the rocket driver
      tty: make rocketport use standard port->flags
      tty: Redo the rocket driver locking
      tty: Make epca use the port helpers
      tty: refcount the epca driver
      tty: relock epca
      tty: Fix the HSO termios handling a bit
      hso: net driver using tty without locking
      tty: kref nozomi
      tty: Remove some pointless casts
      tty: PTYs set TTY_DO_WRITE_WAKEUP when they don't need to
      tty: USB tty devices can block in tcdrain when unplugged
      tty: Introduce some close helpers for ports
      tty: tty port zero baud open
      tty: ESP has been broken for locking etc forver
      tty: rework stallion to use the tty_port bits
      tty: Rework istallion to use the tty port changes
      tty: Introduce a tty_port generic block_til_ready
      tty: relock the mxser driver
      tty: relock riscom8 using port locks
      tty: rocketport uses different port flags to everyone else
      tty: relock generic_serial
      isicom: redo locking to use tty port locks
      tty: Pull the dtr raise into tty port
      rio: Kill off ckmalloc
      tty_port: Add a port level carrier detect operation
      tty: Fix PPP hang under load
      tty: Fix close races in USB serial
      pty: simplify resize
      sierra: Fix formatting
      devpts: Coding style clean up
      n_tty: clean up coding style

Alexander Beregalov (1):
      fix for tty-serial-move-port

Andrew Morton (2):
      drivers/char/cyclades.c: cy_pci_probe: fix error path
      devpts: fix unused function warning

Andy Whitcroft (1):
      serial: RS485 ioctl structure uses __u32 include linux/types.h

David Daney (4):
      Serial: UART driver changes for Cavium OCTEON.
      Serial: Allow port type to be specified when calling serial8250_register_port.
      8250: Serial driver changes to support future Cavium OCTEON serial patches.
      8250: Don't clobber spinlocks.

David Howells (1):
      CRED: Wrap task credential accesses in the devpts filesystem

Denis Joseph Barrow (3):
      hso maintainers update patch
      hso modem detect fix patch against Alan Cox'es tty tree
      tty: Modem functions for the HSO driver

Flavio Leitner (1):
      serial_8250: support for Sealevel Systems Model 7803 COMM+8

Graf Yang (1):
      Blackfin Serial Driver: fix bug - SIR driver stop receiving randomly

Harvey Harrison (1):
      __FUNCTION__ is gcc-specific, use __func__

Jason Wessel (1):
      tty: Fix sparse static warning for tty_driver_lookup_tty

Joe Peterson (4):
      n_tty: Output bells immediately on a full buffer
      n_tty: Fix hanfling of buffer full corner cases
      n_tty: Fix handling of control characters and continuations
      n_tty: Fix loss of echoed characters and remove bkl from n_tty

Kevin Hao (1):
      Add device function for USB serial console

Niels de Vos (1):
      serial: set correct baud_base for Oxford Semiconductor Ltd EXSYS EX-41092 Dual 16950 Serial adapter

Russell King (2):
      And here's a patch (to be applied on top of the last) which prevents
      Convert the oxsemi tornado special cases to use the quirk interface and not

Sonic Zhang (4):
      Blackfin Serial Driver: Remove BI status for known_good_char
      Blackfin Serial Driver: Fix bug - BF527-EZKIT unable to receive large files over UART in DMA mode
      Blackfin Serial Driver: Clean serial console and early prink code.
      Blackfin Serial Driver: updates kgdb over Blackfin serial driver with kgdb framework

Sukadev Bhattiprolu (9):
      Document usage of multiple-instances of devpts
      Enable multiple instances of devpts
      Define get_init_pts_sb()
      Define mknod_ptmx()
      Add DEVPTS_MULTIPLE_INSTANCES config token
      Extract option parsing to new function
      Per-mount 'config' object
      Per-mount allocated_ptys
      Remove devpts_root global

Thomas Pfaff (1):
      tty: N_TTY SIGIO only works for read


 Documentation/filesystems/devpts.txt |  132 ++++++
 MAINTAINERS                          |    6 
 drivers/char/Kconfig                 |   13 +
 drivers/char/amiserial.c             |   34 +
 drivers/char/cyclades.c              |    2 
 drivers/char/epca.c                  |  265 +++--------
 drivers/char/esp.c                   |   61 ++-
 drivers/char/generic_serial.c        |   76 ++-
 drivers/char/hvc_console.c           |    2 
 drivers/char/hvsi.c                  |   12 -
 drivers/char/isicom.c                |  166 +------
 drivers/char/istallion.c             |  221 +++------
 drivers/char/moxa.c                  |   26 +
 drivers/char/mxser.c                 |  150 +-----
 drivers/char/n_r3964.c               |   12 -
 drivers/char/n_tty.c                 |  792 +++++++++++++++++++++++++++-------
 drivers/char/nozomi.c                |   85 ++--
 drivers/char/pcmcia/synclink_cs.c    |  479 ++++++++-------------
 drivers/char/pty.c                   |   57 ++
 drivers/char/rio/rio_linux.c         |   35 +-
 drivers/char/riscom8.c               |  194 ++------
 drivers/char/rocket.c                |  320 ++++----------
 drivers/char/rocket.h                |    2 
 drivers/char/rocket_int.h            |    5 
 drivers/char/selection.c             |    2 
 drivers/char/ser_a2232.c             |   23 +
 drivers/char/serial167.c             |   32 +
 drivers/char/specialix.c             |   34 +
 drivers/char/stallion.c              |  169 ++-----
 drivers/char/sx.c                    |   31 +
 drivers/char/synclink.c              |  177 +++-----
 drivers/char/synclink_gt.c           |  120 ++---
 drivers/char/synclinkmp.c            |  171 +++----
 drivers/char/tty_io.c                |   39 +-
 drivers/char/tty_ldisc.c             |   30 +
 drivers/char/tty_port.c              |  225 ++++++++++
 drivers/char/vme_scc.c               |   27 +
 drivers/char/vt.c                    |   16 -
 drivers/char/vt_ioctl.c              |    2 
 drivers/net/usb/hso.c                |  434 +++++++++++++++++--
 drivers/serial/8250.c                |  225 +++++++---
 drivers/serial/8250_pci.c            |  134 +++---
 drivers/serial/bfin_5xx.c            |  239 +++++-----
 drivers/serial/bfin_sport_uart.c     |   60 +--
 drivers/serial/jsm/jsm_tty.c         |    2 
 drivers/serial/serial_core.c         |  155 +++----
 drivers/usb/serial/console.c         |   13 +
 drivers/usb/serial/ftdi_sio.c        |    9 
 drivers/usb/serial/kl5kusb105.c      |    1 
 drivers/usb/serial/mct_u232.c        |    2 
 drivers/usb/serial/mos7840.c         |    3 
 drivers/usb/serial/sierra.c          |    2 
 drivers/usb/serial/usb-serial.c      |   26 +
 fs/devpts/inode.c                    |  472 ++++++++++++++++++--
 include/linux/8250_pci.h             |    2 
 include/linux/generic_serial.h       |    1 
 include/linux/istallion.h            |    2 
 include/linux/pci_ids.h              |    2 
 include/linux/serial.h               |    3 
 include/linux/serial_8250.h          |    3 
 include/linux/serial_core.h          |   69 ++-
 include/linux/tty.h                  |   27 +
 include/linux/tty_driver.h           |    6 
 net/irda/ircomm/ircomm_tty.c         |    5 
 64 files changed, 3538 insertions(+), 2604 deletions(-)
 create mode 100644 Documentation/filesystems/devpts.txt

--

