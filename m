From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 0/7] USB: serial: add wait_until_sent-support
Date: Sun,  5 May 2013 20:32:26 +0200
Message-ID: <1367778753-22297-1-git-send-email-jhovold@gmail.com>
References: <20130505182913.GE16818@localhost>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:39583 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab3EESdL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 5 May 2013 14:33:11 -0400
In-Reply-To: <20130505182913.GE16818@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Hurley <peter@hurleysoftware.com>, Stas Sergeev <stsp@list.ru>, Jarkko Huijts <jarkko.huijts@gmail.com>, Alan Cox <alan@linux.intel.com>, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Caylan Van Larson <i@caylan.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Johan Hovold <jhovold@gmail.com>

These patches add wait_until_sent-support to usb-serial, which removes
the need to check hardware buffers in chars_in_buffer.

This fixes a problem in ftdi_sio (since 3.7) where select or TIOCMOUTQ
would take much longer than before due the hardware buffers being
queried.

Hardware buffers are also currently checked in chars_in_buffer in io_ti
(since 3.8) and ti_usb_3410_5052 (in 3.10).

Note that simply removing the hardware-buffer checks (e.g. for the
stable trees) would break tty_wait_until_sent, which is used, for
instance, by tcdrain, tcsendbreak, and close.

Johan


Johan Hovold (7):
  USB: serial: add wait_until_sent operation
  USB: serial: add generic wait_until_sent implementation
  USB: ftdi_sio: clean up get_modem_status
  USB: ftdi_sio: fix chars_in_buffer overhead
  USB: io_ti: fix chars_in_buffer overhead
  USB: ti_usb_3410_5052: fix chars_in_buffer overhead
  USB: serial: clean up chars_in_buffer

 drivers/usb/serial/ftdi_sio.c         | 28 +++++++++-------------------
 drivers/usb/serial/generic.c          | 29 +++++++++++++++++++++++++++++
 drivers/usb/serial/io_ti.c            | 22 ++++++++++++++--------
 drivers/usb/serial/ti_usb_3410_5052.c | 23 +++++++++++++++--------
 drivers/usb/serial/usb-serial.c       | 30 +++++++++++++++++++++---------
 include/linux/usb/serial.h            |  4 ++++
 6 files changed, 92 insertions(+), 44 deletions(-)

-- 
1.8.2.1

