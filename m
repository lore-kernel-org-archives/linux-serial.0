From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] serial: txx9: remove duplicate TXX9_SIFCR_TDIL_MASK define
Date: Mon, 9 Jun 2014 18:11:21 +0300
Message-ID: <20140609151121.GF9600@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:48423 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbaFIPLd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Jun 2014 11:11:33 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org

The TXX9_SIFCR_TDIL_MASK define is cut and pasted twice so we can delete
the second instance.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 60f49b9..9878bd3 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -142,7 +142,6 @@ struct uart_txx9_port {
 #define TXX9_SIFCR_RDIL_12	0x00000180
 #define TXX9_SIFCR_RDIL_MAX	0x00000180
 #define TXX9_SIFCR_TDIL_MASK	0x00000018
-#define TXX9_SIFCR_TDIL_MASK	0x00000018
 #define TXX9_SIFCR_TDIL_1	0x00000000
 #define TXX9_SIFCR_TDIL_4	0x00000001
 #define TXX9_SIFCR_TDIL_8	0x00000010
