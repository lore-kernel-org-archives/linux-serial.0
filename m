From: Fengguang Wu <fengguang.wu@intel.com>
Subject: [PATCH] serial: ifx6x60: fix paging fault on spi_register_driver
Date: Tue, 7 Aug 2012 13:12:47 +0800
Message-ID: <20120807051247.GA24140@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14639 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751659Ab2HGFM5 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 7 Aug 2012 01:12:57 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Russ Gorby <russ.gorby@intel.com>

[  117.240866] BUG: unable to handle kernel paging request at 815b627c
[  117.240866] IP: [<813fe94b>] spi_register_driver+0xb/0x50
...
[  117.240866] Call Trace:
[  117.240866]  [<817de977>] ifx_spi_init+0xbe/0xf0

The root cause is, spi_register_driver() is trying to write into the
passed *const* struct spi_driver.

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/tty/serial/ifx6x60.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux.orig/drivers/tty/serial/ifx6x60.c	2012-05-24 19:03:07.408430953 +0800
+++ linux/drivers/tty/serial/ifx6x60.c	2012-08-07 12:57:05.499312357 +0800
@@ -1331,7 +1331,7 @@ static const struct spi_device_id ifx_id
 MODULE_DEVICE_TABLE(spi, ifx_id_table);
 
 /* spi operations */
-static const struct spi_driver ifx_spi_driver = {
+static struct spi_driver ifx_spi_driver = {
 	.driver = {
 		.name = DRVNAME,
 		.pm = &ifx_spi_pm,
