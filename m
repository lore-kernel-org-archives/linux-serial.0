From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2] tty: implement led triggers
Date: Mon, 7 May 2018 11:27:10 +0200
Message-ID: <20180507092710.GQ2285@localhost>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
 <20180507080252.GO2285@localhost>
 <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180507084127.ekpd3ze2itkzo7fd@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-serial@vger.kernel.org

On Mon, May 07, 2018 at 10:41:27AM +0200, Uwe Kleine-König wrote:
> Hello Johan,
> 
> thanks for your feedback.
> 
> On Mon, May 07, 2018 at 10:02:52AM +0200, Johan Hovold wrote:
> > On Thu, May 03, 2018 at 10:19:52PM +0200, Uwe Kleine-König wrote:
> > > The rx trigger fires when data is pushed to the ldisc. This is a bit later
> > > than the actual receiving of data but has the nice benefit that it
> > > doesn't need adaption for each driver and isn't in the hot path.
> > > 
> > > Similarily the tx trigger fires when data taken from the ldisc.
> > 
> > You meant copied from user space, or written to the ldisc, here.
> 
> ack.
> 
> > Note that the rx-path is shared with serdev, but the write path is not.
> > So with this series, serdev devices would only trigger the rx-led.
> 
> Where would be the right place to put the tx trigger to catch serdev,
> too?

I haven't given this much thought, but do we really want this for serdev
at all? I'm thinking whatever driver or subsystem is using serdev should
have their own triggers (e.g. bluetooth or net).

So it might be better to move the rx-blinking to the default tty-port
client receive_buf callback instead (i.e.
tty_port_default_receive_buf()).

And then the resource allocations would need to go after the serdev
registration in tty_port_register_device_attr_serdev().

> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > > Changes since v1, sent with Message-Id: 
> > > 20180503100448.1350-1-u.kleine-koenig@pengutronix.de:
> > > 
> > >  - implement tx trigger;
> > >  - introduce Kconfig symbol for conditional compilation;
> > >  - set trigger to NULL if allocating the name failed to not free random
> > >    pointers in case the port struct wasn't zeroed;
> > >  - use if/else instead of goto
> > 
> > > @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
> > >  		struct tty_buffer *head = buf->head;
> > >  		struct tty_buffer *next;
> > >  		int count;
> > > +		unsigned long delay = 50 /* ms */;
> > 
> > Comment after the semicolon?
> 
> Given that this comment is about the 50 and not the delay member, I
> prefer it before the ;.

Hmm. I personally find it hard to read and can only find about 30
instances of this comment style (for assignments) in the kernel. And
arguably the comment applies equally well to the delay variable in this
case too.

> > Besides the ugly ifdefs here, you're leaking the above LED resources in
> > the error paths below (e.g. on probe deferrals).

> ack, the ifdevs are ugly. I'm working on an idea to get rid of them.

Sounds good.

Thanks,
Johan
