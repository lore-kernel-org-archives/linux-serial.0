From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv2 3/3] tty/serial: at91: fix hardware handshake on SAM9x5
 (without GPIOs)
Date: Tue, 13 Sep 2016 15:45:56 +0200
Message-ID: <20160913134556.wpodujgk6yn7rfxz@piout.net>
References: <20160912094733.21501-1-richard.genoud@gmail.com>
 <20160912094733.21501-4-richard.genoud@gmail.com>
 <20160912095317.74e5xiedrq5nh3v4@piout.net>
 <CACQ1gAhNdPgtkpt1QPaiKjKi5oaq5vHbt4kKL5tQfwLvDBDo0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACQ1gAhNdPgtkpt1QPaiKjKi5oaq5vHbt4kKL5tQfwLvDBDo0w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 12/09/2016 at 12:50:38 +0200, Richard Genoud wrote :
> >> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> >> index e9b4fbf88c2d..32154e7231ce 100644
> >> --- a/drivers/tty/serial/atmel_serial.c
> >> +++ b/drivers/tty/serial/atmel_serial.c
> >> @@ -2130,15 +2130,19 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
> >>       } else if ((termios->c_cflag & CRTSCTS) &&
> >>                  !mctrl_gpio_use_rtscts(atmel_port->gpios)) {
> >>               /*
> >> -              * RS232 with hardware handshake (RTS/CTS)
> >> -              * handled by the controller.
> >> +              * Automatic hardware handshake (RTS/CTS) only work with
> >> +              * FIFOs or PDC.
> >> +              * Meaning that on SAM9x5 the controller can't handle
> >> +              * the hardware handshake (no FIFOs nor PDC on these platforms).
> >>                */
> >> -             if (atmel_use_dma_rx(port) && !atmel_use_fifo(port)) {
> >> -                     dev_info(port->dev, "not enabling hardware flow control because DMA is used");
> >> -                     termios->c_cflag &= ~CRTSCTS;
> >> -             } else {
> >> +             if (atmel_use_pdc_rx(port) || atmel_use_fifo(port))
> >>                       mode |= ATMEL_US_USMODE_HWHS;
> >> -             }
> >> +             else
> >> +                     /*
> >> +                      * The hardware handshake won't be handle by the
> >> +                      * controller but by the driver.
> >> +                      */
> >> +                     mode |= ATMEL_US_USMODE_NORMAL;
> >
> > You still need the case where HWHS is impossible and there are no gpio
> > configured. You need to inform userspace that the configuration was not
> > applied instead of silently ignoring the error.
> 
> Could you explain which case it is ?
> The only one I can see is when there's no GPIO declared for RTS/CTS
> AND, there's no pin muxed for RTS/CTS either.
> 
> Have you got another example in mind ?
> 

Hum, actually, it is that case. The other one (CRTSCTS and gpios) is
handled in the else below. I think you need to keep the termios->c_cflag
&= ~CRTSCTS; here so that userspace knows configuring it failed.

> >
> >>       } else {
> >>               /* RS232 without hadware handshake or controlled by GPIOs */
> >>               mode |= ATMEL_US_USMODE_NORMAL;
> >

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
