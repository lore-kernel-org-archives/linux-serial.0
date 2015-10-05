From: Florian Achleitner <achleitner.florian-JpyZg0bqyNJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] sc16is7xx: Prevent TX buffer overrun, prevent crash
Date: Mon, 5 Oct 2015 14:34:01 +0200
Message-ID: <1553770.pceUAxXUCu@r90b40zn>
References: <53467079.FOLVyveiGt@r90b40zn> <8914018.PpSVth2cIK@r90b40zn> <20151003195257.41864d89@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151003195257.41864d89@laptop>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3-5tc4TXWwyLM@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Jakub!

On Saturday 03 October 2015 19:52:57 Jakub Kici=C5=84ski wrote:
> Hi Florian!
>=20
> Thanks a lot for the submission.  Would you mind digging a little
> deeper into this problem?  I think the root cause is that the SPI
> read fails for some reason and our driver does not handle that
> properly, i.e. we don't read 255, it's just a random/failure value.
> Unfortunatelly I don't have any boards with this chip any more to
> do any tests or development myself, so it's on you ;)

No problem, the board is still on the desk :)

> This driver initially supported only I2C and in I2C regmap code if
> the read fails we will always get a zero value.  Therefore we felt
> free to ignore in sc16is7xx_port_read() the return value of
> regmap_read().
>=20
> Could you please run your tests again and see if perhaps the read is
> failing?  In that case we should zero the return value from
> sc16is7xx_port_read().

I added a dev_err in *_port_read,write,update and *_fifo_read,write. No=
 regmap=20
function returned an error in my test, but the 255 read value is still =
there.

> I think from this thread:
> https://lkml.org/lkml/2008/2/20/271
> we can assume that zero-length writes are a valid use-case for SPI
> and if so could you please test the driver for your SPI controller?
> Perhaps the zero-length check should be placed in the SPI controller
> driver?

I digged a little deeper and did some measurements to support my idea.
I think the reason for the 255 read is that the chip does not support t=
he zero=20
length write.=20

The chip's SPI interface defines two sorts of frames. One for normal re=
gister=20
access, which is essentially an address followed by one byte of data, e=
ither=20
read or written.

The second type is for accessing the fifo. It has an address and two by=
tes of=20
data, by definition.=20

If the master now issues a zero length write, it sends only the address=
 byte,=20
but the chip will expect two following data bytes, which do not arrive.=
=20
Instead it will consume the following frame. When this frame is the tx =
fifo=20
level read, the chip will not drive its SO line (still expecting a fifo=
=20
write), and the master reads 255. Now two bytes were clocked, and they =
are=20
back in sync. However, the value is crap.

If my theorie is true, we would also have to make sure, that fifo acces=
s is=20
always two bytes to keep it synced. I will check this, and craft anothe=
r=20
patch, if neccessary.

>=20
> I am OK with adding the sanity checks but lets first get to the botto=
m
> of this!

I agree. I split the patch in two parts, because I would vote for patch=
 1/2=20
unconditionally, to prevent buffer overruns, whatever happens.=20
And then, use patch 2/2 only if it is the right solution.
>=20
> Thanks!

Thanks,
=46lorian

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
