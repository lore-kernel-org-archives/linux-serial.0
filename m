From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [RFC][PATCH] Xilinx uartlite serial driver
Date: Tue, 16 May 2006 15:03:32 +0200
Message-ID: <87lkt2xgt7.fsf@LKG7F3A44.lan>
References: <87ac9o3ak3.fsf@sleipner.barco.com>
	<20060511222001.GC28693@flint.arm.linux.org.uk>
	<87slnapagf.fsf@LKG7F3A44.lan>
	<20060516125329.GE15481@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from assei2bl6.telenet-ops.be ([195.130.133.69]:37536 "EHLO
	assei2bl6.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932077AbWEPPNz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 May 2006 11:13:55 -0400
In-Reply-To: <20060516125329.GE15481@flint.arm.linux.org.uk> (Russell King's
	message of "Tue, 16 May 2006 13:53:29 +0100")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: tnt@246tNt.com, linux-serial@vger.kernel.org

>>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:

 >> What do you say Sylvain? Reusing device nodes seems pretty common
 >> (pxa.c, at91_serial.c, ..), and I cannot imagine anyone making a
 >> system with uartlite and mpc52xx UARTs ..

 Russell> Actually they're wishing they hadn't because they can't interoperate
 Russell> with standard 16550-based ports without resorting to nasty hacks.
 Russell> As such they're _both_ transitioning away from using the major 4
 Russell> space.

Ok, but I'm using major 204, not 4, so that shouldn't be an issue.

But ok, I'll apply for a range in the 204 series for the driver. The
question is, how many minors should I get? As the UART is implemented
in a FPGA there isn't really any hard upper bound on how many UARTs a
board could have.

 Russell> Actually that's wrong.  INPCK controls whether input parity
 Russell> _checking_ is be enabled.  If INPCK is not set, then there
 Russell> is no checking of input parity, and therefore you don't know
 Russell> if there is an error or not.

Ok, the following little patch updates Documentation/serial/driver to
match:

Update documentation to match reality. INPCK controls whether input
parity checking is enabled.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

---
 Documentation/serial/driver |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: linux/Documentation/serial/driver
===================================================================
--- linux.orig/Documentation/serial/driver	2006-05-16 16:23:44.000000000 +0200
+++ linux/Documentation/serial/driver	2006-05-16 16:28:00.000000000 +0200
@@ -214,12 +214,13 @@
 	The interaction of the iflag bits is as follows (parity error
 	given as an example):
 	Parity error	INPCK	IGNPAR
-	None		n/a	n/a	character received
-	Yes		n/a	0	character discarded
-	Yes		0	1	character received, marked as
+	n/a		0	n/a	character received, marked as
 					TTY_NORMAL
-	Yes		1	1	character received, marked as
+	None		1	n/a	character received, marked as
+					TTY_NORMAL
+	Yes		1	0	character received, marked as
 					TTY_PARITY
+	Yes		1	1	character discarded
 
 	Other flags may be used (eg, xon/xoff characters) if your
 	hardware supports hardware "soft" flow control.

 Russell> which I believe is what 8250 and other ports implement.

Yes.

Did you have time to look at my updated driver patch?

--
Bye, Peter Korsgaard
