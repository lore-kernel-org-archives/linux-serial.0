From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: drivers/serial && drivers/char/serial.c in 2.5 && 2.4...
Date: Wed, 17 Apr 2002 12:14:05 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <a9ji5m$u4$2@main.gmane.org>
References: <20020416174057.F19573@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20020416174057.F19573@flint.arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: ARM Linux kernel <linux-arm-kernel@lists.arm.linux.org.uk>, tytso@mit.edu, linux-serial@vger.kernel.org

Hello all

On our StrongARM board we are preserving power by disabling / enabling an
16550 UART. Until now we were doing this in a separate application. But a
better idea would be to have a (arch-specific, of course) pm-call in
uart_open/close (or serial8250_startup/shutdown) functions. How can we do
this? Currently there's just a call to pm_access in uart_start, which is a
dummy, but uart_close DOES have a call to pm_send, but we anyway have to
add knowledge about this specific UART to the driver, right? And we need a
wakeup call in uart_open, I think.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

