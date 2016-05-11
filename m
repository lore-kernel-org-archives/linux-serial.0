From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] serial: doc: Use port->state instead of info
Date: Wed, 11 May 2016 13:56:05 +0200
Message-ID: <1462967765-30871-3-git-send-email-geert+renesas@glider.be>
References: <1462967765-30871-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1462967765-30871-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

As of commit ebd2c8f6d2ec4012 ("serial: kill off uart_info"), the
circular transmission buffer is part of struct uart_state instead of
struct uart_info. Make it clear this structure is pointed to from struct
uart_port.

Change 'circ' to 'circ_buf' to match the structure name while we're at
it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 90889c785809cde1..da193e092fc3d531 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -48,8 +48,8 @@ data:
 
 	port->mctrl
 	port->icount
-	info->xmit.head (circ->head)
-	info->xmit.tail (circ->tail)
+	port->state->xmit.head (circ_buf->head)
+	port->state->xmit.tail (circ_buf->tail)
 
 The low level driver is free to use this lock to provide any additional
 locking.
@@ -204,7 +204,7 @@ hardware.
 	RTS nor DTR; this will have already been done via a separate
 	call to set_mctrl.
 
-	Drivers must not access port->info once this call has completed.
+	Drivers must not access port->state once this call has completed.
 
 	This method will only be called when there are no more users of
 	this port.
@@ -216,7 +216,7 @@ hardware.
 	Flush any write buffers, reset any DMA state and stop any
 	ongoing DMA transfers.
 
-	This will be called whenever the port->info->xmit circular
+	This will be called whenever the port->state->xmit circular
 	buffer is cleared.
 
 	Locking: port->lock taken.
-- 
1.9.1

