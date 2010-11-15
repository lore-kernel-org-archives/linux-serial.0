From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [RFC PATCH 0/4] use kfifo instead of circ_buf
Date: Mon, 15 Nov 2010 16:01:01 -0500
Message-ID: <1289854865-11865-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:57507 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758468Ab0KOVJt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Nov 2010 16:09:49 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This replaces the use of struct circ_buf with a kfifo in the serial
subsystem.  This was suggested by Alan Cox a while ago.  I've tested
the first patch, the second is compile tested only, and the last 2 are
not tested at all.



Bill Pemberton (4):
  serial: use kfifo instead of circ_buf
  serial: use kfifo instead of circ_buf in mrst_max3110
  serial: use kfifo instead of circ_buf in icom.c
  serial: use kfifo instead of circ_buf for SGI IOC controllers

 drivers/serial/8250.c         |   20 ++++++----
 drivers/serial/icom.c         |   26 ++++++--------
 drivers/serial/ioc3_serial.c  |   32 ++++++-----------
 drivers/serial/ioc4_serial.c  |   32 ++++++-----------
 drivers/serial/jsm/jsm_tty.c  |   26 +++++--------
 drivers/serial/mrst_max3110.c |   45 ++++++++++-------------
 drivers/serial/serial_core.c  |   78 +++++++++--------------------------------
 include/linux/serial_core.h   |    4 +-
 8 files changed, 94 insertions(+), 169 deletions(-)

-- 
1.7.3.2

