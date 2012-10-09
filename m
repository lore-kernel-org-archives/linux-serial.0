From: Matt Schulte <matts@commtech-fastcom.com>
Subject: New serial card development
Date: Tue, 09 Oct 2012 13:43:10 -0500
Message-ID: <5074703E.408@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63662 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab2JISnV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Oct 2012 14:43:21 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so5414872oag.19
        for <linux-serial@vger.kernel.org>; Tue, 09 Oct 2012 11:43:21 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello, my name is Matt and I have recently developed a PCIe card based
on the Exar 17v35x series of PCIe multiport UART chips.

We have written Linux drivers for our other products in the past but
they have never been what I would call the best practice for Linux
development.

This time I would like to write a driver that uses the best practices
and possibly submit it to the kernel when I'm done.

I am a little bit confused about what method would be best for this
device.   I have been examining the sample driver provided by Exar
and it seems that the only things that they have that are really
different from the generic 8250 serial driver are the interrupt
handler (optimized for their multiple ports), the transmit and
receive character functions (modified to use their 256 byte FIFOs)
and the function that calculates the baud.  Also I have two features
specific to my card that I would likely need to use an ioctl for.

If these are the only differences would I be able to create a driver
like what is seen in the /drivers/tty/serial/8250 directory (8250_dw.c
for example)?  Or would I need to do something similar to what I find in
the /drviers/tty/serial directory?

Thank you for your time.

Matt Schulte

