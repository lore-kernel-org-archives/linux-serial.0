From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 2/2] tty/serial: atmel: make the driver DT only
Date: Tue, 13 Jun 2017 21:56:08 +0200
Message-ID: <20170613195608.3tfckys7w42sgmiy@piout.net>
References: <20170613134038.5545-1-alexandre.belloni@free-electrons.com>
 <20170613134038.5545-2-alexandre.belloni@free-electrons.com>
 <CAHp75VdQu=mm3hPb32+3osbx+wugH4iTFqAnz8-2GDmsYV8ViA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdQu=mm3hPb32+3osbx+wugH4iTFqAnz8-2GDmsYV8ViA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 13/06/2017 at 17:50:25 +0300, Andy Shevchenko wrote:
> On Tue, Jun 13, 2017 at 4:40 PM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Now that AVR32 is gone, platform_data are not used to initialize the driver
> > anymore, remove that path from the driver. Also remove the now unused
> > struct atmel_uart_data.
> 
> Nitpicks, not insisting on them at all, just a side comment.
> 
> > +       struct serial_rs485 *rs485conf = &port->rs485;
> > +       u32 rs485_delay[2];
> 
> + empty line?
> 

Okay

> > +       /* rs485 properties */
> 
> > +       if (of_property_read_u32_array(np, "rs485-rts-delay",
> > +                                      rs485_delay, 2) == 0) {
> 
> Now it can be one line I suppose (taking into account ...() == 0 ->
> !...() change)
> 

No, it still doesn't fit, I'll leave it as-is

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
