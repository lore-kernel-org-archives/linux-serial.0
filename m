From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 59/79] 8250: ratelimit LSR safety check engaged warning.
Date: Wed, 26 Oct 2011 14:13:04 +0200
Message-ID: <1319631204-23262-59-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32834 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932915Ab1JZMNz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:55 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On my BIOSTAR TA890FXE the ttyS0 ends up spewing:

[904682.485933] ttyS0: LSR safety check engaged!
[904692.505895] ttyS0: LSR safety check engaged!
[904702.525972] ttyS0: LSR safety check engaged!
[904712.545967] ttyS0: LSR safety check engaged!
[904722.566125] ttyS0: LSR safety check engaged!
..
lets limit it so it won't be the only thing visible
in the ring buffer.

CC: Alan Cox <alan@linux.intel.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/8250.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index 82ca71a..076e9c6 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -2055,8 +2055,8 @@ static int serial8250_startup(struct uart_port *port)
 	 */
 	if (!(up->port.flags & UPF_BUGGY_UART) &&
 	    (serial_inp(up, UART_LSR) == 0xff)) {
-		printk(KERN_INFO "ttyS%d: LSR safety check engaged!\n",
-		       serial_index(&up->port));
+		printk_ratelimited(KERN_INFO "ttyS%d: LSR safety check engaged!\n",
+				   serial_index(&up->port));
 		return -ENODEV;
 	}
 
-- 
1.7.7

