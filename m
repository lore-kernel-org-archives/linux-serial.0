From: "Michael Kohne" <mhkohne@discordia.org>
Subject: (unknown)
Date: Tue, 18 Nov 2003 08:26:28 -0500 (EST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <10718.209.92.255.18.1069161988.squirrel@www.discordia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from techno.discordia.org ([66.92.231.194]:36589 "EHLO
	techno.discordia.org") by vger.kernel.org with ESMTP
	id S262603AbTKRN03 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Nov 2003 08:26:29 -0500
Subject: 
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tytso@mit.edu

Proposed modification to the low_latency flag in version 5.05c of the
linux 16550 driver (drivers/char/serial.c).

My ultimate goal is to get this change accepted into the kernel so that I
don't have to maintain it on our end forever.

Background:
My company (Gasboy LLC) builds fuel management systems. Among other things
our systems talk via RS-422/485 lines to a variety of devices. Our newest
product is linux based and uses an 8 port serial board based on Exar 16654
quad uarts. A single serial port may be used to talk to up 32 devices on a
422 or 485 loop. The linux system is the master and polls the devices for
status information. When we poll a device, we send a small message out
including the device's address and expect the device to respond. If the
device does not respond in X milliseconds, we go on to the next. It is
important to minimize the timeout (X) so that we can talk to as many
devices as possible in as short a time as possible (the devices are gas
pumps, card readers, etc). Minimizing X becomes especially important when
devices are disabled or the system is mis-configured to talk to more
devices than exist (we don't want to hold up operations on live devices
waiting for dead ones). Timeouts are thus specified in terms of when the
FIRST character (STX) comes back from the device. If the STX is not
received in time, the device is assumed to be not present. The timeouts
are VERY short (on the order of 20-30 milliseconds).

The problem:
The old system hardware had uarts with no FIFO. Therefore, getting the STX
immediately after it hit the uart was no problem. The new system has 64
byte fifos. Since the linux serial drivers set the fifo to 56 bytes (a
good choice for high-bandwidth communications), the response packet (22
bytes) fits entirely in the fifo without hitting the trigger. The uart
will wait for 4 empty character times before it triggers the interrupt. At
9600 baud (about 1 millisecond per character) that's about 26 milliseconds
after the STX came in before the application sees it. Since the remote
device DOES take some time to respond, adding 26 milliseconds to the
response time causes our system to believe the device is gone and try to
recover appropriately.

Attempted solutions:
I have played with our timeouts, but significantly extending them (to the
point that they cover the fifo latency) causes user-visible delays when
large numbers of devices are configured on the loop, but missing.
I tried forcing the system to treat the relevant uarts as 16450 instead of
16654, but then we start dropping characters on a regular basis
(especially when heavy ethernet or ppp traffic occurs), thus slowing the
loops down again.
I do have the low_latency flag set, but that of course only changes how
data moves around AFTER it's received from the uart. It does nothing to
speed data in from the uart.

The proposed solution:
An optimal solution to the problem seems (to me) to be reducing the FIFO
trigger levels whenever low_latency is set on the port. This minimizes the
amount of time from when a character is received to when the application
layer sees it (which I believe to be the point of the low_latency flag
already).

Problems with this solution:
1) By reducing the receive fifo trigger level, we significantly increase
the interrupt rate of the uart, and therefore the overhead in servicing
it. I'm OK with this because the low_latency flag already specifies that
you are trading CPU overhead for latency.

2) Conflating the trigger level changes with the established behaviour of
low_latency seems appropriate to me, but better-informed persons might
well disagree. The alternative (to maintain a seperate flag) seems worse.



Results:
On a kernel with this patch installed, I did some timing analysis. My test
code sends a packet out a 422 port and waits for an STX to come back. With
setserial <port> ^low_latency, my timings are about 34 milliseconds. With
setserial <port> low_latency, my timings are 17 milliseconds. (The 34
milliseconds matches the times I got with my old kernel).


Addendum:
In the process of internally reviewing this patch at our company, I found
another division that had made a similar modification for internal use. So
I am now convinced that this is a useful modification.



The proposed patch (in diff -u format):
This patch is against the standard serial.c distributed with the 2.4.22
kernel.
If folks think that this is reasonable for kernel inclusion, I'll port it
to 2.5/2.6 as well.

--- serial.2.4.22.c	Tue Nov 11 02:13:41 2003
+++ serial.c	Tue Nov 11 02:13:04 2003
@@ -62,6 +62,9 @@
  *        Robert Schwebel <robert@schwebel.de>,
  *        Juergen Beisert <jbeisert@eurodsn.de>,
  *        Theodore Ts'o <tytso@mit.edu>
+ *
+ * 11/03: Set minimum fifo trigger level when low_latency set.
+ *        Michael Kohne <mhkohne@discordia.org>
  */

 static char *serial_version = "5.05c";
@@ -1728,7 +1731,10 @@

 	/* Set up FIFO's */
 	if (uart_config[info->state->type].flags & UART_USE_FIFO) {
-		if ((info->state->baud_base / quot) < 2400)
+		/* minimize lag time on low baud or user request */
+		/* otherwise, use appropriate default for this uart */
+		if ( ((info->state->baud_base / quot) < 2400) ||
+			(info->tty->low_latency) )
 			fcr = UART_FCR_ENABLE_FIFO | UART_FCR_TRIGGER_1;
 #ifdef CONFIG_SERIAL_RSA
 		else if (info->state->type == PORT_RSA)




-- 
Michael Kohne        mhkohne@discordia.org
"You should be smarter than the equipment you are trying to operate." --
Matt Osborne


