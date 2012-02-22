From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH 4/4] pch_uart: Use existing default_baud in setup_console
Date: Tue, 21 Feb 2012 17:59:33 -0800
Message-ID: <9b66c322092ebfe4f26b0cbdc96967972096cdcf.1329875301.git.dvhart@linux.intel.com>
References: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:29216 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755087Ab2BVCAR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Feb 2012 21:00:17 -0500
In-Reply-To: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com>
In-Reply-To: <cover.1329875301.git.dvhart@linux.intel.com>
References: <cover.1329875301.git.dvhart@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhart@linux.intel.com>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

Rather than hardcode 9600, use the existing default_baud parameter (which
also defaults to 9600).

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Tomoya MORINAGA <tomoya.rohm@gmail.com>
CC: Feng Tang <feng.tang@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Alan Cox <alan@linux.intel.com>
CC: linux-serial@vger.kernel.org
---
 drivers/tty/serial/pch_uart.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index d00b75c..c2c1bac 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1493,7 +1493,7 @@ static int __init pch_console_setup(struct console *co, char *options)
 {
 	const char *board_name;
 	struct uart_port *port;
-	int baud = 9600;
+	int baud = default_baud;
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
-- 
1.7.6.5

