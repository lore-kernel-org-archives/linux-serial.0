From: Feng Tang <feng.tang@intel.com>
Subject: Re: [spi-devel-general] [PATCH v6] serial: spi: add spi-uart driver
 for Maxim 3110
Date: Mon, 8 Mar 2010 10:11:49 +0800
Message-ID: <20100308101149.6e874718@feng-i7>
References: <20100304152524.56055828@feng-i7>
	<1267775090.1941.31.camel@affe>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16333 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752364Ab0CHCKe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 Mar 2010 21:10:34 -0500
In-Reply-To: <1267775090.1941.31.camel@affe>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Erwin Authried <eauth@softsys.co.at>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, 5 Mar 2010 15:44:50 +0800
Erwin Authried <eauth@softsys.co.at> wrote:

> 
> The spi rate and the uart clock aren't synchronized, what happens if
> the spi rate is slightly higher than the MAX3100's baud rate clock?
> In addition, if there are other devices on the spi bus, the bus will
> be occupied unnecessarily long, especially when low baudrates are
> used.
Hi Erwin,

Yep, here you touched a key point of the driver.

In the early version of our driver, we used a fixed spi rate which is a
little owner than its own working rate (3.684MHz) as a spi controller can
hardly get a divided rate exactly same as 3110's clock , with that we can only
handle one word per spi transfer, and have to add a udelay function for each
transfer, and we even have to calculate the delay time for all kinds of the
UART baud rate it's working with. struct spi_transfer has a member "deay_usecs"
just for this case.

One key point for SPI devices is they can't be accessed by CPU directly and has
to go though tasklet or workqueue for each spi transfer. To improve performance,
we chose to use buffer read/write to let one transfer contain more data, and use
dynamic spi rate by setting "spi_transfer->speed_hz" for each baud rate
accordingly. spi rate is set by spi controller drivers based on the "speed_hz"
number and they should chose a lower spi rate than 3110's baud rate if can't find
a same rate. For a spi controller support multiple devices including 3110, the
delay from 3110 is inevitable no matter we use a explicit udelay or the dynamic
spi rate.

Till here, I have to say the "spi_transfer" of spi core is well designed, which
provides bits_per_word/delay_usecs/speed_hz of great flexibility for developing
spi device/controller drivers

Thanks,
Feng


> 
> One other small cosmetic thing:
> in serial_m3110_tx_empty(), TIOCSER_TEMT should be returned instead of
> 1.
> 
> -Erwin
> 
> 
> 
