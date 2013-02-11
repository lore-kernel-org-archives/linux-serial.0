From: claudio@evidence.eu.com
Subject: [PATCH 1/3] RS485: add unit of measure for delays
Date: Mon, 11 Feb 2013 16:54:24 +0100
Message-ID: <1360598067-3577-2-git-send-email-claudio@evidence.eu.com>
References: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mr001msb.fastweb.it ([85.18.95.85]:55615 "EHLO
	mr001msb.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757815Ab3BKQCz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Feb 2013 11:02:55 -0500
In-Reply-To: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: nicolas.ferre@atmel.com, clagix@gmail.com, Claudio Scordino <claudio@evidence.eu.com>

From: Claudio Scordino <claudio@evidence.eu.com>

This patch adds the unit of measure (i.e., milliseconds) in the documentation
serial-rs485.txt (it is already available in the header file).

Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
Signed-off-by: Guido Classen <clagix@gmail.com>
---
 Documentation/serial/serial-rs485.txt |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/serial/serial-rs485.txt b/Documentation/serial/serial-rs485.txt
index 41c8378..e30335d 100644
--- a/Documentation/serial/serial-rs485.txt
+++ b/Documentation/serial/serial-rs485.txt
@@ -110,10 +110,10 @@
 	/* or, set logical level for RTS pin equal to 0 after sending: */
 	rs485conf.flags &= ~(SER_RS485_RTS_AFTER_SEND);
 
-	/* Set rts delay before send, if needed: */
+	/* Set rts delay before send (in milliseconds) if needed: */
 	rs485conf.delay_rts_before_send = ...;
 
-	/* Set rts delay after send, if needed: */
+	/* Set rts delay after send (in milliseconds) if needed: */
 	rs485conf.delay_rts_after_send = ...;
 
 	/* Set this flag if you want to receive data even whilst sending data */
-- 
1.7.9.5

