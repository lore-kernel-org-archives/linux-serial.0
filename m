From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] serial: clear entire struct in uart_get_info()
Date: Fri, 7 Sep 2012 09:46:14 +0300
Message-ID: <20120907064613.GA12028@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:21793 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2IGGqb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Sep 2012 02:46:31 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org

There is a typo here, sizeof(retinfo) should be sizeof(*retinfo) to
clear the struct.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Only needed in linux-next.

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 137b25c..19993d8 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -640,7 +640,7 @@ static void uart_get_info(struct tty_port *port,
 {
 	struct uart_port *uport = state->uart_port;
 
-	memset(retinfo, 0, sizeof(retinfo));
+	memset(retinfo, 0, sizeof(*retinfo));
 
 	retinfo->type	    = uport->type;
 	retinfo->line	    = uport->line;
