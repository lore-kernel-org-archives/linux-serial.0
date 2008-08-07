From: Andreas Helmcke <ahnews01@ela-soft.com>
Subject: Faster read response / Improved low latency in RS-485 communication
Date: Thu, 07 Aug 2008 14:49:20 +0200
Message-ID: <gj7rm5xpqe.ln2@mail.ela-soft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43035 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952AbYHGMzJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Aug 2008 08:55:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KR51C-0002il-Lk
	for linux-serial@vger.kernel.org; Thu, 07 Aug 2008 12:55:03 +0000
Received: from mail.ela-soft.com ([213.23.49.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 07 Aug 2008 12:55:02 +0000
Received: from ahnews01 by mail.ela-soft.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Thu, 07 Aug 2008 12:55:02 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I am at the point of connecting a multidrop RS485 bus to a linux system
and ran into two problems.

Since the first problem (RS-485 direction control) is currently discussed
and will result hopefully in an kernel patch, which will avoid some nasty
non standard hacking in the future, I would like to bring the second
problem back into attention, which has been described very well by
Michael Kohne back in 2003:

On 18.11.2003 16:28, Michael Kohne wrote:
> ...
> Background:
> My company (Gasboy LLC) builds fuel management systems. Among other things
> our systems talk via RS-422/485 lines to a variety of devices. Our newest
> product is linux based and uses an 8 port serial board based on Exar 16654
> quad uarts. A single serial port may be used to talk to up 32 devices on a
> 422 or 485 loop. The linux system is the master and polls the devices for
> status information. When we poll a device, we send a small message out
> including the device's address and expect the device to respond. If the
> device does not respond in X milliseconds, we go on to the next. It is
> important to minimize the timeout (X) so that we can talk to as many
> devices as possible in as short a time as possible (the devices are gas
> pumps, card readers, etc). Minimizing X becomes especially important when
> devices are disabled or the system is mis-configured to talk to more
> devices than exist (we don't want to hold up operations on live devices
> waiting for dead ones). Timeouts are thus specified in terms of when the
> FIRST character (STX) comes back from the device. If the STX is not
> received in time, the device is assumed to be not present. The timeouts
> are VERY short (on the order of 20-30 milliseconds).
>
> The problem:
> The old system hardware had uarts with no FIFO. Therefore, getting the STX
> immediately after it hit the uart was no problem. The new system has 64
> byte fifos. Since the linux serial drivers set the fifo to 56 bytes (a
> good choice for high-bandwidth communications), the response packet (22
> bytes) fits entirely in the fifo without hitting the trigger. The uart
> will wait for 4 empty character times before it triggers the interrupt. At
> 9600 baud (about 1 millisecond per character) that's about 26 milliseconds
> after the STX came in before the application sees it. Since the remote
> device DOES take some time to respond, adding 26 milliseconds to the
> response time causes our system to believe the device is gone and try to
> recover appropriately.
>
> Attempted solutions:
> I have played with our timeouts, but significantly extending them (to the
> point that they cover the fifo latency) causes user-visible delays when
> large numbers of devices are configured on the loop, but missing.
> I tried forcing the system to treat the relevant uarts as 16450 instead of
> 16654, but then we start dropping characters on a regular basis
> (especially when heavy ethernet or ppp traffic occurs), thus slowing the
> loops down again.
> I do have the low_latency flag set, but that of course only changes how
> data moves around AFTER it's received from the uart. It does nothing to
> speed data in from the uart.
>
> The proposed solution:
> An optimal solution to the problem seems (to me) to be reducing the FIFO
> trigger levels whenever low_latency is set on the port. This minimizes the
> amount of time from when a character is received to when the application
> layer sees it (which I believe to be the point of the low_latency flag
> already).
>
> Problems with this solution:
> 1) By reducing the receive fifo trigger level, we significantly increase
> the interrupt rate of the uart, and therefore the overhead in servicing
> it. I'm OK with this because the low_latency flag already specifies that
> you are trading CPU overhead for latency.
>
> 2) Conflating the trigger level changes with the established behaviour of
> low_latency seems appropriate to me, but better-informed persons might
> well disagree. The alternative (to maintain a seperate flag) seems worse.
>

Full Post including his proposed patch:
http://osdir.com/ml/serial/2004-04/msg00001.html


The very same problem (only shorter timeouts and faster baudrate) we have
with our RS485 bus.

Quick and dirty patch to solve this problem when using 16C950 UARTS by
setting the 950 trigger level registers:

--- /src/linux-2.6.18.i686/drivers/serial/8250.c	2008-07-14
14:48:56.000000000 +0200
+++ ./8250.c	2008-07-25 09:00:39.000000000 +0200
@@ -2073,6 +2073,19 @@
 		}
 		serial_outp(up, UART_FCR, fcr);		/* set fcr */
 	}
+
+	/*
+	 * 16C950: if LOW_LATENCY flag is set, set trigger levels to 1
+	 */
+	if (up->port.type == PORT_16C950) {
+		if (up->port.flags & UPF_LOW_LATENCY) 	{
+			up->acr |= UART_ACR_TLENB;
+			serial_icr_write(up, UART_ACR, up->acr);
+			serial_icr_write(up, UART_RTL, 1);
+			serial_icr_write(up, UART_TTL, 1);
+		}
+	}
+
 	serial8250_set_mctrl(&up->port, up->port.mctrl);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }


Any comments are very welcome.

Andreas

