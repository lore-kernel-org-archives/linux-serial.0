From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 0/6] Clean up tty buffering v page allocation
Date: Thu, 18 Feb 2010 16:43:06 +0000
Message-ID: <20100218164104.31856.89546.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33868 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753421Ab0BRRHi (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Feb 2010 12:07:38 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

Resend with all the bits in the right patches (guess who forgot to do an stg
refresh at one point).
---

Alan Cox (6):
      tty: Fix up char drivers request_room usage
      tty: kill request_room for USB ACM class
      tty: sort out the request_room handling for whiteheat
      tty: Prune uses of tty_request_room in the USB layer
      tty: Add a function to insert a string of characters with the same flag
      tty: Keep the default buffering to sub-page units


 drivers/char/nozomi.c                 |    2 --
 drivers/char/serial167.c              |    3 +--
 drivers/char/specialix.c              |    2 --
 drivers/char/tty_buffer.c             |   17 ++++++++++-------
 drivers/serial/icom.c                 |    1 -
 drivers/serial/ioc3_serial.c          |    3 +--
 drivers/usb/class/cdc-acm.c           |    1 -
 drivers/usb/serial/ark3116.c          |    1 -
 drivers/usb/serial/cyberjack.c        |    1 -
 drivers/usb/serial/cypress_m8.c       |   10 +++-------
 drivers/usb/serial/digi_acceleport.c  |   13 ++-----------
 drivers/usb/serial/empeg.c            |    1 -
 drivers/usb/serial/garmin_gps.c       |    1 -
 drivers/usb/serial/io_edgeport.c      |   19 +++++++------------
 drivers/usb/serial/io_ti.c            |    1 -
 drivers/usb/serial/ipaq.c             |    1 -
 drivers/usb/serial/ipw.c              |    1 -
 drivers/usb/serial/ir-usb.c           |    6 ++----
 drivers/usb/serial/kl5kusb105.c       |    1 -
 drivers/usb/serial/kobil_sct.c        |    1 -
 drivers/usb/serial/mos7720.c          |    1 -
 drivers/usb/serial/mos7840.c          |    1 -
 drivers/usb/serial/navman.c           |    1 -
 drivers/usb/serial/opticon.c          |   11 +++--------
 drivers/usb/serial/option.c           |    1 -
 drivers/usb/serial/pl2303.c           |    1 -
 drivers/usb/serial/sierra.c           |    1 -
 drivers/usb/serial/spcp8x5.c          |    6 ++----
 drivers/usb/serial/symbolserial.c     |   10 ++--------
 drivers/usb/serial/ti_usb_3410_5052.c |    3 +--
 drivers/usb/serial/visor.c            |   10 +++-------
 drivers/usb/serial/whiteheat.c        |   18 +++---------------
 include/linux/tty.h                   |   10 ++++++++++
 include/linux/tty_flip.h              |    7 ++++++-
 34 files changed, 56 insertions(+), 111 deletions(-)

-- 
"..hoping for a hanged parliament"
"It's hung not hanged"
"Hanged.. you misunderstand quite how cross the masses are"

