From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 4/4] max3110: Fix up port->tty backreferencing
Date: Fri, 26 Aug 2011 11:26:00 +0100
Message-ID: <20110826102546.17010.25347.stgit@localhost.localdomain>
References: <20110826102414.17010.71484.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60893 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab1HZLVB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Aug 2011 07:21:01 -0400
In-Reply-To: <20110826102414.17010.71484.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

We want to keep refcounts properly on this against hangup.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/mrst_max3110.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mrst_max3110.c b/drivers/tty/serial/mrst_max3110.c
index 4f90411..f3ddbcd 100644
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

