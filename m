From: chao bi <chao.bi@intel.com>
Subject: [PATCH] serial:ifx6x60:SPI header is decoded incorrectly
Date: Tue, 06 Nov 2012 11:13:59 +0800
Message-ID: <1352171639.4445.33.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13234 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933630Ab2KFC7i (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Nov 2012 21:59:38 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, richardx.r.gorby@intel.com, jun.d.chen@intel.com


This patch is to correct the bit mapping of "MORE" and "CTS" in SPI frame header.
Per SPI protocol, SPI header is encoded with length of 4 byte, which is defined
as below:
bit 0 ~ 11: current data size;
bit 12: "MORE" bit;
bit 13: reserve
bit 14 ~ 15: reserve
bit 16 ~ 27: next data size
bit 28: RI
bit 29: DCD
bit 30: CTS/RTS
bit 31: DSR/DTR

According to above SPI header structure, the bit mapping of "MORE" and "CTS" is
incorrect in function ifx_spi_decode_spi_header();

cc: Chen Jun <jun.d.chen@intel.com>
Signed-off-by: channing <chao.bi@intel.com>
---
 drivers/tty/serial/ifx6x60.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 5b9bc19..60e767f 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -64,8 +64,8 @@
 #include "ifx6x60.h"
 
 #define IFX_SPI_MORE_MASK		0x10
-#define IFX_SPI_MORE_BIT		12	/* bit position in u16 */
-#define IFX_SPI_CTS_BIT			13	/* bit position in u16 */
+#define IFX_SPI_MORE_BIT		4	/* bit position in u8 */
+#define IFX_SPI_CTS_BIT			6	/* bit position in u8 */
 #define IFX_SPI_MODE			SPI_MODE_1
 #define IFX_SPI_TTY_ID			0
 #define IFX_SPI_TIMEOUT_SEC		2
-- 
1.7.1



