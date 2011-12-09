From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH RESEND 8/8] serial: 8250: fix comment about accessing EMSR
Date: Fri,  9 Dec 2011 18:07:20 +0100
Message-ID: <1323450440-414-9-git-send-email-w.sang@pengutronix.de>
References: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323450440-414-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Claudio Scordino <claudio@evidence.eu.com>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-serial@vger.kernel.org

All docs I checked do say LCR should NOT be 0xBF (16c850, 16c854,
16v2750). Fix it according to that, since the only usage of the register
currently implements the revised access method. If somebody later finds
a derivate which actually does need 0xBF to enable that register, we can
update the comment again with precise references.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 include/linux/serial_reg.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 0267bab6..0a1beca 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -211,7 +211,7 @@
 #define UART_FCTR_TX		0x80  /* Programmable trigger mode select */
 
 /*
- * LCR=0xBF, FCTR[6]=1
+ * LCR!=0xBF (some docs say =0), FCTR[6]=1, XR16C85x
  */
 #define UART_EMSR	7	/* Extended Mode Select Register */
 #define UART_EMSR_FIFO_COUNT	0x01  /* Rx/Tx select */
-- 
1.7.7.3
