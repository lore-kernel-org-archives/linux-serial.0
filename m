From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Re: [PATCH v2 1/2] sc16is7xx: Prevent TX buffer overrun, prevent
 crash
Date: Sat, 3 Oct 2015 19:52:57 +0100
Message-ID: <20151003195257.41864d89@laptop>
References: <53467079.FOLVyveiGt@r90b40zn>
	<8914018.PpSVth2cIK@r90b40zn>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8914018.PpSVth2cIK@r90b40zn>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Achleitner <achleitner.florian-JpyZg0bqyNJBDgjK7y7TUQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 30 Sep 2015 16:09:44 +0200, Florian Achleitner wrote:
> If the chip wrongly reports a TX FIFO space, bigger than the driver's
> buffer, it runs over and destroys the struct sc16is7xx_port, its
> struct kworker, and very likely a lot more.
> For us, this lead to the immediate crash of the driver's kworker thread.
> 
> Prevent a buffer overrun by adding a length check.
> 
> Signed-off-by: Florian Achleitner <achleitner.florian-JpyZg0bqyNJBDgjK7y7TUQ@public.gmane.org>

Hi Florian!

Thanks a lot for the submission.  Would you mind digging a little
deeper into this problem?  I think the root cause is that the SPI
read fails for some reason and our driver does not handle that
properly, i.e. we don't read 255, it's just a random/failure value.
Unfortunatelly I don't have any boards with this chip any more to
do any tests or development myself, so it's on you ;)

This driver initially supported only I2C and in I2C regmap code if
the read fails we will always get a zero value.  Therefore we felt
free to ignore in sc16is7xx_port_read() the return value of
regmap_read().

Could you please run your tests again and see if perhaps the read is
failing?  In that case we should zero the return value from
sc16is7xx_port_read().

I think from this thread: 
https://lkml.org/lkml/2008/2/20/271
we can assume that zero-length writes are a valid use-case for SPI 
and if so could you please test the driver for your SPI controller?
Perhaps the zero-length check should be placed in the SPI controller
driver?

I am OK with adding the sanity checks but lets first get to the bottom
of this!

Thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
