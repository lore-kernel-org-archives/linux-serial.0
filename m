From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6] serial: spi: add spi-uart driver
 for Maxim 3110
Date: Thu, 11 Mar 2010 17:07:36 +0800
Message-ID: <20100311170736.3272b6a5@feng-i7>
References: <20100304152524.56055828@feng-i7> <1267775090.1941.31.camel@affe>
	<20100308101149.6e874718@feng-i7>
	<fa686aa41003072012q51c57f7fidbc1b62b91969832@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa41003072012q51c57f7fidbc1b62b91969832-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, 8 Mar 2010 12:12:34 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:


> >
> > Yep, here you touched a key point of the driver.
> >
> > In the early version of our driver, we used a fixed spi rate which
> > is a little owner than its own working rate (3.684MHz) as a spi
> > controller can hardly get a divided rate exactly same as 3110's
> > clock , with that we can only handle one word per spi transfer, and
> > have to add a udelay function for each transfer, and we even have
> > to calculate the delay time for all kinds of the UART baud rate
> > it's working with. struct spi_transfer has a member "deay_usecs"
> > just for this case.
> >
> > One key point for SPI devices is they can't be accessed by CPU
> > directly and has to go though tasklet or workqueue for each spi
> > transfer. To improve performance, we chose to use buffer read/write
> > to let one transfer contain more data, and use dynamic spi rate by
> > setting "spi_transfer->speed_hz" for each baud rate accordingly.
> > spi rate is set by spi controller drivers based on the "speed_hz"
> > number and they should chose a lower spi rate than 3110's baud rate
> > if can't find a same rate. For a spi controller support multiple
> > devices including 3110, the delay from 3110 is inevitable no matter
> > we use a explicit udelay or the dynamic spi rate.
> >
> > Till here, I have to say the "spi_transfer" of spi core is well
> > designed, which provides bits_per_word/delay_usecs/speed_hz of
> > great flexibility for developing spi device/controller drivers
> 
> You're abusing the speed_hz setting of the SPI controller.  By
> clocking down the SPI bus, you're effectively using the SPI completion
> interrupt as a high resolution timer to schedule your character
> transmissions so that you don't overrun the max3110 which has no tx
> fifo.  Using a udelay is also the wrong thing to do because it chews
> up CPU cycles to achieve the same result.
> 
> The correct thing to do is to either use a high resolution timer, or
> the IRQ from the MAX3110 itself to schedule your spi transfers, and
> set the SPI rate to the highest frequency that the MAX3110 can handle
> so that your driver neither hogs the SPI bus, nor wastes CPU cycles.
> You can improve the performance of the driver by using spi_async()
> instead of spi_sync() it enqueue the transfers so that you can handle
> everything at IRQ context and you don't need to drop into a workqueue
> to process the data.

Yes, using a high resolution timer instead of udelay is definitely better.
The reason we didn't use it is the delay for 115200 bps is about 90us,
which is shorter than the time of executing an hr_timer(IRQ handling and
precess waking stuff), but it's our HW's problem anyway.

But this doesn't help on buffer read/write, and only works for one word per
spi_transfer model as 3110 only has 1 word TX buffer and 8 word RX buffer.
We normally use such a test case, Ctrl+C a big string (500 Bytes), and Ctrl+V
it on the 3110 console, check if they are correctly received and echoed on
screen, one word per transfer can hardly make that, due to the cost in spi
layer and tty layer, while buffer read/write model can.

If "speed_hz" are not for this case, then where should it be used for,
spi core already has "max_speed_hz" specifying the maxim clock permitted by
HW. Using speed_hz does affect other devices connecting to the same controller,
but can we provide an option for the platform code to chose whether dynamic
lower spi clk is allowed, in case the spi controller has only 3110 as its
slave device.

Thanks,
Feng 
 
> 
> g.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
