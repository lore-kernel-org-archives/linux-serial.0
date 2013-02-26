From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH v2 0/4] TTY: port hangup and close fixes
Date: Tue, 26 Feb 2013 12:14:28 +0100
Message-ID: <1361877272-6074-1-git-send-email-jhovold@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:40262 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab3BZLRK (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Feb 2013 06:17:10 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Johan Hovold <jhovold@gmail.com>

These patches against tty-next fix a few issues with tty-port hangup and
close.

The first and third patch are essentially clean ups.

The second patch makes sure DTR is dropped also on hangup and that DTR
is only dropped for initialised ports (where is could have been raised
in the first place).

The fourth and final patch, make sure no tty callbacks are made from
tty_port_close_start when the port has not been initialised (successfully
opened). This was previously only done for wait_until_sent but there's
no reason to call flush_buffer or to honour port drain delay either.
The latter could cause a failed open to stall for up to two seconds.

As a side-effect, these patches also fix an issue in USB-serial where we could
get tty-port callbacks on an uninitialised port after having hung up and
unregistered a device after disconnect.

Johan


v2:
 - reuse tty reference from hangup and close in shutdown. Both call sites
   guarantee tty is either NULL or has a kref.

Changes since RFC-series:
 - fix up the two driver relying on tty_port_close_start directly but
   that did not manage DTR themselves


Johan Hovold (4):
  TTY: clean up port shutdown
  TTY: fix DTR not being dropped on hang up
  TTY: clean up port drain-delay handling
  TTY: fix close of uninitialised ports

 drivers/tty/mxser.c    |  4 +++
 drivers/tty/n_gsm.c    |  4 +++
 drivers/tty/tty_port.c | 72 +++++++++++++++++++++++++++++---------------------
 3 files changed, 50 insertions(+), 30 deletions(-)

-- 
1.8.1.1

