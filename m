From: Florian Achleitner <achleitner.florian-JpyZg0bqyNJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] sc16is7xx: Prevent TX buffer overrun, prevent crash
Date: Tue, 6 Oct 2015 10:41:46 +0200
Message-ID: <2151687.RJUYUNn8g7@r90b40zn>
References: <53467079.FOLVyveiGt@r90b40zn> <20151003195257.41864d89@laptop> <1553770.pceUAxXUCu@r90b40zn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1553770.pceUAxXUCu@r90b40zn>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi,

some news.
On Monday 05 October 2015 14:34:01 Florian Achleitner wrote:
> I digged a little deeper and did some measurements to support my idea.
> I think the reason for the 255 read is that the chip does not support the
> zero length write.
> 
> The chip's SPI interface defines two sorts of frames. One for normal
> register access, which is essentially an address followed by one byte of
> data, either read or written.
> 
> The second type is for accessing the fifo. It has an address and two bytes
> of data, by definition.
> 
> If the master now issues a zero length write, it sends only the address
> byte, but the chip will expect two following data bytes, which do not
> arrive. Instead it will consume the following frame. When this frame is the
> tx fifo level read, the chip will not drive its SO line (still expecting a
> fifo write), and the master reads 255. Now two bytes were clocked, and they
> are back in sync. However, the value is crap.
> 
> If my theorie is true, we would also have to make sure, that fifo access is
> always two bytes to keep it synced. I will check this, and craft another
> patch, if neccessary.

My theorie is wrong with fifo frame lengths. Actually, they can be be of 
arbitrary length and the SPI chip select (CS) terminates a frame. Thus, the 
complete fifo can be filled at once, and single bytes can be written, as well.

However, a zero-length write seems to confuse the chip. If I prevent it, 
everything works.

As already mentioned, all regmap operations return success.

Florian

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
