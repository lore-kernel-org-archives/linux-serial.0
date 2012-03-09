From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 5/7] serial: introduce generic port in/out helpers
Date: Thu,  8 Mar 2012 19:12:12 -0500
Message-ID: <1331251934-25540-6-git-send-email-paul.gortmaker@windriver.com>
References: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44817 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757684Ab2CIAM3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Mar 2012 19:12:29 -0500
In-Reply-To: <1331251934-25540-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org, alan@linux.intel.com
Cc: linux-serial@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>

Looking at the existing serial drivers (esp. the 8250 derived
variants) we see a common trend.  They create a hardware specific
port struct, which in turn contains a generic serial_port struct.

The other trend, is that they all create some sort of shortcut
to go through the hardware specific struct, to the serial_port
struct, which has the basic in/out operations within.  Looking
for the serial_in and serial_out in several drivers shows this.

Rather than let this continue, lets create a generic set of
similar helper wrappers that can be used on a struct port, so
we can eliminate bouncing out through hardware specific struct
pointers just to come back into struct port where possible.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/serial_core.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 585bfd0..f51bf2e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -383,6 +383,16 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+static inline int serial_port_in(struct uart_port *up, int offset)
+{
+	return up->serial_in(up, offset);
+}
+
+static inline void serial_port_out(struct uart_port *up, int offset, int value)
+{
+	up->serial_out(up, offset, value);
+}
+
 /*
  * This is the state information which is persistent across opens.
  */
-- 
1.7.9.1

