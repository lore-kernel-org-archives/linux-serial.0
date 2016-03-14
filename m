From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/9] serial: doc: Un-document obsolete tmpbuf_sem
Date: Mon, 14 Mar 2016 16:16:10 +0100
Message-ID: <1457968577-22379-3-git-send-email-geert+renesas@glider.be>
References: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1457968577-22379-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

uart_info.tmpbuf and uart_info.tmpbuf_sem were removed in v2.6.10, in
full-history-linux commit a797ad7e3ae9cad4 ("[SERIAL] Clean up
serial_core.c write functions.").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index e7c6f86ee06f9927..61d520dea4c6e13a 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -36,8 +36,7 @@ It is the responsibility of the low level hardware driver to perform the
 necessary locking using port->lock.  There are some exceptions (which
 are described in the uart_ops listing below.)
 
-There are three locks.  A per-port spinlock, a per-port tmpbuf semaphore,
-and an overall semaphore.
+There are two locks.  A per-port spinlock, and an overall semaphore.
 
 From the core driver perspective, the port->lock locks the following
 data:
@@ -50,9 +49,6 @@ data:
 The low level driver is free to use this lock to provide any additional
 locking.
 
-The core driver uses the info->tmpbuf_sem lock to prevent multi-threaded
-access to the info->tmpbuf bouncebuffer used for port writes.
-
 The port_sem semaphore is used to protect against ports being added/
 removed or reconfigured at inappropriate times. Since v2.6.27, this
 semaphore has been the 'mutex' member of the tty_port struct, and
-- 
1.9.1

