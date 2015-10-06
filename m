From: JakubK <moorray3-5tc4TXWwyLM@public.gmane.org>
Subject: Odp: Re: [PATCH v2 1/2] sc16is7xx: Prevent TX buffer overrun,
 prevent crash
Date: Tue, 06 Oct 2015 11:18:48 +0200
Message-ID: <561391f8acb008.44475929@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Achleitner <achleitner.florian-JpyZg0bqyNJBDgjK7y7TUQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Ringle <jringle-gkqdKIIuv0Hby3iVrkZq2A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Dnia Poniedzia=B3ek, 5 Pa=BCdziernika 2015 14:34 Florian Achleitner <ac=
hleitner.florian-JpyZg0bqyNJBDgjK7y7TUQ@public.gmane.org> napisa=B3(a)
> Hi Jakub!
> =20
> On Saturday 03 October 2015 19:52:57 Jakub Kici=F1ski wrote:
> > Hi Florian!
> >
> > Thanks a lot for the submission.  Would you mind digging a little
> > deeper into this problem?  I think the root cause is that the SPI
> > read fails for some reason and our driver does not handle that
> > properly, i.e. we don't read 255, it's just a random/failure value.
> > Unfortunatelly I don't have any boards with this chip any more to
> > do any tests or development myself, so it's on you ;)
> =20
> No problem, the board is still on the desk :)
=20
Thanks!
=20
> > This driver initially supported only I2C and in I2C regmap code if
> > the read fails we will always get a zero value.  Therefore we felt
> > free to ignore in sc16is7xx_port_read() the return value of
> > regmap_read().
> >
> > Could you please run your tests again and see if perhaps the read i=
s
> > failing?  In that case we should zero the return value from
> > sc16is7xx_port_read().
> =20
> I added a dev_err in *_port_read,write,update and *_fifo_read,write. =
No regmap
> function returned an error in my test, but the 255 read value is stil=
l there.
> =20
> > I think from this thread:
> > https://lkml.org/lkml/2008/2/20/271
> > we can assume that zero-length writes are a valid use-case for SPI
> > and if so could you please test the driver for your SPI controller?
> > Perhaps the zero-length check should be placed in the SPI controlle=
r
> > driver?
> =20
> I digged a little deeper and did some measurements to support my idea=
=2E
> I think the reason for the 255 read is that the chip does not support=
 the zero
> length write.
> =20
> The chip's SPI interface defines two sorts of frames. One for normal =
register
> access, which is essentially an address followed by one byte of data,=
 either
> read or written.
> =20
> The second type is for accessing the fifo. It has an address and two =
bytes of
> data, by definition.
> =20
> If the master now issues a zero length write, it sends only the addre=
ss byte,
> but the chip will expect two following data bytes, which do not arriv=
e.
> Instead it will consume the following frame. When this frame is the t=
x fifo
> level read, the chip will not drive its SO line (still expecting a fi=
fo
> write), and the master reads 255. Now two bytes were clocked, and the=
y are
> back in sync. However, the value is crap.
> =20
> If my theorie is true, we would also have to make sure, that fifo acc=
ess is
> always two bytes to keep it synced. I will check this, and craft anot=
her
> patch, if neccessary.
=20
My knowledge about SPI is minimal but this sounds reasonable. I just wo=
nder
why we've never seen this issue before? If the address byte is treated =
as data
then we should see it received on the other side, did you observe that?

> > I am OK with adding the sanity checks but lets first get to the bot=
tom
> > of this!
> =20
> I agree. I split the patch in two parts, because I would vote for pat=
ch 1/2
> unconditionally, to prevent buffer overruns, whatever happens.
> And then, use patch 2/2 only if it is the right solution.
=20
I would personally move the zero checks of to_send to sc16is7xx_fifo_wr=
ite()
and just return early from there if to_send is zero. Even if this issue=
 is
somehow specific to your board/SPI controller we can treat this early r=
eturn
as an optimization :)
=20
As for the error check I would break out of the loop when we see the bo=
gus value
instead of just masking of the top bit. I think such value should not b=
e trusted at all.

Thanks,
Jakub


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
