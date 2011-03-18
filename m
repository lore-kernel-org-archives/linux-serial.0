From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC 0/5] Starting to pull out the I/O operations
Date: Fri, 18 Mar 2011 15:24:29 +0000
Message-ID: <20110318152145.10657.23718.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:44122 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922Ab1CRPoU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 18 Mar 2011 11:44:20 -0400
Received: from bob.linux.org.uk (earthlight.etchedpixels.co.uk [81.2.110.250])
	by lxorguk.ukuu.org.uk (8.14.4/8.14.1) with ESMTP id p2IFl9ZM018090
	for <linux-serial@vger.kernel.org>; Fri, 18 Mar 2011 15:47:14 GMT
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is an untested WIP but as it was coming in discussion about device-tree
as well I figured it will be useful to post the prototype code at this point.

There is lots left to do - in particular resource claim/release should be an
ops method, and it's going to need people to update various embedded 8250 
drivers when we finally go for a version of it.

On the bright side once we have an ops structure we have the basis for avoiding
further mayhem in the arch code.

---

Alan Cox (5):
      8250: extract out the "odd" port types
      8250: evict the hub6 I/O operations
      8250: register upio users
      8250: introduce the idea of an operations struct for an 8250 port
      8250: Make serial_dl_write a port operation


 drivers/char/mwave/mwavedd.c    |    2 
 drivers/tty/serial/8250.c       |  450 ++++++++++++++-------------------------
 drivers/tty/serial/8250.h       |   27 ++
 drivers/tty/serial/8250_au.c    |   90 ++++++++
 drivers/tty/serial/8250_dwapb.c |  120 ++++++++++
 drivers/tty/serial/8250_hub6.c  |   39 +++
 drivers/tty/serial/8250_pci.c   |    2 
 drivers/tty/serial/8250_pnp.c   |    2 
 drivers/tty/serial/8250_rm9k.c  |   95 ++++++++
 drivers/tty/serial/Kconfig      |    9 +
 drivers/tty/serial/Makefile     |    3 
 drivers/tty/serial/of_serial.c  |    2 
 drivers/tty/serial/serial_cs.c  |    2 
 include/linux/serial_8250.h     |   36 ++-
 include/linux/serial_core.h     |    5 
 15 files changed, 579 insertions(+), 305 deletions(-)
 create mode 100644 drivers/tty/serial/8250_au.c
 create mode 100644 drivers/tty/serial/8250_dwapb.c
 create mode 100644 drivers/tty/serial/8250_rm9k.c

-- 
Words without body bare winter barren trees much unspoken

