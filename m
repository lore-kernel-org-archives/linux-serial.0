From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6] tty/serial: at91: fix hardware handshake on Atmel
 platforms
Date: Fri, 28 Oct 2016 08:11:44 -0400
Message-ID: <20161028121144.GA3948@kroah.com>
References: <20161027160406.25738-1-richard.genoud@gmail.com>
 <20161027180229.5faqrvxa2a4pos7i@pengutronix.de>
 <20161027231331.gngekbg22wfvnolr@piout.net>
 <20161028095151.f24lhelfknzrpy6c@pengutronix.de>
 <CACQ1gAjX6fVghjxf=o_WNUDYFW6Sc_HF_3G6gxrSma5F3qjpbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACQ1gAjX6fVghjxf=o_WNUDYFW6Sc_HF_3G6gxrSma5F3qjpbQ@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "#4 . 4+" <stable@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Cyrille Pitchen <cyrille.pitchen@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Oct 28, 2016 at 12:56:09PM +0200, Richard Genoud wrote:
> 2016-10-28 11:51 GMT+02:00 Uwe Kleine-König <u.kleine-koenig@pengutronix.de>:
> > On Fri, Oct 28, 2016 at 01:13:31AM +0200, Alexandre Belloni wrote:
> >> On 27/10/2016 at 20:02:29 +0200, Uwe Kleine-König wrote :
> >> > Hello Richard,
> >> >
> >> > On Thu, Oct 27, 2016 at 06:04:06PM +0200, Richard Genoud wrote:
> >> > > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> >> > > index fd8aa1f4ba78..168b10cad47b 100644
> >> > > --- a/drivers/tty/serial/atmel_serial.c
> >> > > +++ b/drivers/tty/serial/atmel_serial.c
> >> > > @@ -2132,11 +2132,29 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
> >> > >           mode |= ATMEL_US_USMODE_RS485;
> >> > >   } else if (termios->c_cflag & CRTSCTS) {
> >> > >           /* RS232 with hardware handshake (RTS/CTS) */
> >> > > -         if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
> >> > > -                 dev_info(port->dev, "not enabling hardware flow control because DMA is used");
> >> > > -                 termios->c_cflag &= ~CRTSCTS;
> >> > > -         } else {
> >> > > +         if (atmel_use_fifo(port) &&
> >> > > +             !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)) {
> >> > > +                 /*
> >> > > +                  * with ATMEL_US_USMODE_HWHS set, the controller will
> >> > > +                  * be able to drive the RTS pin high/low when the RX
> >> > > +                  * FIFO is above RXFTHRES/below RXFTHRES2.
> >> > > +                  * It will also disable the transmitter when the CTS
> >> > > +                  * pin is high.
> >> > > +                  * This mode is not activated if CTS pin is a GPIO
> >> > > +                  * because in this case, the transmitter is always
> >> > > +                  * disabled (there must be an internal pull-up
> >> > > +                  * responsible for this behaviour).
> >> > > +                  * If the RTS pin is a GPIO, the controller won't be
> >> > > +                  * able to drive it according to the FIFO thresholds,
> >> > > +                  * but it will be handled by the driver.
> >> > > +                  */
> >> > >                   mode |= ATMEL_US_USMODE_HWHS;
> >> >
> >> > You use
> >> >
> >> >     !mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS)
> >> >
> >> > as indicator that the cts mode of the respective pin is used. Is this
> >> > reliable? (It's not if there are machines that don't use CTS, neither as
> >> > gpio nor using the hardware function.) Maybe this needs a dt property to
> >> > indicate that there is no (hw)handshaking available?
> >> >
> >>
> >> We had a call today were we agreed that this should be added in a future
> >> patch. Let's fix the regression for now.
> >
> > A machine without CTS (neither gpio nor hw function) used to work fine
> > before the breaking commit, right? So this case is part of the
> > regression and needs a fix?
> Actually, a machine with a FIFO and without CTS didn't even exist at the
> time of the breaking commit (v4.0), the FIFO handling was introduced later,
> so it's not even a regression !
> 
> > Anyhow, this probably shouldn't stop the commit entering mainline
> > because there are probably very few such machines (if any).
> >
> > So:
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >
> > Best regards
> > Uwe
> 
> 
> Thanks !
> 
> Greg, could you take this in your tree ?

Now applied, thanks for working through all of this.

greg k-h
