From: Feng Tang <feng.tang@intel.com>
Subject: Re: [spi-devel-general] [RFC][PATCH] serial: spi: add spi-uart
 driver for Maxim 3110
Date: Wed, 30 Dec 2009 09:54:48 +0800
Message-ID: <20091230095448.7ff828f6@feng-desktop>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20091229145953.GC27213@jasper.tkos.co.il>
	<73BDC2BA3DA0BD47BAAEE12383D407EF303E943D@shzsmsx502.ccr.corp.intel.com>
	<1262112228.28396.93.camel@justakiss.home.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40881 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbZL3B6G (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Dec 2009 20:58:06 -0500
In-Reply-To: <1262112228.28396.93.camel@justakiss.home.at>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Erwin Authried <eauth@softsys.co.at>
Cc: Baruch Siach <baruch@tkos.co.il>, David Brownell <dbrownell@users.sourceforge.net>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Wed, 30 Dec 2009 02:43:48 +0800
Erwin Authried <eauth@softsys.co.at> wrote:


Hi Erwin,

Thanks for the comments.
> 
> Hi,
> 
> looking at your driver, there are several points that make me doubt
> that it is working at all:
You can trust me on this point:) it has worked reliably on our HW platform
for long time. I don't know if Alan has played with the platform, but
David Woodhouse has, max3110's console is one of the main debug methods
for developers.

Actually it can co-work well with other SPI devices connecting to the
same SPI controller(our platform use a Designware core based controller)
> 
> * The MAX3110 requires CS going low at the start of each 16-bit
> transfer, if you look at the datasheet. 
Our SPI controller can handle this (drivers/spi/dw_spi.c), it has a
dedicated chip select register for handling chip select. And this part
is transparent for all SPI slave devices connecting to the controller 

> 
> * in max3110_read_multi, it looks to me that this will work for
> big-endian architectures only.
We are running on x86 architecture, with little endian. But endian issue is
a good point

> 
> * I can't see how send_circ_buf() should work at all. You are just
> sending a burst of characters to the MAX3110 without checking the
> transmit buffer status at all. The MAX3110 has a single TX buffer
> only, so that will cause transmit characters to be lost.
Yes, I let the SPI controller driver handle this, which has a rather
big FIFO. And structure spi_transfer has a member "speed_hz", this driver
set it according to current UART baud rate, then SPI controller driver will
adjust the bus frequency between controller and 3110 accordingly to prevent
its overflow, which will avoid explicit delay in driver

> 
> I think there's no need for a MAX3100 **and** a MAX3110 driver, this
> is just confusing. The MAX3110 driver is identical to the MAX3100
> from the software view, it is simply a MAX3100 with transceivers
> added to the chip. If there's any improvement, that should be merged
> into the existing MAX3100 driver.
I agree there should not be 2 drivers cover 1 family of HW, so this is a RFC.
I've thinked about merge with current 3100 code, but it depends on one char
per spi_transfer, while my driver relys on batch data transfer for efficiency.
Another key point is the console, SPI UART can't be directly accessed by
CPU, so every spi_transfer will go through tasklet/workqueue, which makes
supporting printk a big part of my driver.


Thanks,
Feng  

> 
> -Erwin
> 
> 
