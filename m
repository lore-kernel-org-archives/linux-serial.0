From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] tty/serial: atmel: use proper accessors
Date: Mon, 20 Jul 2015 22:02:49 +0200
Message-ID: <20150720200249.GK15539@piout.net>
References: <1437400572-16575-1-git-send-email-alexandre.belloni@free-electrons.com>
 <55AD4683.3090708@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55AD4683.3090708@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-serial@vger.kernel.org

Hi,

(adding Hans in Cc)

On 20/07/2015 at 15:05:39 -0400, Peter Hurley wrote :
> Hi Alexandre,
> 
> On 07/20/2015 09:56 AM, Alexandre Belloni wrote:
> > On ARM, it is necessary to use the _relaxed versions of read[bl] and
> > write[bl] to ensure we do the correct endianness conversion when running in
> > big endian.
> > Keep using avr32 __raw version on avr32 to avoid breakage.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > ---
> > 
> > This patch applies after [PATCH v4 0/5] tty/serial: at91: add support to FIFOs
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/353704.html
> > 
> >  drivers/tty/serial/atmel_serial.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> > index e91b3b2f0590..451acf054281 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -194,6 +194,7 @@ to_atmel_uart_port(struct uart_port *uart)
> >  	return container_of(uart, struct atmel_uart_port, uart);
> >  }
> >  
> > +#ifdef CONFIG_AVR32
> 
> The whole point of i/o accessors is to encapsulate arch-specific
> differences, so one of these arches isn't doing it right, or the wrong
> i/o accessors are being used.
> 

I'm not an avr32 specialist but I think __raw accessors are doing big
endian accesses but _relaxed accessors are doing litlle endian accesses.

Maybe Hans can clarify what's needed here.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
