From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v7 1/2] serial: sc16is7xx
Date: Fri, 25 Apr 2014 17:48:48 +0100
Message-ID: <20140425174848.7e79066e@alan.etchedpixels.co.uk>
References: <1398387367-4047-1-git-send-email-jon@ringle.org>
	<alpine.LRH.2.03.1404250914380.30160@frank.harvard.edu>
	<alpine.LRH.2.03.1404250941590.2625@frank.harvard.edu>
	<CAMwGMjyqiC1DLKfz0LUFg-iN8mDKc54w+8AYKFHOydiwtXHrFQ@mail.gmail.com>
	<alpine.LRH.2.03.1404251019300.2893@frank.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.03.1404251019300.2893@frank.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Coldwell <coldwell@gmail.com>
Cc: Jon Ringle <jon@ringle.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Alexander Shiyan <shc_work@mail.ru>, Jon Ringle <jringle@gridpoint.com>
List-Id: linux-serial@vger.kernel.org

> Fair enough, but the 8250 framework does allow you to insert your own
> irq service routine. "serial8250_default_handle_irq" is the default
> (unsurprisingly), but if the uart_port has a non-NULL "handle_irq"
> method it will be faithfully copied into the uart_8250_port
> "handle_irq" method in 8250_core.c:early_serial_setup.

It's nowhere near sufficient and this was discussed earlier in some depth.

> If that's really true, then I would say it argues in favor of a
> revision of the 8250 code.  Certainly, this is not the last time that
> a 16550-compatible UART will appear on a non-PCI, non-ISA bus.

The 8250 code has deep seated assumptions about locking and atomicity.
Not only would it be very hard to unify the drivers the end result would
probably be quite horrible to maintain.

We should just merge the driver as is, as submitted in version 7. It's
fine. The fact all the I/O accesses are asynchronous completely changes
the way the driver is written. Architecturally from the 8250 driver's
point of view its a completely unrelated piece of hardware that shares
some constants.

If there are other 16x50 i2c/spi uarts then yes merge them with the
sc16is7xx driver.

Alan
 
