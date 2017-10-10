From: "Han, Nandor (GE Healthcare)" <nandor.han-JJi787mZWgc@public.gmane.org>
Subject: [PATCH] serial: imx-serial - move DMA buffer configuration to DT
Date: Tue, 10 Oct 2017 07:58:31 +0000
Message-ID: <AM3P101MB0180BF8845D0CCFD9C76C63EE6750@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
References: <20170628101514.22610-1-romain.perier@collabora.com>
 <20170629182618.jpahpmuq364ldcv2@pengutronix.de>
 <AM3P101MB0180F7019908E059648488F0E67D0@AM3P101MB0180.NAMP101.PROD.OUTLOOK.COM>
 <20171004214935.nejsdqmlj4wwyq5v@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171004214935.nejsdqmlj4wwyq5v-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org



> -----Original Message-----
> From: Uwe Kleine-König [mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org]
> Sent: 05 October 2017 00:50
> To: Han, Nandor (GE Healthcare) <nandor.han-JJi787mZWgc@public.gmane.org>
> Cc: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>; Greg Kroah-Hartman
> <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>; linux-
> serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: EXT: Re: [PATCH] serial: imx-serial - move DMA buffer configuration
> to DT
> 
> Hello,
> 
> On Mon, Oct 02, 2017 at 01:17:41PM +0000, Han, Nandor (GE Healthcare)
> wrote:
> > > -----Original Message-----
> > > From: Uwe Kleine-König [mailto:u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org]
> > > Sent: 29 June 2017 21:26
> > > To: Romain Perier <romain.perier-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
> > > Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>; Jiri Slaby
> > > <jslaby-IBi9RG/b67k@public.gmane.org>; linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Han, Nandor (GE
> > > Healthcare) <nandor.han-JJi787mZWgc@public.gmane.org>; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > Subject: EXT: Re: [PATCH] serial: imx-serial - move DMA buffer
> > > configuration to DT
> > >
> > > Hello,
> > >
> > > Cc: += devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > >
> > > On Wed, Jun 28, 2017 at 12:15:14PM +0200, Romain Perier wrote:
> > > > From: Nandor Han <nandor.han-JJi787mZWgc@public.gmane.org>
> > > >
> > > > The size of the DMA buffer can affect the delta time between data
> > > > being produced and data being consumed. Basically the DMA system
> > > > will move data to tty buffer when a) DMA buffer is full b) serial line is
> idle.
> > > > The situation is visible when producer generates data continuously
> > > > and there is no possibility for idle line. At this point the DMA
> > > > buffer is directly affecting the delta time.
> >
> > Hi Uwe,
> >    Maybe I can explain a bit better the situation. At least I've tried
> > to explain well enough the problem and the fix. :)
> >
> > >
> > > This doesn't look like a hw property but a configuration item. Also
> > > I don't understand the problematic case. The i.MX is sending
> > > continuously and then doesn't receive bytes until the DMA buffer is full?
> >
> > Yes
> >
> > > What is the DMA buffer?
> > > You don't mean the FIFO here, do you?
> > >
> >
> > DMA buffer is not HW FIFO. Is the buffer provided by serial driver to DMA to
> store data.
> >
> > > That doesn't sound like a good fix but more like a work around.
> > > Which other options did you test to fix your problem?
> > >
> >
> > I haven't tried any other, because except using maybe, ioctl I haven't
> > got anything better.
> 
> My question didn't target where to configure the buffer size instead of dts. I
> wonder if it would help to change the fifo watermark limits for example.
> 

Ok. Sorry I didn't understand correct. Watermark will not help in this case because it is used only to trigger
the moving of the data from RX FIFO to DMA buffer.  The iMX DMA (check the iMX6 RM A.3.1.2.4 since is missing
from iMX53 RM) will only return data to serial driver when no more data exist in the RX FIFO (is using aging timer for this check)
or BD (DMA buffer) is full. If data is sent continuously DMA will return data to driver only when BD is full.

So what we need here is a trigger that will force DMA to return data faster to serial driver. The only one that I could find was the size of the buffer. Of course another way will be to create different SDMA scripts that can do all kinds of handling -- but dint' want to go on that route :) 

> > Our problem is that in our system some serial ports needs to have
> > really low data latency, where others trade more bytes over data
> > latency. This situation results in a need of beeing able to have
> > different DMA buffer size for different ports.
> >
> > How can DMA buffer size affect latency?
> > DMA works like this: (To answer to your question DMA buffer is not
> > FIFO)  1. Transfer the data from HW FIFO to DMA buffer based on some
> > interrupts (character received, etc)  2. Transfer the DMA buffer back
> > to serial port based on some events (buffer full, aging timer, etc)  3. Serial
> port forwards to tty buffer.
> 
> BTW In the past I saw the serial core introduce latency, too. Are you sure
> that's not your bottle neck?
> 

Can you be more specific? Receiving data seems very straight forward and serial core is not involved that much with or without DMA.
Basically the driver handles the moving of the data from rx FIFO to tty buffer. Beside this lowering the DMA buffer fixed our issue. So I will assume that no. 

> > Data availability to consumer depends on: DMA buffer size, baud rate
> > and communication pattern. By communication patter I'm refering that
> > we send data continuoselly (serial line is never idle) or packet by
> > packet (serial line is idle in between)
> > Example:
> >       Baud: 19200 (1Byte = 0.52 ms)
> >       DMA buffer size: 100 bytes
> >       Communication pattern: continuously
> >       =>  DMA will return data to serial port only when DMA buffer is
> >       full, since the communication is continuously. This result in a
> >       data latency of 0.52 ms* 100bytes = 52ms. In case the buffer
> >       will be 200bytes the letency will be double.
> >
> > I agree with you, this is not directly a hw property but a DMA configuration
> item.
> > But I've found this to be the best way to configure this comparing with using
> ioctl.
> >
> > Let me know if you need more clarification and I would really be open
> > to other options that will solve our problem.
> >
> > <snip>
> >
> > > > +- fsl,dma-size : Indicate the size of the DMA buffer and its
> > > > +periods
> > >
> > > This is a sparse description, just from reading that I don't
> > > understand what it does.
> > >
> >
> > Serial driver configures a circular ring of buffers for DMA. Here we
> > can configure the size and the number of buffers.
> 
> The problem is: How should a person, who wants to make available a port on a
> machine via dts, choose what value to use for fsl,dma-size?

It doesn't have too. If this configuration is not provided the serial port will have a default value.
The user has the possibility to tweak this settings in case is needed.

> 
> What you want (for a low latency port) is that also small amounts of data
> received are passed quickly to the upper layer. The knob you identified to be
> available for that is the dma buffer size.
> 
> I'd prefer to talk about low latency instead of buffer sizes when setting
> parameters for the port. That this influences the buffer size (and maybe
> watermark settings) under the hood shouldn't matter for the person
> configuring the low latency property.
> 

I understand your point of view. A simple grep in "Documentation/devicetree/bindings" shows me that both options are used (latency/buffer configurations). We could use latency here as configuration and then translate it to DMA buffer size taking in consideration the baud rate but it's a bit more work to do and beside this we have also the number of buffers configuration which will be trickier to convert it from latency. In my opinion, I don't see a significant difference between latency and buffer since most of the serial port users (userspace level) don't touch these settings. Of course, will be a different story if this configuration will be provided using termios or other means accessible from userspace. 

> Best regards
> Uwe
> 

Thanks Uwe :)

Regards,
     Nandor

> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
