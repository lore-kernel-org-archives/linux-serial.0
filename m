From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [spi-devel-general] [PATCH v6] serial: spi: add spi-uart driver
	for Maxim 3110
Date: Sun, 7 Mar 2010 21:12:34 -0700
Message-ID: <fa686aa41003072012q51c57f7fidbc1b62b91969832@mail.gmail.com>
References: <20100304152524.56055828@feng-i7> <1267775090.1941.31.camel@affe>
	<20100308101149.6e874718@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:59225 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab0CHEM4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 7 Mar 2010 23:12:56 -0500
Received: by gxk9 with SMTP id 9so3134523gxk.8
        for <linux-serial@vger.kernel.org>; Sun, 07 Mar 2010 20:12:55 -0800 (PST)
In-Reply-To: <20100308101149.6e874718@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Erwin Authried <eauth@softsys.co.at>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Sun, Mar 7, 2010 at 7:11 PM, Feng Tang <feng.tang@intel.com> wrote:
> On Fri, 5 Mar 2010 15:44:50 +0800
> Erwin Authried <eauth@softsys.co.at> wrote:
>
>>
>> The spi rate and the uart clock aren't synchronized, what happens if
>> the spi rate is slightly higher than the MAX3100's baud rate clock?
>> In addition, if there are other devices on the spi bus, the bus will
>> be occupied unnecessarily long, especially when low baudrates are
>> used.
> Hi Erwin,
>
> Yep, here you touched a key point of the driver.
>
> In the early version of our driver, we used a fixed spi rate which is a
> little owner than its own working rate (3.684MHz) as a spi controller can
> hardly get a divided rate exactly same as 3110's clock , with that we can only
> handle one word per spi transfer, and have to add a udelay function for each
> transfer, and we even have to calculate the delay time for all kinds of the
> UART baud rate it's working with. struct spi_transfer has a member "deay_usecs"
> just for this case.
>
> One key point for SPI devices is they can't be accessed by CPU directly and has
> to go though tasklet or workqueue for each spi transfer. To improve performance,
> we chose to use buffer read/write to let one transfer contain more data, and use
> dynamic spi rate by setting "spi_transfer->speed_hz" for each baud rate
> accordingly. spi rate is set by spi controller drivers based on the "speed_hz"
> number and they should chose a lower spi rate than 3110's baud rate if can't find
> a same rate. For a spi controller support multiple devices including 3110, the
> delay from 3110 is inevitable no matter we use a explicit udelay or the dynamic
> spi rate.
>
> Till here, I have to say the "spi_transfer" of spi core is well designed, which
> provides bits_per_word/delay_usecs/speed_hz of great flexibility for developing
> spi device/controller drivers

You're abusing the speed_hz setting of the SPI controller.  By
clocking down the SPI bus, you're effectively using the SPI completion
interrupt as a high resolution timer to schedule your character
transmissions so that you don't overrun the max3110 which has no tx
fifo.  Using a udelay is also the wrong thing to do because it chews
up CPU cycles to achieve the same result.

The correct thing to do is to either use a high resolution timer, or
the IRQ from the MAX3110 itself to schedule your spi transfers, and
set the SPI rate to the highest frequency that the MAX3110 can handle
so that your driver neither hogs the SPI bus, nor wastes CPU cycles.
You can improve the performance of the driver by using spi_async()
instead of spi_sync() it enqueue the transfers so that you can handle
everything at IRQ context and you don't need to drop into a workqueue
to process the data.

g.
