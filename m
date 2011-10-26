From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 41/79] max3110: Fix up port->tty backreferencing
Date: Wed, 26 Oct 2011 14:12:46 +0200
Message-ID: <1319631204-23262-41-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32780 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932892Ab1JZMNq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:46 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Alan Cox <alan@linux.intel.com>

We want to keep refcounts properly on this against hangup.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/serial/mrst_max3110.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index 42aa439..1aa2c3c 100644
--- a/drivers/tty/serial/mrst_max3110.c
+++ b/drivers/tty/serial/mrst_max3110.c
@@ -347,7 +347,7 @@ receive_chars(struct uart_max3110 *max, unsigned short *str, int len)
 	if (!port->state)
 		return 0;
 
-	tty = port->state->port.tty;
+	tty = tty_port_tty_get(&port->state->port);
 	if (!tty)
 		return 0;
 
@@ -364,8 +364,10 @@ receive_chars(struct uart_max3110 *max, unsigned short *str, int len)
 		}
 	}
 
-	if (!w)
+	if (!w) {
+		tty_kref_put(tty);
 		return 0;
+	}
 
 	for (r = 0; w; r += usable, w -= usable) {
 		usable = tty_buffer_request_room(tty, w);
@@ -375,6 +377,7 @@ receive_chars(struct uart_max3110 *max, unsigned short *str, int len)
 		}
 	}
 	tty_flip_buffer_push(tty);
+	tty_kref_put(tty);
 
 	return r;
 }
-- 
1.7.7

