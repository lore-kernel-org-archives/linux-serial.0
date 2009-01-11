From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 0/6] Series short description
Date: Sun, 11 Jan 2009 19:48:17 +0000
Message-ID: <20090111194656.16074.14975.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:41716 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751836AbZAKTs3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 11 Jan 2009 14:48:29 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@osdl.org, linux-serial@vger.kernel.org

These are some small fixes that didn't quite make the window. Nothing big here
except in file size. The ti_usb_3410 changes fix a bug in the id handling
code and add support for the mts chips - the handling of the rest isn't changed.

The other bits remove two bogus NULL checks and fix the pty kerneldoc before
Randy Dunlap notices ;)


---

Alan Cox (3):
      usb-serial: remove NULL check
      neo: Remove a bogus NULL check
      pty: Fix documentation

Chris Adams (3):
      ti_usb_3410_5052: add Multi-Tech firmware
      ti_usb_3410_5052: add Multi-Tech modem support
      ti_usb_3410_5052: support alternate firmware


 drivers/char/pty.c                    |    4 
 drivers/serial/jsm/jsm_neo.c          |    3 
 drivers/usb/serial/ti_usb_3410_5052.c |   73 ++-
 drivers/usb/serial/ti_usb_3410_5052.h |    8 
 drivers/usb/serial/usb-serial.c       |    3 
 firmware/Makefile                     |    3 
 firmware/WHENCE                       |   16 +
 firmware/mts_cdma.fw.ihex             |  867 ++++++++++++++++++++++++++++++++
 firmware/mts_edge.fw.ihex             |  881 +++++++++++++++++++++++++++++++++
 firmware/mts_gsm.fw.ihex              |  867 ++++++++++++++++++++++++++++++++
 10 files changed, 2699 insertions(+), 26 deletions(-)
 create mode 100644 firmware/mts_cdma.fw.ihex
 create mode 100644 firmware/mts_edge.fw.ihex
 create mode 100644 firmware/mts_gsm.fw.ihex

-- 
Signature
