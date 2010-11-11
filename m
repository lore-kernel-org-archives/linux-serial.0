From: Baurzhan Ismagulov <ibr@radix50.net>
Subject: [PATCH] Remove unused uart_cpm_port fields
Date: Thu, 11 Nov 2010 10:54:58 +0100
Message-ID: <20101111095458.GB4948@radix50.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:24706 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105Ab0KKMBc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Nov 2010 07:01:32 -0500
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, greg@kroah.com

Hello,

AFAICT, these fields are not used anywhere.

Signed-off-by: Baurzhan Ismagulov <ibr@radix50.net>
---
 drivers/serial/cpm_uart/cpm_uart.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 7274b52..b754dcf 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -76,18 +76,12 @@ struct uart_cpm_port {
 	unsigned char		*tx_buf;
 	unsigned char		*rx_buf;
 	u32			flags;
-	void			(*set_lineif)(struct uart_cpm_port *);
 	struct clk		*clk;
 	u8			brg;
 	uint			 dp_addr;
 	void			*mem_addr;
 	dma_addr_t		 dma_addr;
 	u32			mem_size;
-	/* helpers */
-	int			 baud;
-	int			 bits;
-	/* Keep track of 'odd' SMC2 wirings */
-	int			is_portb;
 	/* wait on close if needed */
 	int			wait_closing;
 	/* value to combine with opcode to form cpm command */
-- 
1.7.1
