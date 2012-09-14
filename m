From: Thomas Walters <Thomas.Walters@sealevel.com>
Subject: FW: atmel_serial DBGU RX DMA
Date: Fri, 14 Sep 2012 18:45:49 +0000
Message-ID: <4993675D6FC33A498CEED979ED2DD66701004D6B@SEAEXCH.int.sealevel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from p01c12o144.mxlogic.net ([208.65.145.67]:39464 "EHLO
	p01c12o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759908Ab2INSyW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Sep 2012 14:54:22 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Greetings,

While working with an Atmel AT91SAM9G45 microprocessor, I have run into a problem with input overruns during typical console usage of the Debug Unit (DBGU) serial port.  The port, being compatible with the standard Atmel USART, uses the Atmel serial driver (drivers/tty/serial/atmel_serial.c).  The driver has the option of using DMA transfers (in fact, it does so by default on all ports except the DBGU).

Using DMA for receive with DBGU does not work on the mainline driver.  I have determined that this is due to the reliance of the driver on the ATMEL_US_TIMEOUT interrupt to trigger transfers from the RX DMA buffer to the TTY buffer at regular intervals.  The DBGU port hardware does not implement the receiver timeout feature.

I have been able to "force" receive DMA to work by adding a timer callback (similar to the method used by the 8250 driver with devices that do not support interrupts).  This method has relieved the input overrun errors I was getting.

I am curious if this is an acceptable approach and if there are any better alternatives.  I'm still looking into the effect on performance, but so far I haven't seen any significant change from the original driver.

Thanks,
Thomas Walters



Confidentiality Notice
________________________________
 This message is intended exclusively for the individual or entity to which it is addressed. This communication may contain information that is PROPRIETARY, TRADE SECRET, PRIVILEGED, CONFIDENTIAL or otherwise legally exempt from disclosure.

If you are not the named addressee, you are not authorized to read, print, retain, copy or disseminate this message or any part of it. If you have received this message in error, please notify the sender immediately either by phone (864.843.4343) or reply to this e-mail and delete all copies of this message.
________________________________
