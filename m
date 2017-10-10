From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] serial: imx-serial - move DMA buffer configuration to DT
Date: Tue, 10 Oct 2017 10:25:56 +0200
Message-ID: <20171010082556.q47bahujdlffxj5e@pengutronix.de>
References: <20170628101514.22610-1-romain.perier@collabora.com>
 <20170629182618.jpahpmuq364ldcv2@pengutronix.de>
 <AM3P101MB0180F7019908E059648488F0E67D0@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
 <20171004214935.nejsdqmlj4wwyq5v@pengutronix.de>
 <AM3P101MB0180BF8845D0CCFD9C76C63EE6750@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AM3P101MB0180BF8845D0CCFD9C76C63EE6750-Irc2Ng3OI610aGNDtyle9VAr667LJVwUiGd9ebBGJoev3QGu/rdwKA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Han, Nandor (GE Healthcare)" <nandor.han-JJi787mZWgc@public.gmane.org>
Cc: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hello,

On Tue, Oct 10, 2017 at 07:58:31AM +0000, Han, Nandor (GE Healthcare) wrote:
> > > > That doesn't sound like a good fix but more like a work around.
> > > > Which other options did you test to fix your problem?
> > > >
> > >
> > > I haven't tried any other, because except using maybe, ioctl I haven't
> > > got anything better.
> > 
> > My question didn't target where to configure the buffer size instead of dts. I
> > wonder if it would help to change the fifo watermark limits for example.
> > 
> 
> Ok. Sorry I didn't understand correct. Watermark will not help in this case because it is used only to trigger
> the moving of the data from RX FIFO to DMA buffer.  The iMX DMA (check the iMX6 RM A.3.1.2.4 since is missing
> from iMX53 RM) will only return data to serial driver when no more data exist in the RX FIFO (is using aging timer for this check)
> or BD (DMA buffer) is full. If data is sent continuously DMA will return data to driver only when BD is full.

I read once over the description but I failed to understand it. At least
it talks about water mark levels and min(WML-1,Count) which makes me
think that the DMA script makes use of water marking too and my idea to
play with that instead of buffer sizes might be sensible.

> So what we need here is a trigger that will force DMA to return data
> faster to serial driver. The only one that I could find was the size
> of the buffer. Of course another way will be to create different SDMA
> scripts that can do all kinds of handling -- but dint' want to go on
> that route :) 

:-)

> > > Our problem is that in our system some serial ports needs to have
> > > really low data latency, where others trade more bytes over data
> > > latency. This situation results in a need of beeing able to have
> > > different DMA buffer size for different ports.
> > >
> > > How can DMA buffer size affect latency?
> > > DMA works like this: (To answer to your question DMA buffer is not
> > > FIFO)  1. Transfer the data from HW FIFO to DMA buffer based on some
> > > interrupts (character received, etc)  2. Transfer the DMA buffer back
> > > to serial port based on some events (buffer full, aging timer, etc)  3. Serial
> > port forwards to tty buffer.
> > 
> > BTW In the past I saw the serial core introduce latency, too. Are you sure
> > that's not your bottle neck?
> 
> Can you be more specific?

http://www.spinics.net/lists/linux-serial/msg17767.html

> > > Data availability to consumer depends on: DMA buffer size, baud rate
> > > and communication pattern. By communication patter I'm refering that
> > > we send data continuoselly (serial line is never idle) or packet by
> > > packet (serial line is idle in between)
> > > Example:
> > >       Baud: 19200 (1Byte = 0.52 ms)
> > >       DMA buffer size: 100 bytes
> > >       Communication pattern: continuously
> > >       =>  DMA will return data to serial port only when DMA buffer is
> > >       full, since the communication is continuously. This result in a
> > >       data latency of 0.52 ms* 100bytes = 52ms. In case the buffer
> > >       will be 200bytes the letency will be double.
> > >
> > > I agree with you, this is not directly a hw property but a DMA configuration
> > item.
> > > But I've found this to be the best way to configure this comparing with using
> > ioctl.
> > >
> > > Let me know if you need more clarification and I would really be open
> > > to other options that will solve our problem.
> > >
> > > <snip>
> > >
> > > > > +- fsl,dma-size : Indicate the size of the DMA buffer and its
> > > > > +periods
> > > >
> > > > This is a sparse description, just from reading that I don't
> > > > understand what it does.
> > > >
> > >
> > > Serial driver configures a circular ring of buffers for DMA. Here we
> > > can configure the size and the number of buffers.
> > 
> > The problem is: How should a person, who wants to make available a port on a
> > machine via dts, choose what value to use for fsl,dma-size?
> 
> It doesn't have too. If this configuration is not provided the serial port will have a default value.
> The user has the possibility to tweak this settings in case is needed.

"The default value works in general" is no good justification to not
provide easy-to-grasp and well documented knobs.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
