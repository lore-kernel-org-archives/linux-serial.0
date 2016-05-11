From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] serial: doc: Always refer to tty_port->mutex
Date: Wed, 11 May 2016 13:56:04 +0200
Message-ID: <1462967765-30871-2-git-send-email-geert+renesas@glider.be>
References: <1462967765-30871-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1462967765-30871-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>, Peter Hurley <peter@hurleysoftware.com>, Russell King <rmk@arm.linux.org.uk>
Cc: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

Stop referring to the mutex member of the tty_port struct as
'port->mutex', as 'port' is ambiguous, and usually refers to the
uart_port struct in this document.  Use 'tty_port->mutex' instead,
following the single existing use.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/serial/driver | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/serial/driver b/Documentation/serial/driver
index 39701515832b70b0..90889c785809cde1 100644
--- a/Documentation/serial/driver
+++ b/Documentation/serial/driver
@@ -57,7 +57,7 @@ locking.
 The port_sem semaphore is used to protect against ports being added/
 removed or reconfigured at inappropriate times. Since v2.6.27, this
 semaphore has been the 'mutex' member of the tty_port struct, and
-commonly referred to as the port mutex (or port->mutex).
+commonly referred to as the port mutex.
 
 
 uart_ops
@@ -186,7 +186,7 @@ hardware.
 	should be terminated when another call is made with a zero
 	ctl.
 
-	Locking: caller holds port->mutex
+	Locking: caller holds tty_port->mutex
 
   startup(port)
 	Grab any interrupt resources and initialise any low level driver
@@ -262,14 +262,14 @@ hardware.
 	Other flags may be used (eg, xon/xoff characters) if your
 	hardware supports hardware "soft" flow control.
 
-	Locking: caller holds port->mutex
+	Locking: caller holds tty_port->mutex
 	Interrupts: caller dependent.
 	This call must not sleep
 
   set_ldisc(port,termios)
 	Notifier for discipline change. See Documentation/serial/tty.txt.
 
-	Locking: caller holds port->mutex
+	Locking: caller holds tty_port->mutex
 
   pm(port,state,oldstate)
 	Perform any power management related activities on the specified
-- 
1.9.1

