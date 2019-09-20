From: Johan Hovold <johan@kernel.org>
Subject: Re: [BACKPORT 4.14.y v2 6/6] serial: sprd: Modify the baud rate
 calculation formula
Date: Fri, 20 Sep 2019 10:06:51 +0200
Message-ID: <20190920080651.GJ30545@localhost>
References: <cover.1567649728.git.baolin.wang@linaro.org>
 <4fe6ec82960301126b9f4be52dd6083c30e17420.1567649729.git.baolin.wang@linaro.org>
 <20190905090130.GF1701@localhost>
 <CAMz4kuJGmQxfy5mi1aZNL8SA8MQBSTTyDeWcHHEtG2aXsFZgug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuJGmQxfy5mi1aZNL8SA8MQBSTTyDeWcHHEtG2aXsFZgug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, "# 3.4.x" <stable@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Orson Zhai <orsonzhai@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 05, 2019 at 05:58:05PM +0800, Baolin Wang wrote:
> Hi Johan,
> 
> On Thu, 5 Sep 2019 at 17:01, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Sep 05, 2019 at 11:11:26AM +0800, Baolin Wang wrote:
> > > From: Lanqing Liu <lanqing.liu@unisoc.com>
> > >
> > > [Upstream commit 5b9cea15a3de5d65000d49f626b71b00d42a0577]
> > >
> > > When the source clock is not divisible by the expected baud rate and
> > > the remainder is not less than half of the expected baud rate, the old
> > > formular will round up the frequency division coefficient. This will
> > > make the actual baud rate less than the expected value and can not meet
> > > the external transmission requirements.
> > >
> > > Thus this patch modifies the baud rate calculation formula to support
> > > the serial controller output the maximum baud rate.
> > >
> > > Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > >  drivers/tty/serial/sprd_serial.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
> > > index e902494..72e96ab8 100644
> > > --- a/drivers/tty/serial/sprd_serial.c
> > > +++ b/drivers/tty/serial/sprd_serial.c
> > > @@ -380,7 +380,7 @@ static void sprd_set_termios(struct uart_port *port,
> > >       /* ask the core to calculate the divisor for us */
> > >       baud = uart_get_baud_rate(port, termios, old, 0, SPRD_BAUD_IO_LIMIT);
> > >
> > > -     quot = (unsigned int)((port->uartclk + baud / 2) / baud);
> > > +     quot = port->uartclk / baud;
> >
> > Are you sure the original patch is even correct?
> >
> > By replacing the divisor rounding with truncation you are introducing
> > larger errors for some baud rates, something which could possibly even
> > break working systems.
> 
> Our UART clock source is 26M, and there is no difference for lower
> than 3M baud rate between dividing closest or dividing down.

But there is; you have introduced larger errors for at least a few
standard rates by changing to truncation.

> But we have one special use case is our BT/GPS want to set 3.25M baud
> rate, but we have to select 3M baud rate in baud_table since no 3.25M
> setting. So in this case if we use the old formula, we will only get
> about 2.8M baud rate, which can not meet our requirement. If we change
> the dividing down method, we can get 3.25M baud rate.
> 
> I have to say this is a workaroud for our special case, and can solve
> our problem. If you have any good suggestion, we can change to a
> better solution. Thanks.

Yeah, I don't think purposefully introducing larger errors, and risk
breaking other people's setups, to work around that use case is
warranted.

We have an interface for setting arbitrary baudrates (TCSETS2) which you
can you use (even if glibc support is still not in place). You'd just
need to lift the seemingly arbitrary limitation to 3 Mbaud in the driver
first.

> > Perhaps the original patch should even be reverted, but in any case
> > backporting this to stable looks questionable.

So I think reverting this may be the right thing to do.

Johan
